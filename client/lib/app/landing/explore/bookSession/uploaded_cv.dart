import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_mentor/constants/strings.dart';

class UploadedCV extends StatelessWidget {
  final double? height;
  final VoidCallback? onTap;

  const UploadedCV({Key? key, this.height = 160, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Stack(
        children: [
          PhysicalModel(
            color: Colors.grey.shade100,
            elevation: 4,
            shadowColor: Colors.black54,
            borderRadius: BorderRadius.circular(4.0),
            child: Container(
              width: 120,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SvgPicture.asset(
                  Strings.logo,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 40,
                  child: Text(
                    'CV 2020',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black45,
                        Colors.black54,
                        Colors.black87,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
