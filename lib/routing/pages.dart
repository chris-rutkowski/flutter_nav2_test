import 'package:flutter/material.dart';

import '../screens.dart';
import 'child_section.dart';
import 'main_section.dart';

class DropletsPage extends Page {
  final ValueChanged<int> onSelect;
  final VoidCallback onCreateNew;

  DropletsPage({required this.onSelect, required this.onCreateNew});

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (_) => DropletsScreen(onSelect: onSelect, onCreateNew: onCreateNew),
      );
}

class DropletDetailsPage extends Page {
  final int id;
  final ValueChanged<ChildSection> onSelect;

  DropletDetailsPage({required this.id, required this.onSelect}) : super(key: ValueKey(id));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return DropletDetailsScreen(id: id, onSelect: onSelect);
      },
    );
  }
}

class WelcomePage extends Page {
  final VoidCallback onAuthenticated;
  final VoidCallback onSelectTerms;

  WelcomePage({required this.onAuthenticated, required this.onSelectTerms});

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return WelcomeScreen(onAuthenticated: onAuthenticated, onSelectTerms: onSelectTerms);
      },
    );
  }
}

class SplashPage extends Page {
  final ValueChanged<bool> onAuthenticationChanged;

  SplashPage({required this.onAuthenticationChanged});

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SplashScreen(
          onAuthenticationChanged: onAuthenticationChanged,
        );
      },
    );
  }
}

class TermsPage extends Page {
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return TermsScreen();
      },
    );
  }
}

class AccountPage extends Page {
  final VoidCallback onLogout;

  AccountPage({required this.onLogout});

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return AccountScreen(
          onLogout: onLogout,
        );
      },
    );
  }
}

class MenuPage extends Page {
  final ValueChanged<MainSection> onSectionChange;

  MenuPage({required this.onSectionChange});

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return MenuScreen(onSectionChange: onSectionChange);
      },
    );
  }
}

class NewDropletPage extends Page {
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return NewDropletScreen();
      },
    );
  }
}

class SnapshotsPage extends Page {
  final ValueChanged<int> onSelect;

  SnapshotsPage({required this.onSelect});

  @override
  Route createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (_) => SnapshotsScreen(onSelect: onSelect),
      );
}

class SnapshotDetailsPage extends Page {
  final int id;

  SnapshotDetailsPage(this.id) : super(key: ValueKey(id));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SnapshotDetailsScreen(id: id);
      },
    );
  }
}

class DropletNetworkingPage extends Page {
  final int id;

  DropletNetworkingPage(this.id) : super(key: ValueKey('DropletNetworkingPage_$id'));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return DropletNetworkingScreen(id: id);
      },
    );
  }
}
