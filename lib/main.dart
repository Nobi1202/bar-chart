import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<GDPData> _chartData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text("Usage Hours"),
            const Text(
              'Aug 1 - Aug 7, 2021',
            ),
            _buildChart()
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
        height: 250,
        child: ShaderMask(
          child: charts.BarChart(
            _createSampleData(),
            vertical: false,
            primaryMeasureAxis: const charts.NumericAxisSpec(
              showAxisLine: false,
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                desiredMinTickCount: 6,
                desiredMaxTickCount: 6,
              ),
            ),
            domainAxis: const charts.OrdinalAxisSpec(
              showAxisLine: false,
            ),
            layoutConfig: charts.LayoutConfig(
                leftMarginSpec: charts.MarginSpec.fixedPixel(30),
                topMarginSpec: charts.MarginSpec.fixedPixel(0),
                rightMarginSpec: charts.MarginSpec.fixedPixel(30),
                bottomMarginSpec: charts.MarginSpec.fixedPixel(0)),
            defaultRenderer: charts.BarRendererConfig(
                cornerStrategy: const charts.ConstCornerStrategy(30)),
          ),
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xe55bef92), Color(0xe214a54a)],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
        ));
  }

  static List<charts.Series<GDPData, String>> _createSampleData() {
    final data = [
      GDPData('Mo', 5),
      GDPData('Tu', 9),
      GDPData('We', 4),
      GDPData('Th', 7),
      GDPData('Fr', 8),
      GDPData('Sa', 6),
      GDPData('Su', 5),
    ];

    return [
      charts.Series<GDPData, String>(
        id: 'Sales',
        domainFn: (GDPData sales, _) => sales.continent,
        measureFn: (GDPData sales, _) => sales.gdp,
        data: data,
      )
    ];
  }
}

class GDPData {
  GDPData(
    this.continent,
    this.gdp,
  );

  final String continent;
  final double gdp;
}
