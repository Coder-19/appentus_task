import 'dart:convert';
import 'dart:typed_data';

import 'package:appentus_flutter_task/database/database_controller.dart';
import 'package:appentus_flutter_task/models/user.dart';
import 'package:appentus_flutter_task/provider/login_provider.dart';
import 'package:appentus_flutter_task/screens/image_gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// the code below is used to create the home screen of the app
class HomeScreen extends StatefulWidget {
  // the code below is used to create a property for doing the ontap functionality
  // on Click of the button
  final Function()? onTapSignOut;

  // initializing the above properties using the dart constructor
  const HomeScreen({
    Key? key,
    this.onTapSignOut,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // the code below is used to create a instance of the db controller
  DatabaseController db = DatabaseController();

  // the code below is used to create a google map controller
  GoogleMapController? _controller;

  // the code below is used to create an instance of position
  Position? position;

  // the code below is used to create an instance of widget
  Widget? child;

  // the code below is used to create a method to get the current location
  void getCurrentLocation() async {
    // the code below is used to create a property for getting the current position
    Position result = await Geolocator.getCurrentPosition();
    setState(() {
      position = result;
      child = mapWidget();
    });
  }

  // the code below is used to return the map widget
  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        zoom: 12.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      markers: _createMarker(),
    );
  }

  // the code below is used to create a method for showing the
  // marker on the current location
  Set<Marker> _createMarker() {
    return <Marker>{
       Marker(
        markerId: const MarkerId("Home"),
        position: LatLng(position!.latitude, position!.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: "Home",
        ),
      ),
    };
  }

  signOut() {
    setState(() {
      widget.onTapSignOut;
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  // the code below is used to create a method for getting the base 64 string
  // and converting it to image
  Uint8List getImage(String codedImage) {
    Uint8List bytes = base64.decode(codedImage);
    return bytes;
  }

  @override
  void initState() {
    child = const CircularProgressIndicator();
    getCurrentLocation();
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    // // the below lines of code are for debugging purpose
    DatabaseController db = DatabaseController();
    // db.getLogin("jasman@gmail.com".toString(), "123456");
    db.getAllUsers();
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: FutureBuilder<User>(
            future: db.getUserImage(
                Provider.of<LoginProvider>(context, listen: false)
                    .email
                    .toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(
                  getImage(snapshot.data!.userImage),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          title: FutureBuilder<User>(
            // future: db.getUserName("jasmanarora@gmail.com".toString()),
            future: db.getUserName(
                Provider.of<LoginProvider>(context, listen: false)
                    .email
                    .toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.userName.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.lock_open),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            // const Center(
            //    child: Text("Home Page"),
            //  ),

            Container(child: child),

            // the code below is used to create a button to go to
            // the next screen of the app
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.height * 1.4,
              child: Center(
                child: GestureDetector(
                  // TODO: need to add the onTap functionality
                  onTap: () {
                    // the navigator below is used to go to the image gallery screen
                    // of the app
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ImageGalleryScreen();
                    }));
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.teal,
                    ),
                    child: const Center(
                      child: Text(
                        "Image Gallery",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
