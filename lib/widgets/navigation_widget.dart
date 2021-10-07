import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../custom_colors.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../controller.dart';

class NavigationWidget extends StatelessWidget {

  final bool mobile;
  final Controller c = Get.find();

  NavigationWidget(this.mobile,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("newNavigation");
    double paddingBottom;

    if (mobile) {
      paddingBottom = 46.0; // bottom sheet min height
    } else {
      paddingBottom = 8.0;
    }

    var phone = c.phone.value;
    
    if (phone == '') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // launch(
                  //   WebpageController.instance.getMainpage(),
                  //   universalLinksOnly: true
                  // );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: c.getHeadline()
                ),
              )
            ]
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, paddingBottom),
              child: c.getNavigation(),
            )
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // launch(
                  //   WebpageController.instance.getMainpage(),
                  //   universalLinksOnly: true
                  // );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Container(
                    child: c.getHeadline()
                  )
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  launch(
                    'tel:$phone',
                    universalLinksOnly: true
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 18, 8),
                  child: Icon(
                    Icons.local_phone,
                    color: CustomColors.instance.getTextColor(CustomColors.background),
                    size: 24,
                  ),
                ),
              )
            ]
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, paddingBottom),
              child: c.getNavigation()
            )
          )
        ],
      );
    }
  }
}
