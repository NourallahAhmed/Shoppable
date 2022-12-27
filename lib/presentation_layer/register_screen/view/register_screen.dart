import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';

import '../../../application_layer/dependency_injection.dart';
import '../../common/state_randerer/state_renderer_impl.dart';
import '../../resources/image_manager.dart';
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
  final TextEditingController _pictureController = TextEditingController();



  _bind(){
    _registerViewModel.start();
    _passwordController.addListener(() { _registerViewModel.setPassword(_passwordController.text);});
    _emailController.addListener(() { _registerViewModel.setEmail(_emailController.text);});
    _userNameController.addListener(() { _registerViewModel.setUserName(_userNameController.text);});
    _phoneController.addListener(() { _registerViewModel.setPhone(_phoneController.text);});
    _countryCodeController.addListener(() { _registerViewModel.setCountryCode(_countryCodeController.text);});

    //todo: add pic field


    //todo : navigate to home when registered


  }

  @override
  initState(){
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body:
        Center(child: _getContentWidgets())


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

  Widget _getContentWidgets(){
    return SingleChildScrollView(
      child: Column(
        children: [
          ///image
          Padding(
            padding: const EdgeInsets.only(top: AppPadding.p100),
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
                          )
                        );
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
                              label: Text(AppStrings.email),
                              hintText: AppStrings.email,
                              errorText: snapShot.data,
                        )
                        );
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
                  child: Padding(padding:  const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: StreamBuilder<String?>(
                            stream: _registerViewModel.countryCodeValidationMessage,
                            builder: (context, snapShot) {
                              return TextButton(onPressed: (){}, child: Text("+02"));
                              //todo:find pub to get the country codes
                            },
                          )),
                      Expanded(
                          flex: 4,
                          child: StreamBuilder<String?>(
                            stream: _registerViewModel.phoneValidationMessage,
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



                ///photo
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

              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s30,
          ),

          ///photo


          ///buttons
              ///register
              ///already have account


        ],
      ),
    );
  }
  @override
  dispose(){
    _registerViewModel.dispose();
    super.dispose();
  }
}
