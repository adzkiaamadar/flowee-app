import 'package:flowee_app/models/promo_banner.dart';
import 'package:flutter/material.dart';

class BannerSlide extends StatelessWidget {
  const BannerSlide({super.key, required this.banner});

  final PromoBanner banner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(22),
        child: Stack(
          //fit punya class stack
          fit: StackFit.expand,
          children: [
            //banner dipanggil dalam class PromoBanner yang isinya models promo_banner.dart -> tempat image URL
            Image.network(
              banner.imageUrl, 
              fit: BoxFit.cover,
              // untuk mendefinisikan warna gradient ketika imagenya tidak berhasil di load
              errorBuilder: (context, error, StackTrace) => Container(color: banner.gradientColors.first),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: banner.gradientColors.first,
                );
              },
            ),
            // image network yang akan dikombinasikan dengan stack dan gradiasi, dengan sentuhan transparansi
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    banner.gradientColors.first.withValues(alpha: 0.92),
                    banner.gradientColors.last.withValues(alpha: 0.35)
                  ]
                )
              )
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(22, 20, 90, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    banner.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1.1
                    ),
                  ),
                  Text(
                    banner.subtitle,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.3
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}