@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Products'

@UI: {
    headerInfo: {
        typeName: 'Sold Item',
        typeNamePlural: 'Sold Items',
        title: {
            type: #STANDARD, value: 'SKU'
        },
        description: {
            value: 'Theme'
        },
        imageUrl: 'ImageURL'
     }
}

define view entity ZND_C_Product
  as select from ZND_I_Product as Product


{
      @UI.facet: [ { id:            'Product',
                     purpose:       #STANDARD,
                     type:          #IDENTIFICATION_REFERENCE,
                     label:         'Product',
                     position:      10 }  ]

      @UI.identification: [ { position: 10 , qualifier: 'Product'} ]
  key Product.SKU,
      @UI.identification: [ { position: 20 } ]
      Product.Theme,
      @UI.identification: [ { position: 30 } ]
      Product.UsefulData,
      
      @UI.hidden: true
      ImageURL,

      _ProductTheme,
      _Text

}
