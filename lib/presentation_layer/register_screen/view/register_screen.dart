import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/style_manager.dart';

import '../../../application_layer/dependency_injection.dart';
import '../../resources/image_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../view_model/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();

  final ImagePicker _imagePicker = instance<ImagePicker>();

  _bind() {
    _registerViewModel.start();
    _passwordController.addListener(() {
      _registerViewModel.setPassword(_passwordController.text);
    });
    _emailController.addListener(() {
      _registerViewModel.setEmail(_emailController.text);
    });
    _userNameController.addListener(() {
      _registerViewModel.setUserName(_userNameController.text);
    });
    _phoneController.addListener(() {
      _registerViewModel.setPhone(_phoneController.text);
    });
    _countryCodeController.addListener(() {
      _registerViewModel.setCountryCode(_countryCodeController.text);
    });

    _registerViewModel.isRegisteredSuccessfullyStreamController.stream
        .listen((isRegistered) {
      if (isRegistered) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
        });
      }
    });
  }

  @override
  initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: Center(child: _getContentWidgets())

      // StreamBuilder<FlowState>(
      //   stream: _registerViewModel.outputFlowState,
      //   builder: (context , snapShot){
      //     return snapShot.data?.getStateContentWidget(context, _getContentWidgets(), (){
      //       // _loginViewModel.login();
      //     }) ?? _getContentWidgets();
      //   },
      // ),
    );
  }

  Widget _getContentWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [

          ///image
          Padding(
            padding: const EdgeInsets.only(top: AppPadding.p18),
            child: Center(
              child: Image.asset(ImageManager.logo),
            ),
          ),

          const SizedBox(
            height: AppSize.s100,
          ),

          Form(
            key: _formKey,
            child: Column(
              children: [

                ///UserName
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<String?>(
                      stream: _registerViewModel.userNameValidationMessage,
                      builder: (context, snapShot) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                              label: const Text(AppStrings.useName),
                              hintText: AppStrings.useName,
                              errorText: snapShot.data,
                            ));
                      },
                    )),

                const SizedBox(
                  height: AppSize.s12,
                ),

                ///Email
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<String?>(
                      stream: _registerViewModel.emailValidationMessage,
                      builder: (context, snapShot) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              label: const Text(AppStrings.email),
                              hintText: AppStrings.email,
                              errorText: snapShot.data,
                            ));
                      },
                    )),

                const SizedBox(
                  height: AppSize.s12,
                ),

                ///password
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<String?>(
                      stream: _registerViewModel.passwordValidationMessage,
                      builder: (context, snapShot) {
                        return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              label: Text(AppStrings.password),
                              hintText: AppStrings.password,
                              errorText: snapShot.data,
                            ));
                      },
                    )),

                const SizedBox(
                  height: AppSize.s12,
                ),

                ///Row:
                ///countycode
                ///phone

                Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                onChanged: (country) {
                                  _registerViewModel
                                      .setCountryCode(country.code ?? "+02");
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'eg',
                                favorite: const ['+39', 'FR'],
                                // optional. Shows only country name and flag
                                showCountryOnly: true,
                                hideMainText: true,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: true,
                                // optional. aligns the flag and the Text left
                                alignLeft: false,
                              )),
                          Expanded(
                              flex: 4,
                              child: StreamBuilder<String?>(
                                stream:
                                _registerViewModel.phoneValidationMessage,
                                builder: (context, snapShot) {
                                  return TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        label: Text(AppStrings.phone),
                                        hintText: AppStrings.phone,
                                        errorText: snapShot.data,
                                      ));
                                },
                              )),
                        ],
                      )),
                ),

                const SizedBox(
                  height: AppSize.s12,
                ),

                ///Photo
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: GestureDetector(
                      child: _getMediaSection(),
                      onTap: () {
                        _showImagePicker(context);
                      },
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s30,
          ),

          ///buttons
          ///register
          Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                  stream: _registerViewModel.isAllInputsAreValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: AppSize.s50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed:
                          (snapshot.data ?? false  )
                              ? () {
                            // _registerViewModel.register();

                            Navigator.pushReplacementNamed(context, Routes.homeScreen);
                          }
                              : null ,
                          child: Text(AppStrings.register)),
                    );
                  })),
          ///already have account
        ],
      ),
    );
  }

  Widget _getMediaSection() {
    return Container(
      padding: const EdgeInsets.only(left: AppPadding.p8 , right: AppPadding.p8 , bottom: AppPadding.p18 , top: AppPadding.p8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
          border: Border.all(color: ColorManager.black)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(AppStrings.photo.trim())),

            Flexible(child: StreamBuilder<File>(
                stream: _registerViewModel.outputPicture,
                builder: (context, snapShot) {
                  return _showPickedImage(snapShot.data);
                }
            )),

            Flexible(child: Icon(IconManager.cameraIcon))
          ],
        ),


    );
  }

  Widget _showPickedImage(File? photo) {
    print(photo?.path ?? "Path Empty");
    if (photo != null && photo.path.isNotEmpty) {
      return Image.file(photo);
    } else {
      return Container(); /*Text(AppStrings.errorPhoto)*/;
    }
  }

  _showImagePicker(BuildContext context) {
     showModalBottomSheet(context: context,
        builder: (BuildContext context){
          return Wrap(
            children: [
              ListTile(
                leading: Icon(IconManager.galleryIcon , color: ColorManager.primary,) ,
                // trailing: Icon(Icons.arrow_forward),
                title: Text(AppStrings.photoFromGallery , style: getRegularStyle(color: ColorManager.grey , fontSize: AppSize.s14)),
                onTap: (){
                      _imageFromGallery();
                      Navigator.of(context).pop();
                },
              ),

              ListTile(
                leading: Icon(IconManager.cameraIcon , color: ColorManager.primary) ,
                // trailing: Icon(Icons.arrow_forward),
                title: Text(AppStrings.photoFromCamera , style: getRegularStyle(color: ColorManager.grey , fontSize: AppSize.s14),),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();

                },
              ),
            ],
          );


        });
  }
  _imageFromGallery() async{
    print("image from gallery");
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    print("image from gallery");

    print(image?.path ?? "EMPTY");
    _registerViewModel.setPhoto(File(image?.path ?? ""));
    print("Finished");
  }
  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _registerViewModel.setPhoto(File(image?.path ?? ""));
  }
  @override
  dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }
}
