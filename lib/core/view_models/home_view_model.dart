import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/repository_exception.dart';
import 'package:provider_start/core/models/post/post.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';

import 'package:flutter/cupertino.dart';

import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

import '../constant/view_routes.dart';
import '../enums/view_state.dart';
import '../services/navigation/navigation_service.dart';

class HomeViewModel extends BaseViewModel {
  final _playerNameController = TextEditingController();
  final _navigationService = locator<NavigationService>();


  String newPlayer;
  TextEditingController get playerNameController => _playerNameController;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

 final Map<String, String> _playersMap = <String, String>{};

  get playersList => _playersMap.keys.toList();
  Map<String, String> get playersMap {
    return _playersMap;
  }


  void addPlayer(String name) {
    setState(ViewState.Busy);
    _playersMap.putIfAbsent(name, () => 'Bürger');
    print(_playersMap);
    notifyListeners();
    setState(ViewState.Idle);
  }

  void removePlayer(String name) {
    setState(ViewState.Busy);
    _playersMap.remove(name);
    setState(ViewState.Idle);
  }

  void resetGame() {
    setState(ViewState.Busy);
    _playersMap.clear();
    setState(ViewState.Idle);
  }

  void resetRoles() {
    setState(ViewState.Busy);
    _playersMap.forEach(
            (key, value) =>
            _playersMap.update(key, (String value) => 'Bürger'));
    setState(ViewState.Idle);
  }

  List randomNumberGenerator() {
    setState(ViewState.Busy);
    var playerNames = playersMap.keys.toList();

    var myList = [for (int i = 0; i < playerNames.length; i++) i];
    myList.shuffle();
    print(myList.take(7));
    setState(ViewState.Idle);
    return myList;
  }
  void assignRole() {
    ///to-do: Make it absulutely undbreakable
    try {
      var playerNames = playersMap.keys.toList();
      var l = randomNumberGenerator();
      print('###############################################');
      int rN1 = l[0]; //Heiler

      int rN2 = l[1]; //Seher

      int rN3 = l[2]; // Mörder

      int rN4 = l[3]; // Mörder

      int rN5 = l[4]; // Mörder

      int rN6 = l[5]; //Liebespaar 1

      int rN7 = l[6]; //Liebespaar 2

      String name1 = playerNames[rN1];
      String name2 = playerNames[rN2];
      String name3 = playerNames[rN3];
      String name4 = playerNames[rN4];
      String name5 = playerNames[rN5];
      String name6 = playerNames[rN6];
      String name7 = playerNames[rN7];
      _playersMap.update(name1, (String role) => 'Heiler');
      _playersMap.update(name2, (String role) => 'Seher');
      _playersMap.update(name3, (String role) => 'Mörder');
      _playersMap.update(name4, (String role) => 'Mörder');
      _playersMap.update(name5, (String role) => 'Mörder');
      _playersMap.update(name6, (String role) => 'Liebespaar 1');
      _playersMap.update(name7, (String role) => 'Liebespaar 2');
      notifyListeners();
    } catch (e) {
      print('I don\'t know what is going on heerrreee');
    }
  }

  void openAddPlayerView() async {
    setState(ViewState.Busy);

    await _navigationService.pushNamed(ViewRoutes.add_player);

    setState(ViewState.Idle);
  }
}
