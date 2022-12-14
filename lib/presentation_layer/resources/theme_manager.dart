import 'package:flutter/material.dart';
import '/presentation_layer/resources/color_manager.dart';
import '/presentation_layer/resources/font_manager.dart';
import '/presentation_layer/resources/style_manager.dart';
import '/presentation_layer/resources/value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    // ripple effect color
    // cardview theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),
    // app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle: getRegularStyle(
            fontSize: FontSizes.s16, color: ColorManager.white)),
    // button theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary),

    // text theme
    textTheme: TextTheme(
        displayLarge:
            getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSizes.s22),
        displayMedium: getRegularStyle(color: ColorManager.black , fontSize: AppSize.s14),
        displaySmall: getRegularStyle(color: ColorManager.black , fontSize: AppSize.s12),
        headlineLarge : getRegularStyle(color: ColorManager.primary , fontSize: AppSize.s20),
        headlineMedium: getRegularStyle(color: ColorManager.grey1),
        headlineSmall: getRegularStyle(color: ColorManager.grey, fontSize: FontSizes.s14),
        titleMedium: getMeduimStyle(
            color: ColorManager.black, fontSize: FontSizes.s12),

        titleLarge: getMeduimStyle(
            color: ColorManager.white, fontSize: FontSizes.s14),

        titleSmall: getRegularStyle(
            color: ColorManager.white, fontSize: FontSizes.s20),


        labelLarge: getRegularStyle(color: ColorManager.grey)),

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSizes.s17),
            primary: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSizes.s14),
        labelStyle:
            getMeduimStyle(color: ColorManager.grey, fontSize: FontSizes.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),



  );
}
