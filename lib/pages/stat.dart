import 'package:Cov_id/api/api_provider.dart';
import 'package:Cov_id/models/chart_model.dart';
import 'package:Cov_id/models/corona_model.dart';
import 'package:Cov_id/util/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Cov_id/util/util.dart';

class Stat extends StatefulWidget {
  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> {
  List<PieChartSectionData> pieSeries;
  BarChartData data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilderCard = consumerCard(TypeCases.positif);
    var futureBuilderDeath = consumerCard(TypeCases.death);
    var futureBuilderSembuh = consumerCard(TypeCases.recover);
    var futureBuilderAktif = consumerCard(TypeCases.onRecover);
    return ChangeNotifierProvider<ApiProvider>(
      create: (context) => ApiProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Statistik"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[50],
            child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Informasi terbaru Covid di Indonesia",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    card("Total kasus terkonfirmasi", futureBuilderCard,
                        Colors.orangeAccent, double.infinity),
                    Row(children: [
                      buildContainerPieChart(),
                      Spacer(),
                      Column(children: [
                        card("meninggal", futureBuilderDeath, Colors.redAccent,
                            200),
                        card("sembuh", futureBuilderSembuh, Colors.greenAccent,
                            200),
                        card("dirawat", futureBuilderAktif, Colors.blueAccent,
                            200)
                      ])
                    ])
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                        child: Text(
                            "Statistik perkembangan covid di Indonesia dalam sepekan"),
                      ),
                      Row(
                        children: <Widget>[
                          buildContainerStatWeek(),
                        ],
                      )
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  Container buildContainerStatWeek() {
    return Container(
      child: Expanded(
          child: Consumer<ApiProvider>(
        builder: (context, apiProvider, _) => FutureBuilder(
            future: apiProvider.getDataGrowthAsync(),
            builder: (context, AsyncSnapshot<CoronaGrowth> snapshot) {
              Widget widget;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  widget = circularProgressIndicator;
                  break;
                case ConnectionState.active:
                  widget = circularProgressIndicator;
                  break;
                case ConnectionState.waiting:
                  widget = circularProgressIndicator;
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    widget = errindicator(apiProvider.update());
                  } else if (snapshot.hasData) {
                    widget = BarChart(
                      data = createData(snapshot.data),
                      swapAnimationDuration: Duration(seconds: 2),
                    );
                  }else{
                    widget=errindicator(apiProvider.update());
                  }
                  break;
                default:
                  return circularProgressIndicator;
              }
              return widget;
            }),
      )),
    );
  }

  Container buildContainerPieChart() {
    return Container(
        width: 130,
        height: 150,
        padding: EdgeInsets.all(10),
        child: Consumer<ApiProvider>(
          builder: (context, apiProvider, _) => FutureBuilder(
              future: apiProvider.getDataAsync(),
              builder: (context, AsyncSnapshot<CoronaModel> snapshot) {
                Widget pie;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    pie = circularProgressIndicator;
                    break;
                  case ConnectionState.active:
                    pie = circularProgressIndicator;
                    break;
                  case ConnectionState.waiting:
                    pie = circularProgressIndicator;
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      pie = errindicator(apiProvider.update());
                    } else if (snapshot.hasData) {
                      pie = PieChart(
                        PieChartData(
                          sections: _generate(snapshot.data),
                          borderData: FlBorderData(
                            show: false,
                          ),
                        ),
                        swapAnimationDuration: Duration(seconds: 5),
                      );
                    }else{
                    pie=errindicator(apiProvider.update());
                  }
                    break;
                  default:
                    pie = circularProgressIndicator;
                }
                return pie;
              }),
        ));
  }

  Consumer<ApiProvider> consumerCard(TypeCases type) {
    return Consumer<ApiProvider>(
        builder: (context, apiProvider, _) => FutureBuilder(
            future: ApiProvider().getDataAsync(),
            builder: (context, AsyncSnapshot<CoronaModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return circularProgressIndicator;
                  break;
                case ConnectionState.active:
                  return circularProgressIndicator;
                  break;
                case ConnectionState.waiting:
                  return circularProgressIndicator;
                  break;
                case ConnectionState.done:
                  Widget widget;
                  if (snapshot.hasError) {
                    widget = errindicator(apiProvider.update());
                  } else if (snapshot.hasData) {
                    switch (type) {
                      case TypeCases.positif:
                        widget = Text(snapshot.data.positif,
                            style: TextStyle(color: Colors.white));
                        break;
                      case TypeCases.death:
                        widget = Text(snapshot.data.meninggal,
                            style: TextStyle(color: Colors.white));
                        break;
                      case TypeCases.recover:
                        widget = Text(snapshot.data.sembuh,
                            style: TextStyle(color: Colors.white));
                        break;
                      case TypeCases.onRecover:
                        widget = Text(snapshot.data.dirawat,
                            style: TextStyle(color: Colors.white));
                        break;
                    }
                  }else{
                    widget=errindicator(apiProvider.update());
                  }
                  return widget;
                  break;
                default:
                  return circularProgressIndicator;
              }
            }));
  }

  BarChartData createData(CoronaGrowth datas) {
    List<DataGrowth> data = datas.dataGrowth;
    List<String> tgl = [];
    data.forEach((element) {
      tgl.add(element.date);
    });
    List<BarChartGroupData> dataGroup = [];
    int max = data.last.getMax();
    data.forEach((element) {
      dataGroup.add(createBarRod(BarChartModel(
          max, element.death, element.recovered, element.active)));
    });
    return BarChartData(
        groupsSpace: 4,
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(
              margin: 10,
              showTitles: true,
              getTitles: (double val) {
                return "${val.toInt()} K";
              }),
          bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (double val) {
                int value = val.toInt();
                return tgl[value];
              }),
        ),
        borderData: FlBorderData(show: true, border: Border()),
        maxY: max.toDouble(),
        barGroups: dataGroup);
  }
}

createBarRod(BarChartModel model) {
  return BarChartGroupData(x: model.x, barRods: [
    BarChartRodData(
        y: model.meninggal,
        color: Colors.redAccent,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(0))),
    BarChartRodData(
        y: model.sembuh,
        color: Colors.greenAccent,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(0))),
    BarChartRodData(
        y: model.dirawat,
        color: Colors.blueAccent,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(0)))
  ]);
}

List<PieChartSectionData> _generate(CoronaModel model) {
  var data = model.percent();
  var pieData = [
    ChartModel('sembuh', data["sembuh"], Colors.greenAccent),
    ChartModel('dirawat', data["dirawat"], Colors.blueAccent),
    ChartModel('meninggal', data["meninggal"], Colors.red),
  ];
  return pieData.map((ChartModel model) {
    return PieChartSectionData(
        titlePositionPercentageOffset: 1,
        value: model.caseValue,
        titleStyle: TextStyle(
            fontSize: 12,
            backgroundColor: Colors.black45,
            fontWeight: FontWeight.bold),
        title: "${model.caseValue} %",
        color: model.color);
  }).toList();
}

card(String title, dynamic futureBuilder, Color color, double width) {
  return Card(
    color: color,
    child: Container(
      width: width,
      padding: EdgeInsets.all(5),
      child: Column(children: [
        Text(
          "$title",
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
        futureBuilder
      ]),
    ),
  );
}
