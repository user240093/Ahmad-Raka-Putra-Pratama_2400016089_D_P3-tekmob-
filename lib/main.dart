import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const ClassroomProScreen(),
    );
  }
}

// --- DATA SOURCE (Setiap item unik) ---
final List<Map<String, dynamic>> classroomData = [
  {
    'title': 'Pengenalan Flutter SDK',
    'desc': 'Instalasi dan konfigurasi environment mobile development.',
    'instr': 'Pastikan Flutter SDK sudah terdaftar di Path. Jalankan "flutter doctor" dan screenshot hasilnya ke dalam PDF.',
    'initial': 'F', 'color': Colors.blue, 'status': 'Selesai'
  },
  {
    'title': 'Struktur Widget Tree',
    'desc': 'Memahami konsep dasar Stateless dan Stateful widget.',
    'instr': 'Buat diagram sederhana yang menjelaskan hierarki widget dari project "Hello World" yang kamu buat.',
    'initial': 'W', 'color': Colors.orange, 'status': 'Ongoing'
  },
  {
    'title': 'Layouting: Row & Column',
    'desc': 'Menyusun elemen secara horizontal dan vertikal.',
    'instr': 'Implementasikan desain login screen sederhana menggunakan kombinasi Row dan Column.',
    'initial': 'L', 'color': Colors.green, 'status': 'Due Tomorrow'
  },
  {
    'title': 'Navigasi & Routing',
    'desc': 'Cara berpindah antar screen di aplikasi Flutter.',
    'instr': 'Gunakan Navigator.push untuk berpindah dari halaman List ke halaman Detail Tugas.',
    'initial': 'N', 'color': Colors.red, 'status': 'Ongoing'
  },
  {
    'title': 'Styling & Decoration',
    'desc': 'Mempercantik UI dengan BoxDecoration dan Shadow.',
    'instr': 'Berikan efek shadow dan border radius pada setiap Card tugas yang telah kamu buat.',
    'initial': 'S', 'color': Colors.purple, 'status': 'Ongoing'
  },
  {
    'title': 'ListView Builder',
    'desc': 'Menampilkan data dinamis dalam jumlah besar.',
    'instr': 'Gunakan ListView.builder untuk menampilkan minimal 10 item dari list data map.',
    'initial': 'V', 'color': Colors.teal, 'status': 'Ongoing'
  },
  {
    'title': 'Input User: TextField',
    'desc': 'Menangkap input teks dari pengguna aplikasi.',
    'instr': 'Tambahkan validasi sederhana pada TextField agar tidak boleh kosong saat tombol diklik.',
    'initial': 'I', 'color': Colors.indigo, 'status': 'Ongoing'
  },
  {
    'title': 'Assets & Images',
    'desc': 'Memasukkan gambar lokal dan network ke aplikasi.',
    'instr': 'Daftarkan folder assets di pubspec.yaml dan tampilkan gambar logo universitas.',
    'initial': 'A', 'color': Colors.amber, 'status': 'Ongoing'
  },
  {
    'title': 'HTTP Request: API',
    'desc': 'Mengambil data dari internet menggunakan package http.',
    'instr': 'Konsumsi API publik (JSONPlaceholder) dan tampilkan datanya ke dalam ListView.',
    'initial': 'H', 'color': Colors.cyan, 'status': 'New'
  },
  {
    'title': 'State Management Dasar',
    'desc': 'Mengelola perubahan data menggunakan setState.',
    'instr': 'Buat aplikasi counter sederhana yang bertambah setiap kali tombol "+" ditekan.',
    'initial': 'M', 'color': Colors.brown, 'status': 'Ongoing'
  },
  {
    'title': 'Firebase Auth',
    'desc': 'Integrasi sistem login menggunakan Google Firebase.',
    'instr': 'Konfigurasikan google_services.json ke dalam folder android/app.',
    'initial': 'B', 'color': Colors.deepPurple, 'status': 'Ongoing'
  },
  {
    'title': 'Final Project UI',
    'desc': 'Merangkum semua materi layout menjadi satu aplikasi utuh.',
    'instr': 'Buat tiruan UI aplikasi populer (seperti Instagram/GoJek) menggunakan Flutter.',
    'initial': 'P', 'color': Colors.pink, 'status': 'Final'
  },
];

class ClassroomProScreen extends StatefulWidget {
  const ClassroomProScreen({super.key});

  @override
  State<ClassroomProScreen> createState() => _ClassroomProScreenState();
}

class _ClassroomProScreenState extends State<ClassroomProScreen> {
  late ScrollController _scrollController;
  double _headerOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        // Logika untuk membuat header semakin transparan saat di-scroll
        double offset = _scrollController.offset;
        setState(() {
          _headerOpacity = (1 - (offset / 150)).clamp(0.0, 1.0);
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              backgroundColor: const Color(0xFF064E3B),
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF064E3B), Color(0xFF059669)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Opacity(
                    opacity: _headerOpacity, // Efek transparan halus
                    child: _buildHeaderContent(),
                  ),
                ),
                title: _headerOpacity < 0.2 
                    ? const Text("Praktikum 3", style: TextStyle(color: Colors.white, fontSize: 18)) 
                    : null,
                centerTitle: false,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () => _showSnackBar(context, "Menu opsi diklik"),
                ),
              ],
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: classroomData.length,
          itemBuilder: (context, index) => _buildTaskCard(context, classroomData[index], index),
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Flutter Classroom", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const Text("Praktikum 3", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTab("Stream", true),
              const SizedBox(width: 8),
              _buildTab("Classwork", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool active) {
    return InkWell(
      onTap: () => _showSnackBar(context, "Berpindah ke $label"),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: active ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Map<String, dynamic> data, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(data: data))),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'tag-$index',
                    child: CircleAvatar(
                      backgroundColor: data['color'],
                      child: Text(data['initial'], style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(data['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis)),
                            Text(data['status'], style: TextStyle(fontSize: 11, color: data['status'] == 'Due Tomorrow' ? Colors.red : Colors.grey)),
                          ],
                        ),
                        Text(data['desc'], style: TextStyle(color: Colors.grey.shade600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  _actionButton(context, Icons.visibility_outlined, "View task", () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(data: data)));
                  }),
                  const Spacer(),
                  _actionButton(context, Icons.chat_bubble_outline, "Comment", () {
                    _showSnackBar(context, "Membuka kolom komentar...");
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.teal),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 1)));
  }
}

// --- HALAMAN DETAIL (Instruksi Berbeda) ---
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas Materi")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(data['status'], style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
            const Divider(height: 40),
            const Text("Deskripsi Materi:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(data['desc'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text("Instruksi Tugas:", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
              child: Text(data['instr'], style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Konfirmasi"),
                      content: const Text("Kumpulkan tugas ini sekarang?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Tugas Berhasil Dikumpulkan!")));
                        }, child: const Text("Ya, Kirim")),
                      ],
                    ),
                  );
                },
                child: const Text("KUMPULKAN TUGAS", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}