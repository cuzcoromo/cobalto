import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/providers.dart';
import 'package:prueva/screens/app/agua/components/list__medidor_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medidor_providers.g.dart';

class MedidorId {
  final String id;
  final String ci;
  final String fechaIns;
  final String numMed;

  MedidorId({
    required this.id,
    required this.ci,
    required this.fechaIns,
    required this.numMed,
  });
}

@riverpod
Stream<List<MedidorId>> getMedidor(Ref ref,dynamic medidorId) async* {
  final listMedidores = ref.watch(medidorListProvider);
  final List<Medidor> medidorList = listMedidores.value!;
  // filtar solo por el id
  final medidor = medidorList
      .where((medidor) => medidor.id == medidorId)
      .map((medidor) => MedidorId(
        id: medidor.id ?? '',
        ci: medidor.ci ?? '',
        fechaIns: medidor.fechaIns ?? '',
        numMed: medidor.numMed ?? '',
      )
      ).toList();
      yield medidor;
}
