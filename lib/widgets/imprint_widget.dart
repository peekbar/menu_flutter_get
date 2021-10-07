import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_flutter_get/custom_colors.dart';
import 'package:menu_flutter_get/data_handling/models/imprint.dart';


class ImprintPage extends StatelessWidget {

  final Imprint imprint;

  const ImprintPage(this.imprint, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(imprint.companyName, style: TextStyle(fontWeight: FontWeight.bold),),
          generateImprintTextPair('Inhaber: ', imprint.holder),
          generateImprintTextPair('Adresse: ', '${imprint.street}, ${imprint.city}'),
          generateImprintTextPair('Telefon: ', imprint.phone),
          generateImprintTextPair("Mail: ", imprint.mail),
          generateImprintTextPair("Steuernummer: ", imprint.tax),
        ],
      ),
    );
  }

  Widget generateImprintTextPair(String boldText, String normalText) {
    return RichText(text: TextSpan(
          style: TextStyle(color: CustomColors.instance.blackText ),
          children: <TextSpan>[
            TextSpan(text: boldText, style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: normalText)
          ]));
  }
}