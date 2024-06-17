import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style/core/theme/colors.dart';
import 'package:pet_style/view/widget/my_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: AppColors.primarySecondElement,
        title: const Text('Настройки'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                width: 120.w,
                height: 120.h,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/default_profile.png')),
              ),
              SizedBox(height: 10.h),
              Text(
                'Profile Name',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'profileemail@gmail.com',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 20.h),
              MyButton(
                width: 200.w,
                text: 'Edit Profile',
                onPressed: () {},
              ),
              SizedBox(height: 30.h),
              const Divider(),
              SizedBox(height: 10.h),
              ListTileMenu(
                title: 'Settings',
                icon: const Icon(Icons.logout),
                onPress: () {},
              ),
              ListTileMenu(
                title: 'Settings',
                icon: const Icon(Icons.logout),
                onPress: () {},
              ),
              ListTileMenu(
                title: 'Settings',
                icon: const Icon(Icons.logout),
                onPress: () {},
              ),
              const Divider(),
              SizedBox(height: 10.h),
              ListTileMenu(
                title: 'Выход',
                icon: const Icon(Icons.logout),
                onPress: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                  const Duration(seconds: 1);
                  context.go('/onboarding');
                },
                textColor: AppColors.primaryStatusError,
                endIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileMenu extends StatelessWidget {
  const ListTileMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textColor,
    this.endIcon = true,
  });

  final String title;
  final Icon icon;
  final VoidCallback onPress;
  final Color? textColor;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onPress,
      leading: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.containerColor.withOpacity(0.7),
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryEnabledBorder.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ))
          : null,
    );
  }
}
