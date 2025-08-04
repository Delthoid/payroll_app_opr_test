import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class HomePageCubit extends Cubit<int> {
  HomePageCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
