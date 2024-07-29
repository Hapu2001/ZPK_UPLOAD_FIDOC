*----------------------------------------------------------------------*
* Citek JSC.
* (C) Copyright Citek JSC.
* All Rights Reserved
*----------------------------------------------------------------------*
* Application : Post FI Document from Excel upload
* Creation Date: 02.11.2023
* Created by: NganNM
*----------------------------------------------------------------------*
CLASS ZFI_CL_API_UPLOAD_FIDOC DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES:

      BEGIN OF TS_ITEM,
        ID_LINE                 TYPE ZDE_ID_LINE,
        ACCOUNTINGDOCUMENTITEM  TYPE BUZEI,
        POSTINGKEY              TYPE BSCHL,
        ACCOUNT                 TYPE HKONT,
        MAINASSETNUMBER         TYPE ZDE_ANLN1,
        SUBASSETNUMBER          TYPE ZDE_ANLN2,
        SPECIALGLACCOUNT        TYPE I_SPECIALGLCODE-SPECIALGLCODE,
        ASSETTRANSACTIONTYPE    TYPE I_ASSETTRANSACTIONTYPE-ASSETTRANSACTIONTYPE,
        COMPANYCODECURRENCY     TYPE WAERS,
        AMOUNTINLOCALCURRENCY   TYPE FINS_VWCUR12,
        TRANSACTIONCURRENCY     TYPE WAERS,
        AMOUNTINDOUMENTCURRENCY TYPE FINS_VWCUR12,
        EXCHANGERATE            TYPE ZDE_KURSF,
        TAXBASEAMOUNT           TYPE FINS_VWCUR12,
*        thêm vào đây
        LOCALTAXBASEAMOUNT      TYPE FINS_VWCUR12,
*
        ASSIGNMENT              TYPE DZUONR,
        BUSINESSAREA            TYPE GSBER,
        COSTCENTER              TYPE KOSTL,
        PROFITCENTER            TYPE PRCTR,
        INTERNALORDER           TYPE AUFNR,
        ASSETVALUEDATE          TYPE DATS,
        ITEMTEXT                TYPE SGTXT,
        OVERRIDEGLACCOUNT       TYPE HKONT,
        TAXCODE                 TYPE BUKRS,
        SEGMENT                 TYPE I_SEGMENT-SEGMENT,
        PAYMENTTERMS            TYPE DZTERM,
        PAYMENTBLOCKREASON      TYPE C LENGTH 1,
        PAYMENTMETHOD           TYPE C LENGTH 1,
        CONTRACTNUMBER          TYPE C LENGTH 13,
        CONTRACTTYPE            TYPE C LENGTH 1,
        HOUSEBANK               TYPE HBKID,
        BANKACCOUNTID           TYPE HKTID,
        INVOICEREFNUM           TYPE C LENGTH 10,
        INVOICEFISCALYEAR       TYPE GJAHR,
        INVOICEREFLINEITEM      TYPE N LENGTH 3,
        PURCHASINGNO            TYPE EBELN,
        PURCHASINGITEM          TYPE EBELP,
        BASELINEDATE            TYPE DATS,
        VALUEDATE               TYPE DATS,
        SALEORDER               TYPE VBELN_VL,
        SALEORDERITEM           TYPE I_SALESDOCUMENTITEM-SALESDOCUMENTITEM,
        REF1                    TYPE C LENGTH 20,
        REF2                    TYPE C LENGTH 20,
        REF3                    TYPE C LENGTH 20,
        LONGTEXT                TYPE C LENGTH 100,
        MATERIAL                TYPE MATNR,
        UNIT                    TYPE MEINS,
        NAME1                   TYPE C LENGTH 40,
        NAME2                   TYPE C LENGTH 40,
        CITY                    TYPE C LENGTH 40,
        COUNTRY                 TYPE C LENGTH 3,
        VATREGNO                TYPE STCEG,
        QUANTITY                TYPE MENGE_D,
        CUSTOMER                TYPE I_CUSTOMER-CUSTOMER,
        SUPPLIER                TYPE LIFNR,
*        negativeposting         TYPE char1_run_type,
        ALTERNATIVEPAYEE        TYPE LIFNR,
        MST                     TYPE C LENGTH 20,
        MSTNCCXUATHD            TYPE C LENGTH 40,
        TENNCCXUATHD            TYPE C LENGTH 80,
        NETDUEDATE              TYPE DATS,
      END OF TS_ITEM,
      BEGIN OF TS_DATA,
        FILENAME        TYPE ZDE_FILENAME,
        ID_DOC          TYPE ZDE_ID_DOC,
        COMPANYCODE     TYPE BUKRS,
        DOCUMENTDATE    TYPE DATS,
        POSTINGDATE     TYPE DATS,
        DOCUMENTTYPE    TYPE BLART,
        CURRENCY        TYPE WAERS,
        HEADERTEXT      TYPE BKTXT,
        REFERENCEDOC    TYPE XBLNR1,
        HEADERREF1      TYPE ZDE_XREF1,
        NEGATIVEPOSTING TYPE C LENGTH 1,
        TO_ITEM         TYPE TABLE OF TS_ITEM WITH DEFAULT KEY,
      END OF TS_DATA.
    INTERFACES IF_OO_ADT_CLASSRUN.
    INTERFACES IF_HTTP_SERVICE_EXTENSION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES:
      BEGIN OF TS_DOC_ITEM_REQUEST,
        ID_LINE                 TYPE STRING,
        ACCOUNTINGDOCUMENTITEM  TYPE STRING,
        POSTINGKEY              TYPE STRING,
        ACCOUNT                 TYPE STRING,
        MAINASSETNUMBER         TYPE STRING,
        SUBASSETNUMBER          TYPE STRING,
        SPECIALGLACCOUNT        TYPE STRING,
        ASSETTRANSACTIONTYPE    TYPE STRING,
        COMPANYCODECURRENCY     TYPE STRING,
        AMOUNTINLOCALCURRENCY   TYPE STRING,
        TRANSACTIONCURRENCY     TYPE STRING,
        AMOUNTINDOUMENTCURRENCY TYPE STRING,
        EXCHANGERATE            TYPE STRING,
        TAXBASEAMOUNT           TYPE STRING,
