
import '../../model/card_specs.dart';

abstract class CardSpecsRepository {
  Future<CardSpecs> getOne(String cardId);
  Future<List<CardSpecs>> getList(List<String> cardIds);
  Future<List<CardSpecs>> getAll();
}