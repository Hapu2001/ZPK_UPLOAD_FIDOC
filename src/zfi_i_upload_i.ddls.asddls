//*----------------------------------------------------------------------*
//* Citek JSC.
//* (C) Copyright Citek JSC.
//* All Rights Reserved
//*----------------------------------------------------------------------*
//* Application : Upload FI Doc
//* Creation Date: 30.10.2023
//* Created by: NganNM
//*----------------------------------------------------------------------*
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Upload FI Doc (Item)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZFI_I_UPLOAD_I
  as select from zfi_tb_upload_i
  association to parent ZFI_I_UPLOAD as _header on  $projection.filename = _header.filename
                                                and $projection.id_doc   = _header.id_doc
{
  key zfi_tb_upload_i.filename,
  key zfi_tb_upload_i.id_doc,
  key zfi_tb_upload_i.id_line,
      zfi_tb_upload_i.accountingdocumentitem,
      zfi_tb_upload_i.postingkey,
      zfi_tb_upload_i.account,
      zfi_tb_upload_i.mainassetnumber,
      zfi_tb_upload_i.subassetnumber,
      zfi_tb_upload_i.specialglaccount,
      zfi_tb_upload_i.assettransactiontype,
      zfi_tb_upload_i.companycodecurrency,
      @Semantics.amount.currencyCode: 'companycodecurrency'
      zfi_tb_upload_i.amountinlocalcurrency,
      zfi_tb_upload_i.transactioncurrency,
      @Semantics.amount.currencyCode: 'transactioncurrency'
      zfi_tb_upload_i.amountindoumentcurrency,
      @Semantics.amount.currencyCode: 'transactioncurrency'
      zfi_tb_upload_i.taxbaseamount,
      zfi_tb_upload_i.assignment,
      zfi_tb_upload_i.businessarea,
      zfi_tb_upload_i.costcenter,
      zfi_tb_upload_i.profitcenter,
      zfi_tb_upload_i.internalorder,
      zfi_tb_upload_i.assetvaluedate,
      zfi_tb_upload_i.itemtext,
      zfi_tb_upload_i.overrideglaccount,
      zfi_tb_upload_i.taxcode,
      zfi_tb_upload_i.segment,
      zfi_tb_upload_i.paymentterms,
      zfi_tb_upload_i.paymentblockreason,
      zfi_tb_upload_i.paymentmethod,
      zfi_tb_upload_i.contractnumber,
      zfi_tb_upload_i.contracttype,
      zfi_tb_upload_i.housebank,
      zfi_tb_upload_i.bankaccountid,
      zfi_tb_upload_i.invoicerefnum,
      zfi_tb_upload_i.invoicefiscalyear,
      zfi_tb_upload_i.invoicereflineitem,
      zfi_tb_upload_i.purchasingno,
      zfi_tb_upload_i.purchasingitem,
      zfi_tb_upload_i.baselinedate,
      zfi_tb_upload_i.valuedate,
      zfi_tb_upload_i.saleorder,
      zfi_tb_upload_i.saleorderitem,
      zfi_tb_upload_i.ref1,
      zfi_tb_upload_i.ref3,
      zfi_tb_upload_i.longtext,
      zfi_tb_upload_i.material,
      zfi_tb_upload_i.unit,
      zfi_tb_upload_i.name1,
      zfi_tb_upload_i.name2,
      zfi_tb_upload_i.city,
      zfi_tb_upload_i.country,
      zfi_tb_upload_i.vatregno,
      @Semantics.quantity.unitOfMeasure: 'unit'
      zfi_tb_upload_i.quantity,
      zfi_tb_upload_i.customer,
      zfi_tb_upload_i.supplier,
      zfi_tb_upload_i.alternativepayee,
      zfi_tb_upload_i.mst,
      zfi_tb_upload_i.hotennc1,
      zfi_tb_upload_i.hotennc2,
      zfi_tb_upload_i.tennccxuathd,
      zfi_tb_upload_i.mstnccxuathd,
      _header
}
