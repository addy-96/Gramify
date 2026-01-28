import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/routes/go_routes.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/gsnack.dart';
import 'package:gramify/features/auth/presentation/widgets/screen_switch_text_btn.dart';
import 'package:gramify/features/auth/presentation/widgets/terms_and_condition.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var _hasAgreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.bodyxLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
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
                const Gap(10),
                Text('Connect, Share,\nDsicover', style: AppTextStyles.titleMedium().copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                AppFilledButton(
                  text: 'Sign Up Free',
                  onTap: () {
                    if (_hasAgreedToTerms) {
                      context.pushNamed(GoRoutes.registerRoute);
                    } else {
                      gSnack(context, "Please agree to terms!");
                    }
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        setState(() => _hasAgreedToTerms = !_hasAgreedToTerms);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.grey.shade500),
                          color: _hasAgreedToTerms ? Appcolors.brandGreen : null,
                        ),
                        child:
                            _hasAgreedToTerms ? const Center(child: FaIcon(FontAwesomeIcons.check, color: Appcolors.white, size: 20)) : const SizedBox.shrink(),
                      ),
                    ),
                    const Gap(10),
                    termsAndCondition("I agree to the "),
                  ],
                ),
              ],
            ),
            screenSwitchTextBtn("Already have Account?", "Log in", () => context.goNamed(GoRoutes.loginRoute)),
          ],
        ),
      ),
    );
  }
}
