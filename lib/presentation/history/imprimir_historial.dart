import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prueva/presentation/history/history_providers.dart';

class VistaPreviaHistorial extends ConsumerWidget {
  const VistaPreviaHistorial({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historial = ref.watch(historialProviderResultado);
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa del historial')),
      body: Theme(
        // 🟩 Corrección: se sobrescribe el color púrpura por un gris oscuro (puedes usar otro color si deseas)
        data: ThemeData.light().copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.grey[800], // aquí cambias el púrpura
          ),
          primaryColor: Colors.grey.shade600,
          iconTheme: IconThemeData(color: Colors.grey.shade300),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.grey.shade300),
          ),
        ),
        child: PdfPreview(
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName:
              'Historial_${DateTime.now().toIso8601String().split("T").first}',
          build: (format) => _buildPdf(historial),
          actions: const [],
        ),
      ),
    );
  }

  Future<Uint8List> _buildPdf(List<Map<String, dynamic>> historial) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build:
            (context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              // mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                // 🟦 ENCABEZADO
                pw.Text(
                  'Reporte de Historial de Pagos',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Generado: ${DateTime.now().toLocal().toString().split(' ')[0]} - "COBALTO"',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey,
                  ),
                ),
                pw.Divider(),
                pw.SizedBox(height: 16),

                // 📊 TABLA DE HISTORIAL
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    // Encabezado
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Nombre',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Deuda',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Total aportado',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // Filas dinámicas
                    ...historial.map((item) {
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              '${item['nombre']} ${item['apellido']}',
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('\$${item['deuda']}'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text('${item['total']}'),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
      ),
    );

    return pdf.save();
  }
}