*        Thêm vào đây
        LOCALTAXBASEAMOUNT      TYPE STRING,
*        đây
        ASSIGNMENT              TYPE STRING,
        BUSINESSAREA            TYPE STRING,
        COSTCENTER              TYPE STRING,
        PROFITCENTER            TYPE STRING,
        INTERNALORDER           TYPE STRING,
        ASSETVALUEDATE          TYPE STRING,
        ITEMTEXT                TYPE STRING,
        OVERRIDEGLACCOUNT       TYPE STRING,
        TAXCODE                 TYPE STRING,
        SEGMENT                 TYPE STRING,
        PAYMENTTERMS            TYPE STRING,
        PAYMENTBLOCKREASON      TYPE STRING,
        PAYMENTMETHOD           TYPE STRING,
        CONTRACTNUMBER          TYPE STRING,
        CONTRACTTYPE            TYPE STRING,
        HOUSEBANK               TYPE STRING,
        BANKACCOUNTID           TYPE STRING,
        INVOICEREFNUM           TYPE STRING,
        INVOICEFISCALYEAR       TYPE STRING,
        INVOICEREFLINEITEM      TYPE STRING,
        PURCHASINGNO            TYPE STRING,
        PURCHASINGITEM          TYPE STRING,
        BASELINEDATE            TYPE STRING,
        VALUEDATE               TYPE STRING,
        SALEORDER               TYPE STRING,
        SALEORDERITEM           TYPE STRING,
        REF_1                   TYPE STRING,
        REF_2                   TYPE STRING,
        REF_3                   TYPE STRING,
        LONGTEXT                TYPE STRING,
        MATERIAL                TYPE STRING,
        UNIT                    TYPE STRING,
        NAME_1                  TYPE STRING,
        NAME_2                  TYPE STRING,
        CITY                    TYPE STRING,
        COUNTRY                 TYPE STRING,
        VATREGNO                TYPE STRING,
        QUANTITY                TYPE STRING,
        CUSTOMER                TYPE STRING,
        SUPPLIER                TYPE STRING,
        ALTERNATIVEPAYEE        TYPE STRING,
        MST                     TYPE STRING,
        TENNCCXUATHD            TYPE STRING,
        MSTNCCXUATHD            TYPE STRING,
        NETDUEDATE              TYPE STRING,
      END OF TS_DOC_ITEM_REQUEST,
      BEGIN OF TS_DOC_REQUEST,
        ID_DOC          TYPE STRING,
        COMPANYCODE     TYPE STRING,
        DOCUMENTDATE    TYPE STRING,
        POSTINGDATE     TYPE STRING,
        DOCUMENTTYPE    TYPE STRING,
        CURRENCY        TYPE STRING,
        HEADERTEXT      TYPE STRING,
        REFERENCEDOC    TYPE STRING,
        HEADERREF1      TYPE STRING,
        NEGATIVEPOSTING TYPE STRING,
        TO_ITEM         TYPE STANDARD TABLE OF TS_DOC_ITEM_REQUEST WITH EMPTY KEY,
      END OF TS_DOC_REQUEST,
      BEGIN OF TS_POST_REQUEST,
        ISUPDATE TYPE STRING,
        TESTMODE TYPE STRING,
        FILENAME TYPE STRING,
        DOC      TYPE STANDARD TABLE OF TS_DOC_REQUEST WITH EMPTY KEY,
      END OF TS_POST_REQUEST,
      BEGIN OF TS_RESULT,
        FILENAME           TYPE ZDE_FILENAME,
        ID_DOC             TYPE ZDE_ID_DOC,
        TYPE               TYPE STRING,
        MESSAGE            TYPE STRING,
        ACCOUNTINGDOCUMENT TYPE STRING,
      END OF TS_RESULT,
      BEGIN OF TS_GET_RESPONSE,
        ERROR   TYPE STRING,
        RESULTS TYPE STANDARD TABLE OF TS_RESULT WITH EMPTY KEY,
      END OF TS_GET_RESPONSE,
      BEGIN OF TY_ACCOUNTINGDOCUMENT,
        ACCOUNTINGDOCUMENT TYPE BELNR_D,
        COMPANYCODE        TYPE BUKRS,
        FISCALYEAR         TYPE GJAHR,
      END OF TY_ACCOUNTINGDOCUMENT.

    DATA:
      REQUEST_DATA  TYPE TS_POST_REQUEST,
      RESPONSE_DATA TYPE TS_GET_RESPONSE,
      GT_DATA       TYPE TABLE OF TS_DATA.
    METHODS: POST_FIDOC,
      CHECK_DATA.
ENDCLASS.



CLASS ZFI_CL_API_UPLOAD_FIDOC IMPLEMENTATION.


  METHOD CHECK_DATA.
*$-----------------------------------------------------------$
* Check data
*$-----------------------------------------------------------$
    DATA:
        LS_ITEM_DATA TYPE TS_ITEM.
    LOOP AT REQUEST_DATA-DOC INTO DATA(LS_DOC).

      APPEND INITIAL LINE TO GT_DATA REFERENCE INTO DATA(LS_DATA).
      LS_DATA->* = CORRESPONDING #( LS_DOC EXCEPT TO_ITEM ).
      LS_DATA->FILENAME = REQUEST_DATA-FILENAME.
      LOOP AT LS_DOC-TO_ITEM INTO DATA(LS_ITEM).
        LS_ITEM-AMOUNTINLOCALCURRENCY = LS_ITEM-AMOUNTINLOCALCURRENCY / 100.
*        ls_item-localtaxbaseamount = ls_item-localtaxbaseamount / 100.

        IF LS_ITEM-TRANSACTIONCURRENCY = 'VND'.
          LS_ITEM-AMOUNTINDOUMENTCURRENCY = LS_ITEM-AMOUNTINDOUMENTCURRENCY / 100.
          LS_ITEM-TAXBASEAMOUNT = LS_ITEM-TAXBASEAMOUNT / 100.
