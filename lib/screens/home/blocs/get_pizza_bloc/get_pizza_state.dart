part of 'get_pizza_bloc.dart';

sealed class GetPizzaState extends Equatable {
  const GetPizzaState();

  @override
  List <Object> get props => [];
}

final class GetPizzalInitial extends GetPizzaState {}

final class GetPizzalProcess extends GetPizzaState {}
final class GetPizzalFailure extends GetPizzaState {}
final class GetPizzalSuccess extends GetPizzaState {
  final List <Pizza> pizzas;

  const GetPizzalSuccess(this.pizzas);

  @override
  List <Object> get props => [pizzas];
}