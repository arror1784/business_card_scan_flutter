import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'dart:ffi' as ffi;
import 'dart:ui';

class Coordinate extends ffi.Struct {
  @ffi.Double()
  external double x;

  @ffi.Double()
  external double y;

  factory Coordinate.allocate(double x, double y) =>
      malloc<Coordinate>().ref
        ..x = x
        ..y = y;
}

class NativeDetectionResult extends ffi.Struct {
  external ffi.Pointer<Coordinate> topLeft;
  external ffi.Pointer<Coordinate> topRight;
  external ffi.Pointer<Coordinate> bottomLeft;
  external ffi.Pointer<Coordinate> bottomRight;

  factory NativeDetectionResult.allocate(
      ffi.Pointer<Coordinate> topLeft,
      ffi.Pointer<Coordinate> topRight,
      ffi.Pointer<Coordinate> bottomLeft,
      ffi.Pointer<Coordinate> bottomRight) =>
      malloc<NativeDetectionResult>().ref
        ..topLeft = topLeft
        ..topRight = topRight
        ..bottomLeft = bottomLeft
        ..bottomRight = bottomRight;
}

class EdgeDetectionResult {
  EdgeDetectionResult({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  Offset topLeft;
  Offset topRight;
  Offset bottomLeft;
  Offset bottomRight;
}

typedef DetectEdgesFunction = ffi.Pointer<NativeDetectionResult> Function(
  ffi.Pointer<Utf8> imagePath
);


typedef ProcessImageFunctionFFI = ffi.Int8 Function(
  ffi.Pointer<Utf8> imagePath,
  ffi.Double topLeftX,
  ffi.Double topLeftY,
  ffi.Double topRightX,
  ffi.Double topRightY,
  ffi.Double bottomLeftX,
  ffi.Double bottomLeftY,
  ffi.Double bottomRightX,
  ffi.Double bottomRightY
);
typedef ProcessImageFunction = int Function(
  ffi.Pointer<Utf8> imagePath,
  double topLeftX,
  double topLeftY,
  double topRightX,
  double topRightY,
  double bottomLeftX,
  double bottomLeftY,
  double bottomRightX,
  double bottomRightY
);

class EdgeScreen extends StatefulWidget {
  EdgeScreen(this.path,{Key? key}) : super(key: key);

  final String path;

  @override
  _EdgeScreenState createState() => _EdgeScreenState();
}

class _EdgeScreenState extends State<EdgeScreen> {

  EdgeDetectionResult? edgeDetectionResult;
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    imagePath = widget.path;
    final ffi.DynamicLibrary nativeEdgeDetection = Platform.isAndroid
      ? ffi.DynamicLibrary.open("libnative_edge_detection.so")
      : ffi.DynamicLibrary.process();
    final detectEdges = nativeEdgeDetection
        .lookup<ffi.NativeFunction<DetectEdgesFunction>>("detect_edges")
        .asFunction<DetectEdgesFunction>();

    final processImage = nativeEdgeDetection
        .lookup<ffi.NativeFunction<ProcessImageFunctionFFI>>("process_image")
        .asFunction<ProcessImageFunction>();

    NativeDetectionResult result = detectEdges(imagePath.toNativeUtf8()).ref;
    var v = processImage(imagePath.toNativeUtf8()
                ,result.topLeft.ref.x
                ,result.topLeft.ref.y
                ,result.topRight.ref.x
                ,result.topRight.ref.y
                ,result.bottomLeft.ref.x
                ,result.bottomLeft.ref.y
                ,result.bottomRight.ref.x
                ,result.bottomRight.ref.y);

    var image = Image.file(File(imagePath));
    // image.

    return Container(
      child: Image.file(File(imagePath)),
    );
  }
}