@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sold Items'

define root view entity ZND_I_SoldItem
  as select from znd_t_sold_item as SoldItem

  association [1..1] to ZND_I_Retailer as _Retailer on $projection.RetailerID = _Retailer.RetailerID

  association [1..1] to ZND_I_Product  as _Product  on $projection.SKU = _Product.SKU
{

  key SoldItem.retailer_id       as RetailerID,
  key SoldItem.sku               as SKU,
      _Product.Theme,
      _Product.ImageURL,

      _Product._Text.ProductText as ProductText,
      _Retailer._Text.RetailerDescription,

      @Semantics.user.createdBy: true
      created_by                 as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                 as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by            as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at            as LastChangedAt,

      _Retailer,
      _Product,
      _Product._ProductTheme     as _ProductTheme

}
