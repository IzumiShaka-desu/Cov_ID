
import 'package:Cov_id/models/chart_model.dart';
import 'package:Cov_id/models/corona_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

errindicator(void fun) => Container(
  child: Column(children: [Text("data tidak termuat"),Text("periksa koneksi anda!"),IconButton(icon: Icon(Icons.refresh), onPressed: ()=>fun),Text("refresh")],));


void call(String num) {
  final String phone = 'tel:$num';
  try {
    launch(phone);
  } catch (e) {
    throw e;
  }
}
extension number on String{
  double fixedDouble(){
    return double.parse(double.parse(this).toStringAsFixed(3));
  }
}
extension d on DataGrowth{
      int getMax(){
        List data=[this.active,this.death,this.recovered];
        double d=data[0];
        for(int i=1;i<data.length;i++)if(d<data[i])d=data[i];
        
        return (d+2).toInt();
      }
}

double getPercent(double data,total)=>double.parse(((data/total)*100).toStringAsFixed(2));
extension f on CoronaModel{
    Map<String,double> percent(){
      Map<String,double> map={
        "dirawat":getPercent(this.dirawat.doubleComma(), this.positif.doubleComma()),
        "meninggal":getPercent(this.meninggal.doubleComma(), this.positif.doubleComma()),
        "sembuh":getPercent(this.sembuh.doubleComma(), this.positif.doubleComma()),
      };
       return map;
       
        
    }
}
extension getter on CoronaModel{
     nonNullDeath(){
      var  data=this.meninggal;
      if(data==null)data='0';
      return data;
    }
     nonNullPositif(){
       var  data=this.positif;
       if(data==null)data='0';
       return data;
     }
     nonNullRecovered(){
       var  data=this.sembuh;
       if(data==null)data='0';
       return data;
     }
}
extension NumberParsing on String{
    double doubleComma(){
        String text='';
        this.split(',').forEach((element) {text+=element; });
        return double.parse(text);
    }
}
