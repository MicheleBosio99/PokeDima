import 'package:flutter/material.dart';



class RangedParameter {

  double minValue;
  double maxValue;
  RangedParameter({ required this.minValue, required this.maxValue });

  void setRangedParameter(RangeValues rangeValues) {
    minValue = rangeValues.start;
    maxValue = rangeValues.end;
  }

  RangeValues getRangedParameter() {
    return RangeValues(minValue, maxValue);
  }
}
