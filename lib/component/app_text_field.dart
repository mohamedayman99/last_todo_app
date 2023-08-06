import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({Key? key,
    this.onTab,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.readonly = false,
    this.validator,
  }) : super(key: key);
final VoidCallback? onTab;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? label;
  final String? Function(String?)? validator;
  final bool readonly;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTab,
      controller:controller ,
      readOnly: readonly,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();      },
      validator:validator ,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        prefixIcon:prefixIcon ,
        label: label,

      ) ,

    );
  }
}
