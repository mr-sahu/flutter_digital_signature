import 'package:flutter/material.dart';
import 'signature_controller.dart';
import 'signature_painter.dart';

class SignatureWidget extends StatefulWidget {
  final SignatureController controller;
  final Color backgroundColor;
  final double width;
  final double height;

  const SignatureWidget({
    Key? key,
    required this.controller,
    this.backgroundColor = Colors.white,
    this.width = 300,
    this.height = 150,
  }) : super(key: key);

  @override
  State<SignatureWidget> createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        widget.controller.addPoint(details.localPosition);
      },
      onPanUpdate: (details) {
        widget.controller.addPoint(details.localPosition);
      },
      onPanEnd: (details) {
        widget.controller.addStrokeSeparator();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.backgroundColor,
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            return CustomPaint(
              painter: SignaturePainter(
                widget.controller.points,
                Paint()
                  ..color = widget.controller.penColor
                  ..strokeWidth = widget.controller.penStrokeWidth
                  ..strokeCap = StrokeCap.round
                  ..style = PaintingStyle.stroke,
              ),
            );
          },
        ),
      ),
    );
  }
}
