
class CoronaModel {
  String name;
  String positif;
  String sembuh;
  String meninggal;
  String dirawat;

  CoronaModel({this.name, this.positif, this.sembuh, this.meninggal, this.dirawat});

 CoronaModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    positif = json['positif'];
    sembuh = json['sembuh'];
    meninggal = json['meninggal'];
    dirawat = json['dirawat'];
    
  }

fromJsonprov(Map<String, dynamic> json) {
    name = json['Provinsi'];
    positif = json['Kasus_Posi'].toString();
    sembuh = json['Kasus_Semb'].toString();
    meninggal = json['Kasus_Meni'].toString();
    dirawat = (json['Kasus_Posi']-json['Kasus_Semb']+json['Kasus_Meni']).toString();
    return CoronaModel(name: name,positif: positif,sembuh: sembuh,meninggal: meninggal);
  }
fromJson(Map<String, dynamic> json) {
    name = json['name'];
    positif = json['positif'];
    sembuh = json['sembuh'];
    meninggal = json['meninggal'];
    dirawat = json['dirawat'];
    return CoronaModel(name: name,positif: positif,sembuh: sembuh,meninggal: meninggal,dirawat: dirawat);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['positif'] = this.positif;
    data['sembuh'] = this.sembuh;
    data['meninggal'] = this.meninggal;
    data['dirawat'] = this.dirawat;
    return data;
  }
}
