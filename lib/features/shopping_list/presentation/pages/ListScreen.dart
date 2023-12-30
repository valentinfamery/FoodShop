import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The third screen in the bottom navigation bar.
class ListScreen extends StatelessWidget {
  /// Constructs a [ListScreen] widget.
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(4, (index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: InkWell(
  onTap: () {
    GoRouter.of(context).go('/list/details',extra: 'Card ${index + 1}');
    // Action à effectuer lors du clic
  },
  child: 
    
    // Votre contenu de boîte ici
    Center(
              child: Text(
                'Card ${index + 1}',
                style: TextStyle(fontSize: 20),
              ),
            ),
  
),
          );
        }),
      ),
    );
  }
}


