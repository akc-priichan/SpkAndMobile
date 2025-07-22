import 'package:flutter/material.dart';

class Kriteria_karyawan extends StatefulWidget {
  @override
  _Kriteria_karyawanState createState() => _Kriteria_karyawanState();
}

class _Kriteria_karyawanState extends State<Kriteria_karyawan> {
  List<Map<String, dynamic>> kriteria = [
    {
      'id': 1,
      'nama': 'Kehadiran',
      'bobot': 0.25,
      'jenis': 'Benefit',
      'deskripsi': 'Tingkat kehadiran karyawan'
    },
    {
      'id': 2,
      'nama': 'Kualitas Kerja',
      'bobot': 0.30,
      'jenis': 'Benefit',
      'deskripsi': 'Kualitas hasil kerja'
    },
    {
      'id': 3,
      'nama': 'Produktivitas',
      'bobot': 0.20,
      'jenis': 'Benefit',
      'deskripsi': 'Tingkat produktivitas kerja'
    },
    {
      'id': 4,
      'nama': 'Kerjasama Tim',
      'bobot': 0.15,
      'jenis': 'Benefit',
      'deskripsi': 'Kemampuan bekerjasama dalam tim'
    },
    {
      'id': 5,
      'nama': 'Inisiatif',
      'bobot': 0.10,
      'jenis': 'Benefit',
      'deskripsi': 'Kemampuan berinisiatif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kriteria Penilaian',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showAddDialog(),
                    icon: Icon(Icons.add),
                    label: Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber[700]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Total bobot harus sama dengan 1.0 (100%)',
                        style: TextStyle(color: Colors.amber[700]),
                      ),
                    ),
                    Text(
                      'Total: ${_getTotalBobot().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            _getTotalBobot() == 1.0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: kriteria.length,
            itemBuilder: (context, index) {
              final item = kriteria[index];
              return Card(
                margin: EdgeInsets.only(bottom: 8),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    item['nama'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                          'Bobot: ${(item['bobot'] * 100).toStringAsFixed(0)}%'),
                      Text('Jenis: ${item['jenis']}'),
                      Text('Deskripsi: ${item['deskripsi']}'),
                    ],
                  ),
                  isThreeLine: true,
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'C${item['id']}',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 16),
                            SizedBox(width: 8),
                            Text('Lihat'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Hapus', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'view') {
                        _showViewDialog(item);
                      } else if (value == 'edit') {
                        _showEditDialog(item);
                      } else if (value == 'delete') {
                        _showDeleteDialog(item);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  double _getTotalBobot() {
    return kriteria.fold(0.0, (sum, item) => sum + item['bobot']);
  }

  void _showAddDialog() {
    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> newKriteria = {
      'id': kriteria.isEmpty ? 1 : kriteria.last['id'] + 1,
      'nama': '',
      'bobot': 0.0,
      'jenis': 'Benefit',
      'deskripsi': '',
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Kriteria'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nama Kriteria'),
                    validator: (value) => value!.isEmpty ? 'Harus diisi' : null,
                    onSaved: (value) => newKriteria['nama'] = value!,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Bobot'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return 'Harus diisi';
                      final val = double.tryParse(value);
                      if (val == null) return 'Harus angka';
                      if (val <= 0 || val > 1) return 'Harus antara 0-1';
                      return null;
                    },
                    onSaved: (value) =>
                        newKriteria['bobot'] = double.parse(value!),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: 'Benefit',
                    items: ['Benefit', 'Cost']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    decoration: InputDecoration(labelText: 'Jenis Kriteria'),
                    onChanged: (value) => newKriteria['jenis'] = value!,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Harus diisi' : null,
                    onSaved: (value) => newKriteria['deskripsi'] = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  setState(() {
                    kriteria.add(newKriteria);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showViewDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Kriteria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: C${item['id']}'),
              SizedBox(height: 8),
              Text('Nama: ${item['nama']}'),
              SizedBox(height: 8),
              Text('Bobot: ${(item['bobot'] * 100).toStringAsFixed(0)}%'),
              SizedBox(height: 8),
              Text('Jenis: ${item['jenis']}'),
              SizedBox(height: 8),
              Text('Deskripsi: ${item['deskripsi']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Map<String, dynamic> item) {
    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> editedKriteria = Map.from(item);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Kriteria'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: item['nama'],
                    decoration: InputDecoration(labelText: 'Nama Kriteria'),
                    validator: (value) => value!.isEmpty ? 'Harus diisi' : null,
                    onSaved: (value) => editedKriteria['nama'] = value!,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    initialValue: item['bobot'].toString(),
                    decoration: InputDecoration(labelText: 'Bobot'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return 'Harus diisi';
                      final val = double.tryParse(value);
                      if (val == null) return 'Harus angka';
                      if (val <= 0 || val > 1) return 'Harus antara 0-1';
                      return null;
                    },
                    onSaved: (value) =>
                        editedKriteria['bobot'] = double.parse(value!),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: item['jenis'],
                    items: ['Benefit', 'Cost']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    decoration: InputDecoration(labelText: 'Jenis Kriteria'),
                    onChanged: (value) => editedKriteria['jenis'] = value!,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    initialValue: item['deskripsi'],
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Harus diisi' : null,
                    onSaved: (value) => editedKriteria['deskripsi'] = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  setState(() {
                    int index =
                        kriteria.indexWhere((k) => k['id'] == item['id']);
                    if (index != -1) {
                      kriteria[index] = editedKriteria;
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Kriteria'),
          content: Text('Yakin ingin menghapus kriteria ${item['nama']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  kriteria.removeWhere((k) => k['id'] == item['id']);
                });
                Navigator.pop(context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
