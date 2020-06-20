import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:initiative_helper/app/modules/home/widgets/add_encounter_dialog.dart';
import 'package:mobx/mobx.dart';

class EncounterDrawer extends StatelessWidget {
  final HomeController controller;

  EncounterDrawer({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: DrawerHeader(
              child: Text(
                'List of all encounters',
                style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.white),
                textAlign: TextAlign.center,  
              ),
              decoration: BoxDecoration(color: Colors.red[700]),
              margin: EdgeInsets.all(0),
            ),
          ),
          Flexible(
            flex: 1,
            child: Observer(
              builder: (_){
                switch (controller.encountersList.status) {
                  case FutureStatus.pending:
                    return const LinearProgressIndicator();
                    break;
                  case FutureStatus.fulfilled:
                    final List<Encounter> encounters = controller.encountersList.value;
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: encounters.length,
                      itemBuilder: (_,index) {
                        return _EncounterDrawerEntry(
                          encounter: encounters[index], 
                          controller: controller
                        );
                      }
                    );
                    break;  
                  default:
                    return Container();
                    break;
                }
              }
            )
          ),
          Row(
            children: [
              FlatButton(
                child: const Text('Add encounter'),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddEncounterDialog(controller: controller,),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class _EncounterDrawerEntry extends StatelessWidget {
  final Encounter encounter;
  final HomeController controller;

  const _EncounterDrawerEntry({Key key, @required this.encounter, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = encounter.description ?? 'Unnamed';

    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 4, 9, 0),
      child: Material(
        color: (encounter.id == controller.activeEncounter.id) ? Colors.amber[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            controller.getCharactersInEncounter(encounter);
            Navigator.pop(context); //close the navigation drawer
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: 0,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Combat encounter',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ),
                // Spacer(),
                Flexible(
                  flex: 0,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: Text('Really delete category $title?'),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                }, 
                                child: const Text('Cancel')
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                }, 
                                child: const Text('Delete'),
                                textColor: Colors.red,
                              )
                            ],
                          );
                        },
                      );

                      if (confirmed) {
                        controller.deleteEncounter(encounter);
                      }
                    }
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}