import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:initiative_helper/app/database/database.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';
import 'package:initiative_helper/app/modules/home/widgets/add_encounter_dialog.dart';
import 'package:mobx/mobx.dart';

class EncounterDrawer extends StatelessWidget {
  final HomeController controller;
  final bool displayMobileLayout;

  EncounterDrawer({
    Key key, 
    @required this.controller,
    @required this.displayMobileLayout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 56,
                child: DrawerHeader(
                  child: Text(
                    'List of all encounters',
                    style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,  
                  ),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                              controller: controller,
                              diplayMobileLayout: displayMobileLayout,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  IconButton(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.lightbulb_outline), 
                    onPressed: () => DynamicTheme.of(context).setBrightness(
                      Theme.of(context).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark
                    )
                  )
                ],
              ),
            ],        
          ),
        ),
      ),
    );
  }
}

class _EncounterDrawerEntry extends StatelessWidget {
  final Encounter encounter;
  final HomeController controller;
  final bool diplayMobileLayout;

  const _EncounterDrawerEntry({
    Key key, 
    @required this.encounter, 
    @required this.controller,
    @required this.diplayMobileLayout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = encounter.description ?? 'Unnamed';

    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 4, 9, 0),
      child: Material(
        color: (encounter.id == controller.activeEncounter.id) 
          ? Theme.of(context).selectedRowColor 
          : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            controller.getCharactersInEncounter(encounter);
            if (diplayMobileLayout)
              Navigator.pop(context); //close the navigation drawer
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  flex: 0,
                  fit: FlexFit.tight,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: Text('Really delete encounter $title?'),
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
                                textColor: Theme.of(context).primaryColor,
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