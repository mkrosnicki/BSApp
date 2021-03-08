import 'package:BSApp/mappers/deal_type_mapper.dart';
import 'package:BSApp/models/deal_model.dart';

class DealMapper {
  static DealModel of(dynamic dealObject) {
    return DealModel(
        id: dealObject['id'],
        title: dealObject['title'],
        description: dealObject['description'],
        link: dealObject['link'],
        dealType: DealTypeMapper.of(dealObject['dealType']),
        category: dealObject['category']['name'],
        locationType: dealObject['locationType'],
        voivodeship: dealObject['voivodeship'],
        city: dealObject['city'],
        locationDescription: dealObject['locationDescription'],
        currentPrice: dealObject['currentPrice'],
        regularPrice: dealObject['regularPrice'],
        shippingPrice: dealObject['shippingPrice'],
        startDate: DateTime.parse(dealObject['startDate']),
        endDate: DateTime.parse(dealObject['endDate']),
        numberOfComments: dealObject['numberOfComments'],
        points: dealObject['points']);
  }
}
