import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import '../../imports.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordResetController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final email = ref.read(sharedPrefsServiceProvider).get('email').toString();
      emailController.text = email == 'null' ? '' : email;
    });
    super.initState();
  }

  showError(String errorMessage) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Error'),
            content: Text(errorMessage == '' ? "Unknown Error" : errorMessage),
            backgroundColor: Theme.of(context).colorScheme.primary,
            titlePadding: const EdgeInsets.only(top: 15, left: 20, bottom: 5),
            actionsPadding: const EdgeInsets.only(right: 8, bottom: 8),
            contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.1)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                  child: Text('OK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login bg.jpg'), fit: BoxFit.cover, opacity: 0.8)),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(color: Colors.black.withOpacity(0.8)))),
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
                    UniformTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        icon: SizedBox(
                            height: 10,
                            child: Icon(Icons.alternate_email,
                                opticalSize: 24,
                                weight: 700,
                                grade: 0,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary))),
                    UniformTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'Password',
                        obscureText: true,
                        icon: SizedBox(
                            height: 10,
                            child: Icon(Icons.key,
                                opticalSize: 24,
                                weight: 700,
                                grade: 0,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary))),
                    TextButton(
                        onPressed: authState is AsyncLoading
                            ? null // Disable the button while loading
                            : () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                await ref
                                    .read(authNotifierProvider.notifier)
                                    .login(emailController.text, passwordController.text);
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
                            if (authState is AsyncLoading) ...[
                              const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white))),
                              const SizedBox(width: 20)
                            ],
                            Text(authState is AsyncLoading ? "Logging in..." : 'Login',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white))
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),
                          TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push(Routes.register);
                                })
                        ]))),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Forgot Password?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showAdaptiveDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                      title: Text('Reset Password', style: Theme.of(context).textTheme.titleLarge),
                                      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      content: defaultTargetPlatform == TargetPlatform.android
                                          ? UniformTextFormField(
                                              padding: EdgeInsets.zero,
                                              controller: passwordResetController,
                                              keyboardType: TextInputType.emailAddress,
                                              labelText: 'Email',
                                              icon: Icon(Icons.alternate_email,
                                                  color: Theme.of(context).colorScheme.primary),
                                              colorTheme: Theme.of(context).extension<TextColors>()!.text,
                                            )
                                          : CupertinoTextFormFieldRow(
                                              controller: passwordResetController,
                                              padding: EdgeInsets.zero,
                                              keyboardType: TextInputType.emailAddress,
                                              placeholder: 'Email',
                                              prefix: Icon(Icons.alternate_email,
                                                  color: Theme.of(context).colorScheme.primary),
                                              style: TextStyle(color: Theme.of(context).extension<TextColors>()!.text)),
                                      titlePadding: const EdgeInsets.all(16),
                                      actionsPadding: const EdgeInsets.all(16),
                                      contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                      actions: [
                                        InkWellTextButton(onTap: () => Navigator.of(context).pop(), text: 'OK')
                                      ],
                                    );
                                  });
                            })
                    ])),
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
