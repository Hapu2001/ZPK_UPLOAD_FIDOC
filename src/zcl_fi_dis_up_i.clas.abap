CLASS ZCL_FI_DIS_UP_I DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      IF_RAP_QUERY_PROVIDER.
  PROTECTED SECTION.
  PRIVATE SECTION.
    "Range of
    DATA: GR_FILENAME TYPE RANGE OF ZDE_FILENAME,
          GR_ID_DOC   TYPE RANGE OF ZDE_ID_DOC.

    DATA: GV_SORT_STRING  TYPE STRING,
          GT_FIELDS       TYPE IF_RAP_QUERY_REQUEST=>TT_REQUESTED_ELEMENTS,
          GV_TOP          TYPE INT8,
          GV_SKIP         TYPE INT8,
          GV_MAX_ROWS     TYPE INT8,
          GT_AGGR_ELEMENT TYPE IF_RAP_QUERY_AGGREGATION=>TT_AGGREGATION_ELEMENTS.

    DATA: GT_DATA TYPE TABLE OF ZFI_I_DIS_UP_I.


    METHODS HANDLE_SORT   IMPORTING IO_REQUEST  TYPE REF TO IF_RAP_QUERY_REQUEST.
    METHODS HANDLE_FILTER IMPORTING IO_REQUEST  TYPE REF TO IF_RAP_QUERY_REQUEST.
    METHODS SET_PAGE IMPORTING IO_REQUEST  TYPE REF TO IF_RAP_QUERY_REQUEST.

    METHODS GET_DATA.
ENDCLASS.



