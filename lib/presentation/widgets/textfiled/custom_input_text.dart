import 'package:flutter/material.dart';
import 'package:flutter_login_app/presentation/theme/theme.dart';

class CustomInputText extends StatefulWidget {
  final String title;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController controller;
  final bool passwordMode;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool autoValid;
  final Widget? preffixWidget;
  final int? maxLines;

  const CustomInputText(
      {Key? key,
      required this.title,
      required this.controller,
      this.inputType,
      this.hintText,
      this.validator,
      this.onChanged,
      this.autoValid = false,
      this.passwordMode = false,
      this.preffixWidget,
      this.maxLines})
      : super(key: key);

  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  bool _passwordInVisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: blackTextStyle.copyWith(
            fontSize: fontSizeDefault,
            fontWeight: medium,
          ),
        ),
        TextFormField(
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          // ignore: prefer_if_null_operators
          keyboardType: widget.inputType ?? TextInputType.text,
          autovalidateMode:
              widget.autoValid ? AutovalidateMode.onUserInteraction : null,
          obscureText: widget.passwordMode ? _passwordInVisible : false,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: blackTextStyle.copyWith(
              fontSize: fontSizeDefault, fontWeight: regular),
          decoration: InputDecoration(
            hintText: widget.hintText ?? "",
            hintStyle: greyTextStyle.copyWith(
                fontSize: fontSizeSmall, fontWeight: regular),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kGreyColor, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kGreyColor, width: 1),
            ),
            // ignore: unnecessary_null_in_if_null_operators
            prefixIcon: widget.preffixWidget ?? null,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 19, maxHeight: 24),
            suffixIcon: widget.passwordMode
                ? IconButton(
                    icon: Icon(
                      _passwordInVisible
                          ? Icons.visibility_off
                          : Icons
                              .visibility, //change icon based on boolean value
                      color: kGreyColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordInVisible =
                            !_passwordInVisible; //change boolean value
                      });
                    },
                  )
                : null,
            errorStyle: const TextStyle(
              fontSize: 10.0,
            ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
