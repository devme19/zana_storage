import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DashboardItems{
  List<Item> items = new List();
  Item menuItem;
  List<String> menu = ['Number Of Customers'.tr,'Number Of Invoices'.tr,'Customers Of Month'.tr,'Invoices Of Month'.tr];
  List<Icon> icons = [
    Icon(Icons.person_outline_outlined,color: Colors.red.shade200,),
    Icon(Icons.wysiwyg_outlined,color: Colors.red.shade200),
    Icon(Icons.person,color: Colors.red.shade200),
    Icon(Icons.assignment_rounded,color: Colors.red.shade200),
  ];
  List<Item> getItems(){
    for(int i=0; i<menu.length; i++)
    {
      menuItem = new Item(title: menu[i],icon: icons[i]);
      items.add(menuItem);
    }
    return items;
  }

}
class Item{
  String title;
  Icon icon;
  Item({this.title,this.icon});
}