*          Thêm vào đây
*          ls_item-localtaxbaseamount = ls_item-localtaxbaseamount / 100.
*          đây
        ENDIF.
        CLEAR LS_ITEM_DATA.
        TRY.
            LS_ITEM_DATA = VALUE #(
            ID_LINE                 = LS_ITEM-ID_LINE
            ACCOUNTINGDOCUMENTITEM  = |{ LS_ITEM-ACCOUNTINGDOCUMENTITEM ALPHA = IN }|
            POSTINGKEY              = LS_ITEM-POSTINGKEY
            ACCOUNT                 = |{ LS_ITEM-ACCOUNT                ALPHA = IN }|
            MAINASSETNUMBER         = |{ LS_ITEM-MAINASSETNUMBER        ALPHA = IN }|
            SUBASSETNUMBER          = |{ LS_ITEM-SUBASSETNUMBER         ALPHA = IN }|
            SPECIALGLACCOUNT        = LS_ITEM-SPECIALGLACCOUNT
            ASSETTRANSACTIONTYPE    = LS_ITEM-ASSETTRANSACTIONTYPE
            COMPANYCODECURRENCY     = LS_ITEM-COMPANYCODECURRENCY
            AMOUNTINLOCALCURRENCY   = LS_ITEM-AMOUNTINLOCALCURRENCY
            TRANSACTIONCURRENCY     = LS_ITEM-TRANSACTIONCURRENCY
            AMOUNTINDOUMENTCURRENCY = LS_ITEM-AMOUNTINDOUMENTCURRENCY
            EXCHANGERATE            = LS_ITEM-EXCHANGERATE
            TAXBASEAMOUNT           = LS_ITEM-TAXBASEAMOUNT
*            thêm vào đây
            LOCALTAXBASEAMOUNT      = LS_ITEM-LOCALTAXBASEAMOUNT
*            đây
            ASSIGNMENT              = LS_ITEM-ASSIGNMENT
            BUSINESSAREA            = LS_ITEM-BUSINESSAREA
            COSTCENTER              = LS_ITEM-COSTCENTER
            PROFITCENTER            = |{ LS_ITEM-PROFITCENTER           ALPHA = IN }|
            INTERNALORDER           = LS_ITEM-INTERNALORDER
            ASSETVALUEDATE          = LS_ITEM-ASSETVALUEDATE
            ITEMTEXT                = LS_ITEM-ITEMTEXT
            OVERRIDEGLACCOUNT       = LS_ITEM-OVERRIDEGLACCOUNT
            TAXCODE                 = LS_ITEM-TAXCODE
            SEGMENT                 = LS_ITEM-SEGMENT
            PAYMENTTERMS            = LS_ITEM-PAYMENTTERMS
            PAYMENTBLOCKREASON      = LS_ITEM-PAYMENTBLOCKREASON
            PAYMENTMETHOD           = LS_ITEM-PAYMENTMETHOD
            CONTRACTNUMBER          = LS_ITEM-CONTRACTNUMBER
            CONTRACTTYPE            = LS_ITEM-CONTRACTTYPE
            HOUSEBANK               = LS_ITEM-HOUSEBANK
            BANKACCOUNTID           = LS_ITEM-BANKACCOUNTID
            INVOICEREFNUM           = |{ LS_ITEM-INVOICEREFNUM          ALPHA = IN }|
            INVOICEFISCALYEAR       = LS_ITEM-INVOICEFISCALYEAR
            INVOICEREFLINEITEM      = |{ LS_ITEM-INVOICEREFLINEITEM     ALPHA = IN }|
            PURCHASINGNO            = |{ LS_ITEM-PURCHASINGNO           ALPHA = IN }|
            PURCHASINGITEM          = |{ LS_ITEM-PURCHASINGITEM         ALPHA = IN }|
            BASELINEDATE            = LS_ITEM-BASELINEDATE
            VALUEDATE               = LS_ITEM-VALUEDATE
            SALEORDER               = |{ LS_ITEM-SALEORDER              ALPHA = IN }|
            SALEORDERITEM           = |{ LS_ITEM-SALEORDERITEM          ALPHA = IN }|
            REF1                    = LS_ITEM-REF_1
            REF2                    = LS_ITEM-REF_2
            REF3                    = LS_ITEM-REF_3
            LONGTEXT                = LS_ITEM-LONGTEXT
            MATERIAL                = |{ LS_ITEM-MATERIAL               ALPHA = IN }|
            UNIT                    = LS_ITEM-UNIT
            NAME1                   = LS_ITEM-NAME_1
            NAME2                   = LS_ITEM-NAME_2
            CITY                    = LS_ITEM-CITY
            COUNTRY                 = LS_ITEM-COUNTRY
            VATREGNO                = LS_ITEM-VATREGNO
            QUANTITY                = LS_ITEM-QUANTITY
            ALTERNATIVEPAYEE        = LS_ITEM-ALTERNATIVEPAYEE
            MST                     = LS_ITEM-MST
            TENNCCXUATHD            = LS_ITEM-TENNCCXUATHD
            MSTNCCXUATHD            = LS_ITEM-MSTNCCXUATHD
            CUSTOMER                = |{ LS_ITEM-CUSTOMER               ALPHA = IN }|
            NETDUEDATE              = LS_ITEM-NETDUEDATE
            ).
            APPEND LS_ITEM_DATA TO LS_DATA->TO_ITEM.
          CATCH CX_SY_CONVERSION_NO_NUMBER INTO DATA(LX_SY_CONVERSION_NO_NUMBER).
            RESPONSE_DATA-ERROR = LX_SY_CONVERSION_NO_NUMBER->GET_LONGTEXT(  ).
        ENDTRY.
      ENDLOOP.

    ENDLOOP.



  ENDMETHOD.


  METHOD IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
