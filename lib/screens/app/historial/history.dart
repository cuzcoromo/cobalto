import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:prueva/presentation/history/history_providers.dart';
import 'package:prueva/presentation/history/imprimir_historial.dart';
import 'package:shimmer/shimmer.dart';

class History extends ConsumerStatefulWidget {
  const History({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de pagos'),
        leading: const BackButton(),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Exportar', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDeudaTotal(ref),
          const SizedBox(height: 16),
          _buildSearchBar(ref),
          const SizedBox(height: 16),
          // _buildFiltrosSuperiores(),
          // const SizedBox(height: 24),
          const Text(
            'Filtros Avanzados',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildFiltrosAvanzados(ref),
          const SizedBox(height: 24),
          const Text(
            'Resumen de Pagos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildResumen(ref),
          const SizedBox(height: 24),
          _buildListaUsuarios(ref),
          const SizedBox(height: 24),
          _buildBotonImprimir(context),
        ],
      ),
    );
  }
}

Widget _buildDeudaTotal(WidgetRef ref) {
  final totalAsync = ref.watch(totalHistoryProvider);
  if (totalAsync.isLoading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: 24, width: 100, color: Colors.grey.shade200),
    );
  }
  if (totalAsync.hasError) {
    return Text(
      '\$0',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
  final total = totalAsync.value!;

  return Text(
    'Deuda de consmo: \$$total',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

Widget _buildSearchBar(WidgetRef ref) {
  return TextField(
    onChanged:
        (value) => ref.read(ciFiltroProvider.notifier).state = value.trim(),
    maxLength: 10,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.search),
      hintText: 'Buscar usuario',
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget _buildFiltrosSuperiores() {
  return Wrap(
    spacing: 8,
    children: [
      Chip(label: Text('Fecha')),
      Chip(label: Text('Monto')),
      Chip(label: Text('Estado')),
    ],
  );
}

Widget _buildFiltrosAvanzados(WidgetRef ref) {
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    alignment: WrapAlignment.start,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150),
        child: _buildDropdownOption(ref),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 90),
        child: _buildDropdown('Año', ref),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150),
        child: _buildDropdownmes('Mes', ref),
      ),
    ],
  );
}

Widget _buildDropdown(String label, WidgetRef ref) {
  final currentYear = DateTime.now().year;
  final years = List.generate(
    10,
    (index) => currentYear - index,
  ); // últimos 10 años
  return DropdownButtonFormField<int>(
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    items:
        years.map((year) {
          return DropdownMenuItem(value: year, child: Text('$year'));
        }).toList(),
    onChanged: (value) => ref.read(anioFiltro.notifier).state = value!,
  );
}

Widget _buildDropdownmes(String label, WidgetRef ref) {
  // final currentYear = DateTime.now().year;
  final mes = List.generate(12, (index) {
    final mesDate = DateTime(0, index + 1);
    final nombreMes = DateFormat.MMMM('es_ES').format(mesDate);
    final capitalizado = nombreMes[0].toUpperCase() + nombreMes.substring(1);
    return {'id': index + 1, 'label': capitalizado};
  }); // últimos 10 años
  return DropdownButtonFormField<int>(
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    items:
        mes.map((month) {
          return DropdownMenuItem(
            value: month['id'] as int,
            child: Text(
              month['label'] as String,
              style: TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
    onChanged: (value) => ref.read(mesFiltro.notifier).state = value!,
  );
}

Widget _buildDropdownOption(WidgetRef ref) {
  final select = ref.watch(filterSearProvider);
  return DropdownButtonFormField<FilterSearch>(
    value: select,
    decoration: InputDecoration(
      // labelText: select,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    items:
        FilterSearch.values.map((tipo) {
          return DropdownMenuItem(value: tipo, child: Text(tipo.name));
        }).toList(),
    // onChanged: (_) {},
    onChanged: (value) {
      if (value != null) {
        ref.read(filterSearProvider.notifier).state = value;
      }
    },
  );
}

Widget _buildResumen(WidgetRef ref) {
  final dataAsync = ref.watch(totalMesProvider);

  if (dataAsync.isLoading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: 50, width: 100, color: Colors.grey.shade200),
    );
  }
  if (dataAsync.hasError) {
    return Text('\$0');
  }
  final data = dataAsync.value!;

  final montototal = ref.watch(totaltCategoriaProvider);
  if (montototal.isLoading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: 50, color: Colors.grey.shade200),
    );
  }
  if (montototal.hasError) {
    return Text('\$0');
  }
  final total = montototal.value!;
  return Wrap(
    spacing: 4,
    runSpacing: 4,
    children: [
      _buildCardResumen('Monto del Mes', '\$$data'),
      // const SizedBox(height: 12),
      _buildCardResumen('Monto total', '\$$total'),
      // const SizedBox(height: 12),
      // _buildCardResumen('Pagos por Estado', '\$1000'),
    ],
  );
}

Widget _buildCardResumen(String titulo, String monto) {
  return Container(
    padding: const EdgeInsets.all(8),
    // width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          monto,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Text( style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
      ],
    ),
  );
}

Widget _buildListaUsuarios(WidgetRef ref) {
  final dataAsync = ref.watch(listRegisterCobroProvider);
  if (dataAsync.isLoading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(height: 24, width: 100),
    );
  }
  if (dataAsync.hasError) {
    return SizedBox(height: 24, width: 100, child: Text('No data'));
  }
  final dataUser = dataAsync.value!;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        dataUser.map((user) {
          final id = user['id'];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usuario: ${user['nombre']} ${user['apellido']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Text('Monto adeudado: \$${user['id']}'),
                //todo deuda
                _buildDeuda(ref, id),
                Text(user['fechaR'].toString()),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildTotal(ref, id),
                  // child: Text(
                  //   '\$${user['monto']}',
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ),
              ],
            ),
          );
        }).toList(),
  );
}

Widget _buildBotonImprimir(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Imprimir Historial'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VistaPreviaHistorial()),
        );
      },
    ),
  );
}

Widget _buildDeuda(WidgetRef ref, String? id) {
  final dataAsyn = ref.watch(deudaUserProvider(id));
  if (dataAsyn.isLoading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: 24, width: 100, color: Colors.grey.shade200),
    );
  }
  if (dataAsyn.hasError) {
    return const Text('\$');
  }
  final deuda = dataAsyn.value!;

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Monto adeudado:  ',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: '\$$deuda',
          style: TextStyle(
            color: Colors.red.shade300,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Widget _buildDeuda(WidgetRef ref, String? id) {
// final dataAsyn = ref.watch(deudaUserProvider(id));
Widget _buildTotal(WidgetRef ref, String? id) {
  final dataAsync = ref.watch(totalAporteProvider(id));

  if (dataAsync.isLoading) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(height: 24, width: 100, color: Colors.grey.shade200),
    );
  }
  if (dataAsync.hasError) {
    Text('\$0');
  }
  final total = dataAsync.value!;
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Total: ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextSpan(
          text: '\$$total',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
      ],
    ),
  );
}
