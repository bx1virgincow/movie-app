part of 'bottom_nav_bloc.dart';

sealed class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

final class OnTabChangedEvent extends BottomNavEvent {
  final int tabIndex;

  const OnTabChangedEvent({required this.tabIndex});
  @override
  List<Object> get props => [tabIndex];
}
