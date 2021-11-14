@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Products'

define view entity ZND_I_Product
  as select from znd_t_product as Product

  association [0..1] to ZND_I_ProductTheme as _ProductTheme on $projection.Theme = _ProductTheme.ProductTheme

  association [0..*] to ZND_I_ProductText  as _Text         on $projection.SKU = _Text.SKU

{
      @ObjectModel.text.association: '_Text'
  key Product.sku         as SKU,

      Product.theme       as Theme,

      Product.useful_data as UsefulData,

      Product.imageurl    as ImageURL,

      _ProductTheme,
      _Text

}
