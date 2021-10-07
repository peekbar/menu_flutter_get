import 'package:flutter/widgets.dart';

class WrapperWidget extends StatelessWidget {
  Widget child;
  WrapperWidget(this.child, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}