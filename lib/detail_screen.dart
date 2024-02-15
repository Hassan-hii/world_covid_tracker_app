import 'package:flutter/material.dart';
class detail_Screen extends StatefulWidget {
  final String name;
  final String  image;
  final int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test;
  const detail_Screen({super.key,
  required this.image ,
    required this.name ,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<detail_Screen> createState() => _detail_ScreenState();
}

class _detail_ScreenState extends State<detail_Screen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
body: Column(
mainAxisAlignment: MainAxisAlignment.start,
  children: [
    SizedBox(height: 20,),
    Container(

      child: Image(image: NetworkImage(widget.image),fit: BoxFit.fill,)
          ,
      decoration: BoxDecoration(

      ),
    ),
    reuseablerow(title: 'Cases' , value: widget.totalCases.toString()),
    reuseablerow(title: 'Deaths' , value: widget.totalDeaths.toString()),
    reuseablerow(title: 'Recovered' , value: widget.totalRecovered.toString(),),
    reuseablerow(title: 'Critical' , value: widget.critical.toString(),),
    reuseablerow(title: 'Active' , value: widget.active.toString(),),

  ],
),
    );
  }
}
class reuseablerow extends StatelessWidget {
  String title,value;
  reuseablerow({super.key, required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding:  EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
      child: Column(

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          )
        ],
      ),
    );
  }
}

