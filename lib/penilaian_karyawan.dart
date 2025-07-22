import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penilaian Karyawan',
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

  final List<Widget> _screens = [
    const Penilaian_karyawan(),
    const PerangkinganScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Penilaian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Perangkingan',
          ),
        ],
      ),
    );
  }
}

class Rank_karyawanScreen {}

class Penilaian_karyawan extends StatefulWidget {
  const Penilaian_karyawan({super.key});

  @override
  Rank_karyawan createState() => Rank_karyawan();
}

class Rank_karyawan extends State<Penilaian_karyawan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();

  double _kedisiplinan = 0;
  double _kerjasama = 0;
  double _kreativitas = 0;
  double _tanggungJawab = 0;
  double _kualitasKerja = 0;

  final List<Map<String, dynamic>> _penilaianList = [];

  void _submitPenilaian() {
    if (_formKey.currentState!.validate()) {
      // Hitung nilai SAW
      double totalNilai = (_kedisiplinan +
              _kerjasama +
              _kreativitas +
              _tanggungJawab +
              _kualitasKerja) /
          5;

      setState(() {
        _penilaianList.add({
          'nama': _namaController.text,
          'jabatan': _jabatanController.text,
          'kedisiplinan': _kedisiplinan,
          'kerjasama': _kerjasama,
          'kreativitas': _kreativitas,
          'tanggungJawab': _tanggungJawab,
          'kualitasKerja': _kualitasKerja,
          'totalNilai': totalNilai,
        });
      });

      // Reset form
      _namaController.clear();
      _jabatanController.clear();
      _kedisiplinan = 0;
      _kerjasama = 0;
      _kreativitas = 0;
      _tanggungJawab = 0;
      _kualitasKerja = 0;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Penilaian berhasil ditambahkan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penilaian Karyawan'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Karyawan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Karyawan',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _jabatanController,
                        decoration: const InputDecoration(
                          labelText: 'Jabatan',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.work),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Jabatan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kriteria Penilaian',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSlider('Kedisiplinan', _kedisiplinan, (value) {
                        setState(() {
                          _kedisiplinan = value;
                        });
                      }),
                      _buildSlider('Kerjasama', _kerjasama, (value) {
                        setState(() {
                          _kerjasama = value;
                        });
                      }),
                      _buildSlider('Kreativitas', _kreativitas, (value) {
                        setState(() {
                          _kreativitas = value;
                        });
                      }),
                      _buildSlider('Tanggung Jawab', _tanggungJawab, (value) {
                        setState(() {
                          _tanggungJawab = value;
                        });
                      }),
                      _buildSlider('Kualitas Kerja', _kualitasKerja, (value) {
                        setState(() {
                          _kualitasKerja = value;
                        });
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPenilaian,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Simpan Penilaian',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(1)}',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Slider(
          value: value,
          min: 0,
          max: 10,
          divisions: 100,
          onChanged: onChanged,
          activeColor: Colors.blue[600],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class PerangkinganScreen extends StatefulWidget {
  const PerangkinganScreen({super.key});

  @override
  _PerangkinganScreenState createState() => _PerangkinganScreenState();
}

class _PerangkinganScreenState extends State<PerangkinganScreen> {
  final List<Map<String, dynamic>> _sampleData = [
    {
      'nama': 'Ahmad Fauzi',
      'jabatan': 'Software Developer',
      'kedisiplinan': 8.5,
      'kerjasama': 9.0,
      'kreativitas': 8.8,
      'tanggungJawab': 9.2,
      'kualitasKerja': 8.7,
      'totalNilai': 8.84,
    },
    {
      'nama': 'Siti Nurhaliza',
      'jabatan': 'Project Manager',
      'kedisiplinan': 9.5,
      'kerjasama': 9.8,
      'kreativitas': 8.2,
      'tanggungJawab': 9.5,
      'kualitasKerja': 9.0,
      'totalNilai': 9.20,
    },
    {
      'nama': 'Budi Santoso',
      'jabatan': 'UI/UX Designer',
      'kedisiplinan': 8.0,
      'kerjasama': 8.5,
      'kreativitas': 9.5,
      'tanggungJawab': 8.8,
      'kualitasKerja': 9.2,
      'totalNilai': 8.80,
    },
    {
      'nama': 'Diana Putri',
      'jabatan': 'Data Analyst',
      'kedisiplinan': 9.0,
      'kerjasama': 8.8,
      'kreativitas': 8.5,
      'tanggungJawab': 9.0,
      'kualitasKerja': 8.9,
      'totalNilai': 8.84,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Sort data by total nilai (descending)
    _sampleData.sort((a, b) => b['totalNilai'].compareTo(a['totalNilai']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perangkingan Karyawan'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sampleData.length,
        itemBuilder: (context, index) {
          final data = _sampleData[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                _showDetailDialog(context, data, index + 1);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getRankColor(index + 1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['jabatan'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Nilai',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          data['totalNilai'].toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.orange[300]!;
      default:
        return Colors.blue[300]!;
    }
  }

  void _showDetailDialog(
      BuildContext context, Map<String, dynamic> data, int rank) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detail Penilaian'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Ranking: #$rank',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Nama: ${data['nama']}'),
                Text('Jabatan: ${data['jabatan']}'),
                const SizedBox(height: 12),
                const Text('Kriteria Penilaian:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildDetailRow('Kedisiplinan', data['kedisiplinan']),
                _buildDetailRow('Kerjasama', data['kerjasama']),
                _buildDetailRow('Kreativitas', data['kreativitas']),
                _buildDetailRow('Tanggung Jawab', data['tanggungJawab']),
                _buildDetailRow('Kualitas Kerja', data['kualitasKerja']),
                const SizedBox(height: 8),
                const Divider(),
                Text(
                  'Total Nilai: ${data['totalNilai'].toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value.toStringAsFixed(1)),
        ],
      ),
    );
  }
}
