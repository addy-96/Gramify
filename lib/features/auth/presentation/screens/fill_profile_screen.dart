import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/enums.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_outlined_button.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/core/widgets/app_drop_down.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  int currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyxSmall, horizontal: AppSpacing.bodyxLarge),
        child: currentScreenIndex == 0 ? _buildFormScreen() : _buildProfilePictureScreen(),
      ),
    );
  }

  Widget _buildFormScreen() => Form(
    key: _formKey,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          const Gap(10),
          Text('Lets get you started!', style: AppTextStyles.titleLarge().copyWith(fontWeight: FontWeight.bold)),
          Text(
            'Please fill in your details, you can always update them later.',
            style: AppTextStyles.caption().copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: AppTextStyles.bodyMedium().copyWith(fontWeight: FontWeight.bold)),
                AppTextField(
                  maxLength: 30,
                  inputType: TextInputType.text,
                  hintText: 'First Name',
                  controller: _firstNameController,
                  validator: (value) => Utils.validateTextFieldInput(Validator.firstName, value),
                ),
                AppTextField(
                  maxLength: 30,
                  inputType: TextInputType.text,
                  hintText: 'Last Name',
                  controller: _lastNameController,
                  validator: (value) => Utils.validateTextFieldInput(Validator.lastName, value),
                ),
                Divider(color: Colors.grey.shade200, thickness: 3, radius: BorderRadius.circular(20), endIndent: 50, indent: 50),
                Text('Gender', style: AppTextStyles.bodyMedium().copyWith(fontWeight: FontWeight.bold)),
                const AppDropDown(defaultText: 'Select Gender', options: ['Male', 'Female', 'Other']),
                Text('Select your pronoun', style: AppTextStyles.bodyMedium().copyWith(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 2, color: Colors.grey.shade500)),
                        ),
                        const Gap(5),
                        Text('He/Him', style: AppTextStyles.bodySmall()),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 2, color: Colors.grey.shade500)),
                        ),
                        const Gap(5),
                        Text('She/Her', style: AppTextStyles.bodySmall()),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 2, color: Colors.grey.shade500)),
                        ),
                        const Gap(5),
                        Text('They/Them', style: AppTextStyles.bodySmall()),
                      ],
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade200, thickness: 3, radius: BorderRadius.circular(20), endIndent: 50, indent: 50),
                Text('Location', style: AppTextStyles.bodyMedium().copyWith(fontWeight: FontWeight.bold)),
                AppTextField(
                  maxLength: 30,
                  inputType: TextInputType.text,
                  hintText: 'City/State',
                  controller: _stateController,
                  validator: (value) => Utils.validateTextFieldInput(Validator.state, value),
                ),
                AppTextField(
                  maxLength: 30,
                  inputType: TextInputType.text,
                  hintText: 'Country',
                  controller: _countryController,
                  validator: (value) => Utils.validateTextFieldInput(Validator.country, value),
                ),
                Center(child: AppFilledButton(text: 'Next', onTap: () {})),
                const Gap(10),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildProfilePictureScreen() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('Add your profile picture!', style: AppTextStyles.titleMedium().copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
      InkWell(
        onTap: () {},
        child: DottedBorder(
          options: const CircularDottedBorderOptions(
            dashPattern: [6, 10],
            strokeWidth: 6,
            padding: EdgeInsets.all(0),
            color: Appcolors.gradientMint, // needed if gradient is used
          ),
          child: Container(
            height: Utils.getScreenWidth(context) / 2,
            width: Utils.getScreenWidth(context) / 2,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
            child: Center(child: FaIcon(FontAwesomeIcons.solidCamera, color: Colors.grey.shade500, size: Utils.getScreenWidth(context) / 5)),
          ),
        ),
      ),
      Column(spacing: 10, children: [AppOutlinedButton(onTap: () {}, text: 'Skip'), AppFilledButton(onTap: () {}, text: 'Save')]),
    ],
  );
}
