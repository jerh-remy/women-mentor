import 'package:flutter/material.dart';
import 'package:women_mentor/constants/styles.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';

class AddOfferStatementDialog extends StatefulWidget {
  final Function(String) onExpertiseEntered;
  final String? text;

  const AddOfferStatementDialog({
    Key? key,
    required this.onExpertiseEntered,
    this.text,
  }) : super(key: key);

  @override
  _AddOfferStatementDialogState createState() =>
      _AddOfferStatementDialogState();
}

class _AddOfferStatementDialogState extends State<AddOfferStatementDialog> {
  late TextEditingController offerStatementController;

  @override
  void initState() {
    if (widget.text != null) {
      offerStatementController = TextEditingController(text: widget.text);
    } else {
      offerStatementController = TextEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        // height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    'Add Offer Statement'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'This helps potential mentees know what you can help them with',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            letterSpacing: 0.5,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: fieldHeight,
                  alignment: Alignment.centerLeft,
                  padding: fieldPadding,
                  decoration: fieldDecoration,
                  child: TextFormField(
                      controller: offerStatementController,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Add new',
                          hintStyle: TextStyle(fontSize: 15))),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
                child: Text('CONFIRM'),
                onPressed: () {
                  if (offerStatementController.text.isNotEmpty)
                    widget.onExpertiseEntered(offerStatementController.text);
                }),
          ],
        ),
      ),
    );
  }
}
