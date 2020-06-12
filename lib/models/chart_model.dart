
import 'package:Cov_id/util/util.dart';
class ChartModel{
  var color;
  String cases;
  double caseValue;
  ChartModel(this.cases,this.caseValue,this.color);
}
class BarChartModel {
  double meninggal,sembuh,dirawat;
  int x;
  BarChartModel(this.x,this.meninggal,this.sembuh,this.dirawat);
}

class CoronaGrowth {
  int max;
  List<DataGrowth> dataGrowth;

  CoronaGrowth({this.max, this.dataGrowth});

  CoronaGrowth.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    if (json['dataGrowth'] != null) {
      dataGrowth = new List<DataGrowth>();
      json['dataGrowth'].forEach((v) {
        dataGrowth.add(new DataGrowth.fromJson(v));
      });
    }
  }
  fromJson(Map<String, dynamic> json) {
    dataGrowth = new List<DataGrowth>();
    max = json['max'];
    if (json['dataGrowth'] != null) {
      
      json['dataGrowth'].forEach((v) {
        dataGrowth.add(new DataGrowth.fromJson(v));

      });
    }
    return CoronaGrowth(max:max,dataGrowth:dataGrowth);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    if (this.dataGrowth != null) {
      data['dataGrowth'] = this.dataGrowth.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataGrowth {
  double active;
  double recovered;
  double death;
  String date;

  DataGrowth({this.active, this.recovered, this.death, this.date});

  DataGrowth.fromJson(Map<String, dynamic> json) {
    active = json['active'].toString().fixedDouble();
    recovered = json['recovered'].toString().fixedDouble();
    death = json['death'].toString().fixedDouble();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['recovered'] = this.recovered;
    data['death'] = this.death;
    data['date'] = this.date;
    return data;
  }
}
