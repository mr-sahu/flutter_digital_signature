import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_digital_signature/src/signature_painter.dart';

class SignatureController extends ChangeNotifier {
  SignatureController({
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
  });

  Color penColor;
  double penStrokeWidth;

  final List<Offset?> _points = [];

  List<Offset?> get points => List.unmodifiable(_points);

  void addPoint(Offset point) {
    _points.add(point);
    notifyListeners();
  }

  /// Add null to separate strokes
  void addStrokeSeparator() {
    _points.add(null);
    notifyListeners();
  }

  /// Clear all points
  void clear() {
    _points.clear();
    notifyListeners();
  }

  /// Export the signature as a PNG image
  Future<ui.Image> toImage({
    double pixelRatio = 3.0,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()
      ..color = penColor
      ..strokeWidth = penStrokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final signaturePainter = SignaturePainter(points, paint);

    signaturePainter.paint(canvas, const Size(300, 150));

    final picture = recorder.endRecording();
    return picture.toImage(
      (300 * pixelRatio).toInt(),
      (150 * pixelRatio).toInt(),
    );
  }
}
