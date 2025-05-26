import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgh_mobile/theme.dart';

class AsyncTextFormField extends StatefulWidget {
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;
  final String isValidatingMessage;
  final String valueIsEmptyMessage;
  final String valueIsInvalidMessage;
  final Widget? icon;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final Color? cursorColor;
  final TextStyle? style;
  final EdgeInsets? padding;
  final bool? canEmpty;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final double? height;
  final Color? colorTheme;
  final GlobalKey<FormFieldState>? fieldKey;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const AsyncTextFormField({
    super.key,
    required this.validator,
    required this.validationDebounce,
    required this.controller,
    this.isValidatingMessage = "please wait for the validation to complete",
    this.valueIsEmptyMessage = 'please enter a value',
    this.valueIsInvalidMessage = 'please enter a valid value',
    this.hintText = '',
    this.icon,
    required this.keyboardType,
    this.decoration,
    this.cursorColor,
    this.padding,
    this.canEmpty,
    this.style,
    this.suffixIcon,
    this.height,
    this.colorTheme,
    this.focusNode,
    this.fieldKey,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  State<AsyncTextFormField> createState() => _AsyncTextFormFieldState();
}

class _AsyncTextFormFieldState extends State<AsyncTextFormField> with WidgetsBindingObserver {
  Timer? _debounce;
  var isValidating = false;
  var isValid = true;
  var isDirty = false;
  var isWaiting = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      check(widget.controller.text);
      setState(() {});
    }
    super.didChangeAppLifecycleState(state);
  }

  void check(String text) async {
    isDirty = true;
    if (text.isEmpty) {
      setState(() {
        if (widget.canEmpty == null || widget.canEmpty == false) isValid = false;
      });
      cancelTimer();
      return;
    }
    isWaiting = true;
    cancelTimer();
    _debounce = Timer(widget.validationDebounce, () async {
      isWaiting = false;
      isValid = await validate(text);
      setState(() {});
      isValidating = false;
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(right: 32, left: 32, bottom: 30),
      child: SizedBox(
        height: widget.height ?? 56,
        child: TextFormField(
          key: widget.fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          cursorColor: widget.cursorColor ?? Colors.white,
          validator: (value) {
            if (value?.isEmpty ?? false) {
              if (widget.canEmpty == true) return null;
              return widget.valueIsEmptyMessage;
            }
            if (!isWaiting && !isValid) {
              return widget.valueIsInvalidMessage;
            }
            return null;
          },
          onChanged: (text) async {
            isDirty = true;
            if (text.isEmpty) {
              setState(() {
                if (widget.canEmpty == null || widget.canEmpty == false) isValid = false;
              });
              cancelTimer();
              return;
            }
            isWaiting = true;
            cancelTimer();
            _debounce = Timer(widget.validationDebounce, () async {
              isWaiting = false;
              isValid = await validate(text);
              setState(() {});
              isValidating = false;
            });
          },
          controller: widget.controller,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          // textAlignVertical: TextAlignVertical.center,
          // maxLines: 1,
          style: widget.style ??
              TextStyle(color: widget.colorTheme ?? Theme.of(context).extension<TextColors>()!.text, fontSize: 16),
          decoration: widget.decoration?.copyWith(
                  suffixIcon: Padding(padding: const EdgeInsetsDirectional.only(end: 10), child: _normalSuffixIcon()),
                  hintText: widget.hintText) ??
              InputDecoration(
                  filled: true,
                  helperText: ' ',
                  // labelText: widget.labelText,
                  fillColor: Colors.transparent,
                  icon: widget.icon,
                  suffixIcon: _getSuffixIcon(),
                  hintText: widget.hintText,
                  // prefixIcon: Icon(Symbols.alternate_email, opticalSize: 24, weight: 700, grade: 0),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: widget.colorTheme ?? Theme.of(context).extension<TextColors>()!.text),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).extension<TextColors>()!.textSecondary),
                  // labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  contentPadding: const EdgeInsets.only(top: 14),
                  errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                  errorMaxLines: 3,
                  errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.colorTheme ?? Theme.of(context).extension<TextColors>()!.text, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: widget.colorTheme ?? Theme.of(context).extension<TextColors>()!.text))),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _debounce?.cancel();
    super.dispose();
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  Future<bool> validate(String text) async {
    setState(() {
      isValidating = true;
    });
    var isValid = await widget.validator(text);
    if (text == "") {
      if (widget.canEmpty == null || widget.canEmpty == false) isValid = false;
    }
    isValidating = false;
    return isValid;
  }

  Widget _normalSuffixIcon() {
    if (isValidating) {
      return Container(
        padding: const EdgeInsetsDirectional.all(8),
        width: widget.height != null ? widget.height! : 40,
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      if (widget.controller.text.isNotEmpty && isDirty) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => widget.controller.clear(), child: const Icon(Icons.cancel, color: Colors.grey, size: 20)),
        );
      } else {
        return widget.suffixIcon ?? const SizedBox.shrink();
      }
    }
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return Container(
        padding: const EdgeInsets.all(8),
        width: widget.height != null ? widget.height! : 40,
        height: 20,
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      );
    } else {
      if (!isValid && isDirty) {
        return const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid && isDirty) {
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}
