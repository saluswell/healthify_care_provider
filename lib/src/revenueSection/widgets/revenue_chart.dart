import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/utils/appcolors.dart';
import '../models/revenue_data.dart';
import '../services/revenue_services.dart';

class RevenueChartWidget extends StatefulWidget {
  @override
  State<RevenueChartWidget> createState() => _RevenueChartWidgetState();
}

class _RevenueChartWidgetState extends State<RevenueChartWidget> {
  RevenueServices revenueServices = RevenueServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RevenueData>>(
      stream: revenueServices.streamsPaymentsChartData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        } else if (snapshot.data!.isEmpty) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: 15, top: 5),
            child: Text(
              "No Earning Yet!",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ));
        }

        List<RevenueData> revenueDataList = snapshot.data!;

        return SfCartesianChart(
            enableAxisAnimation: true,
            enableSideBySideSeriesPlacement: true,
            primaryXAxis: CategoryAxis(),
            //title: ChartTitle(text: "Revenue Stats"),
            indicators: <TechnicalIndicators<dynamic, dynamic>>[
              MomentumIndicator<dynamic, dynamic>(
                  seriesName: 'HiloOpenClose',
                  isVisible: true,
                  isVisibleInLegend: true,
                  legendIconType: LegendIconType.diamond,
                  legendItemText: 'Indicator')
            ],
            primaryYAxis:
                NumericAxis(numberFormat: NumberFormat.simpleCurrency()
                    // numberFormat:
                    //     NumberFormat.currency(name: "CAD", decimalDigits: 0)

                    ),
            series: <ChartSeries>[
              ColumnSeries<RevenueData, String>(
                color: AppColors.darkAppColor,
                width: 0.2,
                enableTooltip: true,
                yAxisName: "Earnings",
                xAxisName: "Months",
                markerSettings:
                    const MarkerSettings(color: AppColors.darkAppColor),
                dataSource: revenueDataList,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                  labelPosition: ChartDataLabelPosition.outside,
                  useSeriesColor: true,
                  showZeroValue: false,
                  offset: Offset(0, 0),
                  //   showCumulativeValues: false,

                  // Format the label with dollar sign
                  // format: '\$ {point.y}',
                  textStyle: TextStyle(
                      color: AppColors.whitecolor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                //dataLabelMapper: (RevenueData data, _) => data.revenue,
                xValueMapper: (RevenueData data, _) =>
                    data.monthYear.toString(),
                yValueMapper: (RevenueData data, _) =>
                    double.parse(data.revenue),
                name: 'Monthly Revenue',
              ),
            ]);
      },
    );
  }
}
