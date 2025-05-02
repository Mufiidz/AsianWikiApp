import 'dart:math';

extension DoubleExt on double? {
  /// Mengonversi derajat ke radian, dengan membungkus nilai agar berada dalam rentang [0, 360) derajat.
  ///
  /// Jika nilai negatif, akan dikonversi ke nilai positif yang ekuivalen.
  /// Jika nilai bernilai `null`, maka akan dianggap `0.0`.
  /// Hasil konversi akan selalu menghasilkan sudut antara `0` dan `2π` radian.
  double get degreesToRadian {
    final double value = (this ?? 0.0) % 360;
    final double normalized = value < 0 ? value + 360 : value;
    return normalized * pi / 180;
  }
}
