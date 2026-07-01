/// Banner que se muestra cuando no hay conexión a internet.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/network/network_info.dart';
import '../../core/services/injection_container.dart';

class OfflineBanner extends ConsumerStatefulWidget {
  const OfflineBanner({super.key});

  @override
  ConsumerState<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends ConsumerState<OfflineBanner> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    sl<NetworkInfo>().connectivityStream.listen((isConnected) {
      if (mounted) {
        setState(() => _isOffline = !isConnected);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOffline) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.warning.withOpacity(0.9),
      child: const Row(
        children: [
          Icon(Icons.cloud_off, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Sin conexión — los datos se guardan localmente',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
