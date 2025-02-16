import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintname;
  final int maxLines;
  const CustomTextField(
      {super.key, required this.controller, required this.hintname, this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black45,
            )),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black45,
            )),
            hintText: hintname,
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hintname';
          }
          return null;
        },
      ),
    );
  }
}
