import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final List<String> items;
  final Function(String) onItemTapped;
  const MyDropdownButton(
      {Key? key, required this.items, required this.onItemTapped})
      : super(key: key);

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      iconSize: 24,
      elevation: 8,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        widget.onItemTapped(dropdownValue);
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
