import 'package:flutter/material.dart';
import 'package:food_shop/features/shopping_list/presentation/pages/parameters_screen.dart';
import 'package:food_shop/injection_container.dart';

import 'package:go_router/go_router.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';

import 'package:food_shop/features/shopping_list/presentation/pages/details_screen.dart';
import 'package:food_shop/features/shopping_list/presentation/pages/list_screen.dart';
import 'package:food_shop/features/shopping_list/presentation/pages/search_screen.dart';
import 'package:food_shop/features/shopping_list/presentation/pages/settings_screen.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final sharedPrefs = sl<SharedPreferences>();

int? country = sharedPrefs.getInt('selected_country');
int? language = sharedPrefs.getInt('selected_language');

class Routes {
  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: language != null && country != null
        ? '/list'
        : '/imput_parameters_screen',
    //redirect: (context, state) {
    //return language != null && country != null
    //? '/list'
    //: '/imput_parameters_screen';
    //},
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
              return ListScreen();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'details',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final ProductFoodShop extraProductEntity =
                      GoRouterState.of(context).extra! as ProductFoodShop;

                  return DetailsScreen(
                    productEntity: extraProductEntity,
                  );
                },
              ),
            ],
          ),

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/search',
            builder: (BuildContext context, GoRouterState state) {
              return SearchScreen();
            },
            routes: <RouteBase>[
              /// Same as "/a/details", but displayed on the root Navigator by
              /// specifying [parentNavigatorKey]. This will cover both screen B
              /// and the application shell.
              GoRoute(
                path: 'details',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final ProductFoodShop extraProductEntity =
                      GoRouterState.of(context).extra! as ProductFoodShop;

                  return DetailsScreen(
                    productEntity: extraProductEntity,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: '/settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
        ],
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/imput_parameters_screen',
        builder: (BuildContext context, GoRouterState state) {
          return const ParametersScreen();
        },
      ),
    ],
  );
}
