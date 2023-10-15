import 'package:agrimart/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
          child: SpinKitWanderingCubes(
            color: appMainColor,
            size: 50,
            duration: Duration(microseconds: 1000000),
          )
      
      
    );
  }
}
