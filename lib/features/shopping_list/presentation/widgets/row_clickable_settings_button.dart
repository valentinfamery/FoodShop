import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/accent_color_button.dart';

class RowClickableSettingsButton extends ConsumerWidget {
  final String title;
  final String description;

  const RowClickableSettingsButton({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showMyDialog(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(description),
        ],
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: const SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccentColorButton(color: Color(0xFFE54C41)),
                AccentColorButton(color: Color(0xFFFFCD29)),
                AccentColorButton(color: Color(0xFF14AE5C)),
                AccentColorButton(color: Color(0xFF4C88EF)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
