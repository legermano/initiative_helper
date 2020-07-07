import 'package:flutter/material.dart';
import 'package:initiative_helper/app/modules/home/home_controller.dart';

class AddEncounterDialog extends StatefulWidget {
  final HomeController controller;

  const AddEncounterDialog({Key key, this.controller}) : super(key: key);

  @override
  _AddEncounterDialogState createState() => _AddEncounterDialogState();
}

class _AddEncounterDialogState extends State<AddEncounterDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  HomeController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add an encounter',
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Name of the encounter'
          ),
          onSubmitted: (_) => _addEncounter(),
          textCapitalization: TextCapitalization.sentences,
        ),
      ),
      actions: [
        FlatButton(
          child: const Text('Add'),
          textColor: Theme.of(context).accentColor,
          onPressed: _addEncounter,
        )
      ],
    );
  }

  void _addEncounter() {
    if (_textEditingController.text.isNotEmpty) {
      controller.addEncounter(_textEditingController.text);
      Navigator.of(context).pop();
    }
  }
}