import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:Cov_id/models/chart_model.dart';
import 'package:Cov_id/models/corona_model.dart';
import 'package:Cov_id/util/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiProvider extends ChangeNotifier {
  int indexProv = 0;
  CoronaModel data;
  CoronaGrowth dataThisWeek;
  Dio dio = Dio();
  final urlGrowth = "https://ainxzeeebermhanxx.000webhostapp.com/api.php";

  set setIndexProv(int index) {
    index < provinces.length ? indexProv = index : indexProv = 0;
    notifyListeners();
  }

  String get getProvinceNow => provinces[indexProv];
  get getdataGrowth => getDataGrowthAsync();
  Future<CoronaGrowth> getDataGrowthAsync() async {
    dataThisWeek = CoronaGrowth();
    final response = await dio.get(urlGrowth);
    final jsonString = response.data;
    final jsonresponse = jsonDecode(jsonString);
    return dataThisWeek.fromJson(jsonresponse);
  }

  get getData => getDataAsync();
  Future<CoronaModel> getDataAsync() async {
    if (indexProv != 0) {
      String now = getProvinceNow;
      final urlCorona =
          "https://ainxzeeebermhanxx.000webhostapp.com/apiProvinsi.php?prov=$now";
      final response =  await dio.get(urlCorona);
      final jsonresponse = jsonDecode(response.data);
      return CoronaModel().fromJsonprov(jsonresponse);
    } else {
      final urlCorona = "https://api.kawalcorona.com/indonesia";
      final response = await dio.get(urlCorona);
      return CoronaModel().fromJson(response.data[0]);
    }
  }
}
