/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports

/// Renders the gauge label customization sample
class PerformGlobal extends StatefulWidget {
  const PerformGlobal({Key? key}) : super(key: key);

  @override
  State<PerformGlobal> createState() => _PerformGlobalState();
}

class _PerformGlobalState extends State<PerformGlobal> {

  @override
  Widget build(BuildContext context) {
    return _buildRadialLabelCustomization();
  }

  /// Returns the customized axis label gauge
  SfRadialGauge _buildRadialLabelCustomization() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            startAngle: 180,
            endAngle: 360,
            canScaleToFit: true,
            showLastLabel: true,
            interval: 10,
            labelFormat: '{value}%',
            labelsPosition: ElementsPosition.outside,
            minorTickStyle: const MinorTickStyle(
                length: 0.05, lengthUnit: GaugeSizeUnit.factor),
            majorTickStyle: const MajorTickStyle(
                length: 0.1, lengthUnit: GaugeSizeUnit.factor),
            minorTicksPerInterval: 5,
            pointers: const <GaugePointer>[
              NeedlePointer(
                  value: 70,
                  needleEndWidth: 3,
                  needleLength: 0.8,
                  knobStyle: KnobStyle(
                    knobRadius: 8,
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                  ),
                  tailStyle: TailStyle(
                      width: 3,
                      lengthUnit: GaugeSizeUnit.logicalPixel,
                      length: 20))
            ],
            axisLabelStyle: const GaugeTextStyle(fontWeight: FontWeight.w500),
            axisLineStyle:
            const AxisLineStyle(thickness: 3, color: Color(0xFF00A8B5))),
      ],
    );
  }
}