// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/config.dart';
import 'package:frontend/utils/shared_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? email;
  String? password;
  bool hidePassword = true;
  bool isRemember = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map) {
      if (args['email'] != null) {
        _emailController.text = args['email'];
        email = args['email'];
      }

      if (args['password'] != null) {
        _passwordController.text = args['password'];
        password = args['password'];
      }

      if (args['mensagem'] != null && args['mensagem'].isNotEmpty) {
        Future.microtask(() {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(args['mensagem'])));
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isAsyncCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(key: globalKey, child: _loginUI(context)),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
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
              "Login",
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
          Center(
            child: FormHelper.submitButton(
              "Sign In",
              () async {
                if (validadeSave()) {
                  setState(() {
                    isAsyncCallProcess = true;
                  });

                  try {
                    final response = await APIService.loginUser(
                      email!,
                      password!,
                    );
                    setState(() {
                      isAsyncCallProcess = false;
                    });

                    if (response != null && response.isNotEmpty) {
                      await SharedService.setLoginDetails({
                        'token': response['token'],
                        'fullName': response['fullName'],
                        'email': email,
                        'userId': response['userId'],
                      });
                      // logger.i(SharedService.loginDetails());
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "User logged-In successfully.",
                        "Ok",
                        () {
                          Navigator.of(context).pop();
                          Navigator.of(
                            context,
                          ).pushNamedAndRemoveUntil("/home", (route) => false);
                        },
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Invalid E-mail/Password.",
                        "Ok",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  } catch (e) {
                    setState(() {
                      isAsyncCallProcess = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString().replaceAll("Exception: ", ""),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
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
                  TextSpan(text: "Don’t have an account? "),
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/register",
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
