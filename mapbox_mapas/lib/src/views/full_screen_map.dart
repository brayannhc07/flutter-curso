import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final center = LatLng(37.810575, -122.477174);
  final streetStyle = "mapbox://styles/brayannhc7/ckwl0a77m28ml15leercygckr";
  final oscuroStyle = "mapbox://styles/brayannhc7/ckwl07jzi3pbu15uo6mdcnncb";
  String selectedStyle = "mapbox://styles/brayannhc7/ckwl07jzi3pbu15uo6mdcnncb";

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(Uri.parse(url));
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearMapa(),
      floatingActionButton: _botones(),
    );
  }

  Column _botones() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Simbolos
        FloatingActionButton(
            child: Icon(Icons.location_on),
            onPressed: () {
              mapController.addSymbol(
                SymbolOptions(
                    geometry: center,
                    // iconSize: 3,
                    iconImage: "assetImage",
                    textField: "Montaña creada aquí",
                    textOffset: Offset(0, 3)),
              );
            }),
        SizedBox(
          height: 10,
        ),
        // ZoomIn
        FloatingActionButton(
            child: Icon(Icons.zoom_in),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            }),
        SizedBox(
          height: 10,
        ),
        // ZoomOut
        FloatingActionButton(
            child: Icon(Icons.zoom_out),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            }),
        SizedBox(
          height: 10,
        ),
        // Cambiar estilo
        FloatingActionButton(
            child: Icon(Icons.add_to_home_screen),
            onPressed: () {
              selectedStyle =
                  selectedStyle == oscuroStyle ? streetStyle : oscuroStyle;
              _onStyleLoaded();
              setState(() {});
            })
      ],
    );
  }

  MapboxMap _crearMapa() {
    return MapboxMap(
        styleString: selectedStyle,
        initialCameraPosition: CameraPosition(target: center, zoom: 14),
        onMapCreated: _onMapCreated);
  }
}
