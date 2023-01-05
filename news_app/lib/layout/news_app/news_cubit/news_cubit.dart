import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/news_cubit/news_state.dart';
import 'package:news_app/modules/businesses/businesses_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(CubitInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItem = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screen = const [
    BusinessesScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getHttpSport();
    // } else if (index == 2) {
    //   getHttpScience();
    // }
    emit(CubitBottomNavBar());
  }

  List<dynamic> getBusiness = [];

  void getHttpBusiness() {
    emit(GetBusinessLoading());
    if (getBusiness.isEmpty) {
      DioHelper.getHttp(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'aeccb357c25543fda5223023554ad8e3',
        },
      ).then(
        (value) {
          getBusiness = value.data['articles'];
          print(getBusiness[0].toString());
          emit(GetBusinessSuccess());
        },
      ).catchError((onError) {
        print(onError.toString());
        emit(GetBusinessFailed(onError.toString()));
      });
    } else {
      emit(GetBusinessSuccess());
    }
  }

  List<dynamic> getSports = [];
  void getHttpSport() {
    emit(GetSportsLoading());
    if (getSports.isEmpty) {
      DioHelper.getHttp(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'aeccb357c25543fda5223023554ad8e3',
        },
      ).then(
        (value) {
          getSports = value.data['articles'];
          print(getSports[0].toString());
          emit(GetSportsSuccess());
        },
      ).catchError((onError) {
        print(onError.toString());
        emit(GetSportsFailed(onError.toString()));
      });
    } else {
      emit(GetSportsSuccess());
    }
  }

  List<dynamic> getScience = [];

  void getHttpScience() {
    emit(GetScienceLoading());
    if (getScience.isEmpty) {
      DioHelper.getHttp(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'aeccb357c25543fda5223023554ad8e3',
        },
      ).then(
        (value) {
          getScience = value.data['articles'];
          print(getScience[0].toString());
          emit(GetScienceSuccess());
        },
      ).catchError((onError) {
        print(onError.toString());
        emit(
          GetScienceFailed(onError.toString()),
        );
      });
    } else {
      emit(GetScienceSuccess());
    }
  }

  bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeChange());
    } else {
      isDark = !isDark;
      CacheHelper.putBol(key: 'isDark', value: isDark).then((value) {
        emit(ThemeChange());
      });
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit((GetSearchLoading()));

    DioHelper.getHttp(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'aeccb357c25543fda5223023554ad8e3',
      },
    ).then(
      (value) {
        search = value.data['articles'];
        print(search[0].toString());
        emit(GetSearchSuccess());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(
        GetSearchFailed(onError.toString()),
      );
    });
  }
}

// List<dynamic> search = [];

//   void getSearch(String value)
//   {
//     emit(NewsGetSearchLoadingState());

//     DioHelper.getData(
//       url: 'v2/everything',
//       query:
//       {
//         'q':'$value',
//         'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
//       },
//     ).then((value)
//     {
//       //print(value.data['articles'][0]['title']);
//       search = value.data['articles'];
//       print(search[0]['title']);

//       emit(NewsGetSearchSuccessState());
//     }).catchError((error){
//       print(error.toString());
//       emit(NewsGetSearchErrorState(error.toString()));
//     });
//   }
// }