import 'package:flutter/material.dart';

class FlowerNetworkImage extends StatelessWidget {
  // menampilkan gambar dari url internet
  // sedang dimuat = menampilkan indikator loading
  // gagal dimuat = menampilkan icon
  const FlowerNetworkImage({super.key, required this.imageUrl, required this.fallbackIcon, required this.fallbackColor, required this.fit});

  final String imageUrl;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      // loading indikator yang akan dijalankan terus menerus selama image dalam proses download dari internet
      loadingBuilder: (contex, child, progress) {
        if (progress == null) return child; 
          return _Placeholder( // private (muncul hanya saat kondisi tertentu)
            color: fallbackColor,
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.2, // ukuran
                color: fallbackColor,
                // loading muncul berdasarkan progress dari rendering image
                // mengecek apakah gambar yang diambil punya nilai
                // kalau flutter tahu ukuran total file, maka akan menghitung proses download gambar
                // kalau flutter tida tahu ukuran total file, maka akan mengembalikan null
                value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes! : null,
              ),
            ),
          ); 
        },
        // errorBuilder, yang akan dipanggil kalau proses DI ATAS gagal
        errorBuilder: (context, error, StackTrace) {
          return _Placeholder(
            color: fallbackColor,
            child: Icon(fallbackIcon, size: 48, color: fallbackColor,),
          );
        },
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.18),
      alignment: Alignment.center,
      child: child,
    );
  }
}