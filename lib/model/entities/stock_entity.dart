abstract class StockEntity {
  StockEntity({
    this.stockId = 0,
    this.stockCode = '',
    this.stockName = '',
    this.coolerId = 0,
    this.face = 0,
    this.layer = 0,
    this.total = 0,
    this.stockPicture = '',
  });

  int? stockId;
  String? stockCode;
  String? stockName;
  int? coolerId;
  int? face;
  int? layer;
  int? total;
  String? stockPicture;
}
