import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/features/wrapper/presentation/widgets/g_bottom_navbar.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodySmall, horizontal: AppSpacing.bodyLarge),
            child: Column(
              children: [
                const Gap(AppSpacing.bodyLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [CircleAvatar(radius: 25, backgroundColor: Colors.grey), Gap(AppSpacing.bodymedium), Text('Username')]),
                    IconButton(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket, color: Colors.black87)),
                  ],
                ),
                const Expanded(child: Text('wrapper screeen')),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const GBottomNavbar(),
      ),
    );
  }
}
