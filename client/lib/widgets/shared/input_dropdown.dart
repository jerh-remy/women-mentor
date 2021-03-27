import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/selection_modal.dart';

class InputDropdown extends StatefulWidget {
  const InputDropdown({
    Key? key,
    required this.labelText,
    required this.onItemTapped,
    required this.items,
  }) : super(key: key);

  final String labelText;

  final List<String> items;
  final Function(String) onItemTapped;

  @override
  _InputDropdownState createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   onTap: onPressed,
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    //     decoration: BoxDecoration(
    //       color: Colors.grey[100],
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(4.0),
    //       ),
    //       // border: Border.all(
    //       //   color: CustomColors.appColorGrey.withOpacity(0.4),
    //       //   width: 0.5,
    //       // ),
    //     ),
    //     width: double.infinity,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Expanded(
    //             child: Text(valueText,
    //                 style: valueStyle ?? TextStyle(fontSize: 15.0))),
    //         Icon(Icons.arrow_drop_down,
    //             color: Theme.of(context).brightness == Brightness.light
    //                 ? Colors.black54
    //                 : Colors.white70),
    //       ],
    //     ),
    //   ),
    // );

    return InkWell(
      onTap: () {
        showSelectionModal(
          children: widget.items,
          context: context,
          initialIndex: _currentIndex,
          onChanged: (selectedIndex) {
            setState(() {
              _currentIndex = selectedIndex;
            });
          },
        );
        widget.onItemTapped(widget.items[_currentIndex]);
      },
      child: InputDecorator(
        // isEmpty: valueText == null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 8.0),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText,
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
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              borderSide: BorderSide.none),
        ),
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.items[_currentIndex],
                  style: TextStyle(fontSize: 15.0),
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
