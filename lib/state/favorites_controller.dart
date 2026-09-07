import 'package:flutter/material.dart';

class FavoritesController extends ValueNotifier<Set<String>>{
  FavoritesController._() : super(<String>{});

  // ketilka ada perpindahan data dari kelas satu ke kelas yng lain
  static final FavoritesController instance = FavoritesController._();

  bool isFavorite(String id) => value.contains(id); // ngambil value dari id

  void toggle(String id) {
    final updated = Set<String>.from(value); // memastikan flutter membaca perubahan
    if (!updated.remove(id)) { //kalau ada perubahan value maka id yng lama akan diremove
        updated.add(id); // dan digantikan dengan id baru
    } 
    value = updated;
  }
}