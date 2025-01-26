
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

   CustomTextField({super.key, required this.textEditingController});

  TextEditingController  textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        //hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        // Hint text style
        filled: true,
        fillColor: Colors.grey[900],
        // Input field background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
          BorderSide.none, // Removes the border
        ),
      ),
      style: TextStyle(
          color: Colors.white), // Text color
    );
  }
}
