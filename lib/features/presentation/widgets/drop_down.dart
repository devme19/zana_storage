import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
class DropdownWidget extends StatefulWidget {
  final ValueChanged<String> parentAction;
  List<DropDownItem> items;
  String currentItem;
  int index;

  DropdownWidget({this.items,this.parentAction,this.index,this.currentItem});
  State createState() =>  DropdownWidgetState();
}
class DropdownWidgetState extends State<DropdownWidget> {

  String title;
  String selectedItem;
  List<String> list = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = getHint();
    for(var item in widget.items)
      list.add(item.title);
    WidgetsBinding.instance.addPostFrameCallback((_) => setDefault());
  }
  setDefault(){
    if (this.selectedItem != widget.currentItem) {
      setState(() {
        this.selectedItem = widget.currentItem;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  String getHint(){
    switch(widget.index){
      case(0):
        return "Payment Type";
      case(1):
        return "Pay Status";
      case(2):
        return "Select Category";
      case(3):
        return "Select Tax";
      case(4):
        return "Select Currency";


    }
  }
  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(color:widget.index == 0 || widget.index == 1? Colors.grey:Colors.black87,width: 1),
          // color: Colors.white
      ),
      padding: EdgeInsets.all(8),
      child:  DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint:  Text(title.tr),
          value: selectedItem,
          onChanged: (String value) {
            setState(() {
              selectedItem = value;
              widget.parentAction(widget.items.singleWhere((i) => i.title == selectedItem).value);
            });
          },
          items: list.map((String item) {
            return  DropdownMenuItem<String>(
              value: item,
              child: Container(
                height: 80,
                child:
                Center(
                  child: Text(
                    item.tr,
                    style:  TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
class DropDownItem{
  String title;
  String value;
  DropDownItem({this.title,this.value});
}