import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/rockets/di/rocket_list_module.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/view/rocket_list_screen.dart';
import 'package:flutter_rocket_launcher/routes/feature_routes.dart';

class RocketsRoutes extends FeatureRoutes {
  static const String ROCKETS_SCREEN = "rockets_screen";

  @override
  List<String> get screens => [
        ROCKETS_SCREEN,
      ];

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROCKETS_SCREEN:
        return MaterialPageRoute(builder: (_) => RocketListScreen(RocketListModule.provideRocketListPresenter()));
      default:
        return generateDefaultRoute(settings);
    }
  }
}
