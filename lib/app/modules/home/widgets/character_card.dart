import 'package:flutter/material.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_dialog.dart';
import 'package:initiative_helper/colors/custom_colors.dart';

class CharacterCard extends StatelessWidget {
  final HomeController controller;
  final CharacterWithInfo character;

  CharacterCard({Key key, @required this.controller, @required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Character ch = character.character;
    return Card(
      color: character.turn ? Colors.amber[100] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ch.name),
                  Row(
                    children: [
                      Text(
                        'Initiative : '+ch.initiative.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Modifier : '+ch.modifier.toString(),
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  )
                ],
              )
            ),
            IconButton(
              icon: const Icon(Icons.edit), 
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => CharacterDialog(controller: controller,character: character),
                );
              }
            ),
            IconButton(
              icon: const Icon(Icons.delete), 
              color: CustomColor.red,
              onPressed: () {
                controller.deleteCharacter(character);
              }
            )
          ],
        ),
      ),
    );
  }
}
