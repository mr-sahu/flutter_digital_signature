import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_digital_signature/flutter_digital_signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignatureController _controller = SignatureController();

  Uint8List? _imageBytes;

  Future<void> _exportSignature() async {
    final ui.Image image = await _controller.toImage();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      setState(() {
        _imageBytes = byteData.buffer.asUint8List();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Digital Signature')),
        body: Column(
          children: [
            SignatureWidget(controller: _controller),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.clear(),
                  child: const Text('Clear'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _exportSignature,
                  child: const Text('Export'),
                ),
              ],
            ),
            if (_imageBytes != null)
              Image.memory(_imageBytes!, width: 300, height: 150),
          ],
        ),
      ),
    );
  }
}
