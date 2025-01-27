import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/utils/constants/colors.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    super.key,
    required this.optionsList,
    required this.onChange,
    this.label,
    required this.hint,
    this.enableSearch,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.initialValue,
    this.validator,
  });

  final List<DropDownValueModel>? optionsList;
  final String? Function(String?)? validator;
  final dynamic Function(dynamic)? onChange;
  final String? label, hint;
  final bool? enableSearch;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final String? initialValue;

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropDownTextField(
        enableSearch: widget.enableSearch ?? false,
        initialValue: widget.initialValue ?? "",
        // dropdownColor: Colors.white,
        dropDownIconProperty: IconProperty(
          color: cPrimary,
        ),
        clearIconProperty: IconProperty(
          color: cPrimary,
        ),
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        searchDecoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: cPrimary.withOpacity(0.5),
          ),
        ),
        textFieldDecoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          filled: true,
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
          hintText: widget.hint,
          label: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.label ?? widget.hint ?? "",
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 16,
          ),
          prefix: const SizedBox(
            width: 8,
          ),
        ),
        listPadding: ListPadding(top: 15),
        validator: widget.validator ?? FormBuilderValidators.required(),
        dropDownList: widget.optionsList!,
        listTextStyle: const TextStyle(
          color: Colors.black,
        ),
        dropDownItemCount: 10,
        onChanged: widget.onChange!,
      ),
    );
  }
}
