import 'package:ecommerce_app/features/shipment/data/datasources/shipment_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockShipmentLocalDataSource extends Mock implements ShipmentLocalDataSource {}

void main() {

  late MockShipmentLocalDataSource mockShipmentLocalDataSource;

  test('should return the number of provinces correct', () async {
    mockShipmentLocalDataSource = MockShipmentLocalDataSource();
    final result = await mockShipmentLocalDataSource.getProvinces();
    expect(result.length, 63);
  });
}