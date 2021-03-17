import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Menu{
  List<MenuItem> menuItems = new List();
  MenuItem menuItem;
  List<String> menu = ['Customers'.tr,'Invoices'.tr,'Products'.tr];
  List<Image> images = [
    Image.asset("asset/images/1.png"),
    Image.asset("asset/images/2.png"),
    Image.asset("asset/images/3.png"),
    ];
  List<MenuItem> getMenu(){
    for(int i=0; i<menu.length; i++)
    {
      menuItem = new MenuItem(title: menu[i],image: images[i]);
      menuItems.add(menuItem);
    }
    return menuItems;
  }

}
class MenuItem{
  String title;
  Image image;
  MenuItem({this.title,this.image});
}