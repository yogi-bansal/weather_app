import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget currentWeather(
    IconData icon, String temp, String date, String city, String weather, String time,
    IconData iconRefresh, Color color, bool isList, double paddingValue,
    VoidCallback? onRefresh) {

  return Center(
    child: Padding (
      padding: EdgeInsets.all(paddingValue),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(city, style: TextStyle(fontSize: 17, color: color),),
            Text(weather, style: TextStyle(fontSize: 36, color: color),),
            Text(temp, style: TextStyle(fontSize: 14, color: color),),
            const SizedBox(height: 10.0,),
            Icon(icon, color: Colors.red, size: 34.0,),
            const SizedBox(height: 10.0,),
            Text(date, style: TextStyle(fontSize: 14, color: color),),
            Text(time, style: TextStyle(fontSize: 14, color: color),),
            if (isList)
            const SizedBox(height: 30.0,),
            if (isList)
            IconButton(icon: Icon(iconRefresh, color: color, size: 30.0,), onPressed: onRefresh,),
          ]),
    ),
  );
}