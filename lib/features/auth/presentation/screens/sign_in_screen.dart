import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/routes/app_routes.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';
import 'package:progresssoft_task/core/utils/constant/app_images.dart';
import 'package:progresssoft_task/core/utils/constant/app_sizes.dart';
import 'package:progresssoft_task/core/utils/regex.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_button.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_form_filed.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_loading.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_snack_bar.dart';
import 'package:progresssoft_task/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:progresssoft_task/features/auth/presentation/widgets/sign_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String countryCode = '+962';

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    IconData getPasswordIcon(SignInState state) {
      return state is PasswordHiddenState
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    }

    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          Get.offAllNamed(AppRoutes.base);
        } else if (state is SignInErrorState) {
          CustomSnackBar.error(
            title: 'Sign In'.tr,
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return SignWidget(
          title: 'Sign In'.tr,
          body: Form(
            key: formKey,
            child: Center(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 2.0,
                child: ListView(
                  padding: const EdgeInsets.only(
                    top: AppDefaults.defaultTopPadding * 4,
                    right: AppDefaults.defaultMaxRightRadius,
                    left: AppDefaults.defaultMaxLeftRadius,
                    bottom: AppDefaults.defaultBottomPadding,
                  ),
                  children: [
                    Image(
                      width: AppSizeConfig.screenWidth * 0.8,
                      height: AppSizeConfig.screenHeight * 0.2,
                      fit: BoxFit.fill,
                      image: const AssetImage(
                        AppImages.progressSoftLogo,
                      ),
                    ),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenBigWidget,
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
                      maxLength: 9,
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
                      controller: passwordController,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Password Required'.tr;
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
                              .read<SignInBloc>()
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
                      height: AppDefaults.defaultVerticalSpaceBetweenBigWidget,
                    ),
                    AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: state is SignInLoadingState
                            ? const CustomLoading()
                            : CustomButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(
                                        SignInSubmitEvent(
                                            phoneNumber:
                                                '$countryCode${phoneController.text}',
                                            password: passwordController.text));
                                  }
                                },
                                text: 'Sign In'.tr,
                                textColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                background: Theme.of(context).primaryColor,
                                height: 47,
                                radius: 10,
                              )),
                    const SizedBox(
                      height: AppDefaults.defaultVerticalSpaceBetweenWidget,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don\'t have an account ,'.tr,
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
                          onTap: () {
                            Get.toNamed(AppRoutes.signUp);
                          },
                          child: Text(
                            "Register now".tr,
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
}
