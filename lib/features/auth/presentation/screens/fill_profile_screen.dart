import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/enums.dart';
import 'package:gramify/core/theme/colors.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/core/widgets/app_filled_button.dart';
import 'package:gramify/core/widgets/app_gradient_scaffold.dart';
import 'package:gramify/core/widgets/app_outlined_button.dart';
import 'package:gramify/core/widgets/app_snack.dart';
import 'package:gramify/core/widgets/app_text_field.dart';
import 'package:gramify/core/widgets/app_drop_down.dart';
import 'package:gramify/features/wrapper/presentation/widgets/profile_image_avatar.dart';

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
  final int _currentScreenIndex = 0;
  int _pronounIndex = -1;
  File? _selectedImage;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyxSmall, horizontal: AppSpacing.bodyxLarge),
        child: _currentScreenIndex == 0 ? _buildFormScreen() : _buildProfilePictureScreen(),
      ),
    );
  }

  Widget pronounItem(int i, String text) {
    bool isSelected = _pronounIndex == i;
    return InkWell(
      onTap: () {
        setState(() {
          _pronounIndex = i;
        });
      },
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 2, color: isSelected ? Appcolors.brandGreen : Colors.grey.shade500),
            ),
          ),
          const Gap(5),
          Text(text, style: AppTextStyles.bodySmall()),
        ],
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
                  children: [pronounItem(0, 'He/Him'), pronounItem(1, 'She/Her'), pronounItem(2, 'They/Them')],
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
                Center(
                  child: AppFilledButton(
                    text: 'Next',
                    onTap: () async {
                      if (_formKey.currentState!.validate() && _pronounIndex != -1) {
                        await _onEditProfile();
                      } else {
                        appSnack(context, 'Please fill all the fields and select a pronoun');
                      }
                    },
                  ),
                ),
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
      ProfileImageAvatar(imageFile: _selectedImage),
      Column(
        spacing: 10,
        children: [
          AppOutlinedButton(
            onTap: () {
              _onEditProfile();
            },
            text: 'Skip',
          ),
          AppFilledButton(
            onTap: () async {
              await _onEditProfile();
            },
            text: 'Save',
          ),
        ],
      ),
    ],
  );

  Future<void> _onEditProfile() async {
    if (_selectedImage != null) {
      
    }
  }
}
