import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/constants/colors.dart';

class BackButtonAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Row(
          children: [
            Icon(
              Ionicons.chevron_back,
              size: 24,
              color: CustomColors.appColorOrange,
            ),
            Text(
              'Back',
              style: TextStyle(
                color: CustomColors.appColorOrange,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
