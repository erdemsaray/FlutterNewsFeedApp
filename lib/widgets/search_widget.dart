import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    Key? key,
    required this.textFormController,
    required this.hintText,
    required this.formIcon,
    required this.searchClicked,
  }) : super(key: key);

  final TextEditingController textFormController;
  final String hintText;
  final IconData formIcon;
  final IconData? formSuffixIcon = null;
  final VoidCallback searchClicked;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: textFormController,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        hoverColor: Colors.black,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        suffixIcon: IconButton(
          onPressed: () {
            searchClicked();
          },
          icon: Icon(formIcon),
          color: Colors.black,
        ),
        prefixIcon: Icon(
          formSuffixIcon,
          color: Colors.black,
        ),
      ),
    );
  }
}