*$-----------------------------------------------------------$
* Handle request
*$-----------------------------------------------------------$
    DATA:
      REQUEST_METHOD TYPE STRING,
      REQUEST_BODY   TYPE STRING,
      RESPONSE_BODY  TYPE STRING.

    REQUEST_METHOD = REQUEST->GET_HEADER_FIELD( I_NAME = '~request_method' ).
    REQUEST_BODY = REQUEST->GET_TEXT( ).

    CASE REQUEST_METHOD.
      WHEN 'POST'.
*---$ Get request
        XCO_CP_JSON=>DATA->FROM_STRING( REQUEST_BODY )->APPLY( VALUE #(
      ( XCO_CP_JSON=>TRANSFORMATION->CAMEL_CASE_TO_UNDERSCORE ) ) )->WRITE_TO( REF #( REQUEST_DATA ) ).

*---$ Call post FI Document
        CHECK_DATA( ).
        POST_FIDOC( ).

*---$ Set response
        RESPONSE_BODY = XCO_CP_JSON=>DATA->FROM_ABAP( RESPONSE_DATA )->APPLY( VALUE #(
        ( XCO_CP_JSON=>TRANSFORMATION->UNDERSCORE_TO_CAMEL_CASE )
        ) )->TO_STRING( ).
        RESPONSE->SET_TEXT( I_TEXT = RESPONSE_BODY ).
      WHEN 'GET'.

    ENDCASE.

  ENDMETHOD.


  METHOD IF_OO_ADT_CLASSRUN~MAIN.
*$-----------------------------------------------------------$
* For class run
*$-----------------------------------------------------------$
    REQUEST_DATA-FILENAME = 'ZUP_TEMPLATE PHYTO11.xlsx'.
    POST_FIDOC(  ).
  ENDMETHOD.


  METHOD POST_FIDOC.
*$-----------------------------------------------------------$
* Post FI Document
*$-----------------------------------------------------------$
    DATA: LT_POST_DATA            TYPE TABLE FOR ACTION IMPORT I_JOURNALENTRYTP~POST,
          LT_CHECK_DATA           TYPE TABLE FOR FUNCTION IMPORT I_JOURNALENTRYTP~VALIDATE,
          LV_CID                  TYPE ABP_BEHV_CID,
          LV_FINANCIALACCOUNTTYPE TYPE KOART,
          LS_ACCOUNTINGDOCUMENT   TYPE TY_ACCOUNTINGDOCUMENT.

    DATA:
        LS_RESULT TYPE TS_RESULT.

    LOOP AT GT_DATA INTO DATA(LS_HEADER).
      APPEND INITIAL LINE TO LT_POST_DATA ASSIGNING FIELD-SYMBOL(<LFS_POST_DATA>).
      TRY.
          LV_CID = CL_UUID_FACTORY=>CREATE_SYSTEM_UUID( )->CREATE_UUID_X16( ).
        CATCH CX_UUID_ERROR.
      ENDTRY.
      <LFS_POST_DATA>-%CID = |{ LS_HEADER-FILENAME }#{ LS_HEADER-ID_DOC }#{ LV_CID }|.
      <LFS_POST_DATA>-%PARAM-COMPANYCODE            = LS_HEADER-COMPANYCODE.
      <LFS_POST_DATA>-%PARAM-DOCUMENTREFERENCEID    = LS_HEADER-REFERENCEDOC.
      <LFS_POST_DATA>-%PARAM-CREATEDBYUSER          = SY-UNAME.
      <LFS_POST_DATA>-%PARAM-ACCOUNTINGDOCUMENTTYPE = LS_HEADER-DOCUMENTTYPE.
      <LFS_POST_DATA>-%PARAM-DOCUMENTDATE           = LS_HEADER-DOCUMENTDATE.
      <LFS_POST_DATA>-%PARAM-POSTINGDATE            = LS_HEADER-POSTINGDATE.
      <LFS_POST_DATA>-%PARAM-ACCOUNTINGDOCUMENTHEADERTEXT = LS_HEADER-HEADERTEXT.
      <LFS_POST_DATA>-%PARAM-ISNEGATIVEPOSTING = LS_HEADER-NEGATIVEPOSTING.
      <LFS_POST_DATA>-%PARAM-TAXDETERMINATIONDATE = SY-DATUM.

      SELECT DISTINCT
        I_POSTINGKEY~POSTINGKEY,
        I_POSTINGKEY~FINANCIALACCOUNTTYPE,
        I_POSTINGKEY~DEBITCREDITCODE
       FROM I_POSTINGKEY
       INNER JOIN @LS_HEADER-TO_ITEM AS ITEM ON ITEM~POSTINGKEY = I_POSTINGKEY~POSTINGKEY
       ORDER BY I_POSTINGKEY~POSTINGKEY
       INTO TABLE @DATA(LT_POSTINGKEY).

      LOOP AT LS_HEADER-TO_ITEM INTO DATA(LS_ITEM).
        IF  LS_ITEM-AMOUNTINDOUMENTCURRENCY IS INITIAL AND LS_ITEM-EXCHANGERATE IS NOT INITIAL.
          LS_ITEM-AMOUNTINDOUMENTCURRENCY = LS_ITEM-AMOUNTINLOCALCURRENCY / LS_ITEM-EXCHANGERATE.
        ENDIF.

        READ TABLE LT_POSTINGKEY INTO DATA(LS_POSTINGKEY)
        WITH KEY POSTINGKEY = LS_ITEM-POSTINGKEY BINARY SEARCH.
        IF SY-SUBRC = 0.
          CASE LS_POSTINGKEY-FINANCIALACCOUNTTYPE.
            WHEN 'K'. "Supplier -> AP
              APPEND INITIAL LINE TO <LFS_POST_DATA>-%PARAM-_APITEMS REFERENCE INTO DATA(LS_APITEM).
              LS_APITEM->* = VALUE #(
                GLACCOUNTLINEITEM             = LS_ITEM-ID_LINE
                SUPPLIER                      = LS_ITEM-ACCOUNT
                GLACCOUNT                     = COND #( WHEN LS_ITEM-OVERRIDEGLACCOUNT IS NOT INITIAL THEN LS_ITEM-OVERRIDEGLACCOUNT ELSE SPACE )
                DOCUMENTITEMTEXT              = LS_ITEM-ITEMTEXT
                REFERENCE1IDBYBUSINESSPARTNER = LS_ITEM-REF1
                REFERENCE2IDBYBUSINESSPARTNER = LS_ITEM-REF2
                REFERENCE3IDBYBUSINESSPARTNER = LS_ITEM-REF3
                ASSIGNMENTREFERENCE           = LS_ITEM-ASSIGNMENT
                PAYMENTTERMS                  = LS_ITEM-PAYMENTTERMS
                DUECALCULATIONBASEDATE        = LS_ITEM-BASELINEDATE
                PAYMENTMETHODSUPPLEMENT       = LS_ITEM-PAYMENTMETHOD
                PAYMENTBLOCKINGREASON         = LS_ITEM-PAYMENTBLOCKREASON
                VATREGISTRATION               = LS_ITEM-VATREGNO
                SPECIALGLCODE                 = LS_ITEM-SPECIALGLACCOUNT
                TAXCODE                       = LS_ITEM-TAXCODE
                HOUSEBANK                     = LS_ITEM-HOUSEBANK
                HOUSEBANKACCOUNT              = LS_ITEM-BANKACCOUNTID
                ALTERNATIVEPAYEE              = LS_ITEM-ALTERNATIVEPAYEE
                PROFITCENTER                  = LS_ITEM-PROFITCENTER
                _CURRENCYAMOUNT               = VALUE #(
                                                ( CURRENCYROLE           = '00'
                                                  JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINDOUMENTCURRENCY * -1 ELSE LS_ITEM-AMOUNTINDOUMENTCURRENCY )
                                                  EXCHANGERATE           = LS_ITEM-EXCHANGERATE
                                                  CURRENCY               = LS_ITEM-TRANSACTIONCURRENCY
                                                  TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-TAXBASEAMOUNT * -1 ELSE LS_ITEM-TAXBASEAMOUNT ) ) ) ).
              IF  LS_ITEM-AMOUNTINLOCALCURRENCY IS NOT INITIAL AND LS_ITEM-AMOUNTINLOCALCURRENCY <> LS_ITEM-AMOUNTINDOUMENTCURRENCY.
                APPEND VALUE #( CURRENCYROLE           = '10'
                                JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINLOCALCURRENCY * -1 ELSE LS_ITEM-AMOUNTINLOCALCURRENCY )
