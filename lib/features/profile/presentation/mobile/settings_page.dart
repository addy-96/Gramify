import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/mobile/login_page_mobile.dart';
import 'package:gramify/features/profile/presentation/widgets/settings_option.dart';
import 'package:ionicons/ionicons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: Text(
          'Settings',
          style: txtStyle(
            title24,
            Colors.white,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                SettingsOption(
                  settingsTitle: 'Edit Profile',
                  settingIcon: Ionicons.person_outline,
                  subTitleText: 'Edit bio, other personal details.',
                ),
                SettingsOption(
                  settingsTitle: 'Audience',
                  settingIcon: Ionicons.people_outline,
                  subTitleText: 'Privacy, edit who can see your post.',
                ),
                SettingsOption(
                  settingsTitle: 'App Settings',
                  settingIcon: Ionicons.phone_portrait_outline,
                  subTitleText: 'Theme, App aperance etc.',
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.white12)),
            ),
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOutRequested());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPageMobile(),
                  ),
                );
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Log Out',
                        style: txtStyle(
                          subTitle18,
                          Colors.white,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(20),
                      const Icon(Ionicons.log_out_outline, size: title24),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
