import 'package:et_eats/src/features/custom_app_bar/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';


class ScaffoldWithAppBar extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const ScaffoldWithAppBar({
    Key? key,
    required this.body,
    required this.title,
    this.actions,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "ET Eats",
        actions: actions,
      ),
      body: body,
    );
  }
}
