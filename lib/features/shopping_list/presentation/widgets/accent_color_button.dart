import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/config/theme/app_theme.dart';

class AccentColorButton extends ConsumerWidget {
  final Color color;

  const AccentColorButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acProvider = ref.watch(accentColorProvider);
    double size = 32;

    return InkWell(
      onTap: () =>
          ref.read(accentColorProvider.notifier).update((state) => color),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: size * .1,
            color: acProvider == color ? color : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(size),
        ),
        padding: EdgeInsets.all(size * .15),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ),
    );
  }
}
