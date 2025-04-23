part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int index;
  final Widget body;

  const NavigationState(this.index, this.body);

  @override
  List<Object> get props => [body, index];
}
