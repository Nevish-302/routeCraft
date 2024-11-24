import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

import 'package:ai_travel_planner/data/Repository/itenary.dart';
import 'package:ai_travel_planner/data/model/DiscoverModel.dart';
import 'package:ai_travel_planner/env/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String Imag = '';
  DiscoverModel items = DiscoverModel();
  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        // Use the recommended flutter_map_cancellable_tile_provider package to
        // support the cancellation of loading tiles.
        tileProvider: CancellableNetworkTileProvider(),
      );

  final ScrollController _scrollController = ScrollController();
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  late String _darkMapStyle;
  @override
  void initState() {
    // TODO: implement initState
    // fetchImage();

    _loadMapStyles();
    fetchItems();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> ItemIms = [];
  List<Marker> markersIms = [];
  // BitmapDescriptor? bitmapImage;

  // Future<BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
  //   Image _image = await Image.asset(iconPath);
  //   List<int> list = utf8.encode(_image.toString());
  //   Uint8List bytes = Uint8List.fromList(list);
  //   // ByteData byteData = await rootBundle.load(iconPath);
  //   // // And construct the BitmapDescriptor from the bytelist
  //   BitmapDescriptor _bitmapDescriptor = BitmapDescriptor.bytes(bytes);
  //
  //   // And return the product
  //   // return _bitmapDescriptor;
  //   ImageConfiguration configuration = ImageConfiguration();
  //   bitmapImage = await BitmapDescriptor.asset(
  //     configuration,
  //     iconPath,
  //   );
  //   setState(() {
  //     // bitmapImage = _bitmapDescriptor;
  //     print(bitmapImage);
  //     print(_image);
  //     print("jhack");
  //   });
  //
  //   return bitmapImage!;
  // }
  LatLng center = LatLng(
      37.42796133580664, -122.085749655962); // Initial map center in London
  double _zoom = 5.0;
  void fetchItems() async {
    ItenaryRepo repo = ItenaryRepo();
    items = await repo.FetchDiscoverAI();
    print(items.items![0].name);
    int i = 1;
    int totalPlaces = items.items!.length;
    for (int i = 0; i < totalPlaces; i++) {
      try {
        String imagelink =
            // 'https://images.pexels.com/photos/2929906/pexels-photo-2929906.jpeg?auto=compress&cs=tinysrgb&h=350';
            await repo.fetchPexelsData(Env.PEXELS, '${items.items![i].name}');
        items.items![i].imageLink = imagelink;
        ItemIms.add(makeIM(items.items![i], i + 1));
        String name =
            await '${items.items![i].name} ${items.items![i].location}';
        List<Location> locations = await locationFromAddress(name);
        markersIms.add(
            makeMarker(locations[0].latitude, locations[0].longitude, i + 1));
        center = LatLng(locations[0].latitude, locations[0].longitude);
        setState(() {});
      } catch (e) {
        print(e.toString());
      }
    }

    setState(() {});
    print(ItemIms.length);
    print(markersIms.length);
    // setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double middlePosition =
          (_scrollController.position.maxScrollExtent / 10) * 1.8;
      _scrollController.jumpTo(middlePosition);
    });
  }

  void fetchImage() async {
    ItenaryRepo repo = ItenaryRepo();
    Imag = await repo.fetchPexelsData(Env.PEXELS, "Bali");
    print(Imag + " dddd");
  }

  Widget makeIM(item, i) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height * .42,
          width: MediaQuery.of(context).size.height * .30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.location,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 15,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(125, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * .25),
                    child: Container(
                        color: Colors.white,
                        child: Image(
                            height: 30,
                            width: 30,
                            image: AssetImage('asset/mapIcons/${i}.png'))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(125, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        item.vacationDuration,
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 8.0,
                              color: Color.fromARGB(125, 0, 0, 0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(item.imageLink), fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Marker makeMarker(long, lat, image) {
    return Marker(
      width: 35,
      height: 35,
      point: LatLng(lat, long),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * .25),
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image(
                  height: 30,
                  width: 30,
                  image: AssetImage('asset/mapIcons/${image}.png')),
            )),
      ),
    );
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('asset/style.json');
    print(_darkMapStyle);
  }

  // final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Discover',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ItemIms,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 1; i < 6; i++)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * .25),
                          child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image(
                                    height: 30,
                                    width: 30,
                                    image:
                                        AssetImage('asset/mapIcons/${i}.png')),
                              )),
                        ),
                      ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * .175),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.height * .3,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: center,
                        initialZoom: 1,
                        onPositionChanged:
                            (MapPosition pos, bool hasGesture) async {
                          if (hasGesture) {
                            // latLng initialCenter=
                            center = pos.center!;
                            print("changed inside");
                            print(pos.toString());
                            _zoom = pos.zoom!;
                            print(pos.center.toString());
                            print(pos.zoom.toString());
                            setState(() {
                              center =
                                  pos.center!; // Update center on map gesture
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
                          markers: markersIms,
                        ),
                      ],
                    ),
                    // child: GoogleMap(
                    //   onMapCreated: (GoogleMapController controller) {
                    //     _controller.complete(controller);
                    //     _controller.future.then((value) {
                    //       value.setMapStyle(_darkMapStyle);
                    //     });
                    //     _createMarkerImageFromAsset('asset/1.png');
                    //   },
                    //   initialCameraPosition: _kGooglePlex,
                    //   zoomControlsEnabled: false,
                    //   markers: {
                    //     Marker(
                    //         markerId: MarkerId("value"),
                    //         position: _kGooglePlex.target,
                    //         icon: bitmapImage ?? BitmapDescriptor.defaultMarker),
                    //   },
                    //   // mapType: MapType.satellite,
                    // ),
                  ),
                ),
                Column(
                  children: [
                    for (int i = 6; i < 11; i++)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * .25),
                          child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image(
                                    height: 30,
                                    width: 30,
                                    image:
                                        AssetImage('asset/mapIcons/${i}.png')),
                              )),
                        ),
                      ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
