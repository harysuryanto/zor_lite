import 'package:flutter/cupertino.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final themeBrightness = CupertinoTheme.brightnessOf(context);
    final subtitleColor = themeBrightness == Brightness.dark
        ? CupertinoColors.white.withOpacity(0.5)
        : CupertinoColors.black.withOpacity(0.5);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: CupertinoColors.white.withOpacity(0),
        child: Row(
          children: [
            if (leading != null) leading!,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
