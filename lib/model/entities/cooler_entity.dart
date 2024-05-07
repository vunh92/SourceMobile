abstract class CoolerEntity {
  CoolerEntity({
    this.id = 0,
    this.outletId = 0,
    this.name = '',
    this.serialNumber = '',
    this.planogramPicture = '',
    this.note = '',
    this.status = 1,
  });

  int? id;
  int? outletId;
  String? name;
  String? serialNumber;
  String? planogramPicture;
  String? note;
  int? status;
}
