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
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 900;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(flex:1, child: _characterInfo(ch)),
                  Expanded(flex:0, child: _armorClass(ch.armorClass.toString())),
                  Expanded(flex:0, child:_currentHitPoint(character,context)),
                  if(!displayMobileLayout) _conditionsDropDownButton(character)
                ],
              ),
                if(displayMobileLayout) _conditionsDropDownButton(character),
            ],
          )
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

  Widget _currentHitPoint(CharacterWithInfo chInfo,BuildContext context) {    
    void _updateHealt(int hitPoints) {
      final ch = chInfo.character.copyWith(
        currentHealthPoints: hitPoints
      );
      CharacterWithInfo character = chInfo;        
      character.character = ch;
      controller.updateCharacter(character);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          InkWell(
            child: Container(
              child: const Icon(
                Icons.remove_circle_outline),
            ),
            onTap: () => _updateHealt(chInfo.character.currentHealthPoints - 1),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Octicons.heart,
                color: Theme.of(context).primaryColor,
                size: 48,
              ),
              Text(
                chInfo.character.currentHealthPoints.toString(),
                style: TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
          InkWell(
            child: Container(
              child: const Icon(Icons.add_circle_outline),
            ),
            onTap: () => _updateHealt(chInfo.character.currentHealthPoints + 1),
          ),
        ],
      ),
    );
  }  

  Widget _conditionsDropDownButton(CharacterWithInfo chInfo) {
    return Row(
      children: [
        Text('Condition : '),
        DropdownButton<Conditions>(
          isDense: true,
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
        ),
      ],
    );
  }
}
