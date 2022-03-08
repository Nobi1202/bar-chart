import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    // _trackballBehavior = TrackballBehavior(
    //     lineColor: Colors.red,
    //     lineDashArray: <double>[5, 5],
    //     enable: true,
    //     shouldAlwaysShow: true,
    //     activationMode: ActivationMode.singleTap,
    //     tooltipSettings: InteractiveTooltip(
    //         enable: false,
    //         color: Colors.red
    //     )
    // );
    // _crosshairBehavior = CrosshairBehavior(
    //   enable: true,
    //   lineColor: Colors.red,
    //   lineDashArray: <double>[2, 1],
    //   lineWidth: 3,
    //   lineType: CrosshairLineType.vertical,
    //   shouldAlwaysShow: true,
    //   activationMode: ActivationMode.singleTap,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text("Usage Hours"),
              const Text(
                'Aug 1 - Aug 7, 2021',
              ),
              SfCartesianChart(
                plotAreaBorderWidth: 0,
                // title: ChartTitle(text: 'Usage Hours'),
                legend: Legend(isVisible: true),
                // crosshairBehavior: _crosshairBehavior,
                tooltipBehavior: TooltipBehavior(
                  enable: false,
                ),

                series: List.generate(_chartData.length, (index) =>
                    BarSeries<GDPData, String>(
                      // pointColorMapper: (GDPData data, _) => data.color,
                      isVisibleInLegend: false,
                      width: 3,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: _chartData[index].gdp >= 4 ? [Color(0xe55bef92), Color(0xe214a54a)] : [Colors.red,Colors.orange],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      // name: 'Aug 1 - Aug 7, 2021',
                      dataSource:[_chartData[index]],
                      xValueMapper: (GDPData gdp, _) => gdp.continent,
                      yValueMapper: (GDPData gdp, _) => gdp.gdp,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: false,

                      ),
                      enableTooltip: true,
                    ),).toList(),
                primaryXAxis: CategoryAxis(
                  maximumLabelWidth: 122,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelAlignment: LabelAlignment.center,
                  majorTickLines: const MajorTickLines(width: 0),
                  //Hide the gridlines of x-axis
                  majorGridLines: const MajorGridLines(width: 0),
                  //Hide the axis line of x-axis
                  axisLine: const AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}h',
                  labelAlignment: LabelAlignment.end,
                  majorTickLines: const MajorTickLines(width: 0),
                  //Hide the gridlines of y-axis
                  plotBands: [
                    PlotBand(
                      start: 7,
                      end: 7,
                      borderColor: Colors.red,
                      borderWidth: 2,
                      dashArray: const [5, 2],
                    ),
                  ],
                  majorGridLines: const MajorGridLines(
                    width: 0,
                  ),
                  axisLine: const AxisLine(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  decimalPlaces: 0,
                  interval: 1,
                  minimum: 3.8,
                  maximum: 9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Su', 8),
      GDPData('Sa', 6),
      GDPData('Fr', 7.2),
      GDPData('Th', 7,),
      GDPData('We', 6.8,),
      GDPData('Tu', 6,),
      GDPData('Mo', 4, ),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp,);

  final String continent;
  final double gdp;
}
