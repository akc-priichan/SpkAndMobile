import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Validasi sederhana - Anda bisa customize sesuai kebutuhan
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan password harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Contoh validasi sederhana (ganti dengan logic autentikasi yang sebenarnya)
    if (username == 'admin' && password == 'admin') {
      // Navigasi ke MainScreen setelah login berhasil
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo atau Title
              Icon(
                Icons.business,
                size: 80,
                color: Colors.blue[800],
              ),
              const SizedBox(height: 24),
              Text(
                'SPK SAW Penilaian Karyawan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Form Login
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'Demo: Username: admin, Password: admin',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
