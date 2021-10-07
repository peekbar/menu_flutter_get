import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:menu_flutter_get/data_handling/models/food_category.dart';
import 'package:menu_flutter_get/data_handling/models/imprint.dart';
import 'package:menu_flutter_get/data_handling/models/menu.dart';

import '../controller.dart';
import '../custom_colors.dart';


class NavigationListStateless extends StatelessWidget {

  final List<FoodCategory> categoryList;
  final Menu menu;
  final Controller c = Get.find(); 
  
  final double spacerSize = 16.0;
  final double fontSize = 20.0;

  NavigationListStateless(this.categoryList, this.menu, {Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];

    rows.addAll(generateNavigationRegularItems(categoryList));
    rows.add(getSpacer());
    
    // top scroll effect not working when shrinkWrap: true
    // it also seems, like theres a performance problem when shrinkWrap: true
    return ListView(
      shrinkWrap: true,
      children: rows,
    );
  }

  // returns a list with all the regular widgets for the navigation 
  List<Widget> generateNavigationRegularItems(List<FoodCategory> categoryList) {
  
    List<Widget> rows = [];
    for (var i = 0; i < categoryList.length; i++) {
      rows.add(Obx(()=>getRegularItem(i, categoryList[i].name, c.selectedItem.value == i, categoryList[i].icon)));
      rows.add(getSpacer());
    }
    rows.add(Obx(()=>generateNavigationImprint(menu.imprint)));
    return rows;
  }


  // returns a list with all the small widgets of the navigation 
  Widget getRegularItem(int i, String title, bool selected, String icon) {
    double rowHeight;
    double additonalPaddingLeft;
    var fontWeight;
    print('regularItem: ' + i.toString());
    if (selected) {
      rowHeight = 100;
      additonalPaddingLeft = 0;
      fontWeight = FontWeight.w800;
    } else {
      rowHeight = 70;
      additonalPaddingLeft = 15;
      fontWeight = FontWeight.w500;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        c.changeSelectedNavigation(i);
      },
      child: Container(
        height: rowHeight,
        padding: EdgeInsets.only(left: additonalPaddingLeft),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: rowHeight,
              width: rowHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(rowHeight/2)),
                color: CustomColors.shade,
                border: Border.all(
                  color: CustomColors.shade,
                  width: 2.0
                  )
              ),
              child: Image.network('https://datadirectory-453ba.web.app/dataDirectory/icons/icon3.png')
            ),
            Container(
              width: 10,
              ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child:Text(
                title,
                style: GoogleFonts.solway(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: CustomColors.instance.getTextColor(CustomColors.background)
                )
              )
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward,
                  color: CustomColors.instance.getTextColor(CustomColors.background),
                  size: 24,
                )
              )
            )
          ]
        )
      )
    );
  }


  // returns a list with all the small widgets of the navigation
  Widget generateNavigationImprint(Imprint imprint) {

      var textColor = CustomColors.instance.getTextColor(CustomColors.background);

      if (c.selectedImprint.value) {
        textColor = CustomColors.selected;
      }

      return GestureDetector(
          onTap: () {
            c.selectImprint();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Opacity(
              opacity: 0.7,
              child: Text(
                'Impressum',
                style: GoogleFonts.solway(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: textColor
                )
              ),
            )
          )
        );
  }


  //
  Container getSpacer() {
    return Container(
      width: spacerSize,
      height: spacerSize
    );
  }


  //
  void insertFinishedRow(
      List<Widget> rows,
      List<Widget> row,
      bool insertSpacerTop,
      bool insertSpacerBottom
      ) {
    if (insertSpacerTop) {
      rows.add(getSpacer());
    }

    rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row,
        )
    );
  }


  //
  void topUpRow(List<Widget> row, int expectedRowElementCount) {
    while (expectedRowElementCount > row.length) {
      row.add(getSpacer());
      row.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 55 / 34,
              child: Container(),
            ),
          )
      );
    }
  }
}



