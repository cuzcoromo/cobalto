import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueva/presentation/resumen/resumen.dart';

class Pagination extends ConsumerStatefulWidget {
  const Pagination({super.key});
   
  @override
  ConsumerState<Pagination> createState() => PaginationState();
}
class PaginationState extends ConsumerState<Pagination> {
  @override
  Widget build(BuildContext context) {
    final dataAsync = ref.watch(dataResumenProvider);

    return dataAsync.when(
  data: (data) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        IconButton(
          onPressed: () => previousPage(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text('...'),
        ),
        IconButton(
          onPressed: () => nextPage(data),
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  },
   loading: () => const SizedBox.shrink(),
  error: (e, _) => Center(
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Text('Error: $e'),
    ),
  ),
);

  }

  void previousPage() {
    final history = ref.read(historyProvider);

    if (history.isEmpty) return;

    final newHistory = [...history]..removeLast();
    final previousDoc = newHistory.isNotEmpty ? newHistory.last : null;

    ref.read(historyProvider.notifier).state = newHistory;
    ref.read(lastDocProvider.notifier).state = previousDoc;

    // ignore: unused_result
    ref.refresh(dataResumenProvider);
  }

  void nextPage(List<Map<String, dynamic>> currentData) {
    if (currentData.isEmpty) return;

    final lastDoc = currentData.last['docSnapshot'] as DocumentSnapshot;
    final current = ref.read(lastDocProvider);
    final history = ref.read(historyProvider);

    if (lastDoc != current) {
      ref.read(historyProvider.notifier).state = [...history, lastDoc];
      ref.read(lastDocProvider.notifier).state = lastDoc;
    }

    // ignore: unused_result
    ref.refresh(dataResumenProvider);
  }
}
