import 'package:flutter/material.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/support_me_dialog.dart';

class SupportMeButton extends StatelessWidget {
  final String title;
  final String description;

  const SupportMeButton({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        showMyDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text("$description."),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const SupportMeDialog();
      },
    );
  }
}
