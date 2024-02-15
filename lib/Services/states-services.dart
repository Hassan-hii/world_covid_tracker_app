import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:world_covid_tracker_app/Model/stat.dart' ;

import 'package:world_covid_tracker_app/Services/Utilities/app_url.dart';
import 'package:world_covid_tracker_app/Model/countrymodel.dart';


class StatesServices{
  Future<Stat>fetchworldstat()async{
    final response =await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return Stat.fromJson(data);
    }
    else {
      throw Exception('Error');
    }
  }
}
class CountriesServices{
  Future<List<dynamic>>fetchcountiresstat()async{
    var data;
    final response =await http.get(Uri.parse(AppUrl.worldcountriesApi));
    if(response.statusCode==200){
        data=jsonDecode(response.body);
      return data;
    }
    else {
      throw Exception('Error');
    }
  }
}
