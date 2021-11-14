INTERFACE znd_if_sold_items_constants
  PUBLIC .
  CONSTANTS:
    cv_msg_id TYPE symsgid VALUE 'ZND_SOLD_ITEMS',
    BEGIN OF cs_msgno,
      sku_existence_check      TYPE symsgno VALUE '000',
      retailer_existence_check TYPE symsgno VALUE '001',
      items_posted             TYPE symsgno VALUE '002',
    END OF cs_msgno.


ENDINTERFACE.
