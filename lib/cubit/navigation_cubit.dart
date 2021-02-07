import 'package:cubit/cubit.dart';

class NavigationState {
  final int page;
  final bool isAuth;

  NavigationState(this.page, this.isAuth);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(4, false));

  void changePage(newPage, isAuth) {
    if (!isAuth) newPage += 4;
    print(newPage);
    emit(NavigationState(newPage, state.isAuth /* newPage == 4 */));
  }

  void setAuth(page, status) => emit(NavigationState(page, status));
}
