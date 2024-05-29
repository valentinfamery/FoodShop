import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportMeDialog extends StatelessWidget {
  const SupportMeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Dons"),
      content: SizedBox(
        width: 300,
        height: 400,
        child: Wrap(
          children: [
            InkWell(
              onTap: () {
                launchURL('http://revolut.me/neoazubal');
              },
              child: const Text(
                'http://revolut.me/neoazubal',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SelectableText(
              'XMR : 49VUrysbt5p6MYoSbhBpo9hbR1uZyRuq15VpgYSxv8ceA4iYqvxkVGzVkD4JcqVMr2fs8bK7Jyoq9SmA5gLGuvYM5YEpXXr ',
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Fermer'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<void> launchURL(String stringUrl) async {
    Uri url = Uri.parse(stringUrl);
    if (await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
