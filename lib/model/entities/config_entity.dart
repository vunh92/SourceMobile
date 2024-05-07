abstract class ConfigEntity {
  ConfigEntity({
    this.distance = 100,
    this.hotZonePicture = '',
    this.outletPicture = '',
    this.outletHotZoneCheck = 0,
    this.outletStockCountCheck = 0,
  });

  int? distance;
  String? hotZonePicture;
  String? outletPicture;
  int? outletHotZoneCheck;
  int? outletStockCountCheck;
}
