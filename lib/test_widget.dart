import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class TestWidget extends StatefulWidget {
  bool valueCheckBox;
  final String text;
  TestWidget({super.key, required this.valueCheckBox, required this.text});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with WidgetsBindingObserver {
  final GlobalKey globalKey = GlobalKey();
  ValueNotifier<bool> valueNotifierVisible = ValueNotifier(true);
  double w = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      w = _getwidth(globalKey.currentContext);

      valueNotifierVisible.value = w > 10;
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifierVisible,
        builder: (c, val, _) {
          return Row(
            children: [
              Expanded(
                  flex: val ? 0 : 1,
                  child: Text(widget.text, overflow: TextOverflow.ellipsis)),
              Expanded(
                child: Visibility(
                  visible: val,
                  maintainState: true,
                  child: DottedLine(
                    key: globalKey,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.black,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapRadius: 0.0,
                  ),
                ),
              ),
              Checkbox(
                  value: widget.valueCheckBox,
                  onChanged: (val) {
                    setState(() {
                      if (val != null) {
                        widget.valueCheckBox = val;
                      }
                    });
                  })
            ],
          );
        });
  }

  @override
  void didChangeMetrics() {
    w = _getwidth(globalKey.currentContext);

    valueNotifierVisible.value = w > 10;
  }

  _getwidth(c) {
    try {
      final RenderBox renderBox = c.findRenderObject() as RenderBox;

      final Size size = renderBox.size;

      return size.width;
    } catch (e) {
      return 0;
    }
  }
}
