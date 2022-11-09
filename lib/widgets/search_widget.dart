import 'package:flutter/material.dart';
import 'package:newsapp/utils/project_variables.dart';

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
      style: TextStyle(color: ProjectColors.textColorBlack),
      controller: textFormController,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ProjectColors.textColorBlack,
          ),
        ),
        hoverColor: ProjectColors.textColorBlack,
        hintText: hintText,
        hintStyle: TextStyle(color: ProjectColors.textColorBlack),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            searchClicked();
          },
          icon: Icon(formIcon),
          color: ProjectColors.iconBlackColor,
        ),
        prefixIcon: Icon(
          formSuffixIcon,
          color: ProjectColors.iconBlackColor,
        ),
      ),
    );
  }
}
