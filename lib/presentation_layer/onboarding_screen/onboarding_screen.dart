import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';

class OnBoardinScreen extends StatefulWidget {
  const OnBoardinScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardinScreen> createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.darkPrimary,
    );
  }
}
