import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style/blocs/network_bloc/network_bloc.dart';
import 'package:pet_style/blocs/user/user_bloc.dart';
import 'package:pet_style/core/helpers/log_helpers.dart';
import 'package:pet_style/core/theme/colors.dart';
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
    BlocProvider.of<UserBloc>(context).add(FetchUserData());
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
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is UserLoaded) {
            logDebug('Pets: ${state.pets}');
            return CustomScrollView(
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
                      color: AppColors.primaryText,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppointmentCard(
                          title: 'Запись в салон',
                          subtitle: 'Премиум уход для вашего любимца',
                          imageLeft: Image(
                            image: AssetImage('assets/images/salon2.png'),
                            height: 30,
                            width: 30,
                          ),
                          imageRight: Image(
                            image: AssetImage('assets/images/pet1.png'),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(width: 16),
                        AppointmentCard(
                          title: 'Запись домой',
                          subtitle: 'Индивидуальный уход у груммера дома',
                          imageLeft: Image(
                            image: AssetImage('assets/images/paw-print.png'),
                            height: 30,
                            width: 30,
                          ),
                          imageRight: Image(
                            image: AssetImage('assets/images/pet2.png'),
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pets,
                          color: AppColors.primaryElement,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Мои питомцы',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryElement
                                  ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                            color: AppColors.primaryElement,
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 5)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.pets.length + 1,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 16,
                      ),
                      itemBuilder: (context, index) {
                        if (index == state.pets.length) {
                          return const AddPetCard();
                        } else {
                          return PetCard(
                            width: 250,
                            name: state.pets[index].name ?? '',
                            photo: state.pets[index].photo ?? '',
                            isNetworkImage: true,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          // Добавляем return на случай, если ни одно условие не выполнится
          return const Center(
            child: Text('Unknown state'),
          );
        },
      ),
    );
  }
}
