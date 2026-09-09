import 'package:flowee_app/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({super.key, required this.categries, required this.selectedCategory, required this.onSelected});

  final List<String> categries;
  final String selectedCategory; // menentukan kategori mana yang dipilih
  final ValueChanged<String> onSelected; // kalau kategorinya terpilih..

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(  // pakai ini kalau isi(action) listnya beda beda
        itemCount: categries.length,
        separatorBuilder: (_, _) => SizedBox(width: 8),
        itemBuilder: (contex, index) {
          final category = categries [index];
          final isSelected = category == selectedCategory; // apakah dia terpilih, cek sama atau tida
          return ChoiceChip(
            label: Text(category), 
            selected: isSelected,
            onSelected: (_) => onSelected(category), // kalau chipnya terpilih, onSelected akan terpanggil
            // TODO - Defining on selected action
            selectedColor: AppTheme.primary,
            showCheckmark: false,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13
            ),
            backgroundColor: isSelected ? AppTheme.primary : AppTheme.primarySoft.withValues(alpha: 0.5),
            side: BorderSide.none,
            elevation: 0,
            pressElevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
            
          );
        }, 
      ),
    );
  }
}