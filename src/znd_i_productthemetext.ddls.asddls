@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT

@EndUserText.label: 'Product Theme Description'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZND_I_ProductThemeText
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZND_D_PRODUCT_THEME') as domainText
  
  association [1..1] to I_Language         as _Language     on $projection.Language = _Language.Language
  
  association [1..1] to ZND_I_ProductTheme as _ProductTheme on $projection.ProductTheme = _ProductTheme.ProductTheme
{
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key domainText.language  as Language,
  
      @ObjectModel.foreignKey.association: '_ProductTheme'
  key domainText.value_low as ProductTheme,
  
      @Semantics.text:true
      domainText.text      as ProductThemeText,
      
      _Language,
      _ProductTheme
}
