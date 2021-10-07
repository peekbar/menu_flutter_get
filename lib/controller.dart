import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_flutter_get/data_handling/extractor.dart';
import 'package:menu_flutter_get/data_handling/models/menu.dart';
import 'package:menu_flutter_get/widgets/imprint_widget.dart';
import 'package:menu_flutter_get/widgets/menu_list.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'custom_colors.dart';
import 'widgets/navigation_list.dart';
import 'widgets/wrapper_widget.dart';



class Controller extends GetxController {

  var contentLoaded = false.obs;
  var selectedItem = 0.obs; 
  var selectedImprint = false.obs;

  var title = 'Headline'.obs;
  var subpageTitle = 'subpageTitle'.obs;
  var pageNumber = 0.obs;
  var phone = '0123456789'.obs;
  var consent = false.obs;

  Menu? menu;

  Rx<Widget>? widgetList;
  var combinedPageController = PageController(initialPage: 0, keepPage: true);
  
  Controller() {
    combinedPageController.addListener(() {
      double pos = combinedPageController.page!;
      if (pos == 0 && pos != pageNumber.value) {
        pageNumber.value = 0;
        print(0);
      }
      if (pos == 1 && pos != pageNumber.value) {
        pageNumber.value = 1;
        print(1);
      }
      print('pageNumber: ' + pageNumber.toString());
    });
  }
  

  loadContent() {

    loadJson().then((value) {
      menu = value;
      contentLoaded.value = true;
      widgetList = WrapperWidget(MenuList(value.categories[0])).obs;
      title.value = value.imprint.companyName;
      subpageTitle.value = value.categories[0].name;

      getConsent();
      }
     );
  }

  getConsent() async {
    print('start get consent');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var consentVersion;
    // var requiredConsentVersion = menu!.consentVersion;

    if (prefs.containsKey('consent-version')) {
      consentVersion = prefs.getInt('consent-version');
    } else {
      consentVersion = 0;
    }

    // if (consentVersion == requiredConsentVersion) {
    //   consent.value = true;
    // }

    print('got consent: ' + this.consent.value.toString());
  }
  //
  Widget getNavigation() {
    print("getNavigation");
    return  NavigationListStateless(menu!.categories, menu!);
  }

  changeSelectedNavigation(int selectedNavigationEntry) {
    selectedItem.value = selectedNavigationEntry;
    widgetList!.value = WrapperWidget(MenuList(menu!.categories[selectedItem.value]));
    subpageTitle.value = menu!.categories[selectedItem.value].name;
    selectedImprint.value = false;
    changePageNumber(1);
    
  }

  selectImprint() {
    selectedImprint.value = true;
    subpageTitle.value = 'Impressum';
    widgetList!.value = WrapperWidget(ImprintPage(menu!.imprint));
    changePageNumber(1);
  }

  changePageNumber(int number) {

    if (combinedPageController.hasClients && pageNumber.value != number) {
      combinedPageController.animateToPage(
        number,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
    pageNumber.value = number;
  }

  Widget getHeadline() {
    print("getHeadline");
    
    // if (menu!.imprint. != null ) {
    //   return Container(
    //     height: 30.0,
    //     child: Image.asset(
    //       "images/logo.png",
    //       fit: BoxFit.contain
    //     ),
    //   );
    // } else {
      return Text(
        title.value,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.solway(
          color: CustomColors.instance.getTextColor(CustomColors.background),
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        )
      );
    // }
  }
}
