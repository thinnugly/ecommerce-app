// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;
  bool hidePassword = true;
  bool hideconfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isAsyncCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(key: globalKey, child: _registerUI(context)),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/ai-generated-8793193_640.png",
                  fit: BoxFit.contain,
                  width: 150,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                Config.appName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const SizedBox(height: 10),
            ],
          ),
          const Center(
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FormHelper.inputFieldWidget(
            context,
            "fullName",
            "Full Name",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }

              return null;
            },
            (onSavedVal) {
              fullName = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.face),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withAlpha(77),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade400,
          ),
          const SizedBox(height: 10),
          FormHelper.inputFieldWidget(
            context,
            "email",
            "Email",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }

              bool emailValid = RegExp(
                r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
              ).hasMatch(onValidateVal);

              if (!emailValid) {
                return "Invalid E-mail";
              }

              return null;
            },
            (onSavedVal) {
              email = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withAlpha(77),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade400,
          ),
          const SizedBox(height: 10),
          FormHelper.inputFieldWidget(
            context,
            "password",
            "Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }

              return null;
            },
            (onSavedVal) {
              password = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.lock_open),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withAlpha(77),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade400,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent.withAlpha(102),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            onChange: (val) {
              password = val;
            },
          ),
          const SizedBox(height: 10),
          FormHelper.inputFieldWidget(
            context,
            "confirmPassword",
            "Confirm Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }
              if (onValidateVal != password) {
                return "Confirm Password not matched";
              }
              return null;
            },
            (onSavedVal) {
              confirmPassword = onSavedVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.lock_open),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withAlpha(77),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade400,
            obscureText: hideconfirmPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hideconfirmPassword = !hideconfirmPassword;
                });
              },
              color: Colors.redAccent.withAlpha(102),
              icon: Icon(
                hideconfirmPassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: FormHelper.submitButton(
              "Sign Up",
              () {
                if (validadeSave()) {
                  //API Request
                  setState(() {
                    isAsyncCallProcess = true;
                  });

                  APIService.registerUser(fullName!, email!, password!).then((
                    response,
                  ) {
                    setState(() {
                      isAsyncCallProcess = false;
                    });

                    if (response) {
                      //logger.i("Registration completed successfully");
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Registration completed successfully.",
                        "Ok",
                        () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login",
                            (route) => false,
                            arguments: {"email": email, "password": password},
                          );
                        },
                      );
                    } else {
                      //logger.i("This E-mail already registed");
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "This E-mail already registed.",
                        "Ok",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  });
                }
              },
              btnColor: Colors.deepOrange,
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 20,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login",
                              (route) => false,
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validadeSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
