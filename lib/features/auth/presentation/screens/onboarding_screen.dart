import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.bodyxLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Column(
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Opacity(
                      opacity: 0.9,
                      child: Image.asset(
                        height: Utils.getScreenHeight(context) / 4,
                        width: Utils.getScreenWidth(context) / 1.7,
                        'assets/images/onboarding.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Gap(30),
                Text('Connect,Share,\nDsicover', style: AppTextStyles.titleMedium().copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const Gap(20),
                AppFilledButton(text: 'Sign Up Free', onTap: () {}),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {},
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 2, color: Colors.grey.shade500)),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade500),
                          children: [
                            const TextSpan(text: "I agree to the "),
                            TextSpan(
                              text: "Terms ",
                              style: AppTextStyles.bodyLarge().copyWith(color: Appcolors.brandGreen),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(text: "& ", style: AppTextStyles.bodyLarge()),
                            TextSpan(
                              text: "Privacy Policy",
                              style: AppTextStyles.bodyLarge().copyWith(color: Appcolors.brandGreen),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(color: Colors.grey.shade500.withValues(alpha: 0.1), thickness: 2, radius: BorderRadius.circular(10)),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodyLarge().copyWith(color: Colors.grey.shade500),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Log In",
                        style: AppTextStyles.bodyLarge().copyWith(color: Appcolors.brandGreen),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const Gap(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
