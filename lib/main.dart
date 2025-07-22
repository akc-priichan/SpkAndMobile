import 'package:absen_kantor/kriteria_karyawan.dart';
import 'package:absen_kantor/penilaian_karyawan.dart';
import 'package:absen_kantor/rank_karyawan.dart' as Rank_karyawan;
import 'package:flutter/material.dart';
import 'package:absen_kantor/dashboard.dart';

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

  final List<Widget> _pages = [
    const Karyawan(),
    const Penilaian_karyawan(),
    Rank_karyawan.Rank_karyawan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
            icon: Icon(Icons.people),
            label: 'Karyawan',
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
