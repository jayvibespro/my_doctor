import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:heroicons/heroicons.dart';

import '../../core/utils/constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.label,
    this.validator,
    required this.name,
    this.keyboard,
    this.onTap,
    this.suffixIcon,
    this.readOnly,
    this.controller,
    this.textAlign,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.onChange,
    this.focusNode,
    this.textCapitalization,
    this.isPassword,
    this.initialValue,
    this.inputFormatters,
  });

  final String? label;
  final String hint;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final Function()? onTap;
  final String name;
  final String? initialValue;
  final TextInputType? keyboard;
  final Widget? suffixIcon;
  final bool? readOnly;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? isPassword;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: FormBuilderTextField(
        initialValue: widget.initialValue,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.words,
        inputFormatters: widget.inputFormatters ?? [],
        focusNode: widget.focusNode,
        controller: widget.controller,
        onChanged: widget.onChange,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,
        obscureText: widget.isPassword ?? false ? obscureText : false,
        validator: widget.validator ?? FormBuilderValidators.required(),
        textAlign: widget.textAlign ?? TextAlign.start,
        keyboardType: widget.keyboard,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        cursorColor: cPrimary,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          suffixIcon: widget.isPassword ?? false
              ? InkWell(
                  onTap: () {
                    obscureText = !obscureText;
                    setState(() {});
                  },
                  child: HeroIcon(
                    obscureText ? HeroIcons.eyeSlash : HeroIcons.eye,
                    color: cPrimary,
                  ),
                )
              : widget.suffixIcon ?? const SizedBox(),
          label: Text(
            widget.label ?? widget.hint,
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          prefixIcon: widget.prefixIcon,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: cPrimary.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: Colors.grey.withOpacity(0.2),
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 16,
          ),
        ),
        name: widget.name,
      ),
    );
  }
}
