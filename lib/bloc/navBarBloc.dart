import 'dart:async';

enum NavBarItem { HOME, TROPHY, TICK, SHOP, PROFILE }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.TROPHY);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.TICK);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.SHOP);
        break;
      case 4:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
