abstract class NewsState {}

class CubitInitial extends NewsState {}

class CubitBottomNavBar extends NewsState {}

class GetBusinessLoading extends NewsState {}

class GetBusinessSuccess extends NewsState {}

class GetBusinessFailed extends NewsState {
  final String error;

  GetBusinessFailed(this.error);
}

class GetSportsLoading extends NewsState {}

class GetSportsSuccess extends NewsState {}

class GetSportsFailed extends NewsState {
  final String error;

  GetSportsFailed(this.error);
}

class GetScienceLoading extends NewsState {}

class GetScienceSuccess extends NewsState {}

class GetScienceFailed extends NewsState {
  final String error;

  GetScienceFailed(this.error);
}

class ThemeChange extends NewsState {}

class GetSearchLoading extends NewsState {}

class GetSearchSuccess extends NewsState {}

class GetSearchFailed extends NewsState {
  final String error;

  GetSearchFailed(this.error);
}
