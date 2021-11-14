CLASS znd_cl_customizing_init DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      product_init,
      sold_items_init.
ENDCLASS.



CLASS ZND_CL_CUSTOMIZING_INIT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Product (SKU)
    product_init(  ).

    " Sold Items
    sold_items_init( ).

    COMMIT WORK.
    out->write( 'Done').

  ENDMETHOD.


  METHOD product_init.

    DATA:
      lt_product      TYPE STANDARD TABLE OF znd_t_product,
      lt_product_text TYPE STANDARD TABLE OF znd_t_product_tx.

    DELETE FROM znd_t_product.
    DELETE FROM znd_t_product_tx.

    lt_product = VALUE #(
                    ( sku = 10295 theme = 20216
                      useful_data = 'Additional data for 10295'
                      imageurl = 'https://www.lego.com/cdn/cs/set/assets/blt020ac9aab2d162f4/10295_alt1.jpg?fit=bounds&format=webply&quality=80&width=400&height=400&dpr=2'
                    )

                    ( sku = 10293
                      theme = 20216
                      useful_data = 'Additional data for 10293'
                      imageurl = 'https://www.lego.com/cdn/cs/set/assets/blt00f50f1154bdd4a9/10293_alt1.jpg?fit=bounds&format=webply&quality=80&width=400&height=400&dpr=2' )

                    ( sku = 10240
                      theme = 20056
                      useful_data = 'Additional data for 10292'
                      imageurl = 'https://www.lego.com/cdn/cs/set/assets/blt5ebbbfc9f44b0cad/10240_alt1.jpg?fit=bounds&format=webply&quality=80&width=400&height=400&dpr=2'
                    ) ).

    lt_product_text = VALUE #(
                        language = 'E'
                        ( sku = 10295 description = 'Porsche 911')
                        ( sku = 10293 description = 'Santa’s Visit' )
                        ( sku = 10240 description = 'Red Five X-wing Starfighter' ) ).

    INSERT znd_t_product
        FROM TABLE @lt_product.

    INSERT znd_t_product_tx
        FROM TABLE @lt_product_text.

  ENDMETHOD.


  METHOD sold_items_init.

    DATA:
      lt_sold_items      TYPE STANDARD TABLE OF znd_t_sold_item.

    DELETE FROM znd_t_sold_item.

    lt_sold_items = VALUE #(
                    ( retailer_id = 'AMZ' sku = 10295  ) ).

    INSERT znd_t_sold_item
        FROM TABLE @lt_sold_items.

  ENDMETHOD.
ENDCLASS.
