import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavSuccessState(tabIndex: 0)) {
    on<OnTabChangedEvent>((event, emit) {
      emit(BottomNavSuccessState(tabIndex: event.tabIndex));
    });
  }
}
