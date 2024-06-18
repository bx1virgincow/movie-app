part of 'bottom_nav_bloc.dart';

sealed class BottomNavState extends Equatable {
  final int tabIndex;
  const BottomNavState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

final class BottomNavSuccessState extends BottomNavState {
  const BottomNavSuccessState({required super.tabIndex});
}
