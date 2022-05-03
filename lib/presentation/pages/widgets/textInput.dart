import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  final TextEditingController? textEditController;
  final String? text, errortext;
  final ValueChanged<String>? onChange;
  final bool? enable;
  final int? maxLines, maxLenght;
  final TextInputFormatter? textInputFormatter;
  final TextInputType? textInputType;
  final Icon? icon;
  final FormFieldValidator<String>? validator;
  final FocusNode? emailFocusNode;
  const InputText({
    Key? key,
    this.textEditController,
    this.text,
    this.onChange,
    this.enable = false,
    this.maxLines = 1,
    this.textInputFormatter,
    this.textInputType,
    this.icon,
    this.errortext,
    this.validator, this.emailFocusNode, this.maxLenght,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: TextFormField(
          maxLength: maxLenght,
          maxLines: maxLines,
          controller: textEditController,
          keyboardType: textInputType,
          onChanged: onChange,
          readOnly: enable!,
          inputFormatters: <TextInputFormatter>[textInputFormatter!],
          validator: validator,
          focusNode:  emailFocusNode,
          decoration: InputDecoration(
            errorText: errortext,
            icon: icon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            focusColor: Theme.of(context).colorScheme.primary,
            labelText: text,
            labelStyle:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
            hintStyle: const TextStyle(color: Colors.grey),
            hintText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
          ),
        ));
  }
}
