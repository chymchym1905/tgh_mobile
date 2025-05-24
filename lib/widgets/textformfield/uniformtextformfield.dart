// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../imports.dart';

class UniformTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final String? obscuringCharacter;
  final Widget? icon;
  final String? errorMessage;
  final String? Function(String?)? validator;
  final double? height;
  final Color? colorTheme;
  final EdgeInsets padding;
  final InputDecoration? decoration;
  final bool? enabled;
  final bool? expands;
  final int? maxLines;
  final TextAlignVertical? textAlignVertical;
  final GlobalKey<FormFieldState>? fieldKey;

  const UniformTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    required this.keyboardType,
    this.labelText,
    this.padding = const EdgeInsets.only(right: 32, left: 32, bottom: 30),
    this.obscureText,
    this.obscuringCharacter,
    this.icon,
    this.errorMessage,
    this.validator,
    this.height,
    this.enabled,
    this.colorTheme,
    this.decoration,
    this.expands = false,
    this.maxLines = 1,
    this.textAlignVertical,
    this.fieldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: SizedBox(
          height: height,
          child: TextFormField(
              key: fieldKey,
              keyboardType: keyboardType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: colorTheme ?? Theme.of(context).extension<TextColors>()!.text,
              obscureText: obscureText ?? false,
              obscuringCharacter: obscuringCharacter ?? '•',
              controller: controller,
              validator: validator,
              expands: expands ?? false,
              maxLines: expands == true ? null : maxLines,
              minLines: expands == true ? null : 1,
              textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
              style: TextStyle(color: colorTheme ?? Theme.of(context).extension<TextColors>()!.text, fontSize: 16),
              enabled: enabled,
              decoration: decoration ??
                  InputDecoration(
                      filled: true,
                      labelText: labelText,
                      hintText: hintText,
                      fillColor: Colors.transparent,
                      icon: icon,
                      helperText: ' ',
                      // prefixIcon: Icon(Symbols.alternate_email, opticalSize: 24, weight: 700, grade: 0),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(context).extension<TextColors>()!.text),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(context).extension<TextColors>()!.text),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(context).extension<TextColors>()!.textSecondary),
                      errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                      errorMaxLines: 2,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                      errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: colorTheme ?? Theme.of(context).extension<TextColors>()!.text, width: 2)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: colorTheme ?? Theme.of(context).extension<TextColors>()!.text)))),
        ));
  }
}
