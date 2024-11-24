import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'data/model/itenaryModel.dart';

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      // Use the recommended flutter_map_cancellable_tile_provider package to
      // support the cancellation of loading tiles.
      tileProvider: CancellableNetworkTileProvider(),
    );

class MapTile extends StatefulWidget {
  static const String route = '/';

  MapTile({super.key, required this.item});
  final Places item;
  @override
  State<MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<MapTile> {
  LatLng center = LatLng(1.6333, 4.5823); // Initial map center in London
  double _zoom = 15.0;
  @override
  void initState() {
    super.initState();
    setState(() {
      center = LatLng(double.parse(widget.item.latitude!),
          double.parse(widget.item.longitude!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: _zoom,

                onPositionChanged: (MapPosition pos, bool hasGesture) async {
                  if (hasGesture) {
                    // latLng initialCenter=
                    center = pos.center!;
                    print("changed inside");
                    print(pos.toString());
                    _zoom = pos.zoom!;
                    print(pos.center.toString());
                    print(pos.zoom.toString());
                    setState(() {
                      center = pos.center!; // Update center on map gesture
                    });
                  }
                },
                // cameraConstraint: CameraConstraint.contain(
                //   bounds: LatLngBounds(
                //     LatLng(double.parse(widget.item.latitude!),
                //         double.parse(widget.item.longitude!)),
                //     LatLng(double.parse(widget.item.latitude!),
                //         double.parse(widget.item.longitude!)),
                //   ),
                // ),
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 310,
                      height: 60,
                      point: LatLng(double.parse(widget.item.latitude!),
                          double.parse(widget.item.longitude!)),
                      child: Icon(
                        Iconsax.location5,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
