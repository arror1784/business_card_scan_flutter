import 'package:flutter/material.dart';
import 'bc_list_widget.dart';
import 'camera_widget.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = <CameraDescription>[];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/camera': (context) => CameraScreen(cameras: cameras,),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BC scan"),
      ),
      body: BCListWidget(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("ADD"),
        icon: Icon(Icons.camera_alt_outlined),
        onPressed: () => Navigator.pushNamed(context, '/camera'),
      ),
    );
  }
}
