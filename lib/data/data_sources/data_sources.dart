import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:scan_bonus_card_example/core/drift/tables.dart';
import 'package:scan_bonus_card_example/presentation/pages/transaction_history.dart';
import 'package:rxdart/rxdart.dart';

class DataSources {
  final AppDatabase _db;
  DataSources(this._db);

  Stream<List<CardWithBonus>> getListCard() {
    // Создаем Stream, который реагирует на изменения в обеих таблицах
    return Rx.combineLatest2(
      _db.select(_db.card).watch(),
      _db.select(_db.cardDetail).watch(),
      (List<CardData> cards, List<CardDetailData> _) => cards,
    ).asyncMap((cards) async {
      final cardIds = cards.map((c) => c.id).toList();
      final bonusMap = <int, int>{};

      if (cardIds.isNotEmpty) {
        final sumQuery = _db.selectOnly(_db.cardDetail)
          ..addColumns([_db.cardDetail.idCard, _db.cardDetail.bonus.sum()])
          ..where(_db.cardDetail.idCard.isIn(cardIds))
          ..groupBy([_db.cardDetail.idCard]);

        final results = await sumQuery.get();

        for (final row in results) {
          final cardId = row.read(_db.cardDetail.idCard);
          final totalBonus = row.read(_db.cardDetail.bonus.sum());
          if (cardId != null && totalBonus != null) {
            bonusMap[cardId] = totalBonus;
          }
        }
      }

      return [
        for (final card in cards)
          CardWithBonus(
            card: card,
            bonus: bonusMap[card.id] ?? 0,
          ),
      ];
    });
  }

  Future<void> addCard(CardCompanion card) async {
    await _db.into(_db.card).insert(
          CardCompanion(
            number: card.name,
            name: card.name,
            validPeriod: card.validPeriod,
          ),
        );
  }

  Stream<List<CardDetailWithBonus>> getListCardDetails() {
    return _db.select(_db.cardDetail).watch().asyncMap((cardDetails) async {
      final cardIds = cardDetails.map((cd) => cd.idCard).toSet().toList();
      final bonusMap = <int, int>{};

      if (cardIds.isNotEmpty) {
        // Create a selectOnly query for aggregation
        final sumQuery = _db.selectOnly(_db.cardDetail)
          ..addColumns([_db.cardDetail.idCard, _db.cardDetail.bonus.sum()])
          ..where(_db.cardDetail.idCard.isIn(cardIds))
          ..groupBy([_db.cardDetail.idCard]);

        final results = await sumQuery.get();

        // Convert results to a map of cardId -> totalBonus
        for (final row in results) {
          final cardId = row.read(_db.cardDetail.idCard);
          final totalBonus = row.read(_db.cardDetail.bonus.sum());
          if (cardId != null && totalBonus != null) {
            bonusMap[cardId] = totalBonus;
          }
        }
      }

      return [
        for (final cardDetail in cardDetails)
          CardDetailWithBonus(
            cardDetail: cardDetail,
            bonus: bonusMap[cardDetail.idCard] ?? 0,
          ),
      ];
    });
  }

  Future<void> addHistory(
    BonusCardAction action,
    CardDetailCompanion cardDetail,
  ) async {
    try {
      // Validate input
      if (cardDetail.idCard == const Value.absent()) {
        throw ArgumentError('Card ID must be provided');
      }
      if (cardDetail.bonus == const Value.absent()) {
        throw ArgumentError('Bonus points must be provided');
      }

      // Prepare the record to insert
      final recordToInsert = cardDetail.copyWith(
        bonus: action == BonusCardAction.subtract
            ? Value(cardDetail.bonus.value * -1)
            : cardDetail.bonus,
        dateOperation: cardDetail.dateOperation.present
            ? cardDetail.dateOperation
            : Value(DateTime.now()),
      );

      // Insert into database
      await _db.into(_db.cardDetail).insert(recordToInsert);
    } catch (e) {
      // Log the error and rethrow for UI handling
      log('Failed to add history: $e');
      rethrow;
    }
  }

  Future<List<Transaction>> getCardTransactions(int cardId) async {
    final query = _db.select(_db.cardDetail)
      ..where((tbl) => tbl.idCard.equals(cardId))
      ..orderBy([(t) => OrderingTerm.desc(t.dateOperation)]);

    final details = await query.get();
    return details
        .map((detail) => Transaction(
              id: detail.id,
              cardId: detail.idCard,
              points: detail.bonus.abs(),
              isAddition: detail.isAddBonus,
              date: detail.dateOperation,
            ))
        .toList();
  }
}

class CardWithBonus {
  final CardData card;
  final int bonus;

  CardWithBonus({
    required this.card,
    required this.bonus,
  });
}

class CardDetailWithBonus {
  final CardDetailData cardDetail;
  final int bonus;

  CardDetailWithBonus({
    required this.cardDetail,
    required this.bonus,
  });
}
