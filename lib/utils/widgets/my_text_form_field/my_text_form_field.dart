import 'package:flutter/material.dart';

import '../../text_styles/text_styles.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String?Function(String?) validator;
  final bool isPassword;
  const MyTextFormField({super.key , required this.controller, required this.title,required this.validator ,this.isPassword = false});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {

  late bool obsecureText;

  @override
  void initState() {
        super.initState();
        obsecureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyle.font18GeryTextStyle(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: obsecureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            suffixIcon: widget.isPassword ? IconButton(
                onPressed: (){
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
                icon: Icon(
                  !obsecureText ? Icons.visibility_outlined:Icons.visibility_off_outlined,
                ),
            ):null,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
