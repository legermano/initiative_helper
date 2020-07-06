import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_card.dart';
import 'package:initiative_helper/app/modules/home/widgets/character_dialog.dart';
import 'package:initiative_helper/app/modules/home/widgets/encounters_drawer.dart';
import 'package:initiative_helper/animations/fade_in.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  //! Use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
    controller.getEncounters();

    final window = WidgetsBinding.instance.window;    

    window.onPlatformBrightnessChanged = () {
      final brightness = window.platformBrightness;
      DynamicTheme.of(context).setBrightness(brightness == Brightness.light
        ? Brightness.light
        : Brightness.dark
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Observer(builder: (_) {
              return Text(
                controller.activeEncounter.description,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              );
            }),
          ),
          drawer: EncounterDrawer(controller: controller),
          body: Observer(builder: (_) {
            final List<CharacterWithInfo> characters =
                controller.charactersList;
            if ((characters.length < 1) && 
                (controller.activeEncounter.id == 0))  {
              return Center(
                child: Column(
                  children: [
                    //! In the begging of the json file is set to start
                    //! the animation in second 153 DO NOT CHANGE
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Lottie.asset(
                        'assets/animations/dice.json',
                        fit: BoxFit.scaleDown
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                       child: FloatingActionButton.extended(
                        label: Text(
                          'Choose or create an encounter',
                          style: Theme.of(context).textTheme.headline6
                                 .merge(TextStyle(color: Colors.white))
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        }
                      )
                    )
                  ],
                ),
              ); 
            } else {
              return ScrollConfiguration(
                behavior: NoGlowingBehavior(),
                child: ScrollablePositionedList.builder(
                  itemPositionsListener: itemPositionsListener,
                  itemScrollController: itemScrollController,
                  itemCount: characters.length,
                  itemBuilder: (_, index) {
                    return CharacterCard(
                      controller: controller, character: characters[index]
                    );
                  },
                  physics: ClampingScrollPhysics(),
                ),
              );
            } 
          }),
          bottomNavigationBar: bottomButtons()
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Observer(
      builder: (_) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 0, 4),
              child: FloatingActionButton(                    
                child: Icon(Icons.arrow_back_ios),
                onPressed: controller.activeEncounter.currentTurn == 0
                ? null
                : () {
                  int index = controller.backwardQueue();
                  itemScrollController.scrollTo(
                    index: index,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 4),
              child: FloatingActionButton(
                child: controller.activeEncounter.currentTurn == 0
                ? Icon(Icons.play_arrow)
                : Icon(Icons.refresh),
                onPressed: controller.activeEncounter.id == 0
                ? null
                : () {
                  int index;
                  if (controller.activeEncounter.currentTurn == 0)
                  {
                    index = controller.startQueue();
                  } else {
                    index = controller.restartQueue();
                  }                        
                  itemScrollController.scrollTo(
                    index: index,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 2, 4),
              child: FloatingActionButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: controller.activeEncounter.currentTurn == 0
                ? null
                : () {
                  int index;
                  index = controller.fowardQueue();
                  itemScrollController.scrollTo(
                    index: index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOutExpo
                  );
                }
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child:  controller.activeEncounter.currentTurn == 0
              ? SizedBox()
              : FadeIn(
                1.0,
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 2, 4),
                  child: FloatingActionButton(
                    isExtended: true,
                    child: Text(
                      'Turn : ' + controller.activeEncounter.currentTurn.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: null,
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 8, 4),
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
                    builder: (context) => CharacterDialog(
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
    );
  }
}

//# Take the glowing affect in the end of the list
class NoGlowingBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
