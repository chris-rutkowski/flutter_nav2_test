import 'package:flutter/material.dart';

import 'routing/app_route_information_parser.dart';
import 'routing/app_router_delegate.dart';

void main() {
  runApp(OurApp());
}

class OurApp extends StatefulWidget {
  @override
  _OurAppState createState() => _OurAppState();
}

class _OurAppState extends State<OurApp> {
  final _routerDelegate = AppRouterDelegate();
  final _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
    );
  }
}
