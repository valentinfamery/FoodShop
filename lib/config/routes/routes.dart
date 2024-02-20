import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';

import 'package:meal_maven/features/shopping_list/presentation/pages/DetailsScreen.dart';
import 'package:meal_maven/features/shopping_list/presentation/pages/ListScreen.dart';
import 'package:meal_maven/features/shopping_list/presentation/pages/SearchScreen.dart';
import 'package:meal_maven/features/shopping_list/presentation/widgets/ScaffoldWithNavBar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class Routes {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/list',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(childWidget: child);
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar.
          GoRoute(
            path: '/list',
            builder: (BuildContext context, GoRouterState state) {
              return  ListScreen();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) {
                  final String extraString =
                      GoRouterState.of(context).extra! as String;

                  return DetailsScreen();
                },
              ),
            ],
          ),

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/search',
            builder: (BuildContext context, GoRouterState state) {
              return const SearchScreen();
            },
            routes: <RouteBase>[
              /// Same as "/a/details", but displayed on the root Navigator by
              /// specifying [parentNavigatorKey]. This will cover both screen B
              /// and the application shell.
              GoRoute(
                path: 'details',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final Product extraProductEntity =
                      GoRouterState.of(context).extra! as Product;

                  return DetailsScreen(
                    productEntity: extraProductEntity,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
