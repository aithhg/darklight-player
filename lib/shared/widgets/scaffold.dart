import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../core/constants.dart';
import 'title_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface0,
      body: Column(
        children: [
          const AppTitleBar(),
          Expanded(
            child: Row(
              children: [
                const _Sidebar(),
                Expanded(
                  child: Container(
                    color: AppTheme.surface0,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final currentPath =
        GoRouterState.of(context).uri.path;

    return Container(
      width: AppConstants.sidebarWidth,
      decoration: const BoxDecoration(
        color: AppTheme.surface1,
        border: Border(
          right: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.home_rounded,
            label: '首页',
            path: '/',
            isActive: currentPath == '/',
            onTap: () => context.go('/'),
          ),
          _SidebarItem(
            icon: Icons.search_rounded,
            label: '搜索',
            path: '/search',
            isActive: currentPath == '/search',
            onTap: () => context.go('/search'),
          ),
          _SidebarItem(
            icon: Icons.forest_rounded,
            label: 'Forest',
            path: '/forest',
            isActive: currentPath == '/forest',
            activeColor: const Color(0xFF22C55E),
            onTap: () => context.go('/forest'),
          ),
          const SizedBox(height: 16),
          const _SidebarDivider(),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.favorite_rounded,
            label: '收藏',
            path: '/favorites',
            isActive: currentPath == '/favorites',
            onTap: () => context.go('/favorites'),
          ),
          _SidebarItem(
            icon: Icons.history_rounded,
            label: '历史',
            path: '/history',
            isActive: currentPath == '/history',
            onTap: () => context.go('/history'),
          ),
          _SidebarItem(
            icon: Icons.download_rounded,
            label: '下载',
            path: '/downloads',
            isActive: currentPath == '/downloads',
            onTap: () => context.go('/downloads'),
          ),
          const Spacer(),
          const _SidebarDivider(),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: Icons.settings_rounded,
            label: '设置',
            path: '/settings',
            isActive: currentPath == '/settings',
            onTap: () => context.go('/settings'),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;
  final bool isActive;
  final Color? activeColor;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.path,
    required this.isActive,
    this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = activeColor ?? AppTheme.accent;
    final accentBg = isActive
        ? accent.withValues(alpha: 0.12)
        : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: accentBg,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: AppTheme.surface3.withValues(alpha: 0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive ? accent : AppTheme.textSecondary,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive ? accent : AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarDivider extends StatelessWidget {
  const _SidebarDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 1,
        color: AppTheme.border,
      ),
    );
  }
}
