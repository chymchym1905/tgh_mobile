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
  FToast fToast = FToast();

  // Add a form key to validate the form
  final _formKey = GlobalKey<FormState>();

  // Add keys for each field to access their validation state
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    fToast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final email = ref.read(sharedPrefsServiceProvider).get('email').toString();
      emailController.text = email == 'null' ? '' : email;

      final redirectedFrom = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['from'];

      if (redirectedFrom != null) {
        fToast.showToast(
            child: toast(context, "Please Login to access this feature"),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 5));
      }
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UniformTextFormField(
                          fieldKey: _emailFieldKey,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email',
                          textAlignVertical: TextAlignVertical.top,
                          colorTheme: Colors.white,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            // Simple email validation
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          icon: SizedBox(
                              height: 10,
                              child: Icon(Icons.alternate_email,
                                  opticalSize: 24,
                                  weight: 700,
                                  grade: 0,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.primary))),
                      UniformTextFormField(
                          fieldKey: _passwordFieldKey,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          colorTheme: Colors.white,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          textAlignVertical: TextAlignVertical.top,
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

                                  // Validate all fields
                                  _emailFieldKey.currentState?.validate();
                                  _passwordFieldKey.currentState?.validate();

                                  // Check if the form is valid
                                  if (_formKey.currentState?.validate() ?? false) {
                                    final state = await ref
                                        .read(authNotifierProvider.notifier)
                                        .login(emailController.text, passwordController.text);
                                    if (state is AuthStateError && context.mounted) {
                                      fToast.showToast(
                                          child: toast(context, 'Incorrect email or password'),
                                          gravity: ToastGravity.BOTTOM,
                                          toastDuration: const Duration(seconds: 5));
                                      return;
                                    }

                                    // After successful login, check if we need to redirect to a specific page
                                    if (context.mounted) {
                                      final fromPath = GoRouter.of(context)
                                          .routeInformationProvider
                                          .value
                                          .uri
                                          .queryParameters['from'];
                                      if (fromPath != null && fromPath.isNotEmpty) {
                                        context.go(fromPath);
                                      }
                                    }
                                  } else {
                                    // Show a toast message if validation fails
                                    fToast.showToast(
                                        child: toast(context, 'Please fix the errors in the form'),
                                        gravity: ToastGravity.BOTTOM,
                                        toastDuration: const Duration(seconds: 5));
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
                                    barrierDismissible: true, // Allow dismissing by tapping outside
                                    builder: (context) {
                                      return AlertDialog.adaptive(
                                        title: Text('Reset Password', style: Theme.of(context).textTheme.titleLarge),
                                        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        content: defaultTargetPlatform == TargetPlatform.iOS ||
                                                defaultTargetPlatform == TargetPlatform.macOS
                                            ? CupertinoTextFormFieldRow(
                                                controller: passwordResetController,
                                                padding: EdgeInsets.zero,
                                                keyboardType: TextInputType.emailAddress,
                                                placeholder: 'Email',
                                                prefix: Icon(Icons.alternate_email,
                                                    color: Theme.of(context).colorScheme.primary),
                                                style:
                                                    TextStyle(color: Theme.of(context).extension<TextColors>()!.text))
                                            : UniformTextFormField(
                                                padding: EdgeInsets.zero,
                                                controller: passwordResetController,
                                                keyboardType: TextInputType.emailAddress,
                                                labelText: 'Email',
                                                icon: Icon(Icons.alternate_email,
                                                    color: Theme.of(context).colorScheme.primary),
                                              ),
                                        titlePadding: const EdgeInsets.all(16),
                                        actionsPadding: const EdgeInsets.all(16),
                                        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                                                  overlayColor: WidgetStatePropertyAll(
                                                      Theme.of(context).colorScheme.surfaceBright),
                                                  shape: WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))),
                                              child: Text('OK',
                                                  style: TextStyle(
                                                      color: Theme.of(context).colorScheme.primary, fontSize: 16)))
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
            ),
          )
        ],
      ),
    );
  }
}
