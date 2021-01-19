import 'package:cubit/cubit.dart';

class MapState {
  final List<Map> markers;
  final Map warningMark;

  MapState(this.markers, this.warningMark);
}

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState([], {}));

  void setMarker(marker) {
    emit(MapState(state.markers, marker));
  }
}