*                                journalentryitemamount = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-localtaxbaseamount * -1 else ls_item-localtaxbaseamount )
                                CURRENCY               = 'VND'
*                                taxbaseamount          = COND #( WHEN ls_postingkey-debitcreditcode = 'H' THEN ls_item-amountinlocalcurrency * -1 ELSE ls_item-amountinlocalcurrency ) ) TO ls_apitem->_currencyamount.
*                                thêm vào đây
                                TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-LOCALTAXBASEAMOUNT * -1 ELSE LS_ITEM-LOCALTAXBASEAMOUNT ) ) TO LS_APITEM->_CURRENCYAMOUNT.
*                                đây
              ENDIF.
              IF LS_ITEM-NAME1 IS NOT INITIAL OR LS_ITEM-NAME2 IS NOT INITIAL.
                <LFS_POST_DATA>-%PARAM-_ONETIMECUSTOMERSUPPLIER = VALUE #( NAME                        = LS_ITEM-NAME1
                                                                           CITYNAME                    = LS_ITEM-CITY
                                                                           COUNTRY                     = LS_ITEM-COUNTRY
                                                                           ONETIMEBUSINESSPARTNERNAME2 = LS_ITEM-NAME2
                                                                           VATLIABILITY                = LS_ITEM-VATREGNO
                                                                           TAXNUMBER1                  = LS_ITEM-MST ).
              ENDIF.
            WHEN 'D'. "Customer -> AR
              APPEND INITIAL LINE TO <LFS_POST_DATA>-%PARAM-_ARITEMS REFERENCE INTO DATA(LS_ARITEMS).
              LS_ARITEMS->* = VALUE #(
                GLACCOUNTLINEITEM             = LS_ITEM-ID_LINE
                CUSTOMER                      = LS_ITEM-ACCOUNT
                GLACCOUNT                     = COND #( WHEN LS_ITEM-OVERRIDEGLACCOUNT IS NOT INITIAL THEN LS_ITEM-OVERRIDEGLACCOUNT ELSE SPACE )
                DOCUMENTITEMTEXT              = LS_ITEM-ITEMTEXT
                REFERENCE1IDBYBUSINESSPARTNER = LS_ITEM-REF1
                REFERENCE2IDBYBUSINESSPARTNER = LS_ITEM-REF2
                REFERENCE3IDBYBUSINESSPARTNER = LS_ITEM-REF3
                ASSIGNMENTREFERENCE           = LS_ITEM-ASSIGNMENT
                PAYMENTTERMS                  = LS_ITEM-PAYMENTTERMS
                DUECALCULATIONBASEDATE        = LS_ITEM-BASELINEDATE
                PAYMENTMETHODSUPPLEMENT       = LS_ITEM-PAYMENTMETHOD
                PAYMENTBLOCKINGREASON         = LS_ITEM-PAYMENTBLOCKREASON
                VATREGISTRATION               = LS_ITEM-VATREGNO
                SPECIALGLCODE                 = LS_ITEM-SPECIALGLACCOUNT
                TAXCODE                       = LS_ITEM-TAXCODE
                HOUSEBANK                     = LS_ITEM-HOUSEBANK
                HOUSEBANKACCOUNT              = LS_ITEM-BANKACCOUNTID
                SALESORDER                    = LS_ITEM-SALEORDER
                SALESORDERITEM                = LS_ITEM-SALEORDERITEM
                _CURRENCYAMOUNT               = VALUE #( ( CURRENCYROLE           = '00'
                                                           JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINDOUMENTCURRENCY * -1 ELSE LS_ITEM-AMOUNTINDOUMENTCURRENCY )
                                                           EXCHANGERATE           = LS_ITEM-EXCHANGERATE
                                                           CURRENCY               = LS_ITEM-TRANSACTIONCURRENCY
                                                           TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-TAXBASEAMOUNT * -1 ELSE LS_ITEM-TAXBASEAMOUNT ) ) ) ).
              IF  LS_ITEM-AMOUNTINLOCALCURRENCY IS NOT INITIAL AND LS_ITEM-AMOUNTINLOCALCURRENCY <> LS_ITEM-AMOUNTINDOUMENTCURRENCY.
                APPEND VALUE #( CURRENCYROLE           = '10'
                                JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINLOCALCURRENCY * -1 ELSE LS_ITEM-AMOUNTINLOCALCURRENCY )
