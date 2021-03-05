// To parse this JSON data, do
//
//     final dataRequestAntar = dataRequestAntarFromJson(jsonString);

import 'dart:convert';

import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';

DataRequestAntarModel dataRequestAntarFromJson(String str) => DataRequestAntarModel.fromJson(json.decode(str));

String dataRequestAntarToJson(DataRequestAntarModel data) => json.encode(data.toJson());

class DataRequestAntarModel {
  DataRequestAntarModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataRequestAntar> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory DataRequestAntarModel.fromJson(Map<String, dynamic> json) => DataRequestAntarModel(
    data: json["data"] == null ? null : List<DataRequestAntar>.from(json["data"].map((x) => DataRequestAntar.fromJson(x))),
    draw: json["draw"],
    recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
    recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
    limit: json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "draw": draw,
    "recordsTotal": recordsTotal == null ? null : recordsTotal,
    "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
    "limit": limit,
    "offset": offset == null ? null : offset,
  };
}

class DataRequestAntar {
  DataRequestAntar({
    this.idCabang,
    this.kode,
    this.idAntar,
    this.idTransaksi,
    this.idKonsumen,
    this.idKurir,
    this.status,
    this.statusPersetujuanKurir,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.namaCabang,
    this.namaKonsumen,
    this.namaKurir,
    this.createdDate,
    this.konsumen,
    this.kurir,
    this.laundry,
  });

  int idCabang;
  String kode;
  int idAntar;
  int idTransaksi;
  int idKonsumen;
  int idKurir;
  String status;
  String statusPersetujuanKurir;
  double latitude;
  double longitude;
  DateTime createdAt;
  DateTime updatedAt;
  String namaCabang;
  String namaKonsumen;
  String namaKurir;
  String createdDate;
  Konsumen konsumen;
  Kurir kurir;
  Laundry laundry;

  factory DataRequestAntar.fromJson(Map<String, dynamic> json) => DataRequestAntar(
    idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
    kode: json["kode"] == null ? null : json["kode"],
    idAntar: json["id_antar"] == null ? null : json["id_antar"],
    idTransaksi: json["id_transaksi"] == null ? null : json["id_transaksi"],
    idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
    idKurir: json["id_kurir"] == null ? null : json["id_kurir"],
    status: json["status"] == null ? null : json["status"],
    statusPersetujuanKurir: json["status_persetujuan_kurir"] == null ? null : json["status_persetujuan_kurir"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
    namaKonsumen: json["nama_konsumen"] == null ? null : json["nama_konsumen"],
    namaKurir: json["nama_kurir"] == null ? null : json["nama_kurir"],
    createdDate: json["created_date"] == null ? null : json["created_date"],
    konsumen: json["konsumen"] == null ? null : Konsumen.fromJson(json["konsumen"]),
    kurir: json["kurir"] == null ? null : Kurir.fromJson(json["kurir"]),
    laundry: json["laundry"] == null ? null : Laundry.fromJson(json["laundry"]),
  );

  Map<String, dynamic> toJson() => {
    "id_cabang": idCabang == null ? null : idCabang,
    "kode": kode == null ? null : kode,
    "id_antar": idAntar == null ? null : idAntar,
    "id_transaksi": idTransaksi == null ? null : idTransaksi,
    "id_konsumen": idKonsumen == null ? null : idKonsumen,
    "id_kurir": idKurir == null ? null : idKurir,
    "status": status == null ? null : status,
    "status_persetujuan_kurir": statusPersetujuanKurir == null ? null : statusPersetujuanKurir,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "nama_cabang": namaCabang == null ? null : namaCabang,
    "nama_konsumen": namaKonsumen == null ? null : namaKonsumen,
    "nama_kurir": namaKurir == null ? null : namaKurir,
    "created_date": createdDate == null ? null : createdDate,
    "konsumen": konsumen == null ? null : konsumen.toJson(),
    "kurir": kurir == null ? null : kurir.toJson(),
    "laundry": laundry == null ? null : laundry.toJson(),
  };
}

class Laundry {
  Laundry({
    this.idTransaksi,
    this.idCabang,
    this.idKonsumen,
    this.kodeTransaksi,
    this.pakaiKuota,
    this.parfum,
    this.catatan,
    this.luntur,
    this.tasKantong,
    this.bayarKuota,
    this.totalTagihan,
    this.statusTagihan,
    this.metodePembayaran,
    this.jumlahBayar,
    this.sisaTagihan,
    this.diskon,
    this.kembalian,
    this.kuotaCuciUsed,
    this.kuotaSetrikaUsed,
    this.photo,
    this.statusLaundry,
    this.statusPengambilan,
    this.catatanComplaint,
    this.catatanCancel,
    this.catatanReceive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.tanggalPengambilan,
    this.statusPersetujuan,
    this.cabang,
  });

