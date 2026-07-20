import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class OwnerBranchContextScreen extends StatefulWidget {
  final String branchId;
  const OwnerBranchContextScreen({super.key, required this.branchId});

  @override
  State<OwnerBranchContextScreen> createState() => _OwnerBranchContextScreenState();
}

class _OwnerBranchContextScreenState extends State<OwnerBranchContextScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate setting acting_branch_id in state provider
    // ref.read(actingBranchProvider.notifier).state = widget.branchId;
    
    // Redirect to boss home
    Future.microtask(() {
      if (mounted) {
        // In real app, this changes role dynamically or redirects to boss shell
        context.go('/boss/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
