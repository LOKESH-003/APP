import 'package:flutter/foundation.dart' show kIsWeb;

String getServerUrl() {
  if (kIsWeb) {
    // Web platform
    return 'http://localhost:5000'; // Or your web server URL
  } else {
    // Mobile platform
    // In a real scenario, you might want to fetch the IP dynamically or use a fixed URL
    return 'http://10.0.2.2:5000'; // Commonly used localhost address for Android emulators
  }
}
