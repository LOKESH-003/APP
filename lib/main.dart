import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'platform_utils.dart'; // Import the utility for platform detection

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _count = '';
  String _serverUrl = '';

  @override
  void initState() {
    super.initState();
    _serverUrl = getServerUrl(); // Initialize server URL based on the platform
  }

  Future<void> _startDetection() async {
    final response = await http.post(
      Uri.parse('$_serverUrl/start_detection'),
      body: {
        'video_path': 'rtsp://rtspstream:1930feb0841b01a47d00bb674f92da03@zephyr.rtsp.stream/movie',
        'phone_number': '+919442493256',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _count = 'Detection count: ${data['count']}';
      });
      print('Detection started');
    } else {
      print('Failed to start detection');
    }
  }

  Future<void> _stopDetection() async {
    final response = await http.post(
      Uri.parse('$_serverUrl/stop_detection'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _count = 'Detection stopped and message sent';
      });
    } else {
      print('Failed to stop detection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detection App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startDetection,
              child: Text('Start'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _stopDetection,
              child: Text('Stop'),
            ),
            SizedBox(height: 20),
            Text(_count),
          ],
        ),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'platform_utils.dart'; // Import the utility for platform detection

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Detection App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _videoController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   String _count = '';
//   String _serverUrl = '';

//   @override
//   void initState() {
//     super.initState();
//     _serverUrl = getServerUrl(); // Initialize server URL based on the platform
//   }

//   Future<void> _startDetection() async {
//     final response = await http.post(
//       Uri.parse('$_serverUrl/start_detection'),
//       body: {
//         'video_path': _videoController.text,
//         'phone_number': _phoneController.text,
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         _count = 'Detection count: ${data['count']}';
//       });
//       print('Detection started');
//     } else {
//       print('Failed to start detection');
//     }
//   }

//   Future<void> _stopDetection() async {
//     final response = await http.post(
//       Uri.parse('$_serverUrl/stop_detection'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         _count = 'Detection stopped and message sent';
//       });
//     } else {
//       print('Failed to stop detection');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detection App'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _videoController,
//               decoration: InputDecoration(labelText: 'Video Path or RTSP Link'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                   labelText: 'Receiver\'s Phone/WhatsApp Number'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _startDetection,
//               child: Text('Start'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _stopDetection,
//               child: Text('Stop'),
//             ),
//             SizedBox(height: 20),
//             Text(_count),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Detection App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _videoController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   String _count = '';

//   Future<void> _startDetection() async {
//     final response = await http.post(
//       Uri.parse('http://192.168.231.128:5000/start_detection'),
//       body: {
//         'video_path': _videoController.text,
//         'phone_number': _phoneController.text,
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         _count = 'Detection count: ${data['count']}';
//       });
//       print('Detection started');
//     } else {
//       print('Failed to start detection');
//     }
//   }

//   Future<void> _stopDetection() async {
//     final response = await http.post(
//       Uri.parse('http://192.168.231.128:5000/stop_detection'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         _count = 'Detection stopped and message sent';
//       });
//     } else {
//       print('Failed to stop detection');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detection App'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _videoController,
//               decoration: InputDecoration(labelText: 'Video Path or RTSP Link'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                   labelText: 'Receiver\'s Phone/WhatsApp Number'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _startDetection,
//               child: Text('Start'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _stopDetection,
//               child: Text('Stop'),
//             ),
//             SizedBox(height: 20),
//             Text(_count),
//           ],
//         ),
//       ),
//     );
//   }
// }
