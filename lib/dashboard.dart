import 'package:absen_kantor/penilaian_karyawan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPK SAW Penilaian Karyawan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> get _pages => <Widget>[
        const Dashboard(),
        const Karyawan(),
        //Kriteria_karyawan(),
        const Penilaian_karyawan(),
        //Rank_karyawan(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPK SAW Penilaian Karyawan'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: _pages[3],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Karyawan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kriteria_karyawan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Penilaian_karyawan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Rank_karyawan',
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dashboard Page'),
    );
  }
}

class Karyawan extends StatelessWidget {
  const Karyawan({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Karyawan Page'),
    );
  }
}
