import 'package:flutter/material.dart';
import 'package:mynavigationlast/routing/main_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routing/child_section.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onAuthenticated;
  final VoidCallback onSelectTerms;

  WelcomeScreen({Key? key, required this.onAuthenticated, required this.onSelectTerms}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: ListView(
        children: [
          TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('authenticated', true);
                onAuthenticated();
              },
              child: Text('Sign in')),
          TextButton(onPressed: onSelectTerms, child: Text('Terms')),
        ],
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final ValueChanged<MainSection> onSectionChange;

  MenuScreen({Key? key, required this.onSectionChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          TextButton(onPressed: () => onSectionChange(MainSection.droplets), child: Text('droplets')),
          TextButton(onPressed: () => onSectionChange(MainSection.snapshots), child: Text('snapshots')),
          TextButton(onPressed: () => onSectionChange(MainSection.account), child: Text('account')),
        ],
      ),
    );
  }
}

class DropletsScreen extends StatelessWidget {
  final ValueChanged<int> onSelect;
  final VoidCallback onCreateNew;

  DropletsScreen({Key? key, required this.onSelect, required this.onCreateNew}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Droplets'),
      ),
      body: ListView(
        children: [
          TextButton(onPressed: onCreateNew, child: Text('create new')),
          TextButton(onPressed: () => onSelect(1), child: Text('droplet 1')),
          TextButton(onPressed: () => onSelect(2), child: Text('droplet 2')),
        ],
      ),
    );
  }
}

class DropletDetailsScreen extends StatelessWidget {
  final int id;
  final ValueChanged<ChildSection> onSelect;

  DropletDetailsScreen({Key? key, required this.id, required this.onSelect}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Droplet details $id'),
      ),
      body: ListView(
        children: [TextButton(onPressed: () => onSelect(ChildSection.networking), child: Text('networking'))],
      ),
    );
  }
}

class DropletNetworkingScreen extends StatelessWidget {
  final int id;

  DropletNetworkingScreen({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Droplet networking'),
      ),
      body: Center(
        child: Text('droplet $id'),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final ValueChanged<bool> onAuthenticationChanged;

  SplashScreen({Key? key, required this.onAuthenticationChanged}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuth();
  }

  void _checkAuth() async {
    await Future.delayed(Duration(milliseconds: 20));
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    if (prefs.getBool('authenticated') == true) {
      widget.onAuthenticationChanged(true);
    } else {
      widget.onAuthenticationChanged(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('splash'),
      ),
    );
  }
}

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms'),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  final VoidCallback onLogout;

  AccountScreen({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('authenticated');
            onLogout();
          },
          child: Text('log out'),
        ),
      ),
    );
  }
}

class NewDropletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New droplet'),
      ),
    );
  }
}

class SnapshotsScreen extends StatelessWidget {
  final ValueChanged<int> onSelect;

  SnapshotsScreen({Key? key, required this.onSelect}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snapshots'),
      ),
      body: ListView(
        children: [
          TextButton(onPressed: () => onSelect(1), child: Text('snapshot 1')),
          TextButton(onPressed: () => onSelect(2), child: Text('snapshot 2')),
        ],
      ),
    );
  }
}

class SnapshotDetailsScreen extends StatelessWidget {
  final int id;

  SnapshotDetailsScreen({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snapshot details'),
      ),
      body: Center(
        child: Text('Snapshot details $id'),
      ),
    );
  }
}
