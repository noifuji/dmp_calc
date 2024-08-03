import 'package:flutter/foundation.dart';

const appFont = 'NotoSansJP-Regular';

const String MANA_COLOR_WHITE = "光";
const String MANA_COLOR_BLUE = "水";
const String MANA_COLOR_BLACK = "闇";
const String MANA_COLOR_RED = "火";
const String MANA_COLOR_GREEN = "自然";

const Map<String,String> COLOR_WHITE = { "name": "白単", "color": "光" };
const Map<String,String> COLOR_BLUE = { "name": "青単", "color": "水" };
const Map<String,String> COLOR_BLACK = { "name": "黒単", "color": "闇" };
const Map<String,String> COLOR_RED = { "name": "赤単", "color": "火" };
const Map<String,String> COLOR_GREEN = { "name": "緑単", "color": "自然" };

const Map<String,String> COLOR_WHITE_BLUE = { "name": "白青", "color": "光水" };
const Map<String,String> COLOR_BLUE_BLACK = { "name": "青黒", "color": "水闇" };
const Map<String,String> COLOR_BLACK_RED = { "name": "黒赤", "color": "闇火" };
const Map<String,String> COLOR_RED_GREEN = { "name": "赤緑", "color": "火自然" };
const Map<String,String> COLOR_WHITE_GREEN = { "name": "白緑", "color": "光自然" };

const Map<String,String> COLOR_WHITE_BLACK = { "name": "白黒", "color": "光闇" };
const Map<String,String> COLOR_BLUE_RED = { "name": "青赤", "color": "水火" };
const Map<String,String> COLOR_BLACK_GREEN = { "name": "黒緑", "color": "闇自然" };
const Map<String,String> COLOR_WHITE_RED = { "name": "白赤", "color": "光火" };
const Map<String,String> COLOR_BLUE_GREEN = { "name": "青緑", "color": "水自然" };

const Map<String,String> COLOR_TREVA = { "name": "トリーヴァ", "color": "光水自然" };
const Map<String,String> COLOR_DROMAR = { "name": "ドロマー", "color": "光水闇" };
const Map<String,String> COLOR_CROSIS = { "name": "クローシス", "color": "水闇火" };
const Map<String,String> COLOR_DARIGAAZ = { "name": "デアリ", "color": "闇火自然" };
const Map<String,String> COLOR_RITH = { "name": "リース", "color": "光火自然" };

const Map<String,String> COLOR_DEGAVOLVER = { "name": "デイガ", "color": "光闇火" };
const Map<String,String> COLOR_CETAVOLVER = { "name": "シータ", "color": "水火自然" };
const Map<String,String> COLOR_NECRAVOLVER = { "name": "ネクラ", "color": "光闇自然" };
const Map<String,String> COLOR_RAKAVOLVER = { "name": "ラッカ", "color": "光水火" };
const Map<String,String> COLOR_ANAVOLVER = { "name": "アナ", "color": "水闇自然" };

const Map<String,String> COLOR_4C_EXCEPT_WHITE = {
  "name": "白抜き4C",
  "color": "水闇火自然",
};
const Map<String,String> COLOR_4C_EXCEPT_BLUE = {
  "name": "青抜き4C",
  "color": "光闇火自然",
};
const Map<String,String> COLOR_4C_EXCEPT_BLACK = {
  "name": "黒抜き4C",
  "color": "光水火自然",
};
const Map<String,String> COLOR_4C_EXCEPT_RED = {
  "name": "赤抜き4C",
  "color": "光水闇自然",
};
const Map<String,String> COLOR_4C_EXCEPT_GREEN = {
  "name": "緑抜き4C",
  "color": "光水闇火",
};

const Map<String,String> COLOR_5C = { "name": "5C", "color": "光水闇火自然" };

const List<Map<String,String>> DECK_COLORS = [
  COLOR_WHITE,
  COLOR_BLUE,
  COLOR_BLACK,
  COLOR_RED,
  COLOR_GREEN,
  COLOR_WHITE_BLUE,
  COLOR_BLUE_BLACK,
  COLOR_BLACK_RED,
  COLOR_RED_GREEN,
  COLOR_WHITE_GREEN,
  COLOR_WHITE_BLACK,
  COLOR_BLUE_RED,
  COLOR_BLACK_GREEN,
  COLOR_WHITE_RED,
  COLOR_BLUE_GREEN,
  COLOR_TREVA,
  COLOR_DROMAR,
  COLOR_CROSIS,
  COLOR_DARIGAAZ,
  COLOR_RITH,
  COLOR_DEGAVOLVER,
  COLOR_CETAVOLVER,
  COLOR_NECRAVOLVER,
  COLOR_RAKAVOLVER,
  COLOR_ANAVOLVER,
  COLOR_4C_EXCEPT_WHITE,
  COLOR_4C_EXCEPT_BLUE,
  COLOR_4C_EXCEPT_BLACK,
  COLOR_4C_EXCEPT_RED,
  COLOR_4C_EXCEPT_GREEN,
  COLOR_5C,
];