*                                journalentryitemamount = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-localtaxbaseamount * -1 else ls_item-localtaxbaseamount )
                                                 CURRENCY               = 'VND'
*                                taxbaseamount          = COND #( WHEN ls_postingkey-debitcreditcode = 'H' THEN ls_item-amountinlocalcurrency * -1 ELSE ls_item-amountinlocalcurrency ) ) TO ls_aritems->_currencyamount.
*                                                             thêm vào đây
                                TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-LOCALTAXBASEAMOUNT * -1 ELSE LS_ITEM-LOCALTAXBASEAMOUNT ) ) TO LS_ARITEMS->_CURRENCYAMOUNT.
*                                đây
              ENDIF.
            WHEN 'S' OR 'A'.
              DATA(LV_HKONT_EXT) = |{ LS_ITEM-ACCOUNT ALPHA = OUT }|.
              IF ( ( LV_HKONT_EXT CP '133*' AND LV_HKONT_EXT NP '1338*' OR  LV_HKONT_EXT CP '3331*' ) AND LS_POSTINGKEY-FINANCIALACCOUNTTYPE = 'S' ).
                APPEND INITIAL LINE TO <LFS_POST_DATA>-%PARAM-_TAXITEMS REFERENCE INTO DATA(LS_TAXITEM).
                LS_TAXITEM->* = VALUE #(
                    GLACCOUNTLINEITEM  = LS_ITEM-ID_LINE
                    TAXCODE            = LS_ITEM-TAXCODE
                    CONDITIONTYPE      = COND #( WHEN LV_HKONT_EXT CP '133*' THEN 'MWVS' ELSE 'MWAS' )
                    ISDIRECTTAXPOSTING = ABAP_TRUE
                    _CURRENCYAMOUNT    = VALUE #( ( CURRENCYROLE           = '00'
                                                JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINDOUMENTCURRENCY * -1 ELSE LS_ITEM-AMOUNTINDOUMENTCURRENCY )
                                                CURRENCY               = LS_ITEM-TRANSACTIONCURRENCY
                                                EXCHANGERATE           = LS_ITEM-EXCHANGERATE
                                                TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-TAXBASEAMOUNT * -1 ELSE LS_ITEM-TAXBASEAMOUNT ) ) ) ) .
                IF  LS_ITEM-AMOUNTINLOCALCURRENCY IS NOT INITIAL AND LS_ITEM-AMOUNTINLOCALCURRENCY <> LS_ITEM-AMOUNTINDOUMENTCURRENCY.
                  APPEND VALUE #( CURRENCYROLE           = '10'
                                JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINLOCALCURRENCY * -1 ELSE LS_ITEM-AMOUNTINLOCALCURRENCY )
*                                journalentryitemamount = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-localtaxbaseamount * -1 else ls_item-localtaxbaseamount )
                                     CURRENCY               = 'VND'
*                                  taxbaseamount          = COND #( WHEN ls_postingkey-debitcreditcode = 'H' THEN ls_item-amountinlocalcurrency * -1 ELSE ls_item-amountinlocalcurrency ) ) TO ls_taxitem->_currencyamount.
*                                                         thêm vào đây
                                  TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-LOCALTAXBASEAMOUNT * -1 ELSE LS_ITEM-LOCALTAXBASEAMOUNT ) ) TO LS_TAXITEM->_CURRENCYAMOUNT.
*                                đây
                ENDIF.
              ELSE.
                APPEND INITIAL LINE TO <LFS_POST_DATA>-%PARAM-_GLITEMS REFERENCE INTO DATA(LS_GLITEM).
                LS_GLITEM->* = VALUE #(
                    GLACCOUNTLINEITEM             = LS_ITEM-ID_LINE
                    GLACCOUNT                     = LS_ITEM-ACCOUNT
                    DOCUMENTITEMTEXT              = LS_ITEM-ITEMTEXT
                    REFERENCE1IDBYBUSINESSPARTNER = LS_ITEM-REF1
                    REFERENCE2IDBYBUSINESSPARTNER = LS_ITEM-REF2
                    REFERENCE3IDBYBUSINESSPARTNER = LS_ITEM-REF3
                    ASSIGNMENTREFERENCE           = LS_ITEM-ASSIGNMENT
                    TAXCODE                       = LS_ITEM-TAXCODE
                    MATERIAL                      = LS_ITEM-MATERIAL
                    QUANTITY                      = LS_ITEM-QUANTITY
                    BASEUNIT                      = LS_ITEM-UNIT
                    VALUEDATE                     = LS_ITEM-VALUEDATE
                    HOUSEBANK                     = LS_ITEM-HOUSEBANK
                    HOUSEBANKACCOUNT              = LS_ITEM-BANKACCOUNTID
                    PROFITCENTER                  = LS_ITEM-PROFITCENTER
                    SEGMENT                       = LS_ITEM-SEGMENT
                    COSTCENTER                    = LS_ITEM-COSTCENTER
                    MASTERFIXEDASSET              = LS_ITEM-MAINASSETNUMBER
                    FIXEDASSET                    = LS_ITEM-SUBASSETNUMBER
                    SALESORDER                    = LS_ITEM-SALEORDER
                    SALESORDERITEM                = LS_ITEM-SALEORDERITEM
                    ORDERID                       = LS_ITEM-INTERNALORDER
