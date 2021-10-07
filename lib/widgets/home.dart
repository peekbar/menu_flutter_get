


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'combined_page.dart';
import '../controller.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  const Home
({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    c.loadContent();
    return Scaffold(
      body: Obx(() => c.contentLoaded.value ? 
            CombinedPageStateless()
           : Center(child: const CircularProgressIndicator())),
    );
  }


  
}