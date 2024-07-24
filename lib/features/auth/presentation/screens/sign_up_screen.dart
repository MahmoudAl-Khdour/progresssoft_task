import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/routes/app_routes.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';
import 'package:progresssoft_task/core/utils/constant/app_sizes.dart';
import 'package:progresssoft_task/core/utils/regex.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_button.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_drop_down.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_form_filed.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_snack_bar.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';

import '../widgets/sign_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  IconData getPasswordIcon(SignUpState state) {
    return state is PasswordHiddenState
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
  }

  IconData getConfirmPasswordIcon(SignUpState state) {
    return state is ConfirmPasswordHiddenState
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
  }

  @override
  Widget build(BuildContext context) {
    String countryCode = '+962';

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController birthdayController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    int gender = 1;
    int age = 15;

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is PhoneAuthSuccessState) {
          Get.toNamed(
            AppRoutes.otp,
            arguments: {
              'phoneNumber': '$countryCode${phoneController.text}',
              'fullName': fullNameController.text,
              'gender': gender,
              'password': passwordController.text,
              'age': age,
            },
          );
        } else if (state is PhoneAuthErrorState) {
          CustomSnackBar.error(
              title: 'Sign Up'.tr, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return SignWidget(
          title: 'Sign Up'.tr,
          withAppBar: true,
          body: Form(
            key: formKey,
            child: Center(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 2.0,
                child: ListView(
                  padding: const EdgeInsets.only(
                    top: AppDefaults.defaultTopPadding * 1.2,
                    right: AppDefaults.defaultMaxRightRadius,
                    left: AppDefaults.defaultMaxLeftRadius,
                    bottom: AppDefaults.defaultBottomPadding,
                  ),
                  children: [
                    CustomFormFiled(
                      validator: (fullName) {
                        if (fullName == null || fullName.isEmpty) {
                          return 'Full name is required'.tr;
                        } else if (!(RegexValidator.isValidFullName(
                            fullName))) {
                          return 'Write your full name correctly'.tr;
                        }
                        return null;
                      },
                      controller: fullNameController,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: false,
                      enabled: true,
                      readOnly: false,
                      autofocus: false,
                      borderColors: AppColors.appBorderColor,
                      focusBorderColor: AppColors.appBorderColor,
                      borderWidth: 1,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                      textColor: Theme.of(context).primaryColor,
                      filled: false,
                      label: 'Full Name'.tr,
                      onChange: (value) {},
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      labelStyle: Theme.of(context).textTheme.labelMedium!,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.defaultRightRadius,
                      ),
                      pressablePrefix: false,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    CustomFormFiled(
                      validator: (phone) {
                        if (phone == null || phone.isEmpty) {
                          return 'Phone Required'.tr;
                        } else if (!(RegexValidator.isValidPhoneNumber(
                            phone))) {
                          return 'Phone number must continue from 9 numbers'.tr;
                        }
                        return null;
                      },
                      controller: phoneController,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: false,
                      enabled: true,
                      readOnly: false,
                      autofocus: false,
                      borderColors: AppColors.appBorderColor,
                      focusBorderColor: AppColors.appBorderColor,
                      borderWidth: 1,
                      prefixIcon: SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: AppDefaults
                                  .defaultHorizontalSpaceBetweenSmallWidget,
                            ),
                            Text(
                              countryCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      filled: false,
                      label: 'Phone Number'.tr,
                      onChange: (value) {},
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      labelStyle: Theme.of(context).textTheme.labelMedium!,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.defaultRightRadius,
                      ),
                      pressablePrefix: false,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    CustomFormFiled(
                      onTap: () {
                        BottomPicker.date(
                          pickerTitle: Text(
                            'Set your Birthdate'.tr,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          dateOrder: DatePickerDateOrder.dmy,
                          initialDateTime: DateTime(1996, 10, 22),
                          maxDateTime: DateTime(2024),
                          minDateTime: DateTime(1960),
                          pickerTextStyle: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          buttonWidth: AppSizeConfig.screenWidth * 0.8,
                          onChange: (index) {
                            List<String> parts = index.toString().split(' ');
                            DateTime birthDate = DateTime.parse(
                                birthdayController.text = parts[0]);
                            age = _calculateAge(birthDate);
                          },
                          onSubmit: (index) {
                            List<String> parts = index.toString().split(' ');
                            DateTime birthDate = DateTime.parse(
                                birthdayController.text = parts[0]);
                            age = _calculateAge(birthDate);
                          },
                          bottomPickerTheme: BottomPickerTheme.plumPlate,
                        ).show(context);
                      },
                      validator: (birthday) {
                        if (birthday == null || birthday.isEmpty) {
                          return 'Birthdate required'.tr;
                        }
                        return null;
                      },
                      controller: birthdayController,
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: false,
                      enabled: true,
                      readOnly: true,
                      autofocus: false,
                      borderColors: AppColors.appBorderColor,
                      focusBorderColor: AppColors.appBorderColor,
                      borderWidth: 1,
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Theme.of(context).primaryColor,
                      ),
                      textColor: Theme.of(context).primaryColor,
                      filled: false,
                      label: 'BirthDate'.tr,
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      labelStyle: Theme.of(context).textTheme.labelMedium!,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.defaultRightRadius,
                      ),
                      pressablePrefix: false,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    CustomDropDown(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      dropDownColor:
                          Theme.of(context).dropdownMenuTheme.textStyle!.color!,
                      label: 'Gender'.tr,
                      value: state is GenderSelectedState
                          ? state.selectedGender
                          : gender,
                      prefixStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      onChange: (gender) {
                        if (gender != null) {
                          context
                              .read<SignUpBloc>()
                              .add(SelectGenderEvent(gender));
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Male'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            'Female'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ],
                      autofocus: false,
                      borderColors: Theme.of(context).primaryColor,
                      focusBorderColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      textColor: Theme.of(context).primaryColor,
                      filled: true,
                      fillColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      pressablePrefix: false,
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      labelStyle: Theme.of(context).textTheme.labelMedium!,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.defaultRightRadius,
                      ),
                      borderWidth: 1,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    CustomFormFiled(
                      controller: passwordController,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Password Required'.tr;
                        } else if (password != confirmPasswordController.text) {
                          return 'Password and confirm password does not matches'
                              .tr;
                        }
                        return null;
                      },
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<SignUpBloc>()
                              .add(TogglePasswordVisibilityEvent());
                        },
                        icon: Icon(
                          getPasswordIcon(state),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      isPassword: state is PasswordHiddenState,
                      enabled: true,
                      readOnly: false,
                      autofocus: false,
                      borderColors: AppColors.appBorderColor,
                      focusBorderColor: AppColors.appBorderColor,
                      borderWidth: 1,
                      minLines: 1,
                      maxLines: 1,
                      textColor: Theme.of(context).primaryColor,
                      filled: false,
                      label: 'Password'.tr,
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      labelStyle: Theme.of(context).textTheme.labelMedium!,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.defaultRightRadius,
                      ),
                      pressablePrefix: false,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    CustomFormFiled(
                      controller: confirmPasswordController,
                      validator: (cPassword) {
                        if (cPassword == null || cPassword.isEmpty) {
                          return 'Confirm Password Required'.tr;
                        } else if (cPassword != passwordController.text) {
                          return 'Confirm password and password does not matches'
                              .tr;
                        }
                        return null;
                      },
                      cursorColor: Theme.of(context).primaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<SignUpBloc>()
                              .add(ToggleConfirmPasswordVisibilityEvent());
                        },
                        icon: Icon(
                          getConfirmPasswordIcon(state),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      isPassword: state is ConfirmPasswordHiddenState,
                      enabled: true,
                      readOnly: false,
                      autofocus: false,
                      borderColors: AppColors.appBorderColor,
                      focusBorderColor: AppColors.appBorderColor,
                      borderWidth: 1,
                      minLines: 1,
                      maxLines: 1,
                      textColor: Theme.of(context).primaryColor,
                      filled: false,
                      label: 'Confirm Password'.tr,
                      hintStyle: Theme.of(context).textTheme.labelMedium!,
                      labelStyle: Theme.of(context).textTheme.labelMedium!,
                      borderRadius: BorderRadius.circular(
                        AppDefaults.defaultRightRadius,
                      ),
                      pressablePrefix: false,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenBigWidget,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                                PhoneNumberAuthEvent(
                                  phoneNumber:
                                      '$countryCode${phoneController.text}',
                                ),
                              );
                        }
                      },
                      text: 'Sign Up'.tr,
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      background: Theme.of(context).primaryColor,
                      height: 47,
                      radius: 10,
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do you have account ?'.tr,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          width: AppDefaults
                              .defaultHorizontalSpaceBetweenSmallWidget,
                        ),
                        InkWell(
                          onTap: () => Get.offNamed(AppRoutes.signIn),
                          child: Text(
                            "Sign in".tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