*                    yy1_tennccxuathd_cob = ls_item-tennccxuathd
*                    yy1_mstnhcungcpxuthon_cob = ls_item-mstnccxuathd
                    _PROFITABILITYSUPPLEMENT      = VALUE #( PROFITCENTER = LS_ITEM-PROFITCENTER CUSTOMER = LS_ITEM-CUSTOMER )
                    _CURRENCYAMOUNT               = VALUE #( ( CURRENCYROLE           = '00'
                                                                JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINDOUMENTCURRENCY * -1 ELSE LS_ITEM-AMOUNTINDOUMENTCURRENCY )
                                                                CURRENCY               = LS_ITEM-TRANSACTIONCURRENCY
                                                                EXCHANGERATE           = LS_ITEM-EXCHANGERATE
                                                                TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-TAXBASEAMOUNT * -1 ELSE LS_ITEM-TAXBASEAMOUNT ) ) ) ).
                IF  LS_ITEM-AMOUNTINLOCALCURRENCY IS NOT INITIAL AND LS_ITEM-AMOUNTINLOCALCURRENCY <> LS_ITEM-AMOUNTINDOUMENTCURRENCY.
                  APPEND VALUE #( CURRENCYROLE           = '10'
                                JOURNALENTRYITEMAMOUNT = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-AMOUNTINLOCALCURRENCY * -1 ELSE LS_ITEM-AMOUNTINLOCALCURRENCY )
*                                 journalentryitemamount = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-localtaxbaseamount * -1 else ls_item-localtaxbaseamount )
                                 CURRENCY               = 'VND'
*                                  taxbaseamount          = COND #( WHEN ls_postingkey-debitcreditcode = 'H' THEN ls_item-amountinlocalcurrency * -1 ELSE ls_item-amountinlocalcurrency ) ) TO ls_glitem->_currencyamount.
*                                                                  thêm vào đây
                                 TAXBASEAMOUNT          = COND #( WHEN LS_POSTINGKEY-DEBITCREDITCODE = 'H' THEN LS_ITEM-LOCALTAXBASEAMOUNT * -1 ELSE LS_ITEM-LOCALTAXBASEAMOUNT ) ) TO LS_GLITEM->_CURRENCYAMOUNT.
*                                đây
                ENDIF.
*                if ls_item-taxcode is not initial and
**                đầu vào: OA, OY, KA, NA, IN
**                đầu ra: 0O, KO, OZ, NO
*                (   ls_item-taxcode = '0A'
*                 or ls_item-taxcode = 'OY'
*                 or ls_item-taxcode = 'KA'
*                 or ls_item-taxcode = 'NA'
*                 or ls_item-taxcode = 'IN'
*
*                 or ls_item-taxcode = '0O'
*                 or ls_item-taxcode = 'KO'
*                 or ls_item-taxcode = 'OZ'
*                 or ls_item-taxcode = 'NO'
*                 ) .
*                  append initial line to <lfs_post_data>-%param-_taxitems reference into ls_taxitem.
*                  ls_taxitem->* =  value #(
*                                 glaccountlineitem  = ls_item-id_line
*                                 taxcode            = ls_item-taxcode
*                                 conditiontype      = cond #( when ls_item-taxcode = '0A' or ls_item-taxcode = 'OY' or ls_item-taxcode = 'KA' or ls_item-taxcode = 'NA' or ls_item-taxcode = 'IN' then 'MWVS'
*                                                              when ls_item-taxcode = '0O' or ls_item-taxcode = 'KO' or ls_item-taxcode = 'OZ' or ls_item-taxcode = 'NO' then 'MWAS'  )
*                                 isdirecttaxposting = abap_true
*                                 _currencyamount    = value #( ( currencyrole           = '00'
*                                                                 journalentryitemamount = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-amountindoumentcurrency * -1 else ls_item-amountindoumentcurrency )
*                                                                 currency               = ls_item-transactioncurrency
*                                                                 exchangerate           = ls_item-exchangerate
*                                                                 taxbaseamount          = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-taxbaseamount * -1 else ls_item-taxbaseamount ) ) ) ) .
*                  if  ls_item-amountinlocalcurrency is not initial and ls_item-amountinlocalcurrency <> ls_item-amountindoumentcurrency.
*                    append value #( currencyrole           = '10'
*                                    journalentryitemamount = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-amountinlocalcurrency * -1 else ls_item-amountinlocalcurrency )
*                                    currency               = 'VND'
*                                    taxbaseamount          = cond #( when ls_postingkey-debitcreditcode = 'H' then ls_item-amountinlocalcurrency * -1 else ls_item-amountinlocalcurrency ) ) to ls_taxitem->_currencyamount.
*                  endif.
*                endif.
              ENDIF.
          ENDCASE.
        ENDIF.

      ENDLOOP.
    ENDLOOP.

*--$ call BO
    IF  REQUEST_DATA-TESTMODE = ABAP_FALSE.
      MODIFY ENTITIES OF I_JOURNALENTRYTP
      ENTITY JOURNALENTRY
      EXECUTE POST FROM LT_POST_DATA
      FAILED DATA(LS_FAILED_DEEP)
      REPORTED DATA(LS_REPORTED_DEEP)
      MAPPED DATA(LS_MAPPED_DEEP).
      IF LS_FAILED_DEEP IS NOT INITIAL.
        LOOP AT LS_REPORTED_DEEP-JOURNALENTRY ASSIGNING FIELD-SYMBOL(<LS_REPORT_JOURNAL>).
          SPLIT <LS_REPORT_JOURNAL>-%CID AT '#' INTO LS_RESULT-FILENAME LS_RESULT-ID_DOC.
          LS_RESULT-MESSAGE = <LS_REPORT_JOURNAL>-%MSG->IF_MESSAGE~GET_TEXT( ).
          CASE <LS_REPORT_JOURNAL>-%MSG->IF_T100_DYN_MSG~MSGTY.
            WHEN 'E'.
              LS_RESULT-TYPE = 'Error'.
            WHEN 'S'.
              LS_RESULT-TYPE = 'Success'.
            WHEN 'W'.
              LS_RESULT-TYPE = 'Warning'.
            WHEN 'I'.
              LS_RESULT-TYPE = 'Information'.
          ENDCASE.
          APPEND LS_RESULT TO RESPONSE_DATA-RESULTS.
        ENDLOOP.
      ELSE.
