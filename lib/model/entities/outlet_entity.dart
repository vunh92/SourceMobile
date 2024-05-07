abstract class OutletEntity {
  OutletEntity({
    this.id = 0,
    this.code = '',
    this.name = '',
    this.nameNormalize = '',
    this.phone = '',
    this.lat = 0.0,
    this.long = 0.0,
    this.location1 = '',
    this.location2 = '',
    this.location3 = '',
    this.location4 = '',
    this.hotZonePicture = '',
    this.outletPicture = '',
    this.note = '',
    this.status = 1,
    this.checkInDate,
    this.checkInTime = '',
    this.checkInId = '',
    this.checkOutDate,
    this.checkOutTime = '',
    this.currentStatus = '',
    this.coolerStatus = '',
    this.countCheckoutSuccess=0,
    this.surveyId=0,
    this.checkOutStatus=0,

  });

  int? id;
  String? code;
  String? name;
  String? nameNormalize;
  String? phone;
  double? lat;
  double? long;
  String? location1;
  String? location2;
  String? location3;
  String? location4;
  String? hotZonePicture;
  String? outletPicture;
  String? note;
  int? status;
  DateTime? checkInDate;
  String? checkInTime;
  String? currentStatus;
  String? coolerStatus;
  String? checkInId;
  DateTime? checkOutDate;
  String? checkOutTime;
  int? countCheckoutSuccess;
  int? surveyId;
  int? checkOutStatus;
}
