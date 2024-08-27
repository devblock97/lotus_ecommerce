import 'dart:convert';
import 'dart:isolate';

import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/data/models/province.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ShipmentLocalDataSource {
  Future<List<Province>> getProvinces() => throw UnimplementedError('Stub');
  Future<List<City>> getCities(String parentCode) => throw UnimplementedError('Stub');
  Future<List<City>> getWards(String parentCode) => throw UnimplementedError('Stub');
}

class ShipmentLocalDataSourceImpl implements ShipmentLocalDataSource {

  final SharedPreferences pref;
  ShipmentLocalDataSourceImpl(this.pref);

  @override
  Future<List<Province>> getProvinces() async {
    List<Province> provinces = [];
    final String response = await rootBundle.loadString('assets/data/tinh_tp.json');
    // final data = jsonDecode(response) as Map<String, dynamic>;
    // for (final p in data.entries) {
    //   final province = Province.fromJson(p.value);
    //   provinces.add(province);
    // }
    final List<Province> province = await Isolate.run(() {
      final data = jsonDecode(response) as Map<String, dynamic>;
      return data.entries.map((e) => Province.fromJson(e.value)).toList();
    });
    return province;
  }

  @override
  Future<List<City>> getCities(String parentCode) async {
    // https://medium.com/@nimafarzin-pr/concurrency-and-isolates-in-flutter-and-dart-81d6a36932e8
    List<City> cities = [];
    final String response = await rootBundle.loadString('assets/data/quan_huyen.json');
    final List<City> city = await Isolate.run(() {
      final data = jsonDecode(response) as Map<String, dynamic>;
      try {
        for (final c in data.entries) {
          final city = City.fromJson(c.value);
          if (city.parentCode.compareTo(parentCode) == 0) {
            cities.add(city);
          }
        }
      } catch (e) {
        print('error: ${e.toString()}');
      }
      return cities;
    });
    return city;
  }

  @override
  Future<List<City>> getWards(String parentCode) async {
    List<City> wardsList = [];
    final String response = await rootBundle.loadString('assets/data/xa_phuong.json');
    final List<City> wards = await Isolate.run(() {
      final data = jsonDecode(response) as Map<String, dynamic>;
      // return data.entries.where((e) => City.fromJson(e.value).parentCode == parentCode).toList() as List<City>;
      // data.entries.map((ward) {
      //     final w = City.fromJson(ward.value);
      //     if (w.parentCode.compareTo(parentCode) == 0) {
      //       print(w);
      //       wardsList.add(w);
      //     }
      //   });
      for (final item in data.entries) {
        final w = City.fromJson(item.value);
        if (w.parentCode == parentCode) {
          wardsList.add(w);
        }
      }
      return wardsList;
    });
    print('wards list length: ${wards.length}');
    return wards;
  }

}