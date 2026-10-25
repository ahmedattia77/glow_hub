import 'package:flutter/material.dart';

class EarningsBarData {
  final double amount;
  final Color? color;

  const EarningsBarData({
    required this.amount,
    this.color,
  });
}

class EarningsOverviewModel {
  final List<double> yAxisMarks;
  final List<EarningsBarData> bars;

  const EarningsOverviewModel({
    required this.yAxisMarks,
    required this.bars,
  });
}
