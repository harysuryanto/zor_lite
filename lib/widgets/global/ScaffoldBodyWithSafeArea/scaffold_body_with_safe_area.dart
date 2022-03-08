import 'package:flutter/cupertino.dart';

class ScaffoldBodyWithSafeArea extends StatelessWidget {
  const ScaffoldBodyWithSafeArea({
    Key? key,
    required this.children,
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      children: [
        SafeArea(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
