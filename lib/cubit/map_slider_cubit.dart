import 'package:cubit/cubit.dart';

class MapSliderState {
  final List<Map> slides;

  MapSliderState(this.slides);
}

class MapSliderCubit extends Cubit<MapSliderState> {
  MapSliderCubit() : super(MapSliderState([]));

  void showDialog() {}
}
