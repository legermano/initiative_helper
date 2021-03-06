import 'dart:io';
import 'package:d20/d20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead_web/flutter_typeahead.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:initiative_helper/app/modules/home/models/monsters_model.dart';
import 'package:initiative_helper/app/modules/home/services/monsters_service.dart';
import 'package:initiative_helper/utils/enums/conditions.dart';
import 'package:moor/moor.dart' as moor;
import 'package:numberpicker/numberpicker.dart';

class CharacterDialog extends StatefulWidget {
  final HomeController controller;
  //? If is editing an existing character
  final CharacterWithInfo character;
  //? If is creating a new character
  final int encounterId;

  const CharacterDialog(
      {Key key, this.controller, this.character, this.encounterId})
      : super(key: key);

  @override
  _CharacterDialogState createState() => _CharacterDialogState();
}

class _CharacterDialogState extends State<CharacterDialog> {
  HomeController controller;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _armorClassController = TextEditingController();
  final TextEditingController _maxHitPointsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //* It needs to be initialized here, because I need the references of it on the moment it throws the dice to get values
  NumberPicker initiativePicker;
  NumberPicker modifierPicker;

  int initiativeValue;
  int modifierValue;
  bool isCreating;

  @override
  void initState() {
    controller = widget.controller;

    isCreating = (widget.encounterId != null);

    _nameController.text = isCreating ? '' : widget.character.character.name;
    _armorClassController.text =
        isCreating ? '0' : widget.character.character.armorClass.toString();
    _maxHitPointsController.text =
        isCreating ? '0' : widget.character.character.maxHealthPoints.toString();
    initiativeValue = isCreating ? 0 : widget.character.character.initiative;
    modifierValue = isCreating ? 0 : widget.character.character.modifier;

    initiativePicker = NumberPicker.integer(
      highlightSelectedValue: true,
      initialValue: initiativeValue,
      minValue: -1000,
      maxValue: 1000,
      onChanged: (v) => setState(() => initiativeValue = v)
    );

    modifierPicker = NumberPicker.integer(
      initialValue: modifierValue,
      minValue: -1000,
      maxValue: 1000,
      onChanged: (v) => setState(() => modifierValue = v),
    );

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(isCreating ? 'Create character' : 'Edit character'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                _nameFormField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _armorClassFormField(),
                    SizedBox(width: 12,),
                    _maxHitPointsFormField()  
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _initiativeSpinner(), 
              _modifierSpinner()
            ],
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text(
            'Cancel',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            'Save',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (isCreating) {
                final charactersCompanion = CharactersCompanion(
                  name: moor.Value(_nameController.text),
                  encounter: moor.Value(widget.encounterId),
                  initiative: moor.Value(initiativeValue),
                  modifier: moor.Value(modifierValue),
                  condition: moor.Value(Conditions.Normal),
                  armorClass: moor.Value(int.parse(_armorClassController.text)),
                  maxHealthPoints: moor.Value(int.parse(_maxHitPointsController.text)),
                  currentHealthPoints: moor.Value(int.parse(_maxHitPointsController.text))
                );
                controller.addCharacter(
                  charactersCompanion, 
                  widget.encounterId
                );
              } else {
                final ch = widget.character.character.copyWith(
                  name: _nameController.text,
                  initiative: initiativeValue,
                  modifier: modifierValue,
                  armorClass: int.parse(_armorClassController.text),
                  maxHealthPoints: int.parse(_maxHitPointsController.text)
                );
                CharacterWithInfo character = widget.character;
                character.character = ch;
                character.initiativeWithModifier =
                    (ch.initiative + ch.modifier);
                controller.updateCharacter(character);
              }
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }

  Widget _nameFormField() {
    return TypeAheadFormField<MonstersModel>(
      hideOnEmpty: true,
      hideOnError: true,
      textFieldConfiguration: TextFieldConfiguration(
          controller: _nameController,
          decoration: InputDecoration(
              hintText: 'What is the name of the character?',
              helperText: 'The name of the character'),
          textCapitalization: TextCapitalization.sentences),
      suggestionsCallback: (pattern) async {
        if (pattern.isNotEmpty) {
          final service = Modular.get<MonstersService>();
          return service.queryRows(name: pattern);
        } else {
          return [];
        }
      },
      keepSuggestionsOnLoading: true,
      itemBuilder: (context, suggestion) {
        if (Platform.isIOS || Platform.isAndroid) {
          return ListTile(
            title: Text(suggestion.name),
          );
        } else {
          //? Workaround to work on the web
          return GestureDetector(
            onPanDown: (_) {
              print(suggestion.name);
              _nameController.text = suggestion.name;
              _armorClassController.text = suggestion.armorClass.toString();
              _maxHitPointsController.text = suggestion.hitPoints.toString();
            },
            child: Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Color.fromRGBO(255, 255, 255, 60)
                  : const Color(0xFF474747),
              child: ListTile(
                dense: true,
                title: Text(suggestion.name),
              ),
            ),
          );
        }
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        _nameController.text = suggestion.name;
        _armorClassController.text = suggestion.armorClass.toString();
        _maxHitPointsController.text = suggestion.hitPoints.toString();
      },
      validator: (text) {
        String validation;
        if (text.isEmpty) {
          validation = "Invalid name";
        }
        return validation;
      },
    );
  }

  Widget _initiativeSpinner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        //* It was needed to reinitialize because the current value wasn't been highlited
        initiativePicker = NumberPicker.integer(
          highlightSelectedValue: true,
          initialValue: initiativeValue,
          minValue: -1000,
          maxValue: 1000,
          onChanged: (v) => setState(() => initiativeValue = v)
        ),
        Text(
          'Initiative value',
        ),
        IconButton(
          icon: Icon(FontAwesome5.dice_d20,
              color: Theme.of(context).primaryColor),
          onPressed: () {
            final d20 = D20().roll('1d20');
            setState(() => initiativeValue = d20);
            initiativePicker.animateInt(d20);
          }
        ),
      ]
    );
  }

  Widget _modifierSpinner() {
    return Column(children: [
      //* It was needed to reinitialize because the current value wasn't been highlited
      modifierPicker = NumberPicker.integer(
        initialValue: modifierValue,
        minValue: -1000,
        maxValue: 1000,
        onChanged: (v) => setState(() => modifierValue = v),
      ),
      Text(
        'Modifier value',
        textAlign: TextAlign.center,
      ),
      IconButton(
        icon: Icon(
          FontAwesome5.dice_d20,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          final d20 = D20().roll('1d20');
          setState(() => modifierValue = d20);
          modifierPicker.animateInt(d20);
        }
      ),
    ]);
  }

  Widget _armorClassFormField() {
    return Expanded(
      // width: 60,
      child: TextFormField(
        controller: _armorClassController,
        decoration: InputDecoration(helperText: 'Armor Class'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          String validation;
          if (value.isEmpty) {
            validation = 'Invalid AC';
          }
          return validation;
        },
      ),
    );
  }

  Widget _maxHitPointsFormField() {
    return Expanded(
      // width: 60,
      child: TextFormField(
        controller: _maxHitPointsController,
        decoration: InputDecoration(
          helperText: 'Max HP',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          String validation;
          if (value.isEmpty) {
            validation = 'Invalid HP';
          }
          return validation;
        },
      ),
    );
  }
}