  int idTransaksi;
  int idCabang;
  int idKonsumen;
  String kodeTransaksi;
  String pakaiKuota;
  String parfum;
  dynamic catatan;
  String luntur;
  String tasKantong;
  int bayarKuota;
  String totalTagihan;
  String statusTagihan;
  String metodePembayaran;
  String jumlahBayar;
  String sisaTagihan;
  String diskon;
  int kembalian;
  String kuotaCuciUsed;
  String kuotaSetrikaUsed;
  dynamic photo;
  String statusLaundry;
  String statusPengambilan;
  dynamic catatanComplaint;
  dynamic catatanCancel;
  dynamic catatanReceive;
  String createdBy;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic tanggalPengambilan;
  dynamic statusPersetujuan;
  Cabang cabang;

  factory Laundry.fromJson(Map<String, dynamic> json) => Laundry(
    idTransaksi: json["id_transaksi"] == null ? null : json["id_transaksi"],
    idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
    idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
    kodeTransaksi: json["kode_transaksi"] == null ? null : json["kode_transaksi"],
    pakaiKuota: json["pakai_kuota"] == null ? null : json["pakai_kuota"],
    parfum: json["parfum"] == null ? null : json["parfum"],
    catatan: json["catatan"],
    luntur: json["luntur"] == null ? null : json["luntur"],
    tasKantong: json["tas_kantong"] == null ? null : json["tas_kantong"],
    bayarKuota: json["bayar_kuota"] == null ? null : json["bayar_kuota"],
    totalTagihan: json["total_tagihan"] == null ? null : json["total_tagihan"],
    statusTagihan: json["status_tagihan"] == null ? null : json["status_tagihan"],
    metodePembayaran: json["metode_pembayaran"] == null ? null : json["metode_pembayaran"],
    jumlahBayar: json["jumlah_bayar"] == null ? null : json["jumlah_bayar"],
    sisaTagihan: json["sisa_tagihan"] == null ? null : json["sisa_tagihan"],
    diskon: json["diskon"] == null ? null : json["diskon"],
    kembalian: json["kembalian"] == null ? null : json["kembalian"],
    kuotaCuciUsed: json["kuota_cuci_used"] == null ? null : json["kuota_cuci_used"],
    kuotaSetrikaUsed: json["kuota_setrika_used"] == null ? null : json["kuota_setrika_used"],
    photo: json["photo"],
    statusLaundry: json["status_laundry"] == null ? null : json["status_laundry"],
    statusPengambilan: json["status_pengambilan"] == null ? null : json["status_pengambilan"],
    catatanComplaint: json["catatan_complaint"],
    catatanCancel: json["catatan_cancel"],
    catatanReceive: json["catatan_receive"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    tanggalPengambilan: json["tanggal_pengambilan"],
    statusPersetujuan: json["status_persetujuan"],
    cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
  );

  Map<String, dynamic> toJson() => {
    "id_transaksi": idTransaksi == null ? null : idTransaksi,
    "id_cabang": idCabang == null ? null : idCabang,
    "id_konsumen": idKonsumen == null ? null : idKonsumen,
    "kode_transaksi": kodeTransaksi == null ? null : kodeTransaksi,
    "pakai_kuota": pakaiKuota == null ? null : pakaiKuota,
    "parfum": parfum == null ? null : parfum,
    "catatan": catatan,
    "luntur": luntur == null ? null : luntur,
    "tas_kantong": tasKantong == null ? null : tasKantong,
    "bayar_kuota": bayarKuota == null ? null : bayarKuota,
    "total_tagihan": totalTagihan == null ? null : totalTagihan,
    "status_tagihan": statusTagihan == null ? null : statusTagihan,
    "metode_pembayaran": metodePembayaran == null ? null : metodePembayaran,
    "jumlah_bayar": jumlahBayar == null ? null : jumlahBayar,
    "sisa_tagihan": sisaTagihan == null ? null : sisaTagihan,
    "diskon": diskon == null ? null : diskon,
    "kembalian": kembalian == null ? null : kembalian,
    "kuota_cuci_used": kuotaCuciUsed == null ? null : kuotaCuciUsed,
    "kuota_setrika_used": kuotaSetrikaUsed == null ? null : kuotaSetrikaUsed,
    "photo": photo,
    "status_laundry": statusLaundry == null ? null : statusLaundry,
    "status_pengambilan": statusPengambilan == null ? null : statusPengambilan,
    "catatan_complaint": catatanComplaint,
    "catatan_cancel": catatanCancel,
    "catatan_receive": catatanReceive,
    "created_by": createdBy == null ? null : createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "tanggal_pengambilan": tanggalPengambilan,
    "status_persetujuan": statusPersetujuan,
    "cabang": cabang == null ? null : cabang.toJson(),
  };
}
