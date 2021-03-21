import 'dart:ui';

import 'package:flutter/cupertino.dart' show showCupertinoModalPopup;
import 'package:flutter/material.dart';

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
          padding: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null) ...[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(widget.title!),
                ),
                SizedBox(height: 30),
              ],
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
                color: Theme.of(context).colorScheme.secondaryVariant,
                child: SafeArea(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // highlightElevation: 0,
                      // splashColor: Colors.transparent,
                      // highlightColor: Colors.transparent,
                      primary: Theme.of(context).colorScheme.secondaryVariant,
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
    // final type = widget.children[index];
    // if (type.runtimeType == InsuranceCompany) {
    //   InsuranceCompany _insuranceCompany = widget.children[index];
    //   return InkWell(
    //     onTap: () {
    //       setState(() {
    //         selectedIndex = index;
    //       });
    //       widget.onChanged(selectedIndex);
    //       Navigator.pop(context);
    //     },
    //     child: Container(
    //       padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
    //       decoration: BoxDecoration(
    //         color: selected ? Colors.orange.shade50 : null,
    //       ),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: Container(
    //               child: Image.asset(
    //                 _insuranceCompany.logoImagePath,
    //                 height: 36.0,
    //                 width: 36.0,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10.0,
    //           ),
    //           Expanded(
    //             flex: 5,
    //             child: Text(
    //               _insuranceCompany.name,
    //               style: TextStyle(
    //                 fontSize: 16.0,
    //                 color: selected ? Colors.orange.shade300 : Colors.black54,
    //                 fontWeight: selected ? FontWeight.bold : null,
    //               ),
    //             ),
    //           ),
    //           Spacer(
    //             flex: 1,
    //           ),
    //           if (selected) ...[
    //             Icon(
    //               Icons.done,
    //               color: Colors.orange,
    //               size: 18,
    //             ),
    //           ],
    //         ],
    //       ),
    //     ),
    //   );
    // }
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
          color: selected
              ? Theme.of(context).colorScheme.primaryVariant.withOpacity(0.2)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                widget.children[index],
                style: TextStyle(
                  fontSize: 16.0,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black54,
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
                color: Theme.of(context).colorScheme.primary,
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
