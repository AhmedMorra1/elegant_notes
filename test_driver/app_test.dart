import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  group('Elegant Notes', () {
    final button = find.byType('FloatingActionButton');
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('Given app is ran check the test widgets exist', () async {
      //await driver.tap(button);
      final text = find.text('Email');
      expect(await driver.getText(text), 'Email');
    });
  });
}
