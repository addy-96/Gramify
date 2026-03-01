import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/core/routes/go_routes.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/features/auth/presentation/bloc/auth_events.dart';
import 'package:gramify/features/wrapper/presentation/widgets/post.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodySmall, horizontal: AppSpacing.bodyxSmall),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: Utils.getScreenHeight(context) / 3.8,
              pinned: false,
              floating: false,
              automaticallyImplyLeading: false,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final maxHeight = Utils.getScreenHeight(context) / 3.8;
                  final currentHeight = constraints.maxHeight;

                  final progress = ((currentHeight - kToolbarHeight) / (maxHeight - kToolbarHeight)).clamp(0.0, 1.0);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.bodyLarge, vertical: AppSpacing.bodySmall),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                          child: Opacity(
                            opacity: progress,
                            child: Transform.translate(offset: Offset(0, 40 * (1 - progress)), child: _buildHighLights(context)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: 25, backgroundColor: Colors.grey.shade400),
                                  const Gap(AppSpacing.bodymedium),
                                  Text('Username', style: AppTextStyles.bodyLarge().copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(LogOutEvent());
                                  context.goNamed(GoRoutes.loginRoute);
                                },
                                icon: const FaIcon(FontAwesomeIcons.message, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return const Post();
              }, childCount: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighLights(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Highlights', style: AppTextStyles.titleSmall().copyWith(fontWeight: FontWeight.bold)),
      const Gap(10),
      SizedBox(
        height: Utils.getScreenHeight(context) / 10,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i < 6; i++) Padding(padding: const EdgeInsets.all(8.0), child: CircleAvatar(radius: 30, backgroundColor: Colors.grey.shade400)),
          ],
        ),
      ),
    ],
  );
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


  //               Padding(
  //                 padding: const EdgeInsets.only(top: AppSpacing.bodyxxLarge),
  //                 child: Row(
  //                   spacing: AppSpacing.bodyxxLarge,
  //                   children: [
  //                     Expanded(
  //                       child: BackdropFilter(
  //                         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  //                         blendMode: BlendMode.srcIn,
  //                         child: Container(
  //                           decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
  //                           height: Utils.getScreenHeight(context) / 14,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                             child: Row(children: [_authOption('Sign Up'), _authOption('Login')]),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const FaIcon(FontAwesomeIcons.magnifyingGlass),
  //                     const FaIcon(FontAwesomeIcons.info),
  //                     const FaIcon(FontAwesomeIcons.bell),
  //                   ],
  //                 ),
  //               ),