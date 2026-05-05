import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../../core/theme.dart';
import '../../core/constants.dart';

class AppTitleBar extends StatelessWidget {
  const AppTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) => windowManager.startDragging(),
      child: Container(
        height: AppConstants.titleBarHeight,
        decoration: const BoxDecoration(
          color: AppTheme.surface1,
          border: Border(
            bottom: BorderSide(color: AppTheme.border, width: 1),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            // App icon/logo area
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppTheme.accent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            // Window controls
            _WindowButton(
              icon: Icons.minimize_rounded,
              onPressed: () => windowManager.minimize(),
            ),
            _WindowButton(
              icon: Icons.crop_square_rounded,
              onPressed: () async {
                final isMaximized = await windowManager.isMaximized();
                if (isMaximized) {
                  await windowManager.unmaximize();
                } else {
                  await windowManager.maximize();
                }
              },
            ),
            _WindowButton(
              icon: Icons.close_rounded,
              isClose: true,
              onPressed: () => windowManager.close(),
            ),
          ],
        ),
      ),
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isClose;

  const _WindowButton({
    required this.icon,
    required this.onPressed,
    this.isClose = false,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 46,
          height: AppConstants.titleBarHeight,
          color: _hovering
              ? (widget.isClose
                  ? AppTheme.error
                  : AppTheme.surface3)
              : Colors.transparent,
          child: Icon(
            widget.icon,
            size: 16,
            color: _hovering
                ? (widget.isClose ? Colors.white : AppTheme.textPrimary)
                : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
