class SqliteHelper {
  static const String tableOutletDetail = 'OutletDetails';
  static const String tableStock = 'Stocks';
  static const String tableStockCount = 'StockCounts';
  static const String tableScan = 'Scans';
  static const String tableHotZone = 'HotZones';
  static const String tableQuestion = 'Questions';
  static const String tableMaintenance = 'Maintenances';


  ///Outlet Detail
  static const String createOutletDetailTable = 'CREATE TABLE $tableOutletDetail ('
      'uuid TEXT, '
      'code TEXT, '
      'outletId INTEGER, '
      'deviceId TEXT, '
      'routeCode TEXT, '
      'outletCode TEXT, '
      'coolerCode TEXT, '
      'checkInDate DATETIME, '
      'checkInTime TEXT, '
      'checkInId TEXT, '
      'checkOutDate DATETIME, '
      'completedTime DATETIME, '
      'visitDate DATETIME, '
      'checkOutTime TEXT, '
      'currentStatus TEXT '
      ')';
  static String getOutletDetail({
    required int outletId,
  }) => 'SELECT * FROM $tableOutletDetail WHERE outletId = $outletId LIMIT 1';


  ///StockCount
  static const String createStockCountTable = 'CREATE TABLE $tableStockCount ('
      'uuid TEXT, '
      'outletId INTEGER, '
      'questionId INTEGER, '
      'questionName TEXT, '
      'completedTime DATETIME, '
      'visitDate DATETIME '
      ')';


  ///Stock
  static const String createStockTable = 'CREATE TABLE $tableStock ('
      'uuid TEXT, '
      'stockCountId TEXT, '
      'questionId INTEGER, '
      'questionName TEXT, '
      'outletId INTEGER, '
      'stockId INTEGER, '
      'stockCode TEXT, '
      'stockName TEXT, '
      'coolerId INTEGER, '
      'face INTEGER, '
      'layer INTEGER, '
      'total INTEGER, '
      'faceInput INTEGER, '
      'totalInput INTEGER, '
      'stockPicture TEXT '
      ')';
  static String getStock({
    required int outletId,
    required int coolerId,
  }) => 'SELECT * FROM $tableStock WHERE outletId = $outletId AND coolerId = $coolerId ;';


  ///Scan
  static const String createScanTable = 'CREATE TABLE $tableScan ('
      'uuid TEXT PRIMARY KEY, '
      'id INTEGER, '
      'coolerId INTEGER, '
      'outletId INTEGER, '
      'name TEXT, '
      'serialNumber TEXT, '
      'planogramPicture TEXT, '
      'note TEXT, '
      'status INTEGER, '
      'isScan BIT, '
      'assetStatus INTEGER, '
      'scanCode TEXT, '
      'completedTime DATETIME, '
      'visitDate DATETIME '
      ')';
  static String getScan({
    required int outletId,
  }) => 'SELECT * FROM $tableScan WHERE outletId = $outletId LIMIT 1;';


  ///HotZone
  static const String createHotZoneTable = 'CREATE TABLE $tableHotZone ('
      'uuid TEXT, '
      'outletId INTEGER, '
      'hotZonePicture TEXT, '
      'planogramPicture TEXT, '
      'hotZonePictureLocal TEXT, '
      'planogramPictureLocal TEXT, '
      'completedTime DATETIME, '
      'visitDate DATETIME '
      ')';
  static String getHotZone({
    required int outletId,
  }) => 'SELECT * FROM $tableHotZone WHERE outletId = $outletId LIMIT 1 ;';


  ///Question
  static const String createQuestionTable = 'CREATE TABLE $tableQuestion ('
      'uuid TEXT, '
      'hotZoneId TEXT, '
      'outletId INTEGER, '
      'surveyId INTEGER, '
      'answer1 TEXT, '
      'answer2 TEXT, '
      'answer3 TEXT, '
      'answer4 TEXT, '
      'answerType INTEGER, '
      'isAnswer1Input BIT, '
      'isAnswer2Input BIT, '
      'isAnswer3Input BIT, '
      'isAnswer4Input BIT, '
      'questionId INTEGER, '
      'questionName TEXT, '
      'answerInput1 TEXT, '
      'answerInput2 TEXT, '
      'answerInput3 TEXT, '
      'answerInput4 TEXT, '
      'answerText TEXT, '
      'displayOrder INTEGER, '
      'status INTEGER '
      ')';
  static String getQuestion({
    required int outletId,
  }) => 'SELECT * FROM $tableQuestion WHERE outletId = $outletId ;';



  ///Maintenance
  static const String createMaintenanceTable = 'CREATE TABLE $tableMaintenance ('
      'uuid TEXT, '
      'outletId INTEGER, '
      'maintenancePicture1 TEXT, '
      'maintenancePicture2 TEXT, '
      'maintenancePicture3 TEXT, '
      'maintenancePicture1Local TEXT, '
      'maintenancePicture2Local TEXT, '
      'maintenancePicture3Local TEXT, '
      'description TEXT, '
      'completedTime DATETIME, '
      'visitDate DATETIME '
      ')';
  static String getMaintenance({
    required int outletId,
  }) => 'SELECT * FROM $tableMaintenance WHERE outletId = $outletId LIMIT 1 ;';


}