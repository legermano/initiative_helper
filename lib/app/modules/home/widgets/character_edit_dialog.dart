import 'package:d20/d20.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:moor/moor.dart' as moor ;
import 'package:numberpicker/numberpicker.dart';

class CharacterEditDialog extends StatefulWidget {
  final HomeController controller;
  //? If is editing an existing character
  final Character character;
  //? If is creating a new character
  final int encounterId;
  
  const CharacterEditDialog({Key key,this.controller, this.character, this.encounterId}) : super(key: key);

  @override
  _CharacterEditDialogState createState() => _CharacterEditDialogState();
}

class _CharacterEditDialogState extends State<CharacterEditDialog> {  
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

    _nameController.text = isCreating ? '' : widget.character.name;
    initiativeValue      = isCreating ? 0  : widget.character.initiative;
    modifierValue        = isCreating ? 0  : widget.character.modifier;

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
      title: const Text('Edit character'),
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
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesome5.dice_d20), 
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
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(FontAwesome5.dice_d20), 
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
          child: const Text('Cancel'),
          textColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
        FlatButton(
          child: const Text('Save'),
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
                final character = widget.character.copyWith(
                  name: _nameController.text,
                  initiative: initiativeValue,
                  modifier: modifierValue
                );
                controller.updateCharacter(character, widget.character.encounter);  
              }            
              Navigator.pop(context);
            }            
          }, 
        )
      ],
    );
  }
}