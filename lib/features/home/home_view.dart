import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text("hello")],
    ).scaffoldWrapper();
  }
}
