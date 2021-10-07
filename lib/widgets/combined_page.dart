import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import 'bottom_navigation.dart';
import 'menu_widget.dart';
import '../controller.dart';
import '../custom_colors.dart';
import 'navigation_widget.dart';


class CombinedPageStateless extends StatelessWidget {

  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool> (
      future: Future.value(true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              color: CustomColors.background,
              child: buildMobileDesktop(context)
            )
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return MaterialApp(
            home: Container(
              color: Color(0xFFFFFFFF),
              height: 40,
              width: 40,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      }
    );
  }

  Widget buildMobileDesktop(context) {
    print('buildMobileDesktop');

    var size = MediaQuery.of(context).size;
    var deviceWidth = size.width;
    var deviceHeight = size.height;

    
    var additionalPadding = 0.0;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      print('desktop');
     
        if (deviceWidth < 1600) {
          additionalPadding = 0.0;
        } else {
          additionalPadding = 40.0;
        }

        var navigationWidget = NavigationWidget(false);
        var contentWidget = MenuWidget(deviceHeight, deviceWidth >= 1600, false);

      
        return ConstrainedBox(
          constraints: BoxConstraints.tight(new Size(
            deviceWidth,
            deviceHeight
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 800
                  ),
                  child: navigationWidget
                )
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 800
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, additionalPadding, 0, additionalPadding),
                    child: contentWidget,
                  )
                )
              )
            ]
          )
        );
    } else {
      print('mobile');
      var navigationWidget = NavigationWidget(true);
      var contentWidget = MenuWidget(deviceHeight, false, true);

      return  SafeArea(
        top: true,
        left: true,
        right: true,
        child: Stack(
          children: [
            PageView(
              controller: c.combinedPageController,
                children: <Widget>[
                  navigationWidget,
                  contentWidget
                ]
            ),
            Obx(() => BottomNavigationStateless(c.pageNumber.value, c.subpageTitle.value))
          ],
        ),
      );
    }
  }
}
