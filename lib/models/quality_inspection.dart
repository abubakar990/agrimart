class QualityInspection {
  int inspectorID;
  int cropID;
  String inspectorName;
  DateTime inspectionDate;
  var inspectionResult;
  QualityInspection({
    required this.inspectorID,
    required this.cropID,
    required this.inspectorName,
    required this.inspectionDate,
    required this.inspectionResult
  });
}