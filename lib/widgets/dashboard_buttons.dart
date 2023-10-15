import 'package:agrimart/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class DashboardButtons extends StatelessWidget {
  final String name;
  final Future<int> number;
  final Color backgroundColor;
  final VoidCallback onTap;

  const DashboardButtons({
    Key? key,
    required this.name,
    required this.number,
    required this.backgroundColor,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Container(
          height: height * 0.12,
          width: width * 0.4,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FutureBuilder<int>(
                future: number,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
