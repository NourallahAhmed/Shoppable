import 'package:flutter/material.dart';

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