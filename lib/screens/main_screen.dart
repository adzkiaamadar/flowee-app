// metode untuk menampung 2/lebih screen pada aplikasi agar dapat bernavigasi melalui index
// Shell adalah bingkai luar yang tidak pernah berubah atau berpindah tempat, yang berisi menu Bottom Navigation Bar di bagian bawah

// mengapa semua screen harus dimasukkan ke dalam satu Array/List adalah agar aplikasi bisa 
// mencocokkan angka indeks navigasi dengan layar yang ingin ditampilkan secara instan.

import 'package:flowee_app/screens/favorite_screen.dart';
import 'package:flowee_app/screens/home_screen.dart';
import 'package:flowee_app/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; 
  static const _screens = [HomeScreen(), FavoriteScreen()]; // menentukan index per page

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      // extendbody: true akan membuat 'body' bisa ter scroll sampai ke navbar bawah yang melayang, akan berhenti tepat di atasnya
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 24,
                offset: Offset(0, 10)
              ),
            ]
          ),
          child: Row(
            children: [
              Expanded(
                child: BottomNavItem(
                  icon: Icons.home_rounded, 
                  label: 'Home', 
                  selected: _selectedIndex == 0, 
                  onTap: () => setState(() => _selectedIndex = 0),
                )
              ),
              Expanded(
                child: BottomNavItem(
                  icon: Icons.favorite_rounded, 
                  label: 'Favorite', 
                  selected: _selectedIndex == 1, 
                  onTap: () => setState(() => _selectedIndex = 1),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}