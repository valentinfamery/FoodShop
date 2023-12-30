import 'package:flutter/material.dart';

/// The details screen for either the A, B or C screen.
class DetailsScreen extends StatelessWidget {

   /// The label to display in the center of the screen.
  final String? label;

  /// Constructs a [DetailsScreen].
   const DetailsScreen({
    required this.label,
    super.key,
  });

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}