/// Enum for the types of product care. There is some abbreviations
/// and they mean:
///
/// MWT: Machine Wash Temperature
/// MWC: Machine Wash Cycle
/// MWS: Machine Wash Special
/// DRT: Dryer Temperature
/// DRC: Dryer Cycle
/// DRS: Dryer Special
/// IRT: Iron Temperature
/// IRS: Iron Special
/// BL: Bleach
/// DY: Dry
/// DYC: Dry Clean
///
enum ProductCareType {
  /// Machine Wash Temperature Cold from 0 to 2
  MWT_COLD,
  MWT_WARM,
  MWT_HOT,

  /// MWC: Machine Wash Cycle Normal  from 3 to 5
  MWC_NORMAL,
  MWC_DELICATE,
  MWC_PERMANENT_PRESS,

  /// MWS: Machine Wash Special from 6 to 7
  MWS_HAND_WASH,
  MWS_DO_NOT_WASH,

  /// DRT Dryer Temperature from 8 to 10
  DRT_LOW,
  DRT_MEDIUM,
  DRT_HIGH,

  /// DRC: Dryer Cycle from 11 to 13
  DRC_NORMAL,
  DRC_PERMANENT_PRESS,
  DRC_DELICATE,

  /// DRS: Dryer Special only 14
  DRS_DO_NOT_DRY_IN_DRYER,

  /// IRT: Iron Temperature from 15 to 17
  IRT_LOW,
  IRT_MEDIUM,
  IRT_HIGH,

  /// IRS: Iron Special from 18 to 20
  IRS_DO_NOT_IRON_STEAM,
  IRS_DO_NOT_IRON,
  IRS_IRON_STREAM,

  /// BL: Bleach from 21 to 23
  BL_DO_NOT_BLEACH,
  BL_NON_CHLORINE_BLEACH,
  BL_BLEACH_WHEN_NEEDED,

  /// DY: Dry from 24 to 26
  DY_FLAT,
  DY_DO_NOT_WRING,
  DY_HANG,

  /// DYC: Dry Clean from 27 to 28
  DYC_DRY_CLEAN,
  DYC_DO_NOT_DRY_CLEAN
}

const Map<ProductCareType, String> _careIconsMap = {

  ProductCareType.MWT_HOT : "assets/svg/Icons/care_icons/maschine_wash_temp_hot.svg",
  ProductCareType.MWT_COLD: "assets/svg/Icons/care_icons/maschine_wash_temp_cold.svg",
  ProductCareType.MWT_WARM: "assets/svg/Icons/care_icons/maschine_wash_temp_warm.svg",

  ProductCareType.MWC_NORMAL: "assets/svg/Icons/care_icons/maschine_wash_cycle_normal.svg",
  ProductCareType.MWC_DELICATE: "assets/svg/Icons/care_icons/maschine_wash_cycle_delicate.svg",
  ProductCareType.MWC_PERMANENT_PRESS: "assets/svg/Icons/care_icons/maschine_wash_cycle_permanent_press.svg",

  ProductCareType.MWS_DO_NOT_WASH: "assets/svg/Icons/care_icons/maschine_wash_special_do_not_wash.svg",
  ProductCareType.MWS_HAND_WASH :"assets/svg/Icons/care_icons/maschine_wash_special_handwash.svg",

  ProductCareType.DRT_HIGH: "assets/svg/Icons/care_icons/dryer_temp_high.svg",
  ProductCareType.DRT_MEDIUM: "assets/svg/Icons/care_icons/dryer_temp_medium.svg",
  ProductCareType.DRT_LOW: "assets/svg/Icons/care_icons/dryer_temp_low.svg",

  ProductCareType.DRC_DELICATE: "assets/svg/Icons/care_icons/dryer_delicate.svg",
  ProductCareType.DRC_NORMAL: "assets/svg/Icons/care_icons/dryer_normal.svg",
  ProductCareType.DRC_PERMANENT_PRESS: "assets/svg/Icons/care_icons/dryer_permanent_press.svg",

  ProductCareType.DRS_DO_NOT_DRY_IN_DRYER : "assets/svg/Icons/care_icons/dryer_do_not_dry_in_a_dryer.svg",

  ProductCareType.IRT_HIGH :  "assets/svg/Icons/care_icons/iron_temp_high.svg",
  ProductCareType.IRT_MEDIUM : 'assets/svg/Icons/care_icons/iron_temp_medium.svg',
  ProductCareType.IRT_LOW: 'assets/svg/Icons/care_icons/iron_temp_low.svg',
  ProductCareType.IRS_DO_NOT_IRON : 'assets/svg/Icons/care_icons/iron_do_not_iron.svg',
  ProductCareType.IRS_DO_NOT_IRON_STEAM: 'assets/svg/Icons/care_icons/iron_do_not_iron_steam.svg',
  ProductCareType.IRS_IRON_STREAM: 'assets/svg/Icons/care_icons/iron_iron_steam.svg',

  ProductCareType.BL_DO_NOT_BLEACH: 'assets/svg/Icons/care_icons/bleach_do_not_bleach.svg',
  ProductCareType.BL_BLEACH_WHEN_NEEDED :'assets/svg/Icons/care_icons/bleach_when_needed.svg',
  ProductCareType.BL_NON_CHLORINE_BLEACH: 'assets/svg/Icons/care_icons/bleach_do_not_bleach.svg',

  ProductCareType.DY_FLAT: 'assets/svg/Icons/care_icons/dry_dry_flat.svg',
  ProductCareType.DY_DO_NOT_WRING: 'assets/svg/Icons/care_icons/dry_do_not_wring.svg',
  ProductCareType.DY_HANG: 'assets/svg/Icons/care_icons/dry_hang_dry.svg',

  ProductCareType.DYC_DO_NOT_DRY_CLEAN: 'assets/svg/Icons/care_icons/dry_clean_do_not_dry_clean.svg',
  ProductCareType.DYC_DRY_CLEAN: 'assets/svg/Icons/care_icons/dry_clean_dry_clean.svg',

};

