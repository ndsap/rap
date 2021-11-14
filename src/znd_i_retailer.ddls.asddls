@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.resultSet.sizeCategory:#XS

@EndUserText.label: 'Retailer'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZND_I_Retailer
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE( p_domain_name: 'ZND_D_RETAILER_ID' ) as domainValue

  association [0..*] to ZND_I_RetailerText as _Text on $projection.RetailerID = _Text.RetailerID

{
       @ObjectModel.text.association: '_Text'
  key  domainValue.value_low as RetailerID,
  
       _Text
}
