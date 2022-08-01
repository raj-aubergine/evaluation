class Templates {
  String? id;
  String? templateName;
  String? token;
  List<FormControls>? formControls;

  Templates({this.id, this.templateName, this.token, this.formControls});

  Templates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    templateName = json['templateName'];
    token = json['token'];
    if (json['formControls'] != null) {
      formControls = <FormControls>[];
      json['formControls'].forEach((v) {
        formControls!.add(new FormControls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['templateName'] = this.templateName;
    data['token'] = this.token;
    if (this.formControls != null) {
      data['formControls'] = this.formControls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormControls {
  String? type;
  String? label;
  String? placeholder;
  bool? required;
  List<String>? dropdownOptions;

  FormControls(
      {this.type,
      this.label,
      this.placeholder,
      this.required,
      this.dropdownOptions});

  FormControls.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    placeholder = json['placeholder'];
    required = json['required'];

    if (json['dropdownOptions'] != null) {
      dropdownOptions = <String>[];
      json['dropdownOptions'].forEach((v) {
        dropdownOptions!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['label'] = this.label;
    data['placeholder'] = this.placeholder;
    data['required'] = this.required;
    data['dropdownOptions'] = this.dropdownOptions;
    return data;
  }
}
