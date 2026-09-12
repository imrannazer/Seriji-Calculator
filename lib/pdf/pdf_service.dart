import 'dart:typed_data';
import '../core/result/result.dart';

abstract interface class PdfService {
  Future<Result<Uint8List>> generateCalculationReport(String calculationId);
  Future<Result<Uint8List>> generateWillDocument(String willId);
}