const List<Map<String,String>> FINISHER_LIST = [
  { "id": "259200", "abbreviation": "エクス" },
  { "id": "190500", "abbreviation": "ゲート" },
  { "id": "181720", "abbreviation": "キリコ"},
  { "id": "181700", "abbreviation": "キリコ"},
  { "id": "239120", "abbreviation": "MRCロマノフ"},
  { "id": "239100", "abbreviation": "MRCロマノフ"},
  { "id": "60100", "abbreviation": "天門" },
  { "id": "93700", "abbreviation": "ゲート" },
  { "id": "41820", "abbreviation": "カチュア" },
  { "id": "41800", "abbreviation": "カチュア" },
  { "id": "106300", "abbreviation": "ゲオルグ" },
  { "id": "85100", "abbreviation": "サファイア" },
  { "id": "95120", "abbreviation": "ドラゲリオン" },
  { "id": "95100", "abbreviation": "ドラゲリオン" },
  { "id": "93400", "abbreviation": "グール" },
  { "id": "103800", "abbreviation": "ボルガウル" },
  { "id": "81700", "abbreviation": "ツヴァイ" },
  { "id": "106000", "abbreviation": "ゲキメツ" },
  { "id": "66800", "abbreviation": "メイデン" },
  { "id": "83420", "abbreviation": "ドルバロム" },
  { "id": "83400", "abbreviation": "ドルバロム" },
  { "id": "81800", "abbreviation": "テクノロジー" },
  { "id": "106900", "abbreviation": "外道" },
  { "id": "77100", "abbreviation": "ナーガ" },
  { "id": "77220", "abbreviation": "フェニックス" },
  { "id": "77200", "abbreviation": "フェニックス" },
  { "id": "66500", "abbreviation": "アウゼス" },
  { "id": "80020", "abbreviation": "アルファ" },
  { "id": "80000", "abbreviation": "アルファ" },
  { "id": "54800", "abbreviation": "ブリザード" },
  { "id": "77400", "abbreviation": "ペガサス" },
];

const double GOLD_PER_PACK = 150;
const double DMP_PER_PACK = 212.59;
const double DMP_PER_BUILDER = 3480;
const double DMP_PER_SUPERDECK = 5930;
const double DMP_PER_SR_TICKET = 677;
const double DMP_PER_LEG_CARD = 800;
const double DMP_PER_VIC_CARD = 800;
const double DMP_PER_SR_CARD = 600;
const double DMP_PER_VR_CARD = 200;
const double DMP_PER_R_CARD = 70;
const double DMP_PER_UC_CARD = 20;
const double DMP_PER_C_CARD = 10;
const double DMP_PER_PREMIUM_SR_CARD = 1700;
const double DMP_PER_PREMIUM_VR_CARD = 550;
const double DMP_PER_PREMIUM_R_CARD = 200;
const double DMP_PER_PREMIUM_UC_CARD = 60;
const double DMP_PER_PREMIUM_C_CARD = 30;

const String accountAssetGold = 'ゴールド';
const String accountAssetDmp = 'DMポイント';
const String accountAssetPacks = '総パック数';
const String accountAssetSRPacks = '総SRパック数';
const String accountAssetLEGCards = 'LEGカード枚数';
const String accountAssetVICCards = 'VICカード枚数';
const String accountAssetSRCards = 'SRカード枚数';
const String accountAssetVRCards = 'VRカード枚数';
const String accountAssetRCards = 'Rカード枚数';
const String accountAssetUCCards = 'UCカード枚数';
const String accountAssetCCards = 'Cカード枚数';
const String accountAssetBuilderTicket = 'ビルダーチケット';
const String accountAssetSuperDeckTicket = 'スーパーデッキチケット';
const List<String> accountAssetNames = [
  accountAssetGold,
  accountAssetDmp,
  accountAssetPacks,
  accountAssetSRPacks,
  accountAssetLEGCards,
  accountAssetVICCards,
  accountAssetSRCards,
  accountAssetVRCards,
  accountAssetRCards,
  accountAssetUCCards,
  accountAssetCCards,
  accountAssetBuilderTicket,
  accountAssetSuperDeckTicket,
];

const Map<String, double> accountAssetsInDmp = {
  accountAssetGold: DMP_PER_PACK/GOLD_PER_PACK,
  accountAssetDmp: 1.0,
  accountAssetPacks: DMP_PER_PACK,
  accountAssetSRPacks: DMP_PER_SR_TICKET,
  accountAssetLEGCards: DMP_PER_LEG_CARD,
  accountAssetVICCards: DMP_PER_VIC_CARD,
  accountAssetSRCards: DMP_PER_SR_CARD,
  accountAssetVRCards: DMP_PER_VR_CARD,
  accountAssetRCards: DMP_PER_R_CARD,
  accountAssetUCCards: DMP_PER_UC_CARD,
  accountAssetCCards: DMP_PER_C_CARD,
  accountAssetBuilderTicket: DMP_PER_BUILDER,
  accountAssetSuperDeckTicket: DMP_PER_SUPERDECK
};


const String cardMasterUrl = kDebugMode ? 'https://s3.ap-northeast-1.amazonaws.com/dmp-game-charge-calculator-staging/CardMaster.csv':'https://dmpcalc.ezway.link/CardMaster.csv';
const String psychicRelationUrl = kDebugMode ? 'https://s3.ap-northeast-1.amazonaws.com/dmp-game-charge-calculator-staging/PsychicRelation.csv':'https://dmpcalc.ezway.link/PsychicRelation.csv';