*    --$ commit
        COMMIT ENTITIES BEGIN
         RESPONSE OF I_JOURNALENTRYTP
         FAILED DATA(LT_COMMIT_FAILED)
         REPORTED DATA(LT_COMMIT_REPORTED).
        COMMIT ENTITIES END.
        DATA: LS_FI_TB_UPLOAD   TYPE ZFI_TB_UPLOAD,
              LS_FI_TB_UPLOAD_I TYPE ZFI_TB_UPLOAD_I.

        LOOP AT LS_MAPPED_DEEP-JOURNALENTRY REFERENCE INTO DATA(LS_JOURNAL_MAP_KEY).
          SPLIT LS_JOURNAL_MAP_KEY->%CID AT '#' INTO LS_RESULT-FILENAME LS_RESULT-ID_DOC LV_CID.
          READ TABLE GT_DATA INTO LS_HEADER
          WITH KEY FILENAME = LS_RESULT-FILENAME
                   ID_DOC = LS_RESULT-ID_DOC.
          IF SY-SUBRC = 0.
            READ TABLE LT_COMMIT_REPORTED-JOURNALENTRY INTO DATA(LS_COMMIT_REPORTED)
            WITH KEY %PID = LS_JOURNAL_MAP_KEY->%PID.
            IF SY-SUBRC = 0.
              CLEAR: LS_FI_TB_UPLOAD, LS_ACCOUNTINGDOCUMENT.
              LS_ACCOUNTINGDOCUMENT = LS_COMMIT_REPORTED-%MSG->IF_T100_DYN_MSG~MSGV2.

              LS_RESULT-MESSAGE = LS_COMMIT_REPORTED-%MSG->IF_MESSAGE~GET_TEXT( ).
              CASE LS_COMMIT_REPORTED-%MSG->IF_T100_DYN_MSG~MSGTY.
                WHEN 'E'.
                  LS_RESULT-TYPE = 'Error'.
                WHEN 'S'.
                  LS_RESULT-TYPE = 'Success'.
                  LS_RESULT-ACCOUNTINGDOCUMENT = LS_ACCOUNTINGDOCUMENT-ACCOUNTINGDOCUMENT.
                WHEN 'W'.
                  LS_RESULT-TYPE = 'Warning'.
                WHEN 'I'.
                  LS_RESULT-TYPE = 'Information'.
              ENDCASE.
              APPEND LS_RESULT TO RESPONSE_DATA-RESULTS.

              LS_FI_TB_UPLOAD = CORRESPONDING #( LS_HEADER ).
              LS_FI_TB_UPLOAD-ACCOUNTINGDOCUMENT = LS_ACCOUNTINGDOCUMENT-ACCOUNTINGDOCUMENT.
              LS_FI_TB_UPLOAD-FISCALYEAR = LS_ACCOUNTINGDOCUMENT-FISCALYEAR.
              IF  REQUEST_DATA-ISUPDATE = ABAP_TRUE.
                LS_FI_TB_UPLOAD-UPD_DATE = SY-DATUM.
                LS_FI_TB_UPLOAD-UPD_USER = SY-UNAME.
              ELSE.
                LS_FI_TB_UPLOAD-PST_DATE = SY-DATUM.
                LS_FI_TB_UPLOAD-PST_USER = SY-UNAME.
                LS_FI_TB_UPLOAD-ISPST = ABAP_TRUE.
              ENDIF.
              MODIFY ZFI_TB_UPLOAD FROM @LS_FI_TB_UPLOAD.
              LOOP AT LS_HEADER-TO_ITEM INTO LS_ITEM.
                CLEAR: LS_FI_TB_UPLOAD_I.
                LS_FI_TB_UPLOAD_I = CORRESPONDING #( LS_ITEM ).
                LS_FI_TB_UPLOAD_I-FILENAME = LS_FI_TB_UPLOAD-FILENAME.
                LS_FI_TB_UPLOAD_I-ID_DOC = LS_FI_TB_UPLOAD-ID_DOC.
                MODIFY ZFI_TB_UPLOAD_I FROM @LS_FI_TB_UPLOAD_I.
              ENDLOOP.

            ENDIF.

          ENDIF.
        ENDLOOP.
      ENDIF.
    ELSE.
      LT_CHECK_DATA = CORRESPONDING #( LT_POST_DATA ).
      READ ENTITIES OF I_JOURNALENTRYTP
      ENTITY JOURNALENTRY
      EXECUTE VALIDATE FROM LT_CHECK_DATA
        RESULT DATA(LT_CHECK_RESULT)
        FAILED DATA(LS_FAILED_CHECK)
        REPORTED DATA(LS_REPORTED_CHECK_DEEP).

      LOOP AT LS_REPORTED_CHECK_DEEP-JOURNALENTRY ASSIGNING FIELD-SYMBOL(<LFS_REPORTED_CHECK>).
        SPLIT <LFS_REPORTED_CHECK>-%CID AT '#' INTO LS_RESULT-FILENAME LS_RESULT-ID_DOC LV_CID.
        LS_RESULT-MESSAGE = <LFS_REPORTED_CHECK>-%MSG->IF_MESSAGE~GET_TEXT( ).
        CASE <LFS_REPORTED_CHECK>-%MSG->IF_T100_DYN_MSG~MSGTY.
          WHEN 'E'.
            LS_RESULT-TYPE = 'Error'.
          WHEN 'S'.
            LS_RESULT-TYPE = 'Success'.
          WHEN 'W'.
            LS_RESULT-TYPE = 'Warning'.
          WHEN 'I'.
            LS_RESULT-TYPE = 'Information'.
        ENDCASE.
        APPEND LS_RESULT TO RESPONSE_DATA-RESULTS.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
