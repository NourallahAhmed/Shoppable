
import 'package:flutter/material.dart';

var baseImageURL = "assets/images";
var baseJsonURL = "assets/json";

class ImageManager{
  static String logo = "${baseImageURL}/shopping-cart.png";
}
class JsonManager{
  static String emptyJson = "${baseJsonURL}/empty.json";
  static String loadingJson = "${baseJsonURL}/loading.json";
  static String errorJson = "${baseJsonURL}/error.json";
  static String successJson = "${baseJsonURL}/success.json";
  // static String successJson = "${baseJsonURL}/success.json";
}
class IconManager{
  static IconData shopingCart =  Icons.shopping_bag_outlined;
  static IconData deliveryIcon =  Icons.delivery_dining;
  static IconData backArrow = Icons.arrow_back_ios;
  static IconData nextArrow = Icons.arrow_forward_ios;
  static IconData solidCircle = Icons.circle;
  static IconData hollowCircle = Icons.circle_outlined;
  static IconData cameraIcon = Icons.camera_alt_outlined;
  static IconData galleryIcon = Icons.camera;

}