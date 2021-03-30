import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
class MyAlertDialog {
  static void show(List<String> titles,bool isAlert){
    // Get.dialog(
    //     Container(
    //       margin: EdgeInsets.all(16.0),
    //       child: Scaffold(
    //         body:
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //         Column(children: createContent(titles,isAlert),),
    //         Padding(
    //           padding: const EdgeInsets.all(32.0),
    //           child: RaisedButton(
    //               color: Colors.blue.shade600,
    //               shape:RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(borderRadius),
    //                 // side: BorderSide(color: Colors.grey.shade300)
    //               ),
    //               child:
    //               Row(
    //                 children: [
    //                   Expanded(child:
    //
    //                   Padding(
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: Text('ok'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
    //                   )),
    //                 ],
    //               ),onPressed: (){
    //             Get.back();
    //             // Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: id);
    //
    //           }),
    //         ),
    //
    //   ],
    // ),
    //       ),
    //     ));
    Get.defaultDialog(
        confirm:
        RaisedButton(
            color: Colors.blue.shade600,
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                // side: BorderSide(color: Colors.grey.shade300)
            ),
            child:
            Row(
              children: [
                Expanded(child:

                Text('ok'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
              ],
            ),onPressed: (){
          Get.back();
          // Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: id);

        }),
        title: "",
        content: Container(
          child: Column(
            children: createContent(titles,isAlert),
          ),
        )
        // middleTextStyle: TextStyle(fontSize: 21,),
        // middleText: title
    );
  }
  static List<Widget> createContent(List<String> titles,bool isAlert){
    List<Widget> columns = new List();
    for(var title in titles){
      columns.add(Row(
        mainAxisAlignment:  isAlert? MainAxisAlignment.center:MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: isAlert?
              Text(title,textAlign:TextAlign.center):
              Text("- $title"),
            ),
          ),
        ],
      ));
    }
    return columns;
  }

}
