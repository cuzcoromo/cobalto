
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/config/helpers/random_generator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/todo.dart';

part 'cobro_providers.g.dart';

enum FilterType { all, completed, pending }
enum FilterPago {medidor, riego}

extension FilterPagoEx  on FilterPago {
  String get label {
    switch (this){
      case FilterPago.medidor :
        return 'medidor';
      case FilterPago.riego :
        return 'riego';
    }
  }
}

const uuid = Uuid();

@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter {
  @override
  FilterType build() => FilterType.all;

  void setFilter (FilterType newFilter) {
    state = newFilter;
   }
}



@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
   List<Todo> build() =>[
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
   ];

   void toggleTodo(String id){
      state = state.map( (todo) {
        if(todo.id == id){
        todo = todo.copyWith(
          completedAt: todo.done ? null : DateTime.now()
        );
      }
        return todo;
      }).toList();
   }
}


@Riverpod(keepAlive: true)
List<Todo> todosFiltered (Ref ref) {
  final todos = ref.watch(todosProvider);
  final filter = ref.watch(todoCurrentFilterProvider);

  switch (filter) {
    case FilterType.all:
      return todos;
    case FilterType.completed:
      return todos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return todos.where((todo) => !todo.done).toList();
  }
}



//  seleccionar opcion de pago
@Riverpod(keepAlive: true)
class FilterOpcionPago extends _$FilterOpcionPago {
  @override
  FilterPago build() => FilterPago.medidor;

  void select(FilterPago filter) {
    if( state != filter){
    state = filter;
    }
  }
}