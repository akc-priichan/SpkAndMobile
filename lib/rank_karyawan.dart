import 'package:flutter/material.dart';
import 'package:absen_kantor/repository/ranking.dart';

class Rank_karyawan extends StatefulWidget {
  const Rank_karyawan({super.key});

  @override
  _Rank_karyawanState createState() => _Rank_karyawanState();
}

class _Rank_karyawanState extends State<Rank_karyawan> {
  // Data sample untuk demonstrasi
  final List<EmployeeRanking> rankings = [];

  bool _isLoading = false;

  Future getRanking() async {
    setState(() {
      _isLoading = true;
    });
    var res = await RankingRepo.index();
    if (res != false) {
      print(res);
      setState(() {
        // Parse data and update rankings list
        for (var item in res) {
          rankings.add(
            EmployeeRanking(
              rank: item['ranking']['peringkat'],
              name: item['karyawan']['nama'],
              nip: item['karyawan']['nip'],
              kedisiplinan: item['penilaian']['kedisiplinan'],
              kerjasama: item['penilaian']['kerjasama'],
              kreativitas: item['penilaian']['kreativitas'],
              tanggungJawab: item['penilaian']['tanggung_jawab'],
              kualitas: item['penilaian']['kualitas_kerja'],
              finalScore: item['ranking']['nilai_saw'],
            ),
          );
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRanking();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                Icon(Icons.trending_up, color: Colors.white, size: 48),
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
                  style: TextStyle(color: Colors.white70, fontSize: 14),
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
                    _buildCriteriaChip('Kedisiplinan', Colors.blue),
                    _buildCriteriaChip('Kerjasama', Colors.green),
                    _buildCriteriaChip('Kreativitas', Colors.orange),
                    _buildCriteriaChip('Tanggung Jawab', Colors.purple),
                    _buildCriteriaChip('Kualitas', Colors.red),
                  ],
                ),
              ],
            ),
          ),

          // Ranking List
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: rankColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      employee.finalScore,
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
                  _buildScoreItem(
                    'Kedisiplinan',
                    employee.kedisiplinan,
                    Colors.blue,
                  ),
                  _buildScoreItem('Sikap', employee.kerjasama, Colors.green),
                  _buildScoreItem(
                    'Kreativitas',
                    employee.kreativitas,
                    Colors.orange,
                  ),
                  _buildScoreItem(
                    'Tanggung Jawab',
                    employee.tanggungJawab,
                    Colors.purple,
                  ),
                  _buildScoreItem('Kualitas', employee.kualitas, Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, String score, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
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
            Text(
              'Nama: ${employee.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('NIP: ${employee.nip}'),
            const SizedBox(height: 16),
            const Text(
              'Nilai Kriteria:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Kedisiplinan', employee.kedisiplinan),
            _buildDetailRow('Kerjasama', employee.kerjasama),
            _buildDetailRow('Kreativitas', employee.kreativitas),
            _buildDetailRow('Tanggung Jawab', employee.tanggungJawab),
            _buildDetailRow('Kualitas', employee.kualitas),
            const Divider(),
            Text(
              'Skor Akhir: ${employee.finalScore}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
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

  Widget _buildDetailRow(String label, String value) {
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
          'berdasarkan 5 kriteria penilaian: Kedisiplinan, Kerjasama, Kreativitas, '
          'Tanggung Jawab, dan Kualitas kerja.',
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
  final String kedisiplinan;
  final String kerjasama;
  final String kreativitas;
  final String tanggungJawab;
  final String kualitas;
  final String finalScore;

  EmployeeRanking({
    required this.rank,
    required this.name,
    required this.nip,
    required this.kedisiplinan,
    required this.kerjasama,
    required this.kreativitas,
    required this.tanggungJawab,
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