CLASS ZCL_FI_DIS_UP_I IMPLEMENTATION.


  METHOD GET_DATA.
    SELECT
    FROM ZFI_TB_UPLOAD AS ZTB
    LEFT JOIN ZFI_TB_UPLOAD_I AS ITEM ON ZTB~FILENAME = ITEM~FILENAME
                                     AND ZTB~ID_DOC = ITEM~ID_DOC
    FIELDS
    ZTB~*,
    CAST( ZTB~DOCUMENTDATE AS DATS ) AS DOCUMENTDATE,
    CAST( ZTB~POSTINGDATE AS DATS ) AS POSTINGDATE,
    ITEM~*,
    CAST( ITEM~BASELINEDATE AS DATS ) AS BASELINEDATE,
    CAST( ITEM~VALUEDATE AS DATS ) AS VALUEDATE,
    'VND' AS COMPANYCODECURRENCY
    WHERE ZTB~FILENAME IN @GR_FILENAME
      AND ZTB~ID_DOC    IN @GR_ID_DOC
    INTO CORRESPONDING FIELDS OF TABLE @GT_DATA.
  ENDMETHOD.


  METHOD HANDLE_FILTER.
    TRY.
        "get and add filter
        DATA(LT_FILTER_COND) = IO_REQUEST->GET_FILTER( )->GET_AS_RANGES( ). "  get_filter_conditions( ).

        LOOP AT LT_FILTER_COND REFERENCE INTO DATA(LS_FILTER_COND).
          IF LS_FILTER_COND->NAME = |{ 'filename' CASE = UPPER }|.
            GR_FILENAME = CORRESPONDING #( LS_FILTER_COND->RANGE[] ).
          ENDIF.
          IF LS_FILTER_COND->NAME = |{ 'id_doc' CASE = UPPER }|.
            GR_ID_DOC = CORRESPONDING #( LS_FILTER_COND->RANGE[] ).
          ENDIF.
        ENDLOOP.
      CATCH CX_RAP_QUERY_FILTER_NO_RANGE INTO DATA(LX_NO_SEL_OPTION).
    ENDTRY.
  ENDMETHOD.


  METHOD HANDLE_SORT.
    DATA: LV_GROUPING      TYPE STRING.
    DATA: SYSTEMSTATUS     TYPE STRING,
          SYSTEMSTATUSOPER TYPE STRING.

    DATA(LT_SORT)          = IO_REQUEST->GET_SORT_ELEMENTS( ).
    DATA(LT_SORT_CRITERIA) = VALUE STRING_TABLE( FOR SORT_ELEMENT IN LT_SORT
                                                     ( SORT_ELEMENT-ELEMENT_NAME && COND #( WHEN SORT_ELEMENT-DESCENDING = ABAP_TRUE
                                                                                            THEN ` descending`
                                                                                            ELSE ` ascending` ) ) ).
    DATA(LV_DEFAUTL) = 'FILENAME,ID_DOC'.
    GV_SORT_STRING  = COND #( WHEN LT_SORT_CRITERIA IS INITIAL THEN LV_DEFAUTL
                                ELSE CONCAT_LINES_OF( TABLE = LT_SORT_CRITERIA SEP = `, ` ) ).

  ENDMETHOD.


  METHOD IF_RAP_QUERY_PROVIDER~SELECT.
    "Sort
    HANDLE_SORT( IO_REQUEST ).
    "Filter
    HANDLE_FILTER( IO_REQUEST ).
    "Get Data
    GET_DATA(  ).

    "SET PAGE
    SET_PAGE( IO_REQUEST ).
    "RESPONSE DATA
    DATA(LV_REQ_ELEMENTS)  = CONCAT_LINES_OF( TABLE = GT_FIELDS SEP = `, ` ).

    SELECT (LV_REQ_ELEMENTS)
    FROM @GT_DATA AS DATA
     ORDER BY (GV_SORT_STRING)
    INTO CORRESPONDING FIELDS OF TABLE @GT_DATA
    OFFSET @GV_SKIP UP TO @GV_MAX_ROWS ROWS.

    IO_RESPONSE->SET_TOTAL_NUMBER_OF_RECORDS( LINES( GT_DATA ) ).
    IO_RESPONSE->SET_DATA( GT_DATA ).
  ENDMETHOD.


  METHOD SET_PAGE.
    GT_FIELDS        = IO_REQUEST->GET_REQUESTED_ELEMENTS( ).
    GT_AGGR_ELEMENT  = IO_REQUEST->GET_AGGREGATION( )->GET_AGGREGATED_ELEMENTS( ).
    GV_TOP           = IO_REQUEST->GET_PAGING( )->GET_PAGE_SIZE( ).
    GV_SKIP          = IO_REQUEST->GET_PAGING( )->GET_OFFSET( ).
    GV_MAX_ROWS = COND #( WHEN GV_TOP = IF_RAP_QUERY_PAGING=>PAGE_SIZE_UNLIMITED THEN 0
                                ELSE GV_TOP ).

    IF GV_MAX_ROWS = -1 .
      GV_MAX_ROWS = 1.
    ENDIF.
    IF GT_AGGR_ELEMENT IS NOT INITIAL.
      LOOP AT GT_AGGR_ELEMENT ASSIGNING FIELD-SYMBOL(<FS_AGGR_ELEMENT>).
        DELETE GT_FIELDS WHERE TABLE_LINE = <FS_AGGR_ELEMENT>-RESULT_ELEMENT.
        DATA(LV_AGGREGATION) = |{ <FS_AGGR_ELEMENT>-AGGREGATION_METHOD }( { <FS_AGGR_ELEMENT>-INPUT_ELEMENT } ) as { <FS_AGGR_ELEMENT>-RESULT_ELEMENT }|.
        APPEND LV_AGGREGATION TO GT_FIELDS.
      ENDLOOP.
    ENDIF.


*        DATA(LT_GROUPED_ELEMENT) = IO_REQUEST->GET_AGGREGATION( )->GET_GROUPED_ELEMENTS( ).
*        LV_GROUPING = CONCAT_LINES_OF( TABLE = LT_GROUPED_ELEMENT SEP = `, ` ).

  ENDMETHOD.
ENDCLASS.
