import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:absen_kantor/repository/karyawan.dart';
import 'package:absen_kantor/repository/penilaian.dart';

class Penilaian_karyawan extends StatefulWidget {
  const Penilaian_karyawan({super.key});

  @override
  Rank_karyawan createState() => Rank_karyawan();
}

class Rank_karyawan extends State<Penilaian_karyawan> {
  final _formKey = GlobalKey<FormState>();
  int idKaryawan = 0;
  double _kedisiplinan = 0;
  double _kerjasama = 0;
  double _kreativitas = 0;
  double _tanggungJawab = 0;
  double _kualitasKerja = 0;

  // final List<Map<String, dynamic>> _penilaianList = [];
  List<Map<String, dynamic>> karyawan = [];

  void _submitPenilaian() {
    if (_formKey.currentState!.validate()) {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      var req = {
        'karyawan_id': idKaryawan,
        'kedisiplinan': _kedisiplinan.round(),
        'kerjasama': _kerjasama.round(),
        'kreativitas': _kreativitas.round(),
        'tanggung_jawab': _tanggungJawab.round(),
        'kualitas_kerja': _kualitasKerja.round(),
        'tanggal_penilaian': formattedDate,
      };
      print(req);
      setState(() {
        _isLoading = true;
      });
      PenilaianRepo.store(req).then((res) {
        if (res != false) {
          PenilaianRepo.hitung();
          setState(() {
            if (mounted) {
              // Reset form
              _formKey.currentState!.reset();
              _kedisiplinan = 0;
              _kerjasama = 0;
              _kreativitas = 0;
              _tanggungJawab = 0;
              _kualitasKerja = 0;
              idKaryawan = 0;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Penilaian berhasil disimpan!')),
              );
            }
          });
        } else {
          setState(() {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal menyimpan penilaian')),
              );
            }
          });
        }
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoading = false;

  Future getKaryawan() async {
    setState(() {
      _isLoading = true;
    });
    var res = await KaryawanRepo.index();

    if (res != false) {
      return res;
    }
  }

  @override
  void initState() {
    super.initState();
    getKaryawan().then((data) {
      if (data != null) {
        setState(() {
          karyawan = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nama Karyawan',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        items: [
                          for (var item in karyawan)
                            DropdownMenuItem(
                              value: item['id'],
                              child: Text(item['nama']),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              idKaryawan = value as int;
                            });
                          }
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
                onPressed: _isLoading ? null : _submitPenilaian,
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
          divisions: 10,
          onChanged: onChanged,
          activeColor: Colors.blue[600],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
