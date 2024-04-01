import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login.dart'; // Import the LoginPage widget from login.dart

void main() {
  runApp(MyApp());
}

void deleteUserId() async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'userId');
}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    // deleteUserId(); // uncomment if need to logout user
    return MaterialApp(
      title: 'Login App',
      home: FutureBuilder(
        future: _checkLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.data == true) {
              // User is logged in, return the main app structure
              return MainApp();
            } else {
              // User is not logged in, navigate to the login page
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()), // Use LoginPage from login.dart
                );
              });
              return Container(); // Placeholder while navigating
            }
          }
        },
      ),
    );
  }

  Future<bool> _checkLoggedIn() async {
    final userId = await storage.read(key: 'userId');
    print('User ID from secure storage: $userId');
    return userId != null;
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Drone app"),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Pages to switch between
          HomePage(),
          DronePage(),
          SafetyCheckPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("pressed");
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Drone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.safety_check),
            label: 'Safety Check',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Update the index when a bottom navigation item is tapped
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}

class DronePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Drone Page'),
    );
  }
}

class SafetyCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Safety Check Page'),
    );
  }
}
