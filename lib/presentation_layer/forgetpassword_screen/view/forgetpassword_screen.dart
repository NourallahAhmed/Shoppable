import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/forgetpassword_screen/view_model/forget_password_view_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';

import '../../../application_layer/dependency_injection.dart';
import '../../common/state_randerer/state_renderer_impl.dart';
import '../../resources/image_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _forgetPasswordViewModel = instance<ForgetPasswordViewModel>();

  final TextEditingController _userNameController = TextEditingController();


  _bind() {
    _forgetPasswordViewModel.start();
    _userNameController.addListener(
            () => _forgetPasswordViewModel.setUserEmail(_userNameController.text));
  }

  initState(){
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _forgetPasswordViewModel.outputFlowState,
        builder: (context , snapshot){
          return snapshot.data?.getStateContentWidget(context, _getContentWidgets(), (){}) ?? _getContentWidgets();
        },
      ),
    );
  }

  dispose(){
    _forgetPasswordViewModel.dispose();
    super.dispose();
  }
  Widget _getContentWidgets() {
    return Container(
      child: SingleChildScrollView(
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
                        stream: _forgetPasswordViewModel.isUserEmailValid,
                        builder: (context, snapShot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                                label: Text(AppStrings.email),
                                hintText: AppStrings.email,
                                errorText: (snapShot.data ?? true)
                                    ? null
                                    : AppStrings.emailError),
                          );
                        },
                      )),

                  const SizedBox(
                    height: AppSize.s12,
                  ),

                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s30,
            ),

            //reset button

            Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _forgetPasswordViewModel.isAllInputsAreValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: AppSize.s50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed:
                            (snapshot.data ?? false  )
                                ? () {

                              _forgetPasswordViewModel.resetPassword();

                              // Navigator.pushReplacementNamed(context, Routes.homeScreen);
                            }
                                : null ,
                            child: const Text(AppStrings.resetPassword)),
                      );
                    })
            ),

            //resend email

            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                  top: AppPadding.p28),
              child: StreamBuilder<bool>(
                  stream: _forgetPasswordViewModel.isAllInputsAreValid,
                  builder: (context, snapshot) {
                    return Row(

                      children: [TextButton(
                          onPressed:
                          (snapshot.data ?? false  )
                              ? () {

                            _forgetPasswordViewModel.resetPassword();

                            // Navigator.pushReplacementNamed(context, Routes.homeScreen);
                          }
                              : null ,
                          child:  Text(
                            AppStrings.resendMail,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      )   ]);
                  })
            ),

          ],
        ),
      ),
    );
  }
}

