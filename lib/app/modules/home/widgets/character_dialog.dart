import 'package:d20/d20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:moor/moor.dart' as moor ;
import 'package:numberpicker/numberpicker.dart';

class CharacterDialog extends StatefulWidget {
  final HomeController controller;
  //? If is editing an existing character
  final CharacterWithInfo character;
  //? If is creating a new character
  final int encounterId;
  
  const CharacterDialog({Key key,this.controller, this.character, this.encounterId}) : super(key: key);

  @override
  _CharacterDialogState createState() => _CharacterDialogState();
}

class _CharacterDialogState extends State<CharacterDialog> {  
  HomeController controller;

  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final _dialogKey = GlobalKey<AlertDialog>();

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
    initiativeValue      = isCreating ? 0  : widget.character.character.initiative;
    modifierValue        = isCreating ? 0  : widget.character.character.modifier;

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
      title: Text( isCreating
        ? 'Crate character'
        : 'Edit character'
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'What is the name of the character?',
                helperText: 'The name of the character'
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (text) {
                String validation;
                if (text.isEmpty) {
                  validation = "Invalid name";
                }
                return validation;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                    icon: Icon(
                      FontAwesome5.dice_d20,
                      color: Theme.of(context).primaryColor
                    ),
                    onPressed: () {
                      final d20 = D20().roll('1d20');
                      setState(() => initiativeValue = d20);
                      initiativePicker.animateInt(d20);
                    }
                  ),
                ]
              ),
              Column(
                children: [
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
                ]
              )
            ],
          )
        ],
      ),
      actions: [
        FlatButton(
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.button.copyWith(
              color: Theme.of(context).primaryColor
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
        FlatButton(
          child: Text(
            'Save',
            style: Theme.of(context).textTheme.button.copyWith(
              color: Theme.of(context).primaryColor
            ),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (isCreating) {
                final charactersCompanion = CharactersCompanion(
                  name: moor.Value(_nameController.text),
                  encounter: moor.Value(widget.encounterId),
                  initiative: moor.Value(initiativeValue),
                  modifier: moor.Value(modifierValue)
                );
                controller.addCharacter(charactersCompanion, widget.encounterId);
              } else {
                final ch = widget.character.character.copyWith(
                  name: _nameController.text,
                  initiative: initiativeValue,
                  modifier: modifierValue
                );
                CharacterWithInfo character = widget.character;
                character.character = ch;
                character.initiativeWithModifier = (ch.initiative + ch.modifier);
                controller.updateCharacter(character);
              }            
              Navigator.pop(context);
            }            
          }, 
        )
      ],
    );
  }
}