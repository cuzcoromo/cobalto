
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_one_providers.g.dart';

@Riverpod(keepAlive: true)
class OptionNavigation extends _$OptionNavigation {
  @override
  int build()  => 0;

  void setOption (int index){
    state = index;
  }
}