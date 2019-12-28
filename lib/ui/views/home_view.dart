import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/view_models/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body:  _Posts(),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(local.appTitle),
        ),
        floatingActionButton: SafeArea(
          child: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            closeManually: false,
            curve: Curves.bounceIn,
            onOpen: () => print('opening dialog'),
            onClose: () => print('close dialog'),
            tooltip: 'Optionen',
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.red,
                label: 'Spieler hinzufügen',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  model.openAddPlayerView();
                },
              ),
              SpeedDialChild(
                  child: Icon(Icons.sync),
                  backgroundColor: Colors.red,
                  label: 'Rollen verteilen',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    model.assignRole();
                  }),
              SpeedDialChild(
                  child: Icon(Icons.refresh),
                  backgroundColor: Colors.red,
                  label: 'Alle Rollen zurücksetzen',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    model.resetRoles();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class _NoPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Center(
      child: Text(local.homeViewNoPosts),
    );
  }
}

class _LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformCircularProgressIndicator(),
    );
  }
}

class _Posts extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    var loadedPlayersData = Provider.of<HomeViewModel>(context);

    var playerNames = loadedPlayersData.playersMap.keys.toList();
    var playerRoles = loadedPlayersData.playersMap.values.toList();


    if (model.state == ViewState.Busy) {
      return _LoadingAnimation();
    }

    if (model.playersMap.isEmpty) {
      return _NoPosts();
    }

    return ListView.builder(
      itemCount: playerNames.length,
      itemBuilder: (context, index) => Card(
        color: Colors.white30,
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(playerNames[index]),
          subtitle: Text(
            playerRoles[index],
            style: TextStyle(
              color:
                  newTextStyle(playerRoles[index]) ? Colors.black : Colors.teal,
            ),
          ),
          trailing: IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: () {
              model.removePlayer(playerNames[index]);
            },
          ),
        ),
      ),
    );
  }
}

bool newTextStyle(String role) {
  if (role == 'Bürger') {
    return true;
  } else {
    return false;
  }
}
