import 'package:flutter/material.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  _KaryawanPageState createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  List<Map<String, dynamic>> karyawan = [
    {
      'id': 1,
      'nama': 'Ahmad Fauzi',
      'jabatan': 'Manager',
      'departemen': 'IT',
      'email': 'ahmad@company.com'
    },
    {
      'id': 2,
      'nama': 'Siti Aminah',
      'jabatan': 'Staff',
      'departemen': 'HR',
      'email': 'siti@company.com'
    },
    {
      'id': 3,
      'nama': 'Budi Santoso',
      'jabatan': 'Supervisor',
      'departemen': 'Finance',
      'email': 'budi@company.com'
    },
    {
      'id': 4,
      'nama': 'Diana Sari',
      'jabatan': 'Staff',
      'departemen': 'Marketing',
      'email': 'diana@company.com'
    },
    {
      'id': 5,
      'nama': 'Eko Prasetyo',
      'jabatan': 'Staff',
      'departemen': 'IT',
      'email': 'eko@company.com'
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredKaryawan = [];

  @override
  void initState() {
    super.initState();
    _filteredKaryawan = karyawan;
    _searchController.addListener(_filterKaryawan);
  }

  void _filterKaryawan() {
    setState(() {
      _filteredKaryawan = karyawan.where((employee) {
        return employee['nama']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Data Karyawan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showAddDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari karyawan...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filteredKaryawan.length,
            itemBuilder: (context, index) {
              final employee = _filteredKaryawan[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      employee['nama'][0],
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    employee['nama'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Jabatan: ${employee['jabatan']}'),
                      Text('Departemen: ${employee['departemen']}'),
                      Text('Email: ${employee['email']}'),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 16),
                            SizedBox(width: 8),
                            Text('Lihat'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
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
                        _showViewDialog(employee);
                      } else if (value == 'edit') {
                        _showEditDialog(employee);
                      } else if (value == 'delete') {
                        _showDeleteDialog(employee);
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

  void _showAddDialog() {
    final namaController = TextEditingController();
    final jabatanController = TextEditingController();
    final departemenController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Karyawan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jabatanController,
                decoration: const InputDecoration(
                  labelText: 'Jabatan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: departemenController,
                decoration: const InputDecoration(
                  labelText: 'Departemen',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (namaController.text.isNotEmpty &&
                  jabatanController.text.isNotEmpty &&
                  departemenController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {
                setState(() {
                  karyawan.add({
                    'id': karyawan.length + 1,
                    'nama': namaController.text,
                    'jabatan': jabatanController.text,
                    'departemen': departemenController.text,
                    'email': emailController.text,
                  });
                  _filteredKaryawan = karyawan;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Karyawan berhasil ditambahkan')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showViewDialog(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Karyawan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', employee['id'].toString()),
            _buildDetailRow('Nama', employee['nama']),
            _buildDetailRow('Jabatan', employee['jabatan']),
            _buildDetailRow('Departemen', employee['departemen']),
            _buildDetailRow('Email', employee['email']),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> employee) {
    final namaController = TextEditingController(text: employee['nama']);
    final jabatanController = TextEditingController(text: employee['jabatan']);
    final departemenController =
        TextEditingController(text: employee['departemen']);
    final emailController = TextEditingController(text: employee['email']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Karyawan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jabatanController,
                decoration: const InputDecoration(
                  labelText: 'Jabatan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: departemenController,
                decoration: const InputDecoration(
                  labelText: 'Departemen',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index =
                    karyawan.indexWhere((k) => k['id'] == employee['id']);
                if (index != -1) {
                  karyawan[index] = {
                    'id': employee['id'],
                    'nama': namaController.text,
                    'jabatan': jabatanController.text,
                    'departemen': departemenController.text,
                    'email': emailController.text,
                  };
                  _filteredKaryawan = karyawan;
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Karyawan berhasil diperbarui')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Map<String, dynamic> employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Karyawan'),
        content: Text('Apakah Anda yakin ingin menghapus ${employee['nama']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                karyawan.removeWhere((item) => item['id'] == employee['id']);
                _filteredKaryawan = karyawan;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Karyawan berhasil dihapus')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
