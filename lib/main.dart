import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// Import your signature controller and widget files here, assuming they are inside lib/src/
import 'src/signature_controller.dart';
import 'src/signature_widget.dart';

void main() {
  runApp(
      const MyApp());
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
      title: 'Flutter Digital Signature Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Digital Signature'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SignatureWidget(
                controller: _controller,
                width: double.infinity,
                height: 200,
                backgroundColor: Colors.grey[200]!,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _controller.clear(),
                    child: const Text('Clear'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _exportSignature,
                    child: const Text('Export as PNG'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_imageBytes != null)
                Column(
                  children: [
                    const Text('Exported Signature:'),
                    const SizedBox(height: 10),
                    Image.memory(
                      _imageBytes!,
                      width: 300,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
