import 'dart:async';

import 'package:flowee_app/models/promo_banner.dart';
import 'package:flowee_app/widgets/banner_slide.dart';
import 'package:flowee_app/widgets/carousel_dots.dart';
import 'package:flutter/material.dart';

//carousel banner akan bergerak setiap beberapa detik
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});

  final List<PromoBanner> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

// tetap berjalan tanpa merusak widget yang lain, future dan asynkron itu sepaket

class _BannerCarouselState extends State<BannerCarousel> {
  // Page controller -> mengatur slide mana yang sedang tampil di PageView
  // Banner akan melakukan perubahan ketika waktunya sudah habis
  late final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void initState (){
    super.initState();
    // Timer.periodic akan menjalankan fungsi didalamnya secara berulang

    //Setiap 4 detik, cek apakah widget masih aktif dan ada bannernya. 
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      if (!mounted || widget.banners.isEmpty) return;
      //Jika ya, hitung halaman berikutnya (kalau sudah di akhir, kembali ke awal),
      final next = (_page + 1) % widget.banners.length;
      //Lalu geser banner ke halaman tersebut secara otomatis dengan animasi mulus selama 0,5 detik
      _controller.animateToPage(
        next,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic
      );
    });
  }

  @override
  // timer harus dicencle saat widget tida tampil dilayar, supaya timer tida terus berjalan di latar belakang walau carousel sudah tida muncul dilayar
  // termasuk penyebab memory late di flutter
  void dispose(){
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) 
      return const SizedBox.shrink();

      return Column(
        children: [
          SizedBox(
            height: 168,
            child: PageView.builder(
              controller: _controller,
              // mengambil(memanggil) banyaknya data dari sebuah class
              itemCount: widget.banners.length, // berapa banyak jumlah data yang akan ditampilakn, diambil dari dalam object Product 
              // ketika user melakukan swipe manual
              // supaya titik indokator dibawah selalu sinkron dengan banner yang tampil
              // initState dipanggil otomatis di awal, sedangkan setState kamu panggil sendiri saat ada perubahan.
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (context, index) => BannerSlide(banner: widget.banners[index]),
            )
          ),
          SizedBox(height: 10),
          // penggabungan carousel dots dan banner slide
          CarouselDots(
            count: widget.banners.length,
            activeIndex: _page,
            activeColor: widget.banners[_page].gradientColors.first,
          )
        ],
      );
  
  }
}