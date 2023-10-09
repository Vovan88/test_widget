import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class TestWidget extends StatefulWidget {
  bool valueCheckBox;
  final String text;
  TestWidget({super.key, required this.valueCheckBox, required this.text});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final GlobalKey globalKey = GlobalKey();
  final GlobalKey globalChexBox = GlobalKey();
  final GlobalKey globalText = GlobalKey();

  double wLine = 0;
  double wCheckBox = 0;
  double wText = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      wLine = _getwidth(globalKey.currentContext);
      wCheckBox = _getwidth(globalChexBox.currentContext);
      wText = _getwidth(globalText.currentContext);
      return Row(
        children: [
          Expanded(
            flex: wText + wCheckBox <= constraints.maxWidth - 10 ? 0 : 1,
            child: Text(
              key: globalText,
              widget.text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          wText + wCheckBox >= constraints.maxWidth - 10
              ? const SizedBox(
                  width: 10,
                )
              : Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 10),
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
              key: globalChexBox,
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
