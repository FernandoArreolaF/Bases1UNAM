class Domicilio {
  int id_domicilio;
  String estado;
  String colonia;
  String calle;
  int numero;
  int cp;

  Domicilio({this.id_domicilio, this.estado, this.colonia, this.calle, this.cp, this.numero});

  Domicilio.fromJson(Map<String, dynamic> json) {
    this.id_domicilio = json['id_domicilio'];
    this.estado = json['estado'];
    this.colonia = json['colonia'];
    this.calle = json['calle'];
    this.numero = json['numero'];
    this.cp = json['cp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id_domicilio': this.id_domicilio,
      'estado': this.estado,
      'colonia': this.colonia,
      'calle': this.calle,
      'numero': this.numero,
      'cp': this.cp,
    };
  }
}