import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:world_covid_tracker_app/Model/countrymodel.dart';
import 'package:world_covid_tracker_app/Services/Utilities/app_url.dart';
import 'package:world_covid_tracker_app/Services/states-services.dart';
import 'package:world_covid_tracker_app/detail_screen.dart';
import 'Model/stat.dart';
import 'package:http/http.dart'as http;


class countires extends StatefulWidget {
  const countires({super.key});

  @override
  State<countires> createState() => _countiresState();
}

class _countiresState extends State<countires> with TickerProviderStateMixin {
  SearchController searchController=SearchController();
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
bool loaded=true;
  @override
  Widget build(BuildContext context) {
    CountriesServices countriesServices = CountriesServices();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading:  IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(  left: 16 ,right: 16,bottom: 9),
                    child: TextFormField(

                      onChanged: (value){
                        setState(() {

                        });
                      },

                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: 'Search with countries name',



                          border: OutlineInputBorder(


                              borderRadius: BorderRadius.circular(15)

                          )

                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: FutureBuilder(
                    future: countriesServices.fetchcountiresstat(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return  ListView.builder(
                          shrinkWrap: true,
                          itemCount: 7,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(child:  Column(
                              children: [
                                ListTile(
                                    title:Container(height: 18, width: 89,color: Colors.white,),
                                    subtitle: Container(height: 18, width: 89,color: Colors.white,),

                                    leading: Container(height: 28, width: 50,color: Colors.white,),


                                ),
                              ],
                            ), baseColor: Colors.grey.shade600
                                , highlightColor:Colors.grey.shade100);



                          },


                        );
                      } else {
                        return
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                String name=snapshot.data![index]['country'];
                                if(searchController.text.isEmpty){

                                 return InkWell(
                                   onTap:(){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> detail_Screen(
                                       image: snapshot.data![index]['countryInfo']['flag'],
                                       name: snapshot.data![index]['country'] ,
                                       totalCases:  snapshot.data![index]['cases'] ,
                                       totalRecovered: snapshot.data![index]['recovered'] ,
                                       totalDeaths: snapshot.data![index]['deaths'],
                                       active: snapshot.data![index]['active'],
                                       test: snapshot.data![index]['tests'],
                                       todayRecovered: snapshot.data![index]['todayRecovered'],
                                       critical: snapshot.data![index]['critical'] ,
                                     )));
                                   },
                                   child: Column(
                                      children: [
                                        ListTile(
                                            title:Text(snapshot.data![index]['country'],),

                                            leading: Image(
                                                height:60,
                                                width: 60,
                                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']
                                                )

                                            ),
                                            subtitle: Text(snapshot.data![index]['cases'].toString(),)

                                        ),
                                      ],
                                    ),
                                 );

                                }
                                else if(name.toLowerCase().startsWith(searchController.text.toLowerCase()) ==loaded){


                                return  InkWell(

                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> detail_Screen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'] ,
                                      totalCases:  snapshot.data![index]['cases'] ,
                                      totalRecovered: snapshot.data![index]['recovered'] ,
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'] ,
                                    )));

                                  },
                                  child: Column(
                                      children: [
                                        ListTile(
                                            title:Text(snapshot.data![index]['country'],),

                                            leading: Image(
                                                height:60,
                                                width: 60,
                                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']
                                                )

                                            ),
                                            subtitle: Text(snapshot.data![index]['cases'].toString(),)

                                        ),
                                      ],
                                    ),
                                );
                                }
                                else
                                  {
                                  return  Container(

                                    );
                                  }


                              },


                            );
                      }
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
