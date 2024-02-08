import 'package:flutter/material.dart';
import 'package:pokedex_dima_new/domain/ranged_parameter.dart';


class FilterSlidebar extends StatefulWidget {

  final RangedParameter rangedParam;
  const FilterSlidebar({super.key, required this.rangedParam});

  @override
  _FilterSlidebarState createState() => _FilterSlidebarState();
}

class _FilterSlidebarState extends State<FilterSlidebar> {

  RangeValues rangeValuesState = const RangeValues(0.0, 100.0);

  @override
  Widget build(BuildContext context) {
    var rangedParam = widget.rangedParam.getRangedParameter();
    return Column(
      children: [
        RangeSlider(
          values: rangedParam,
          min: 0.0,
          max: widget.rangedParam.maxValue,
          onChanged: (RangeValues values) {
            setState(() {
              widget.rangedParam.setRangedParameter(values);
              rangeValuesState = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Min: ${rangedParam.start.toStringAsFixed(2)} '
                  '- Max: ${rangedParam.end.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFFAAAAAA),
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}