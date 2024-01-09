import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The second screen in the bottom navigation bar.
class SearchScreen extends StatelessWidget {
  /// Constructs a [SearchScreen] widget.
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Search Screen'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/search/details');
              },
              child: const Text('View Search details'),
            ),
          ],
        ),
      ),
    );
  }
}
