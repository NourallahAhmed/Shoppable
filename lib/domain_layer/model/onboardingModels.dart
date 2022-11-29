import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/onboarding_screen/view/onboarding_screen.dart';

class SliderObject {
  String txt;
  IconData icon;

  SliderObject({required this.txt, required this.icon});
}


class SliderObjectView{

  SliderObject sliderObject;
  int currentIndex;
  int numOfSliders;

  SliderObjectView(this.sliderObject, this.currentIndex, this.numOfSliders);
}