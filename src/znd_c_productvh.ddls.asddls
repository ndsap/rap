@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Products'

define view entity ZND_C_ProductVH
  as select from ZND_I_Product as Product

{

  key SKU,
      Theme,

      _ProductTheme,
      _Text
}
