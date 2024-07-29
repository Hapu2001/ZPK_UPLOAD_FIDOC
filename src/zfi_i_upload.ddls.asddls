//*----------------------------------------------------------------------*
//* Citek JSC.
//* (C) Copyright Citek JSC.
//* All Rights Reserved
//*----------------------------------------------------------------------*
//* Application : Upload FI Doc
//* Creation Date: 30.10.2023
//* Created by: NganNM
//*----------------------------------------------------------------------*
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Upload FI Doc (Header)'
@Metadata.allowExtensions: true
//@Search.searchable: true
define root view entity ZFI_I_UPLOAD
  as select distinct from zfi_tb_upload
  composition [0..*] of ZFI_I_UPLOAD_I as _Item
{
      //  @Consumption.filter: { mandatory: true , selectionType: #SINGLE,
      //  multipleSelections: false  /*defaultValue: '*'*/  }
      //  @Search.defaultSearchElement: true
      //  @Consumption.valueHelpDefinition: [{entity: {name: 'ZFI_I_UPLOAD', element: 'filename' }}]
  key zfi_tb_upload.filename,
  key zfi_tb_upload.id_doc,
      zfi_tb_upload.companycode,
      zfi_tb_upload.accountingdocument,
      zfi_tb_upload.fiscalyear,
      zfi_tb_upload.documentdate,
      zfi_tb_upload.postingdate,
      zfi_tb_upload.documenttype,
      zfi_tb_upload.currency,
      zfi_tb_upload.exchangerate,
      zfi_tb_upload.headertext,
      zfi_tb_upload.referencedoc,
      zfi_tb_upload.headerref1,
      zfi_tb_upload.negativeposting,
      zfi_tb_upload.ispst,
      zfi_tb_upload.pst_user,
      zfi_tb_upload.pst_date,
      zfi_tb_upload.upd_user,
      zfi_tb_upload.upd_date,
      _Item
}
