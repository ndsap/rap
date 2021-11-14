@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT

@EndUserText.label: 'Product Theme Description'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZND_I_RetailerText
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZND_D_RETAILER_ID') as domainText

  association [1..1] to I_Language     as _Language on $projection.Language = _Language.Language

  association [1..1] to ZND_I_Retailer as _Retailer on $projection.RetailerID = _Retailer.RetailerID
{
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key domainText.language                      as Language,

      @ObjectModel.foreignKey.association: '_Retailer'
  key domainText.value_low                     as RetailerID,

      @Semantics.text:true
      cast( domainText.text as abap.char(50) ) as RetailerDescription,

      _Language,
      _Retailer
}
