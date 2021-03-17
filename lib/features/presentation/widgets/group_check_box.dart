import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:zana_storage/helper/item.dart';
class GroupCheckBox extends StatefulWidget {
  final ValueChanged<int> parentAction;
  String title;
  List<Item> items;
  int checkedIndex;
  GroupCheckBox({this.title,this.items,this.checkedIndex,this.parentAction});
  @override
  _GroupCheckBoxState createState() => _GroupCheckBoxState();
}

class _GroupCheckBoxState extends State<GroupCheckBox> {
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: Container(
          padding: EdgeInsets.all(8),
           color: Colors.white,
            // height: 250,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: createItems(),),
    ),
      );
  }
  List<Widget> createItems(){
    List<Widget> list  = new List();
    for(int index=0;index<widget.items.length;index++){
      list.add(Divider());
      list.add(checkItem(widget.items[index].title,(widget.items.length==2?widget.checkedIndex:widget.checkedIndex-1)==index?true:false,widget.items.length==2?index:index+1));

    }
    list.add(Divider());
    return list;
  }
  Widget checkItem(String title,bool val,int index){
    return InkWell(
      onTap: (){
        widget.checkedIndex = index;
        widget.parentAction(index);
        setState(() {
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          CircularCheckBox(
            activeColor: Colors.green,
              value: val,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (bool selected) {
                if(selected == true) {
                  widget.checkedIndex = index;
                  widget.parentAction(index);
                }
                setState(() {
                });
      }
      // setState(() {
      // });
          ),
          // Checkbox(value: value, onChanged:(value){

          //
          // }),
        ],
      ),
    );
  }
}


