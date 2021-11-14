@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true

@EndUserText.label: 'Sold Items'

define root view entity ZND_C_SoldItem
  provider contract transactional_query
  as projection on ZND_I_SoldItem as SoldItem

  // navigation to Product Info (image + additional data)
  association [0..1] to ZND_C_Product as _ProductCard on $projection.SKU = _ProductCard.SKU

{

      @ObjectModel.foreignKey.association: '_Retailer'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key RetailerID,

      @ObjectModel.foreignKey.association: '_Product'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key SKU,

      @ObjectModel.foreignKey.association: '_ProductTheme'
      Theme,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      ProductText,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      RetailerDescription,
      
      @UI.hidden: true
      LastChangedAt,

      _Product,
      _ProductCard,
      _ProductTheme,
      _Retailer

}
