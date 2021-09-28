import 'package:charts_flutter/flutter.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/launch_chart_item.dart';

class LaunchToLaunchChartItemMapper implements Mapper<List<Launch>, List<Series<LaunchChartItem, String>>> {
  @override
  List<Series<LaunchChartItem, String>> call(List<Launch> input) {
    final groupedByYearMap = _groupListByYear(input);
    final keys = groupedByYearMap.keys.toList(growable: false);
    keys.sort((date, otherDate) => date.compareTo(otherDate));

    final List<LaunchChartItem> data = List.empty(growable: true);
    keys.forEach((year) {
      data.add(LaunchChartItem(
        year: year,
        count: groupedByYearMap[year]!.length,
      ));
    });

    return [
      Series<LaunchChartItem, String>(
        id: "Launch chart data",
        data: data,
        domainFn: (LaunchChartItem item, _) => "${item.year}",
        measureFn: (LaunchChartItem item, _) => item.count,
      )
    ];
  }

  Map<int, List<Launch>> _groupListByYear(List<Launch> input) {
    final result = Map<int, List<Launch>>();
    input.sort((launch, otherLaunch) => launch.date.compareTo(otherLaunch.date));
    input.forEach((launch) {
      if (result[launch.date.year] == null) {
        result[launch.date.year] = List<Launch>.empty(growable: true);
      }
      result[launch.date.year]!.add(launch);
    });
    return result;
  }
}
