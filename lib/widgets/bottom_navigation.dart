import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_colors.dart';
import '../../controller.dart';

class BottomNavigationStateless extends StatelessWidget {

  final int pageNumber;
  final String subpageTitle;
  final Controller c = Get.find();
  var firstPageColor = CustomColors.shade;
  var secondPageColor = CustomColors.background;

  BottomNavigationStateless(this.pageNumber, this.subpageTitle, {Key? key}) {
    if (pageNumber == 0) {
      firstPageColor = CustomColors.shade;
      secondPageColor = CustomColors.background;
    } else {
      firstPageColor = CustomColors.background;
      secondPageColor = CustomColors.shade;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("newBottomNav");
    
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: CustomColors.background,
          boxShadow: [BoxShadow(offset: Offset(10,10), color: Color(0xFF000000).withOpacity(0.2), blurRadius: 20)]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  c.changePageNumber(0);
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: firstPageColor,
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Startseite',
                        style: GoogleFonts.solway(
                          color: CustomColors.instance.getTextColor(firstPageColor)
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  c.changePageNumber(1);
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: secondPageColor,
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        subpageTitle,
                        style: GoogleFonts.solway(
                          color: CustomColors.instance.getTextColor(secondPageColor)
                          ),
                        )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


