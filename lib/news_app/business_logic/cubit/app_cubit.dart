import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/local/cache_helper.dart';
import '../../data/data_sources/remote/dio_helper.dart';
import '../../presentation/screens/business/business_screen.dart';
import '../../presentation/screens/science/science_screen.dart';
import '../../presentation/screens/sports/sports_screen.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
  BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
  BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
  BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),

  ];
  List <Widget>screens=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
  ];

  changeBottomNavBar(int index){
  currentIndex =index;
  if(index==1)
  getSports();
  if(index==2)
  getScience();
  emit(AppBottomNavState());
  }
  List<dynamic> business = [];
  void getBusiness(){
  emit(AppGetBusinessLoadingState());
  DioHelper.getData(url: 'v2/top-headlines',
  query: {
  'country':'eg',
  'category':'business',
  'apiKey':'3b15b8348665413f850378f3438deb80',
  }).then((value) {
  business = value.data['articles'];
  print(business[0]['title']);
  emit(AppGetBusinessSuccessState());
  }).catchError((onError){
  print(onError.toString());
  emit(AppGetBusinessErrorState(onError.toString()));
  });
  }
  List<dynamic> sports = [];
  void getSports(){
  emit(AppGetSportsLoadingState());
  if(sports.length==0) {
  DioHelper.getData(url: 'v2/top-headlines',
  query: {
  'country': 'eg',
  'category': 'sports',
  'apiKey': '3b15b8348665413f850378f3438deb80',
  }).then((value) {
  sports = value.data['articles'];
  print(sports[0]['title']);
  emit(AppGetSportsSuccessState());
  }).catchError((onError) {
  print(onError.toString());
  emit(AppGetSportsErrorState(onError.toString()));
  });
  }
  else{
  emit(AppGetSportsSuccessState());
  }
  }
  List<dynamic> science = [];

  void getScience(){
  emit(AppGetScienceLoadingState());
  if(science.length==0){
  DioHelper.getData(url: 'v2/top-headlines',
  query: {
  'country':'eg',
  'category':'science',
  'apiKey':'3b15b8348665413f850378f3438deb80',
  }).then((value) {
  science = value.data['articles'];
  print(science[0]['title']);
  emit(AppGetScienceSuccessState());
  }).catchError((onError){
  print(onError.toString());
  emit(AppGetScienceErrorState(onError.toString()));
  });
  }else{
  emit(AppGetScienceSuccessState());

  }
  }

  List<dynamic> search = [];

  void getSearch(String value){
  emit(AppGetSearchLoadingState());
  search=[];
  DioHelper.getData(url: 'v2/everything',
  query: {
  'q':'$value',
  'apiKey':'3b15b8348665413f850378f3438deb80',
  }).then((value) {
  search = value.data['articles'];
  print(search[0]['title']);
  emit(AppGetSearchSuccessState());
  }).catchError((onError){
  print(onError.toString());
  emit(AppGetSearchErrorState(onError.toString()));
  });
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}){
  if(fromShared != null) {
  isDark = fromShared;
  emit(AppChangeModeState());
  }
  else {
  isDark = !isDark;
  CacheHelper.putBoolean('isDark', isDark).then((value) {
  emit(AppChangeModeState());
  });
  }
  }
}
