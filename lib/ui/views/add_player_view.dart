import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_widget.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:provider_start/core/localization/localization.dart';

import '../../core/view_models/home_view_model.dart';

class AddPlayerView extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return ViewModelProvider<HomeViewModel>.withoutConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(local.addPlayer),
        ),
        body: Container(
          child: Card(
              child: Column(
            children: <Widget>[
              TextField(
                decoration: kTextFieldInputDecoration,
                controller: myController,
                onChanged: (value) => model.newPlayer = value,
              ),
              FlatButton(
                  color: Colors.teal,
                  onPressed: () {
                    if (model.newPlayer == null) {
                      Navigator.of(context).pop();
                    } else {
                      model.addPlayer(model.newPlayer);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Spieler hinzufügen')),
            ],
          )),
        ),
      ),
    );
  }
}

class _AddPlayerTextField extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    final local = AppLocalizations.of(context);
    return TextField(
      onChanged: (value) => model.newPlayer = value,
      controller: model.playerNameController,
      decoration: InputDecoration(
        hintText: local.addPlayer,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _AddPlayerButton extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PlatformButton(
      child: Text('Spieler hinzufügen'),
      //to-do: Make it like local.addplayerButton
      onPressed: () =>
          {model.addPlayer(model.newPlayer), Navigator.of(context).pop()},
      android: (context) => MaterialRaisedButtonData(
        textTheme: ButtonTextTheme.primary,
        color: theme.primaryColor,
      ),
    );
  }
}

class _Container extends StatelessWidget {
  final List<Widget> children;

  const _Container({Key key, @required this.children})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

final kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
      Icons.person,
      color: Colors.teal,
    ),
    hintText: 'Enter Player Name',
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none));
