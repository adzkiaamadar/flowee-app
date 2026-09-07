import 'package:flowee_app/models/flower.dart';
import 'package:flowee_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProductSummary extends StatelessWidget {
  const ProductSummary({super.key, required this.flower});

  final Flower flower;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CategoryBadge(text: flower.category),
              SizedBox(height: 10),
              Text(
                flower.name,
                style: AppTheme.display(fontSize: 24)
              )
            ],
          ),
        ),
        _RatingBadge(rating: flower.rating)
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.leaf.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.leaf,
          fontSize: 11,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row( // bikin ukuran seminimal mungkin, ngikutin parentnya
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 18, color: Colors.amber),
          SizedBox(width: 3),
          Text(
            rating.toString(),
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}