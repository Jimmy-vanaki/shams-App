import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';

class ScaffoldController extends GetxController {
  var sliderDrawerKey = GlobalKey<SliderDrawerState>();
  void openDrawer() {
    sliderDrawerKey.currentState?.openSlider();
  }

  void closeDrawer() {
    sliderDrawerKey.currentState?.closeSlider();
  }
}
