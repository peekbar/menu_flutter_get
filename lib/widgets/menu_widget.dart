import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:menu_flutter_get/controller.dart';

import '../../../custom_colors.dart';

class MenuWidget extends StatelessWidget {

  final bool mobile;
  final double deviceHeight;
  double additionalPadding = 0;

  final Controller c = Get.find();

  MenuWidget(this.deviceHeight, bool additionalPadding, this.mobile, { Key? key }) : super(key: key) {
    if (additionalPadding) {
      this.additionalPadding = 20.0;
    } else {
      this.additionalPadding = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('new');
    var bottomPadding = 0.0;
    List<BoxShadow> shadows = [];

    if (!mobile) {
      shadows.addAll([
        BoxShadow(offset: Offset(10,10), color: Color(0xFF000000).withOpacity(0.2), blurRadius: 20),
        BoxShadow(offset: Offset(-10,-10), color: Color(0xFFFFFFFF).withOpacity(0.6), blurRadius: 20)
      ]);
    } else {
      bottomPadding = 46.0;
    }

    return 
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: CustomColors.background,
                boxShadow: shadows
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(additionalPadding),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  children: [Obx(() => c.widgetList!.value)],
                ),
              )
            ),
          )
        );
  }
}
