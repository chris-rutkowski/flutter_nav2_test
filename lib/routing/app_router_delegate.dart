import 'package:flutter/material.dart';
import 'package:mynavigationlast/routing/app_route_path.dart';

import 'child_section.dart';
import 'main_section.dart';
import 'pages.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool? authenticated;
  MainSection? mainSection;
  int? resourceId;
  ChildSection? childSection;

  AppRoutePath get currentConfiguration {
    if (authenticated == false) {
      final allowedSections = [MainSection.terms];
      return AppRoutePath(
        mainSection: allowedSections.contains(mainSection) ? mainSection : null,
      );
    }

    return AppRoutePath(
      mainSection: mainSection,
      resourceId: resourceId,
      childSection: childSection,
    );
  }

  List<Page> get _pages {
    if (authenticated == null) {
      return [
        SplashPage(onAuthenticationChanged: (authenticated) {
          this.authenticated = authenticated;
          notifyListeners();
        })
      ];
    }

    if (authenticated == false) {
      return [
        WelcomePage(onAuthenticated: () {
          authenticated = true;
          notifyListeners();
        }, onSelectTerms: () {
          this.mainSection = MainSection.terms;
          notifyListeners();
        }),
        if (mainSection == MainSection.terms) TermsPage()
      ];
    }

    final menuPage = MenuPage(onSectionChange: (section) {
      this.mainSection = section;
      notifyListeners();
    });

    if (mainSection == MainSection.account) {
      return [
        menuPage,
        AccountPage(onLogout: () {
          authenticated = false;
          mainSection = null;
          resourceId = null;
          notifyListeners();
        })
      ];
    } else if (mainSection == MainSection.droplets) {
      return [
        menuPage,
        DropletsPage(onSelect: (resourceId) {
          this.resourceId = resourceId;
          notifyListeners();
        }, onCreateNew: () {
          childSection = ChildSection.newResource;
          notifyListeners();
        }),
        if (childSection == ChildSection.newResource) NewDropletPage(),
        if (resourceId != null)
          DropletDetailsPage(
            id: resourceId!,
            onSelect: (selection) {
              childSection = selection;
              notifyListeners();
            },
          ),
        if (resourceId != null && childSection == ChildSection.networking) DropletNetworkingPage(resourceId!),
      ];
    } else if (mainSection == MainSection.snapshots) {
      return [
        menuPage,
        SnapshotsPage(onSelect: (resourceId) {
          this.resourceId = resourceId;
          notifyListeners();
        }),
        if (resourceId != null) SnapshotDetailsPage(resourceId!),
      ];
    }

    return [
      menuPage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (route.settings is DropletsPage ||
            route.settings is AccountPage ||
            route.settings is TermsPage ||
            route.settings is SnapshotsPage) {
          mainSection = null;
        }

        if (route.settings is NewDropletPage || route.settings is DropletNetworkingPage) {
          childSection = null;
        }

        if (route.settings is DropletDetailsPage || route.settings is SnapshotDetailsPage) {
          resourceId = null;
        }

        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    mainSection = path.mainSection;
    resourceId = path.resourceId;
    childSection = path.childSection;
  }
}
