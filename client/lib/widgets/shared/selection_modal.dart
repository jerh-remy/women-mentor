import 'dart:ui';

import 'package:flutter/cupertino.dart' show showCupertinoModalPopup;
import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class SelectionModal extends StatefulWidget {
  final String? title;
  final int initialIndex;
  final List<dynamic> children;
  final ValueChanged<int> onChanged;
  SelectionModal(
      {required this.children,
      required this.initialIndex,
      required this.onChanged,
      this.title});

  @override
  _SelectionModalState createState() => _SelectionModalState();
}

class _SelectionModalState extends State<SelectionModal> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Material(
        child: Container(
          // height: MediaQuery.of(context).size.height / 2,
          color: Colors.white,
          padding: EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (widget.title != null) ...[
              //   Padding(
              //     padding: EdgeInsets.only(left: 20),
              //     child: Text(widget.title!),
              //   ),
              //   SizedBox(height: 30),
              // ],
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.children.length,
                  itemBuilder: (context, index) {
                    bool selected = selectedIndex == index;
                    return buildListItem(index, context, selected);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: CustomColors.appColorTeal,
                child: SafeArea(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // highlightElevation: 0,
                      // splashColor: Colors.transparent,
                      // highlightColor: Colors.transparent,
                      primary: CustomColors.appColorTeal,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildListItem(int index, BuildContext context, bool selected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onChanged(selectedIndex);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        decoration: BoxDecoration(
          color: selected ? CustomColors.appColorTeal.withOpacity(0.2) : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                widget.children[index],
                style: TextStyle(
                  fontSize: 16.0,
                  color: selected ? CustomColors.appColorTeal : Colors.black54,
                  fontWeight: selected ? FontWeight.bold : null,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            if (selected) ...[
              Icon(
                Icons.done,
                color: CustomColors.appColorTeal,
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<void> showSelectionModal({
  String? title,
  required BuildContext context,
  required List<dynamic> children,
  required int initialIndex,
  required ValueChanged<int> onChanged,
}) async {
  return await showCupertinoModalPopup(
    context: context,
    //filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    builder: (context) {
      return SelectionModal(
        title: title ?? '',
        initialIndex: initialIndex,
        onChanged: onChanged,
        children: children,
      );
    },
  );
}
