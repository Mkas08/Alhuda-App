import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/config/routes/route_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: <Widget>[
          _buildSettingsGroup(
            'Account',
            <Widget>[
              _buildSettingsTile(
                icon: Icons.person_outline_rounded,
                title: 'Profile',
                onTap: () {
                  // TODO: Implement profile settings
                },
              ),
              _buildSettingsTile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                onTap: () {
                  // TODO: Implement notification settings
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSettingsGroup(
            'App Settings',
            <Widget>[
              _buildSettingsTile(
                icon: Icons.palette_outlined,
                title: 'Theme & Appearance',
                onTap: () {
                  // TODO: Implement theme settings
                },
              ),
              _buildSettingsTile(
                icon: Icons.language_rounded,
                title: 'Language',
                onTap: () {
                  // TODO: Implement language settings
                },
              ),
              _buildSettingsTile(
                icon: Icons.track_changes_rounded,
                title: 'Update Daily Goal',
                onTap: () => context.push(RouteConstants.goalSetup),
              ),
              _buildSettingsTile(
                icon: Icons.block_flipped,
                title: 'App Blocking',
                onTap: () => context.push(RouteConstants.blocking),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSettingsGroup(
            'Prayer & Duas',
            <Widget>[
              _buildSettingsTile(
                icon: Icons.access_time_rounded,
                title: 'Prayer Times',
                onTap: () => context.push(RouteConstants.prayerTimes),
              ),
              _buildSettingsTile(
                icon: Icons.auto_stories_rounded,
                title: 'Dua Library',
                onTap: () => context.push(RouteConstants.duaLibrary),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSettingsGroup(
            'About',
            <Widget>[
              _buildSettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About Al-Huda',
                onTap: () {
                  // TODO: Implement about screen
                },
              ),
              _buildSettingsTile(
                icon: Icons.star_outline_rounded,
                title: 'Rate App',
                onTap: () {
                  // TODO: Implement rating logic
                },
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.h3.copyWith(color: AppColors.emeraldPrimary),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Implement logout logic
        context.go(RouteConstants.login);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.error.withAlpha(128)),
        ),
        child: Center(
          child: Text(
            'Logout',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
