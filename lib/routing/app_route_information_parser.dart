import 'package:flutter/material.dart';

import 'app_route_path.dart';
import 'child_section.dart';
import 'main_section.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    print('parseRouteInformation ${routeInformation.location}');
    final uri = Uri.parse(routeInformation.location!);

    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return AppRoutePath(mainSection: null);
    } else if (uri.pathSegments[0] == 'droplets') {
      if (uri.pathSegments.length >= 2) {
        final resourceId = int.tryParse(uri.pathSegments[1]);

        if (resourceId != null) {
          if (uri.pathSegments.length >= 3) {
            if (uri.pathSegments[2] == 'networking') {
              return AppRoutePath(
                mainSection: MainSection.droplets,
                resourceId: resourceId,
                childSection: ChildSection.networking,
              );
            }
          }
          return AppRoutePath(
            mainSection: MainSection.droplets,
            resourceId: resourceId,
          );
        } else if (uri.pathSegments[1] == 'new') {
          return AppRoutePath(
            mainSection: MainSection.droplets,
            resourceId: null,
            childSection: ChildSection.newResource,
          );
        }
      }

      return AppRoutePath(mainSection: MainSection.droplets);
    } else if (uri.pathSegments[0] == 'snapshots') {
      if (uri.pathSegments.length >= 2) {
        final resourceId = int.tryParse(uri.pathSegments[1]);

        if (resourceId != null) {
          return AppRoutePath(
            mainSection: MainSection.snapshots,
            resourceId: resourceId,
          );
        }
      }
      return AppRoutePath(mainSection: MainSection.snapshots);
    } else if (uri.pathSegments[0] == 'account') {
      return AppRoutePath(mainSection: MainSection.account);
    } else if (uri.pathSegments[0] == 'terms') {
      return AppRoutePath(mainSection: MainSection.terms);
    }

    return AppRoutePath(mainSection: null);
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    print('restoreRouteInformation $path');

    if (path.mainSection == MainSection.droplets) {
      if (path.resourceId != null) {
        if (path.childSection == ChildSection.networking) {
          return RouteInformation(location: '/droplets/${path.resourceId}/networking');
        }
        return RouteInformation(location: '/droplets/${path.resourceId}');
      } else if (path.childSection == ChildSection.newResource) {
        return RouteInformation(location: '/droplets/new');
      } else {
        return RouteInformation(location: '/droplets');
      }
    } else if (path.mainSection == MainSection.snapshots) {
      if (path.resourceId != null) {
        return RouteInformation(location: '/snapshots/${path.resourceId}');
      } else {
        return RouteInformation(location: '/snapshots');
      }
    } else if (path.mainSection == MainSection.account) {
      return RouteInformation(location: '/account');
    } else if (path.mainSection == MainSection.terms) {
      return RouteInformation(location: '/terms');
    }

    return RouteInformation(location: '/');
  }
}
