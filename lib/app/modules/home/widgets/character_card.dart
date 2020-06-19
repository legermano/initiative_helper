import 'package:flutter/material.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_edit_dialog.dart';

class CharacterCard extends StatelessWidget {
  final HomeController controller;
  final Character character;

  CharacterCard({Key key, @required this.controller, @required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Text(character.name),
                  Row(
                    children: [
                      Text(
                        'Initiative : '+character.initiative.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Modifier : '+character.modifier.toString(),
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
                  builder: (context) => CharacterEditDialog(controller: controller,character: character),
                );
              }
            ),
            IconButton(
              icon: const Icon(Icons.delete), 
              color: Colors.red[700],
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