const Map<ProductCareType, String> _careTypeTitleMap = {
  ProductCareType.MWT_HOT : "Hot",
  ProductCareType.MWT_COLD: "Cold",
  ProductCareType.MWT_WARM: "Warm",

  ProductCareType.MWC_NORMAL: "Normal",
  ProductCareType.MWC_DELICATE: "Delicate",
  ProductCareType.MWC_PERMANENT_PRESS: "Permanent press",

  ProductCareType.MWS_DO_NOT_WASH: "Do not wash",
  ProductCareType.MWS_HAND_WASH :"Hand wash",

  ProductCareType.DRT_HIGH: "High",
  ProductCareType.DRT_MEDIUM: "Medium",
  ProductCareType.DRT_LOW: "Low",

  ProductCareType.DRC_DELICATE: "Delicate",
  ProductCareType.DRC_NORMAL: "Normal",
  ProductCareType.DRC_PERMANENT_PRESS: "Permanent press",

  ProductCareType.DRS_DO_NOT_DRY_IN_DRYER : 'Do not dry in a dryer',

  ProductCareType.IRT_HIGH :  "High",
  ProductCareType.IRT_MEDIUM : 'Medium',
  ProductCareType.IRT_LOW: 'Low',
  ProductCareType.IRS_DO_NOT_IRON : 'Do not iron',
  ProductCareType.IRS_DO_NOT_IRON_STEAM: 'Do not iron steam',
  ProductCareType.IRS_IRON_STREAM: 'Iron steam',

  ProductCareType.BL_DO_NOT_BLEACH: 'Do not bleach',
  ProductCareType.BL_BLEACH_WHEN_NEEDED :'Bleach when needed',
  ProductCareType.BL_NON_CHLORINE_BLEACH: 'Non chlorine bleach',

  ProductCareType.DY_FLAT: 'Dry flat',
  ProductCareType.DY_DO_NOT_WRING: 'Do not wring',
  ProductCareType.DY_HANG: 'Dry hang',

  ProductCareType.DYC_DO_NOT_DRY_CLEAN: 'Do not dry clean',
  ProductCareType.DYC_DRY_CLEAN: 'Dry clean',

};

enum ProductCareCategory {
  MACHINE_WASH, DRYER, IRON,
  BLEACH, DRY, DRY_CLEAN
}

const Map<ProductCareCategory, String> _careCategoryMap = {
  ProductCareCategory.MACHINE_WASH : 'assets/svg/Icons/care_icons/maschine_wash.svg',
  ProductCareCategory.DRYER: 'assets/svg/Icons/care_icons/dryer.svg',
  ProductCareCategory.DRY: 'assets/svg/Icons/care_icons/dry.svg',
  ProductCareCategory.IRON: 'assets/svg/Icons/care_icons/iron.svg',
  ProductCareCategory.BLEACH: 'assets/svg/Icons/care_icons/bleach.svg',
  ProductCareCategory.DRY_CLEAN: 'assets/svg/Icons/care_icons/dry_clean_dry_clean.svg',
};

String getProductCareIconPath(ProductCareType type) => _careIconsMap[type];

String getProductCareCategoryIconPath(ProductCareCategory type) => _careCategoryMap[type];

String getProductCareTypeTitle(ProductCareType type) => _careTypeTitleMap[type];
