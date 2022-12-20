import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/application_layer/dependency_injection.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/login_screen/viewmodel/login_viewmodel.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';

import '../../resources/image_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  _bind() {
    _loginViewModel.start();
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));
    _userNameController.addListener(
        () => _loginViewModel.setUserName(_userNameController.text));
  }

  @override
  initState() {

    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidgets();
  }

  Widget _getContentWidgets() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p100),
              child: Center(
                child: Image.asset(ImageManager.logo),
              ),
            ),

            const SizedBox(
              height: AppSize.s100,
            ),

            //text fields
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ///UserName
                  Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: StreamBuilder<bool>(
                        stream: _loginViewModel.userNameValidation,
                        builder: (context, snapShot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                                label: Text(StringsManager.useName),
                                hintText: StringsManager.useName,
                                errorText: (snapShot.data ?? true)
                                    ? null
                                    : StringsManager.useNameError),
                          );
                        },
                      )),

                  const SizedBox(
                    height: AppSize.s12,
                  ),

                  ///Password
                  Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: StreamBuilder<bool>(
                        stream: _loginViewModel.passwordValidation,
                        builder: (context, snapShot) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                label: Text(StringsManager.password),
                                hintText: StringsManager.password,
                                errorText: (snapShot.data ?? true)
                                    ? null
                                    : StringsManager.passwordError),
                          );
                        },
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s30,
            ),

            //login button

            Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(

                    stream: _loginViewModel.isAllInputsValid,
                    builder: (context, snapshot) {

                        return SizedBox(
                          height: AppSize.s50,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed:

                              (snapshot.data ?? false  ) ?  () { Navigator.pushReplacementNamed(context, Routes.homeScreen);} : null , child: Text(StringsManager.login)),
                        );
                })),

            //forget password and register

            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                  top: AppPadding.p28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, Routes.forgetPasswordScreen),
                      child: Text(
                        StringsManager.forgetPassword,
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                  TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, Routes.registerScreen),
                      child: Text(
                        StringsManager.register,
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    _loginViewModel.dispose();
  }
}
