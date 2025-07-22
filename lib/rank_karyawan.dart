import 'package:flutter/material.dart';

class Rank_karyawan extends StatefulWidget {
  const Rank_karyawan({super.key});

  @override
  _Rank_karyawanState createState() => _Rank_karyawanState();
}

class _Rank_karyawanState extends State<Rank_karyawan> {
  // Data sample untuk demonstrasi
  final List<EmployeeRanking> rankings = [
    EmployeeRanking(
      rank: 1,
      name: "Ahmad Fauzi",
      nip: "2021001",
      kehadiran: 90,
      sikap: 85,
      kerajinan: 88,
      kuantitas: 92,
      kualitas: 87,
      finalScore: 0.884,
    ),
    EmployeeRanking(
      rank: 2,
      name: "Siti Nurhaliza",
      nip: "2021002",
      kehadiran: 88,
      sikap: 90,
      kerajinan: 85,
      kuantitas: 89,
      kualitas: 91,
      finalScore: 0.872,
    ),
    EmployeeRanking(
      rank: 3,
      name: "Budi Santoso",
      nip: "2021003",
      kehadiran: 85,
      sikap: 87,
      kerajinan: 90,
      kuantitas: 86,
      kualitas: 88,
      finalScore: 0.865,
    ),
    EmployeeRanking(
      rank: 4,
      name: "Dewi Sartika",
      nip: "2021004",
      kehadiran: 87,
      sikap: 83,
      kerajinan: 86,
      kuantitas: 88,
      kualitas: 85,
      finalScore: 0.858,
    ),
    EmployeeRanking(
      rank: 5,
      name: "Rizky Pratama",
      nip: "2021005",
      kehadiran: 82,
      sikap: 88,
      kerajinan: 84,
      kuantitas: 85,
      kualitas: 89,
      finalScore: 0.847,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Perangkingan Karyawan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[800]!, Colors.blue[600]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: 10),
                Text(
                  'Hasil Perangkingan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Metode SAW (Simple Additive Weighting)',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Kriteria Info
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kriteria Penilaian:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildCriteriaChip('Kehadiran', Colors.blue),
                    _buildCriteriaChip('Sikap/Etika', Colors.green),
                    _buildCriteriaChip('Kerajinan', Colors.orange),
                    _buildCriteriaChip('Kuantitas', Colors.purple),
                    _buildCriteriaChip('Kualitas', Colors.red),
                  ],
                ),
              ],
            ),
          ),

          // Ranking List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: rankings.length,
              itemBuilder: (context, index) {
                final employee = rankings[index];
                return _buildRankingCard(employee);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDetailDialog(context);
        },
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.info_outline, color: Colors.white),
      ),
    );
  }

  Widget _buildCriteriaChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRankingCard(EmployeeRanking employee) {
    Color rankColor = _getRankColor(employee.rank);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showEmployeeDetail(employee),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Rank Badge
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: rankColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '${employee.rank}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Employee Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          'NIP: ${employee.nip}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Final Score
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: rankColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      employee.finalScore.toStringAsFixed(3),
                      style: TextStyle(
                        color: rankColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Criteria Scores
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildScoreItem('Kehadiran', employee.kehadiran, Colors.blue),
                  _buildScoreItem('Sikap', employee.sikap, Colors.green),
                  _buildScoreItem(
                      'Kerajinan', employee.kerajinan, Colors.orange),
                  _buildScoreItem(
                      'Kuantitas', employee.kuantitas, Colors.purple),
                  _buildScoreItem('Kualitas', employee.kualitas, Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, int score, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$score',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber[600]!; // Gold
      case 2:
        return Colors.grey[600]!; // Silver
      case 3:
        return Colors.brown[600]!; // Bronze
      default:
        return Colors.blue[600]!;
    }
  }

  void _showEmployeeDetail(EmployeeRanking employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Penilaian'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${employee.name}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('NIP: ${employee.nip}'),
            const SizedBox(height: 16),
            const Text('Nilai Kriteria:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildDetailRow('Kehadiran', employee.kehadiran),
            _buildDetailRow('Sikap/Etika', employee.sikap),
            _buildDetailRow('Kerajinan', employee.kerajinan),
            _buildDetailRow('Kuantitas', employee.kuantitas),
            _buildDetailRow('Kualitas', employee.kualitas),
            const Divider(),
            Text('Skor Akhir: ${employee.finalScore.toStringAsFixed(3)}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informasi Sistem'),
        content: const Text(
          'Sistem Penunjang Keputusan (SPK) ini menggunakan metode SAW '
          '(Simple Additive Weighting) untuk menentukan ranking karyawan terbaik '
          'berdasarkan 5 kriteria penilaian: Kehadiran, Sikap/Etika, Kerajinan, '
          'Kuantitas, dan Kualitas kerja.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class EmployeeRanking {
  final int rank;
  final String name;
  final String nip;
  final int kehadiran;
  final int sikap;
  final int kerajinan;
  final int kuantitas;
  final int kualitas;
  final double finalScore;

  EmployeeRanking({
    required this.rank,
    required this.name,
    required this.nip,
    required this.kehadiran,
    required this.sikap,
    required this.kerajinan,
    required this.kuantitas,
    required this.kualitas,
    required this.finalScore,
  });
}

// Untuk menjalankan aplikasi
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPK Penilaian Karyawan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Rank_karyawan(),
      debugShowCheckedModeBanner: false,
    );
  }
}
