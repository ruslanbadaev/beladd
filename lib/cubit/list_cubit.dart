import 'package:cubit/cubit.dart';

class ListState {
  final List<Map> sprinklersTitle;
  final List<Map> sprinklers;

  ListState(this.sprinklers, this.sprinklersTitle);
}

class NavigationCubit extends Cubit<ListState> {
  NavigationCubit() : super(ListState([], []));

  void uploadSprinklers() {
    emit(ListState([], []));
  }

  void getCurrentSprinklers(id) {
    emit(ListState([], []));
  }
}
