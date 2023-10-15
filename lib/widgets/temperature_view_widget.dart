import 'package:agrimart/const/fonts.dart';
import 'package:flutter/material.dart';

class TemperatureViewWidget extends StatelessWidget {
  Icon widgetIcon;
  Color widgetMainColor;
  String mainWidgetText;
  String subWidgetText;

  TemperatureViewWidget({super.key, required this.widgetIcon,required this.widgetMainColor,required this.mainWidgetText,required this.subWidgetText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: widgetMainColor,
          radius: 22,
          child:widgetIcon
          // Icon(,size: 40,color: Color.fromARGB(255, 241, 240, 240),),
        ),
        SizedBox(width: 10,),
        Column(
         // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mainWidgetText,style: boldFontStyle18),
           // SizedBox(height: 5,),
            Text(subWidgetText, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.grey),)
          ],
        )
      ],
      
    );
  }
}