// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../imports.dart';

class UniformTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final bool? obscureText;
  final String? obscuringCharacter;
  final Widget? icon;
  final String? errorMessage;
  final String? Function(String?)? validator;
  final Color colorTheme;
  final EdgeInsets padding;
  const UniformTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    this.colorTheme = Colors.white,
    this.padding = const EdgeInsets.only(right: 32, left: 32, bottom: 30),
    this.obscureText,
    this.obscuringCharacter,
    this.icon,
    this.errorMessage,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: TextFormField(
            keyboardType: keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: colorTheme,
            obscureText: obscureText ?? false,
            obscuringCharacter: obscuringCharacter ?? '•',
            controller: controller,
            validator: validator,
            style: TextStyle(color: colorTheme, fontSize: 16),
            decoration: InputDecoration(
                filled: true,
                // labelText: labelText,
                hintText: labelText,
                fillColor: Colors.transparent,
                icon: icon,
                // prefixIcon: Icon(Symbols.alternate_email, opticalSize: 24, weight: 700, grade: 0),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: colorTheme),
                // labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: colorTheme),
                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                errorMaxLines: 3,
                contentPadding: const EdgeInsets.all(0),
                errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorTheme, width: 2)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colorTheme)))));
  }
}
