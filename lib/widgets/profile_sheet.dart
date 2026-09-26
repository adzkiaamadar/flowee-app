import 'package:flowee_app/data/dummy_data.dart';
import 'package:flowee_app/screens/login_screen.dart';
import 'package:flowee_app/state/auth_controller.dart';
import 'package:flowee_app/theme/app_theme.dart';
import 'package:flowee_app/widgets/sheet_drag_handle.dart';
import 'package:flutter/material.dart';

// untuk membantu mendorong ketika user activity 
void showProfileSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => _ProfileSheetContent(homeContext: context)
  );
}

class _ProfileSheetContent extends StatelessWidget {
  const _ProfileSheetContent({super.key, required this.homeContext});

  final BuildContext homeContext;

  // untuk logout, salah satu dari asynchoronuous 
  Future<void> _logout(BuildContext sheetContext) async {
    Navigator.of(sheetContext).pop();
    await AuthController.instance.logout();

    // membuat perkondisian
    if (!homeContext.mounted) { // jika homescreen sudah tidak siap..
      Navigator.of(homeContext).pushAndRemoveUntil( // menghapus session yang lama
        MaterialPageRoute(builder: (_) => LoginScreen()), // arahkan navigasi ke login screen
        /**
         * Predicate ini bilang: "hapus SEMUA halaman sebelumnya dari riwayat navigasi"
         * berfungsi untuk menghapus semua session sebelumnya ketika user logout
         * jadi setelah logout, tombol back tidak akan mengembalikan pengguna ke halaman home
         */
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetDragHandle(),
          SizedBox(height: 24),
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark]),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded, color: Colors.white, size: 34)
          ),
          SizedBox(height: 14),
          Text(
            
            DummyUser.name,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary
            ),
          ),
          SizedBox(height: 4),
          Text(
            DummyUser.email,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 26),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _logout(context),
              icon: Icon(Icons.login_rounded, size: 18),
              label: Text('Keluar'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryDark,
                side: BorderSide(color: AppTheme.primary),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16))
              ),
            ),
          )
        ],
      ),
    );
  }
}