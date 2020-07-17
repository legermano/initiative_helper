import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_dialog.dart';
import 'package:initiative_helper/utils/enums/conditions.dart';

class CharacterCard extends StatelessWidget {
  final HomeController controller;
  final CharacterWithInfo character;

  CharacterCard({Key key, @required this.controller, @required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Character ch = character.character;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      color: character.turn 
        ? Theme.of(context).selectedRowColor
        : Theme.of(context).cardColor,
      child: Slidable(   
        key: Key(ch.id.toString()),
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _characterInfo(ch),
              _armorClass(ch.armorClass.toString()),
              _currentHitPointClass(ch.currentHealthPoints.toString()),
              _conditionsDropDownButton(character)
            ],
          ),
        ),
        secondaryActions: [
          IconSlideAction(
            caption: 'Edit',
            color: Colors.grey[400],
            icon: Icons.more_horiz,
            foregroundColor: Colors.white,
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CharacterDialog(controller: controller,character: character),
              );
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Theme.of(context).primaryColor,
            icon: Icons.delete,
            onTap: () => controller.deleteCharacter(character),
          )
        ],
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) => controller.deleteCharacter(character),
        ),
      ),
    );
  }

  Widget _characterInfo(Character character) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(character.name),
        Row(
          children: [
            Text(
              'Initiative : ${character.initiative.toString()}',
              style: const TextStyle(fontSize: 12),
            ),
            SizedBox(width: 8,),
            Text(
              'Modifier : ${character.modifier.toString()}',
              style: const TextStyle(fontSize: 12),
            )
          ],
        )
      ],
    );
  }

  Widget _armorClass(String armorClass) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Octicons.shield,
          color: Colors.grey,
          size: 34,
        ),
        Text(
          armorClass,
          style: TextStyle(fontSize: 15, color: Colors.white),
        )
      ],
    );
  }

  Widget _currentHitPointClass(String hitPoints) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Octicons.heart,
          color: Colors.red,
          size: 48,
        ),
        Text(
          hitPoints,
          style: TextStyle(fontSize: 15, color: Colors.white),
        )
      ],
    );
  }  

  Widget _conditionsDropDownButton(CharacterWithInfo chInfo) {
    return DropdownButton<Conditions>(
      value: chInfo.character.condition,
      onChanged: (value) {
        final ch = chInfo.character.copyWith(
          condition: value
        );
        CharacterWithInfo character = chInfo;        
        character.character = ch;
        controller.updateCharacter(character);
      }, 
      items: Conditions.values.map((c) {
        return DropdownMenuItem<Conditions>(
          value: c,
          child: Text(c.toString().split('.').last),
        );
      }).toList(),
    );
  }
}
