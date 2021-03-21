import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key? key,
    required this.labelText,
    required this.valueText,
    this.valueStyle,
    required this.onPressed,
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle? valueStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        // isEmpty: valueText == null,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 8.0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              borderSide: BorderSide(
                color: CustomColors.appColorGrey.withOpacity(0.4),
                width: 0.5,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              borderSide: BorderSide(
                color: CustomColors.appColorGrey.withOpacity(0.4),
                width: 0.5,
              ),
            )),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(5.0),
          //   ),
          //   border: Border.all(
          //     color: CustomColors.appColorGrey.withOpacity(0.4),
          //     width: 0.5,
          //   ),
          // ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  valueText,
                  style: valueStyle ?? TextStyle(fontSize: 15.0),
                ),
              )),
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black54
                      : Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
