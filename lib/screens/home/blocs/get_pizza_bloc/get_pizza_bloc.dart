

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'get_pizza_event.dart';
part 'get_pizza_state.dart';

class GetPizzaBloc extends Bloc<GetPizzaEvent, GetPizzaState> {
  final PizzaRepo _pizzaRepo;
  
  GetPizzaBloc(this._pizzaRepo) : super(GetPizzalInitial()) {
    on <GetPizza> ((event, emit) async {
      emit(GetPizzalProcess());
      try {
        List <Pizza> pizzas = await _pizzaRepo.getPizzas();
        emit(GetPizzalSuccess(pizzas));
      } catch (e) {
        emit(GetPizzalFailure());
      }
    });
  }
}