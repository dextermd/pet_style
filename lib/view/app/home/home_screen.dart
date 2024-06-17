import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_style/blocs/network_bloc/network_bloc.dart';
import 'package:pet_style/core/helpers/log_helpers.dart';
import 'package:pet_style/core/theme/colors.dart';
import 'package:pet_style/domain/repository/user_repository.dart';
import 'package:pet_style/view/app/home/widgets/appointment_card.dart';
import 'package:pet_style/view/app/home/widgets/pet_card.dart';
import 'package:pet_style/view/widget/dialog_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    GetIt.I<UserRepository>().getUserData();
    BlocProvider.of<NetworkBloc>(context).add(CheckNetworkConnection());
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          showDialogBox(context);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            backgroundColor: AppColors.primarySecondElement,
            elevation: 1,
            title: Text(
              'P E T  S T Y L E',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.containerBorder,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    logDebug('Click Profile Pic');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/default_profile.png',
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppointmentCard(
                    backgroundColor: AppColors.containerColor,
                    icon: Icons.business,
                    title: 'Запись в салон',
                    subtitle: 'Премиум уход для вашего любимца',
                    iconColor: AppColors.primaryText,
                    textColor: AppColors.primaryText,
                  ),
                  AppointmentCard(
                    backgroundColor: AppColors.containerColor,
                    icon: Icons.home_work,
                    title: 'Запись домой',
                    subtitle: 'Индивидуальный уход у груммера дома',
                    iconColor: AppColors.primaryText,
                    textColor: AppColors.primaryText,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Мои питомцы',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 2 + 1,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
                itemBuilder: (context, index) {
                  if (index == 2) {
                    return const AddPetCard();
                  } else {
                    return const PetCard(width: 130);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
