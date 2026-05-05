import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _downloadDir = '默认';
  String _defaultSpeed = '1.0x';
  int _sourceCount = 0;
  int _healthyCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final sp = context.read<ServiceProvider>();
    final dir = await sp.db.getSetting('download_dir');
    final speed = await sp.db.getSetting('default_speed');
    final sources = sp.sourceService.sources;
    setState(() {
      _downloadDir = dir ?? '默认';
      _defaultSpeed = speed ?? '1.0x';
      _sourceCount = sources.length;
      _healthyCount = sources.where((s) => s.enabled).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('设置',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 32),
          _SettingsSection(
            title: '播放',
            children: [
              _SettingsTile(
                icon: Icons.speed_rounded,
                title: '默认播放速度',
                subtitle: _defaultSpeed,
                onTap: () => _showSpeedPicker(),
              ),
              _SettingsTile(
                icon: Icons.high_quality_rounded,
                title: '画质偏好',
                subtitle: '自动',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: '下载',
            children: [
              _SettingsTile(
                icon: Icons.folder_rounded,
                title: '下载目录',
                subtitle: _downloadDir,
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.download_rounded,
                title: '同时下载数',
                subtitle: '3',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: '数据源',
            children: [
              _SettingsTile(
                icon: Icons.source_rounded,
                title: '管理数据源',
                subtitle: '$_sourceCount 个源，$_healthyCount 个已启用',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.health_and_safety_rounded,
                title: '源健康检查',
                onTap: () => _runHealthCheck(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingsSection(
            title: '关于',
            children: [
              const _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: '版本',
                subtitle: '1.0.0',
              ),
              _SettingsTile(
                icon: Icons.update_rounded,
                title: '检查更新',
                subtitle: '已是最新版本',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSpeedPicker() {
    final speeds = ['0.5x', '0.75x', '1.0x', '1.25x', '1.5x', '2.0x'];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface2,
        title: const Text('默认播放速度',
            style: TextStyle(color: AppTheme.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: speeds
              .map((s) => RadioListTile<String>(
                    title: Text(s,
                        style:
                            const TextStyle(color: AppTheme.textPrimary)),
                    value: s,
                    groupValue: _defaultSpeed,
                    activeColor: AppTheme.accent,
                    onChanged: (v) {
                      if (v != null) {
                        final sp = context.read<ServiceProvider>();
                        sp.db.setSetting('default_speed', v);
                        setState(() => _defaultSpeed = v);
                        Navigator.of(ctx).pop();
                      }
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  Future<void> _runHealthCheck() async {
    final sp = context.read<ServiceProvider>();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('正在检查数据源健康状态...'),
        backgroundColor: AppTheme.surface3,
      ),
    );
    final results = await sp.sourceService.healthCheckAll();
    final healthy = results.values.where((v) => v).length;
    _loadSettings();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('检查完成: $healthy/${results.length} 个源可用'),
          backgroundColor: healthy > 0 ? AppTheme.success : AppTheme.error,
        ),
      );
    }
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textTertiary,
                letterSpacing: 0.5)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surface2,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  const Divider(height: 1, color: AppTheme.border),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppTheme.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 14, color: AppTheme.textPrimary)),
            ),
            if (subtitle != null)
              Text(subtitle!,
                  style: const TextStyle(
                      fontSize: 13, color: AppTheme.textTertiary)),
            if (onTap != null) ...[
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded,
                  size: 18, color: AppTheme.textTertiary),
            ],
          ],
        ),
      ),
    );
  }
}
