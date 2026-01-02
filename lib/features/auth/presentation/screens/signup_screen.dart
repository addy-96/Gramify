import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/features/auth/presentation/widgets/sso_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyxSmall, horizontal: AppSpacing.bodyxLarge),
          child: SingleChildScrollView(
            child: Column(
              spacing: AppSpacing.componentxMedium,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(AppSpacing.componentLarge),
                Text('Create Your account', style: AppTextStyles.titleMedium().copyWith(fontWeight: FontWeight.bold)),
                const AppTextField(hintText: 'Username'),
                const AppTextField(hintText: 'Email Address'),
                const AppTextField(hintText: 'Phone'),
                const AppTextField(hintText: 'Password', suffixIcon: FontAwesomeIcons.eye),
                const Gap(AppSpacing.bodySmall),
                const Center(child: AppFilledButton()),
                Center(child: Text('OR', style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
                Row(children: [kSsoButton(icon: FontAwesomeIcons.google), const Gap(AppSpacing.bodyLarge), kSsoButton(icon: FontAwesomeIcons.facebook)]),
                Text('By logging in, you agree to our Terms & Privacy.', style: AppTextStyles.caption().copyWith(fontWeight: FontWeight.w100, fontSize: 9)),
                const Gap(AppSpacing.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

                 

  // Widget _authOption(String text, {bool showDivider = false}) => Expanded(
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(text, style: AppTextStyles.bodyLarge().copyWith(fontWeight: FontWeight.bold)),
  //       showDivider ? Divider(color: Colors.black, indent: 5, thickness: 3, radius: BorderRadius.circular(100)) : const SizedBox.shrink(),
  //     ],
  //   ),
  // );

                // Padding(
                //   padding: const EdgeInsets.only(top: AppSpacing.bodyxxLarge),
                //   child: Row(
                //     spacing: AppSpacing.bodyxxLarge,
                //     children: [
                //       Expanded(
                //         child: BackdropFilter(
                //           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                //           blendMode: BlendMode.srcIn,
                //           child: Container(
                //             decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                //             height: Utils.getScreenHeight(context) / 14,
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //               child: Row(children: [_authOption('Sign Up'), _authOption('Login')]),
                //             ),
                //           ),
                //         ),
                //       ),
                //       const FaIcon(FontAwesomeIcons.magnifyingGlass),
                //       const FaIcon(FontAwesomeIcons.info),
                //       const FaIcon(FontAwesomeIcons.bell),
                //     ],
                //   ),
                // ),