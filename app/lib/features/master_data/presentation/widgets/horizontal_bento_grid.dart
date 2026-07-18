import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HorizontalBentoGrid extends StatefulWidget {
  final String title;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? onAdd;

  const HorizontalBentoGrid({
    super.key,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
    this.onAdd,
  });

  @override
  State<HorizontalBentoGrid> createState() => _HorizontalBentoGridState();
}

class _HorizontalBentoGridState extends State<HorizontalBentoGrid> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (_scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _scrollProgress = _scrollController.offset / _scrollController.position.maxScrollExtent;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateProgress);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: AppTypography.h2),
              if (widget.onAdd != null)
                IconButton(
                  onPressed: widget.onAdd,
                  icon: const Icon(Icons.add_circle, color: AppColors.primary),
                )
            ],
          ),
        ),
        const SizedBox(height: AppRadius.md),
        SizedBox(
          height: 180, // Fixed height for Bento Card
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: widget.itemCount,
            separatorBuilder: (context, index) => const SizedBox(width: AppRadius.md),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 280, // Lebar fixed untuk Bento Card
                child: widget.itemBuilder(context, index),
              );
            },
          ),
        ),
        if (widget.itemCount > 0) ...[
          const SizedBox(height: AppRadius.md),
          Center(
            child: Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.2 + (_scrollProgress * 0.8).clamp(0.0, 0.8), // Minimal 20% width
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}

// Widget untuk Skeleton Loader
class BentoSkeleton extends StatelessWidget {
  const BentoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppRadius.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 80,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
        ],
      ),
    );
  }
}
