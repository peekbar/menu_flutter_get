
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_flutter_get/data_handling/models/food_category.dart';
import 'package:menu_flutter_get/data_handling/models/product.dart';
import '../custom_colors.dart';



//
class MenuList extends StatefulWidget {
 
  final FoodCategory category;

  final double titleSize = 20.0;
  final double smallItemSize = 18.0;

  MenuList(this.category, {Key? key}) : super(key: key);

  @override
  _MenuListState createState() => _MenuListState();
}


//
class _MenuListState extends State<MenuList> {
  List<Widget> wl = [];

  int expandedElementPosition = 0;

  @override
  void setState(fn) {
    print(expandedElementPosition);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    int position = 0;
    var eEP = expandedElementPosition;
    wl.clear();

    if (widget.category.name != '') {
      wl.add(
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 12.0),
          child: Text(
            widget.category.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: GoogleFonts.solway(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CustomColors.instance.getTextColor(CustomColors.background),
            )
          )
        )
      );
    }
    
    for (var product in widget.category.products) {
      var element;
      
      if (position == eEP) {
        element = generateExpandedRow(product, position, false);
      } else {
        element = generateRow(product, position);
      }
     
      
      wl.add(element);
      position++;
    }

    return Column(
      children: wl,
    );
  }


  //
  Widget generateExpandedRow(Product product, int position, bool expanded) {
    String index = product.shortName;
    String title = product.name;
    String description = product.description;

    List<Text> smallItemsElements = [];
    List<Text> middleRowElements = [];

    var background = CustomColors.background;
    if (!expanded) {
      background = CustomColors.selected;
    }

    if (index == "") {
      middleRowElements.add(
        Text(
          title,
          textAlign: TextAlign.start,
          overflow: TextOverflow.visible,
          style: GoogleFonts.solway(
            color: CustomColors.instance.getTextColor(background),
            fontSize: widget.titleSize,
            fontWeight: FontWeight.bold
          )
        )
      );
    } else {
      middleRowElements.add(
        Text(
          index + '. ' + title,
          textAlign: TextAlign.start,
          overflow: TextOverflow.visible,
          style: GoogleFonts.solway(
            color: CustomColors.instance.getTextColor(background),
            fontSize: widget.titleSize,
            fontWeight: FontWeight.bold
          )
        ) 
      );
    }

    if (description != '') {
      middleRowElements.add(
        Text(
          '$description',
          textAlign: TextAlign.start,
          overflow: TextOverflow.visible,
          style: GoogleFonts.solway(
            color: CustomColors.instance.getTextColor(background),
            fontSize: widget.smallItemSize,
            fontWeight: FontWeight.normal
          )
        )
      );
    }

    Column middleRow = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: middleRowElements
    );

    
      smallItemsElements.add(
        Text(
          product.price,
          style: GoogleFonts.solway(
            color: CustomColors.instance.getTextColor(background),
            fontSize: widget.smallItemSize
          )
        )
      );
    

    Column smallItems = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: smallItemsElements
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          expandedElementPosition = position;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: middleRow
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: smallItems,
              ),
            ],
          ),
        ),
      )
    );
  }

  //
  Widget generateRow(Product product, int position) {
    String index = product.shortName;
    String title = product.name;
    String smallItem = product.price;
    Widget titleText;

    if (index == null || index == "") {
      titleText = Text(
        '$title',
        textAlign: TextAlign.left,
        overflow: TextOverflow.visible,
        style: GoogleFonts.solway(
          fontSize: widget.titleSize,
          fontWeight: FontWeight.bold,
          color: CustomColors.instance.getTextColor(CustomColors.shade)
        )
      );
    } else {
      titleText = Text(
        '$index' + '. ' + '$title',
        textAlign: TextAlign.left,
        overflow: TextOverflow.visible,
        style: GoogleFonts.solway(
          fontSize: widget.titleSize,
          fontWeight: FontWeight.bold,
          color: CustomColors.instance.getTextColor(CustomColors.shade)
        )
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          expandedElementPosition = position;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.shade,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //getNumberWidget(index, false),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: titleText
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Text(
                    smallItem,
                    style: GoogleFonts.solway(
                      color: CustomColors.instance.getTextColor(CustomColors.background),
                      fontSize: widget.smallItemSize
                    )
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}
