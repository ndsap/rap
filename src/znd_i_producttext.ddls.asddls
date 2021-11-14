@AccessControl.authorizationCheck: #NOT_REQUIRED
//@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #TEXT

@EndUserText.label: 'Product Description'

define view entity ZND_I_ProductText
  as select from znd_t_product_tx as Text

  association [1..1] to I_Language    as _Language on $projection.Language = _Language.Language

  association [1..1] to ZND_I_Product as _Product  on $projection.SKU = _Product.SKU
{
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key Text.language    as Language,
  
      @ObjectModel.foreignKey.association: '_Product'
  key Text.sku         as SKU,
  
      @Semantics.text:true
      Text.description as ProductText,
      
      _Language,
      _Product
}
