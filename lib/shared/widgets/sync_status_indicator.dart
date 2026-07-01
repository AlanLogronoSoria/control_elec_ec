/// Indicador visual del estado de sincronización offline.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../providers/app_providers.dart';

class SyncStatusIndicator extends ConsumerWidget {
  const SyncStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingCountAsync = ref.watch(pendingSyncCountProvider);

    return pendingCountAsync.when(
      data: (count) {
        if (count == 0) {
          return const _SyncBadge(
            icon: Icons.cloud_done_outlined,
            color: AppColors.success,
            tooltip: 'Sincronizado',
          );
        }

        return _SyncBadge(
          icon: Icons.cloud_upload_outlined,
          color: AppColors.warning,
          count: count,
          tooltip: '$count operaciones pendientes',
          isAnimating: true,
        );
      },
      loading: () => const _SyncBadge(
        icon: Icons.sync,
        color: AppColors.textHint,
        isAnimating: true,
      ),
      error: (_, __) => const _SyncBadge(
        icon: Icons.cloud_off_outlined,
        color: AppColors.danger,
        tooltip: 'Error de sincronización',
      ),
    );
  }
}

class _SyncBadge extends StatefulWidget {
  const _SyncBadge({
    required this.icon,
    required this.color,
    this.count,
    this.tooltip,
    this.isAnimating = false,
  });

  final IconData icon;
  final Color color;
  final int? count;
  final String? tooltip;
  final bool isAnimating;

  @override
  State<_SyncBadge> createState() => _SyncBadgeState();
}

class _SyncBadgeState extends State<_SyncBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _SyncBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !oldWidget.isAnimating) {
      _controller.repeat();
    } else if (!widget.isAnimating && oldWidget.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = widget.icon == Icons.sync
        ? RotationTransition(
            turns: _controller,
            child: Icon(widget.icon, color: widget.color, size: 24),
          )
        : Icon(widget.icon, color: widget.color, size: 24);

    final badge = Container(
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          iconWidget,
          if (widget.count != null && widget.count! > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${widget.count}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(
        message: widget.tooltip,
        child: badge,
      );
    }

    return badge;
  }
}
