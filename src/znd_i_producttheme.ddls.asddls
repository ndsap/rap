@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.resultSet.sizeCategory:#XS

@EndUserText.label: 'Product Theme'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZND_I_ProductTheme
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name: 'ZND_D_PRODUCT_THEME' ) as domainValue

  association [0..*] to ZND_I_ProductThemeText as _Text on $projection.ProductTheme = _Text.ProductTheme

{
       @ObjectModel.text.association: '_Text'
  key  cast( domainValue.value_low as znd_ed_product_theme) as ProductTheme,
  
       _Text
}
