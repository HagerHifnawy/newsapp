import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/app_cubit.dart';
import '../../core/utils/app_router.dart';
import 'search/search_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context,SearchScreen());
                }, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  cubit.changeAppMode();
                },
                    icon: Icon(Icons.brightness_4_outlined)),

              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap:(index){
                cubit.changeBottomNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],

        );
      },
    );
  }
}
