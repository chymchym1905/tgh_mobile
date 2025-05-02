import 'dart:ui';

import 'package:flutter/gestures.dart';

import '../../imports.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailErrorMessage = '';
  bool _isSigningUp = false;

  showError(String errorMessage) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            titlePadding: const EdgeInsets.only(top: 15, left: 20, bottom: 5),
            actionsPadding: const EdgeInsets.only(right: 8, bottom: 8),
            contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            title: const Text('Error'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(errorMessage == '' ? "Unknown Error" : errorMessage, textAlign: TextAlign.center),
            actions: [InkWellTextButton(onTap: () => Navigator.of(context).pop(), text: 'OK')],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login bg.jpg'), fit: BoxFit.cover, opacity: 0.8)),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                  ))),
          GestureDetector(
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: kMaxWidthMobile.toDouble()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AsyncTextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) async {
                        try {
                          await ref.watch(getNameProvider(value).future);
                          return false;
                        } catch (e) {
                          return true;
                        }
                      },
                      validationDebounce: const Duration(milliseconds: 500),
                      controller: nameController,
                      icon: SizedBox(
                          height: 10,
                          child: Icon(Icons.person_rounded,
                              opticalSize: 24,
                              weight: 700,
                              grade: 0,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary)),
                      labelText: "Name",
                      isValidatingMessage: "",
                      valueIsEmptyMessage: "Please enter a name",
                      valueIsInvalidMessage: "Name is not available",
                    ),
                    AsyncTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) async {
                        final RegExp regex = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (regex.hasMatch(value)) {
                          try {
                            await ref.watch(getEmailProvider(value).future);
                            setState(() => emailErrorMessage = 'Email already in use');
                            return false;
                          } catch (e) {
                            return true;
                          }
                        } else {
                          setState(() {
                            emailErrorMessage = 'Please enter a valid email address';
                          });
                          return false;
                        }
                      },
                      validationDebounce: const Duration(milliseconds: 500),
                      controller: emailController,
                      icon: SizedBox(
                          height: 10,
                          child: Icon(Icons.alternate_email_rounded,
                              opticalSize: 24,
                              weight: 700,
                              grade: 0,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary)),
                      labelText: "Email",
                      isValidatingMessage: "",
                      valueIsEmptyMessage: "Please enter a valid email address",
                      valueIsInvalidMessage: emailErrorMessage,
                    ),
                    UniformTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'Password',
                        obscureText: true,
                        validator: (value) {
                          final pattern = RegExp(r"^(?=.*[0-9])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,}$");
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (!pattern.hasMatch(value)) {
                            return 'Password must contain at least 8 characters, one uppercase letter, one number and one special character';
                          }
                          return null;
                        },
                        icon: SizedBox(
                            height: 10,
                            child: Icon(Icons.key_rounded,
                                opticalSize: 24,
                                weight: 700,
                                grade: 0,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary))),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            _isSigningUp = true;
                          });
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showError('Please fill in all fields');
                            setState(() {
                              _isSigningUp = false;
                            });
                            return;
                          }
                          try {
                            await ref
                                .read(
                                    registerProvider(nameController.text, emailController.text, passwordController.text)
                                        .future)
                                .timeout(const Duration(seconds: 10));
                            setState(() {
                              _isSigningUp = false;
                            });
                            if (context.mounted) {
                              showAdaptiveDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                        title: const Text('Registration successful'),
                                        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                                        content: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'An email has been sent to ',
                                                  style: Theme.of(context).textTheme.bodyMedium),
                                              TextSpan(
                                                  text: emailController.text,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(color: Colors.blue)),
                                              TextSpan(
                                                  text:
                                                      '. Please follow the instructions in the email to verify your account',
                                                  style: Theme.of(context).textTheme.bodyMedium)
                                            ])),
                                        titlePadding: const EdgeInsets.all(16),
                                        actionsPadding: const EdgeInsets.all(16),
                                        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                        actions: [InkWellTextButton(onTap: () => context.pop(), text: 'OK')]);
                                  });
                            }
                          } catch (e) {
                            showError(e.toString());
                            setState(() {
                              _isSigningUp = false;
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                            overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.2)),
                            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isSigningUp) ...[
                              const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white))),
                              const SizedBox(width: 20)
                            ],
                            Text('Sign Up',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Already have an account? ',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),
                          TextSpan(
                              text: 'Login',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.go(Routes.login);
                                  }
                                })
                        ]))),
                    20.verticalSpace,
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Browse as guest',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go(Routes.home);
                            }),
                    ]))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
