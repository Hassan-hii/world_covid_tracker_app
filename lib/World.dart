import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:world_covid_tracker_app/Model/stat.dart';
import 'package:world_covid_tracker_app/Services/states-services.dart';
import 'package:world_covid_tracker_app/coutries.dart';
class World extends StatefulWidget {
  const World({super.key});

  @override
  State<World> createState() => _WorldState();
}

class _WorldState extends State<World> with TickerProviderStateMixin {
  late final AnimationController _controller= AnimationController(
      duration: Duration(seconds: 6),
      vsync: this)..repeat();
  final colorList=<Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            FutureBuilder(


            future: statesServices.fetchworldstat(),
                builder: (context ,AsyncSnapshot<Stat> snapshot){


                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SpinKitSpinningLines(color: Colors.deepOrangeAccent,
                      size: 60,
                        controller: _controller,
                      ),
                    );

                  }
                  else{
                     return Column(
                      children: [
                        PieChart(dataMap: {
                          "Total":double.parse(snapshot.data!.cases!.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                          "Deaths":double.parse(snapshot.data!.deaths!.toString()),

                        },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        SizedBox(height:MediaQuery.of(context).size.height*0.01 ),
                        Card(

                          child: Column(
                            children: [
                              reuseablerow(title: 'Total', value: snapshot.data!.cases.toString()),
                              reuseablerow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              reuseablerow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              reuseablerow(title: 'Active', value: snapshot.data!.recovered.toString()),
                              reuseablerow(title: 'Critical', value: snapshot.data!.recovered.toString()),
                              reuseablerow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                              reuseablerow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              reuseablerow(title: 'Today Cases', value: snapshot.data!.todayRecovered.toString())


                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap :(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => countires()));
                  },
                          child: Container(
                            height: 50,
                            width: 250,
                            child: Center(child: Text("Track Countries")),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(18)

                            ),
                          ),
                        )
                      ],
                    );
                  }

            }
            ),
     
          ],
          ),

          ),
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
