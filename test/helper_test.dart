import 'package:flutter_batch_9_project/helpers/helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("Testing function formatRupiah()", () {
    test("Test positive value: input 10000 should be Rp 10.000", () {
      final result = formatRupiah(10000);
      expect(result, "Rp 10.000");
    });

    test("Test negative value: input -10000 should be (Rp 10.000)", () {
      final result = formatRupiah(-10000);
      expect(result, "(Rp 10.000)");
    });

    test("Test null value: input null should be Rp 0", () {
      final result = formatRupiah(null);
      expect(result, "Rp 0");
    });

    test("Test null value: input 0 should be Rp 0", () {
      final result = formatRupiah(0);
      expect(result, "Rp 0");
    });
  });

}