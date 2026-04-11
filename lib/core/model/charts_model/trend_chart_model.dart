class TrendChartModel {
  List<String>? labels;
  List<int>? value;

  TrendChartModel({this.labels, this.value});

  // JSON se Model banane ke liye
  TrendChartModel.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    value = json['data'].cast<int>();
  }

  // Model se wapas JSON banane ke liye (Optional)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['labels'] = labels;
    data['data'] = value;
    return data;
  }
}
