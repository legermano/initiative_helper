import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_card.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_edit_dialog.dart';
import 'package:initiative_helper/app/modules/home/widgets/encounters_drawer.dart';
import 'package:lottie/lottie.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
    controller.getEncounters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[700],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Observer(builder: (_) {
              return Text(
                controller.activeEncounter.description,
                overflow: TextOverflow.ellipsis,
              );
            }),
          ),
          drawer: EncounterDrawer(controller: controller),
          body: Observer(builder: (_) {
            final List<CharacterWithInfo> characters =
                controller.charactersList;
            if ((characters.length < 1) && 
                (controller.activeEncounter.id == 0))  {
              return Column(
                children: [
                  //! In the begging of the json file is set to start
                  //! the animation in second 153 DO NOT CHANGE
                  Lottie.asset('assets/dice_red.json'),
                  Text(
                    'Choose an encounter',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ); 
            } else {
              return ListView.builder(
                itemCount: characters.length,
                itemBuilder: (_, index) {
                  return CharacterCard(
                    controller: controller, character: characters[index]
                  );
                }
              );
            } 
          }),
          bottomSheet: Observer(
            builder: (_) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                    child: FloatingActionButton(                    
                      child: Icon(Icons.arrow_back_ios),
                      onPressed: controller.activeEncounter.id == 0
                      ? null
                      : () {
                        controller.backwardQueue();
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 8),
                    child: FloatingActionButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: controller.activeEncounter.id == 0
                      ? null
                      : () {
                        controller.startQueue();
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
                    child: FloatingActionButton(
                      child: Icon(Icons.arrow_forward_ios),
                      onPressed: controller.activeEncounter.id == 0
                      ? null
                      : () {
                        controller.fowardQueue();
                      }
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 18, 8, 0),
                      child: Text(
                        controller.activeEncounter.currentTurn == 0 
                        ? '' 
                        : 'Turn : ' + controller.activeEncounter.currentTurn.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 8, 8),
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      //* When the app is starting it is not positioned in an encounter
                      //* So the button should be disabled
                      onPressed: controller.activeEncounter.id == 0
                        ? null
                        : () {
                          showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => CharacterEditDialog(
                            controller: controller,
                            encounterId: controller.activeEncounter.id
                          ),
                          );
                        },
                    ),
                  )
                ],
              );
            }
          ),
          // persistentFooterButtons: [
          //   Observer(
          //     builder: (_) {
          //       return Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           FloatingActionButton(
          //             child: Icon(Icons.arrow_back_ios),
          //             onPressed: controller.activeEncounter.id == 0
          //             ? null
          //             : () {
          //               controller.backwardQueue();
          //             }
          //           ),
          //           FloatingActionButton(
          //             child: Icon(Icons.play_arrow),
          //             onPressed: controller.activeEncounter.id == 0
          //             ? null
          //             : () {
          //               controller.startQueue();
          //             }
          //           ),
          //           FloatingActionButton(
          //             child: Icon(Icons.arrow_forward_ios),
          //             onPressed: controller.activeEncounter.id == 0
          //             ? null
          //             : () {
          //               controller.fowardQueue();
          //             }
          //           ),
          //           FloatingActionButton(
          //             child: Icon(Icons.add),
          //             //* When the app is starting it is not positioned in an encounter
          //             //* So the button should be disabled
          //             onPressed: controller.activeEncounter.id == 0
          //               ? null
          //               : () {
          //                 showDialog(
          //                 context: context,
          //                 barrierDismissible: false,
          //                 builder: (context) => CharacterEditDialog(
          //                   controller: controller,
          //                   encounterId: controller.activeEncounter.id
          //                 ),
          //                 );
          //               },
          //           )
          //         ],
          //       );
          //     }
          //   )
          // ],
        ),
      ),
    );
  }
}
