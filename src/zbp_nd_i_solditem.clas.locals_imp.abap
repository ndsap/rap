CLASS lhc_ZND_I_SoldItem DEFINITION INHERITING FROM cl_abap_behavior_handler .
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR SoldItem RESULT result.

    METHODS Post FOR MODIFY
      IMPORTING keys FOR ACTION SoldItem~Post RESULT result.

    METHODS validateRetailerID FOR VALIDATE ON SAVE
      IMPORTING keys FOR SoldItem~validateRetailerID.

    METHODS validateSKU FOR VALIDATE ON SAVE
      IMPORTING keys FOR SoldItem~validateSKU.

    METHODS setTheme FOR DETERMINE ON SAVE
      IMPORTING keys FOR SoldItem~setTheme.

ENDCLASS.

CLASS lhc_ZND_I_SoldItem IMPLEMENTATION.

  METHOD get_global_authorizations.
    " no need for now
  ENDMETHOD.

  METHOD Post.

    " real post logic
    "   no actions here yet

    " clear temporary records
    MODIFY ENTITIES OF ZND_I_SoldItem
      IN LOCAL MODE
      ENTITY solditem
      DELETE FROM VALUE #(
                      FOR <ls_key> IN keys
                      ( %key = <ls_key>-%key ) )
      FAILED failed
      REPORTED reported.

    " raise success message
    APPEND VALUE #(
            %key = keys[ 1 ]-%key
            %msg = new_message(
                      id       = znd_if_sold_items_constants=>cv_msg_id
                      number   = znd_if_sold_items_constants=>cs_msgno-items_posted
                      severity = if_abap_behv_message=>severity-success )
        ) TO reported-solditem.

    " Return result to UI
    READ ENTITIES OF ZND_I_SoldItem IN LOCAL MODE
        ENTITY SoldItem
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_sold_items).

    result = VALUE #(
                FOR <ls_sold_item> IN lt_sold_items
                ( %tky   = <ls_sold_item>-%tky
                  %param = <ls_sold_item> ) ).

  ENDMETHOD.

  METHOD validateRetailerID.

    DATA(ls_validated_key) = keys[ 1 ]-%key .

    SELECT SINGLE @abap_true
        FROM ZND_I_Retailer
        WHERE RetailerID = @ls_validated_key-RetailerID
        INTO @DATA(lv_exists) .
    IF  lv_exists = abap_true.
      RETURN.
    ENDIF.

    " Wrong Retailer
    APPEND VALUE #(  %key = ls_validated_key
        ) TO failed-solditem.

    APPEND VALUE #(  %key = ls_validated_key
                     %msg = new_message(
                                id       = znd_if_sold_items_constants=>cv_msg_id
                                number   = znd_if_sold_items_constants=>cs_msgno-retailer_existence_check
                                v1       = ls_validated_key-RetailerID
                                severity = if_abap_behv_message=>severity-error )
                    %element-retailerid = if_abap_behv=>mk-on
        ) TO reported-solditem.

  ENDMETHOD.

  METHOD validateSKU.

    DATA(ls_validated_key) = keys[ 1 ]-%key .

    SELECT SINGLE @abap_true
      FROM ZND_I_Product
      WHERE sku = @ls_validated_key-sku
      INTO @DATA(lv_exists) .
    IF  lv_exists = abap_true.
      RETURN.
    ENDIF.

    " Wrong SKU
    APPEND VALUE #(  %key = ls_validated_key
        ) TO failed-solditem.

    APPEND VALUE #(  %key = ls_validated_key
                     %msg = new_message(
                                id       = znd_if_sold_items_constants=>cv_msg_id
                                number   = znd_if_sold_items_constants=>cs_msgno-sku_existence_check
                                v1       = ls_validated_key-sku
                                severity = if_abap_behv_message=>severity-error )
                    %element-sku = if_abap_behv=>mk-on
        ) TO reported-solditem.

    "IF 1 = 2. MESSAGE e000 WITH space. ENDIF. doesn't work here

  ENDMETHOD.

  METHOD setTheme.

    DATA(ls_key) = keys[ 1 ].

    SELECT SINGLE theme
     FROM ZND_I_Product
     WHERE sku = @ls_key-sku
     INTO @DATA(lv_theme).
    IF lv_theme IS INITIAL.
      RETURN.
    ENDIF.

    " Set theme
    MODIFY ENTITIES OF ZND_I_SoldItem IN LOCAL MODE
      ENTITY SoldItem
        UPDATE
          FIELDS ( theme )
          WITH VALUE #( ( %tky  = ls_key-%tky
                          theme = lv_theme ) )
      REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.
