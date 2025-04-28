import 'dart:async';

import 'package:flutter/material.dart';

class AsyncTextFormField extends StatefulWidget {
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;
  final String isValidatingMessage;
  final String valueIsEmptyMessage;
  final String valueIsInvalidMessage;
  final String labelText;
  final Widget? icon;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final Color? cursorColor;
  final TextStyle? style;
  final EdgeInsets? padding;
  final bool? canEmpty;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  const AsyncTextFormField(
      {super.key,
      required this.validator,
      required this.validationDebounce,
      required this.controller,
      this.isValidatingMessage = "please wait for the validation to complete",
      this.valueIsEmptyMessage = 'please enter a value',
      this.valueIsInvalidMessage = 'please enter a valid value',
      this.hintText = '',
      required this.labelText,
      this.icon,
      required this.keyboardType,
      this.decoration,
      this.cursorColor,
      this.padding,
      this.canEmpty,
      this.style,
      this.suffixIcon,
      this.focusNode});

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
      child: TextFormField(
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
        // maxLines: 1,
        style: widget.style ?? const TextStyle(color: Colors.white),
        decoration: widget.decoration?.copyWith(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(width: 20, height: 20, child: _normalSuffixIcon()),
                ),
                labelText: widget.labelText) ??
            InputDecoration(
                filled: true,
                labelText: widget.labelText,
                fillColor: Colors.transparent,
                icon: widget.icon,
                suffix: SizedBox(
                  height: 20,
                  width: 20,
                  child: _getSuffixIcon(),
                ),
                hintText: widget.hintText,
                // prefixIcon: Icon(Symbols.alternate_email, opticalSize: 24, weight: 700, grade: 0),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                contentPadding: const EdgeInsets.all(0),
                errorMaxLines: 3,
                errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
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
      return const CircularProgressIndicator(
        strokeWidth: 2.0,
      );
    } else {
      if (widget.controller.text.isNotEmpty && isDirty) {
        return GestureDetector(
            onTap: () => widget.controller.clear(), child: const Icon(Icons.cancel, color: Colors.grey, size: 20));
      } else {
        return Container();
      }
    }
  }

  Widget _getSuffixIcon() {
    if (isValidating) {
      return const CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      );
    } else {
      if (!isValid && isDirty) {
        return const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 20,
        );
      } else if (isValid) {
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      } else {
        return Container();
      }
    }
  }
}
