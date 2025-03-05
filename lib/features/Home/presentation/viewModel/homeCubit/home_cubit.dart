import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymer/features/Authentication/data/models/userModel.dart';
import 'package:gymer/features/Favorite/data/models/favoriteModel.dart';
import 'package:gymer/features/Home/data/repository/homeRepo.dart';
import 'package:gymer/features/Home/presentation/viewModel/homeCubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  void fetchData() async {
    try {
      emit(HomeLoading());
      final UserModel? user = await homeRepository.getProfile();
      final FavoriteModel favourites = await homeRepository.getFavorite();
      if (user != null) {
        emit(HomeLoaded(user: user, favourites: [favourites]));
      } else {
        emit(HomeError(message: "Couldn't retrieve user data"));
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
