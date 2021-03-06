import 'package:cubit/cubit.dart';

class NavigationState {
  final int page;
  NavigationState(this.page);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(0));
  void changePage(newPage, isAuth) {
    emit(NavigationState(newPage));
  }

  void setAuth(page, status) => emit(NavigationState(page));
}
