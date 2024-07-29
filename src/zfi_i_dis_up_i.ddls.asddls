@ObjectModel.query.implementedBy: 'ABAP:ZCL_FI_DIS_UP_I'
@EndUserText.label: 'Display log Item'
define custom entity ZFI_I_DIS_UP_I
{
  @UI                    : {

     facet                 : [
             {  id: 'informationitem',
                type: #COLLECTION,
                label: 'Item Information',
                position: 10 },
             {  parentId: 'informationitem',
                id: 'itemInfomation',
                type: #IDENTIFICATION_REFERENCE,
                purpose: #STANDARD,
                position: 10 }
             ] }
      @UI                     : {
          lineItem            : [{ position: 10 , importance: #MEDIUM } ],
          identification      : [{ position: 10 }]
          }
  key filename                : zde_filename;
      @UI                     : { lineItem : [{ position: 11 }] , identification      : [{ position: 11 }]  }
  key pst_user                : uname;
      @UI                     : { lineItem : [{ position: 11 } ], identification      : [{ position: 11 }]  }
  key pst_date                : abap.dats;
      @UI                     : {
         lineItem             : [{ position: 20 , importance: #MEDIUM } ],
         identification       : [{ position: 20 }]
         }

  key id_doc                  : zde_id_doc;
      @UI                     : {
         lineItem             : [{ position: 21 , importance: #MEDIUM } ],
         identification       : [{ position: 21 }]
         }
  key id_line                 : zde_id_line;
      @UI                     : {
       lineItem               : [{ position: 30 , importance: #MEDIUM } ],
       identification         : [{ position: 30 }]
       }
      companycode             : bukrs;
      @UI                     : {
      lineItem                : [{ position: 40 , importance: #MEDIUM } ],
      identification          : [{ position: 40 }]
      }
      accountingdocument      : belnr_d;
      @UI                     : {
      lineItem                : [{ position: 50 , importance: #MEDIUM } ],
      identification          : [{ position: 50 }]
      }
      fiscalyear              : gjahr;
      @UI                     : {
      lineItem                : [{ position: 60 , importance: #MEDIUM } ],
      identification          : [{ position: 60 }]
      }
      documentdate            : abap.dats;
      @UI                     : {
      lineItem                : [{ position: 70 , importance: #MEDIUM } ],
      identification          : [{ position: 70 }]
      }
      postingdate             : abap.dats;
      @UI                     : {
      lineItem                : [{ position: 80 , importance: #MEDIUM } ],
      identification          : [{ position: 80 }]
      }
      documenttype            : blart;
      @UI                     : {
      lineItem                : [{ position: 90 , importance: #MEDIUM } ],
      identification          : [{ position: 90 }]
      }
      currency                : waers;
      @UI                     : {
      lineItem                : [{ position: 100 , importance: #MEDIUM } ],
      identification          : [{ position: 100 }]
      }
      exchangerate            : zde_kursf;
      @UI                     : {
      lineItem                : [{ position: 110 , importance: #MEDIUM } ],
      identification          : [{ position: 110 }]
      }
      headertext              : bktxt;
      @UI                     : {
      lineItem                : [{ position: 120 , importance: #MEDIUM } ],
      identification          : [{ position: 120 }]
      }
      referencedoc            : xblnr1;
      @UI                     : {
      lineItem                : [{ position: 130 , importance: #MEDIUM } ],
      identification          : [{ position: 130 }]
      }
      headerref1              : zde_xref1;
      @UI                     : {
      lineItem                : [{ position: 140 , importance: #MEDIUM } ],
      identification          : [{ position: 140 }]
      }
      negativeposting         : abap.char(1);
      @UI                     : {
      lineItem                : [{ position: 140 , importance: #MEDIUM } ],
      identification          : [{ position: 140 }]
      }
      ispst                   : zde_ispst;
      @UI                     : {
      lineItem                : [{ position: 140 , importance: #MEDIUM } ],
      identification          : [{ position: 140 }]
      }
      upd_user                : zde_upd_user;
      @UI                     : {
      lineItem                : [{ position: 140 , importance: #MEDIUM } ],
      identification          : [{ position: 140 }]
      }
      upd_date                : zde_upd_date;

      @UI                     : {
      lineItem                : [{ position: 150 , importance: #MEDIUM } ],
      identification          : [{ position: 150 }]
      }
      accountingdocumentitem  : buzei;
      @UI                     : {
      lineItem                : [{ position: 151 , importance: #MEDIUM } ],
      identification          : [{ position: 151 }]
      }
      postingkey              : bschl;
      @UI                     : {
      lineItem                : [{ position: 152 , importance: #MEDIUM } ],
      identification          : [{ position: 152 }]
      }
      account                 : hkont;
      @UI                     : {
      lineItem                : [{ position: 153 , importance: #MEDIUM } ],
      identification          : [{ position: 153 }]
      }
      mainassetnumber         : zde_anln1;
      @UI                     : {
      lineItem                : [{ position: 154 , importance: #MEDIUM } ],
      identification          : [{ position: 154 }]
      }
      subassetnumber          : zde_anln2;
      @UI                     : {
      lineItem                : [{ position: 155 , importance: #MEDIUM } ],
      identification          : [{ position: 155 }]
      }
      specialglaccount        : abap.char(1);
      @UI                     : {
      lineItem                : [{ position: 156 , importance: #MEDIUM } ],
      identification          : [{ position: 156 }]
      }
      assettransactiontype    : abap.char(3);
      @UI                     : {
      lineItem                : [{ position: 157 , importance: #MEDIUM } ],
      identification          : [{ position: 157 }]
      }
      companycodecurrency     : abap.cuky;
      @UI                     : {
      lineItem                : [{ position: 158 , importance: #MEDIUM } ],
      identification          : [{ position: 158 }]
      }
      @Semantics.amount.currencyCode : 'companycodecurrency'
      @EndUserText.label: 'Amount in local currency'
      amountinlocalcurrency   : fins_vwcur12;
      @UI                     : {
      lineItem                : [{ position: 159 , importance: #MEDIUM } ],
      identification          : [{ position: 159 }]
      }
      transactioncurrency     : abap.cuky;
      @UI                     : {
      lineItem                : [{ position: 160 , importance: #MEDIUM } ],
      identification          : [{ position: 160 }]
      }
      @Semantics.amount.currencyCode : 'transactioncurrency'
      @EndUserText.label: 'Amount in doument currency'
      amountindoumentcurrency : fins_vwcur12;
      @UI                     : {
      lineItem                : [{ position: 161 , importance: #MEDIUM } ],
      identification          : [{ position: 161 }]
      }
      @Semantics.amount.currencyCode : 'companycodecurrency'
      @EndUserText.label: 'Tax base amount'
      taxbaseamount           : fins_vwcur12;
      @UI                     : {
      lineItem                : [{ position: 162 , importance: #MEDIUM } ],
      identification          : [{ position: 162 }]
      }
      assignment              : dzuonr;
      @UI                     : {
      lineItem                : [{ position: 163 , importance: #MEDIUM } ],
      identification          : [{ position: 163 }]
      }
      businessarea            : gsber;
      @UI                     : {
      lineItem                : [{ position: 164 , importance: #MEDIUM } ],
      identification          : [{ position: 164 }]
      }
      costcenter              : kostl;
      @UI                     : {
      lineItem                : [{ position: 165 , importance: #MEDIUM } ],
      identification          : [{ position: 165 }]
      }
      profitcenter            : prctr;
      @UI                     : {
      lineItem                : [{ position: 166 , importance: #MEDIUM } ],
      identification          : [{ position: 166 }]
      }
      internalorder           : aufnr;
      @UI                     : {
      lineItem                : [{ position: 167 , importance: #MEDIUM } ],
      identification          : [{ position: 167 }]
      }
      assetvaluedate          : abap.numc(8);
      @UI                     : {
      lineItem                : [{ position: 168 , importance: #MEDIUM } ],
      identification          : [{ position: 168 }]
      }
      itemtext                : sgtxt;
      @UI                     : {
      lineItem                : [{ position: 169 , importance: #MEDIUM } ],
      identification          : [{ position: 169 }]
      }
      overrideglaccount       : hkont;
      @UI                     : {
      lineItem                : [{ position: 170 , importance: #MEDIUM } ],
      identification          : [{ position: 170 }]
      }
      taxcode                 : bukrs;
      @UI                     : {
      lineItem                : [{ position: 171 , importance: #MEDIUM } ],
      identification          : [{ position: 171 }]
      }
      segment                 : abap.char(10);
      @UI                     : {
      lineItem                : [{ position: 172 , importance: #MEDIUM } ],
      identification          : [{ position: 172 }]
      }
      paymentterms            : dzterm;
      @UI                     : {
      lineItem                : [{ position: 173 , importance: #MEDIUM } ],
      identification          : [{ position: 173 }]
      }
      paymentblockreason      : abap.char(1);
      @UI                     : {
      lineItem                : [{ position: 174 , importance: #MEDIUM } ],
      identification          : [{ position: 174 }]
      }
      paymentmethod           : abap.char(1);
      @UI                     : {
      lineItem                : [{ position: 175 , importance: #MEDIUM } ],
      identification          : [{ position: 175 }]
      }
      contractnumber          : abap.char(13);
      @UI                     : {
      lineItem                : [{ position: 176 , importance: #MEDIUM } ],
      identification          : [{ position: 176 }]
      }
      contracttype            : abap.char(1);
      @UI                     : {
      lineItem                : [{ position: 177 , importance: #MEDIUM } ],
      identification          : [{ position: 177 }]
      }
      housebank               : hbkid;
      @UI                     : {
      lineItem                : [{ position: 178 , importance: #MEDIUM } ],
      identification          : [{ position: 178 }]
      }
      bankaccountid           : hktid;
      @UI                     : {
      lineItem                : [{ position: 179 , importance: #MEDIUM } ],
      identification          : [{ position: 179 }]
      }
      invoicerefnum           : abap.char(10);
      @UI                     : {
      lineItem                : [{ position: 180 , importance: #MEDIUM } ],
      identification          : [{ position: 180 }]
      }
      invoicefiscalyear       : abap.numc(4);
      @UI                     : {
      lineItem                : [{ position: 181 , importance: #MEDIUM } ],
      identification          : [{ position: 181 }]
      }
      invoicereflineitem      : abap.numc(3);
      @UI                     : {
      lineItem                : [{ position: 182 , importance: #MEDIUM } ],
      identification          : [{ position: 182 }]
      }
      purchasingno            : ebeln;
      @UI                     : {
      lineItem                : [{ position: 183 , importance: #MEDIUM } ],
      identification          : [{ position: 183 }]
      }
      purchasingitem          : ebelp;
      @UI                     : {
      lineItem                : [{ position: 184 , importance: #MEDIUM } ],
      identification          : [{ position: 184 }]
      }
      baselinedate            : abap.dats;
      @UI                     : {
          lineItem            : [{ position: 185 , importance: #MEDIUM } ],
          identification      : [{ position: 185 }]
          }
      valuedate               : abap.dats;
      @UI                     : {
      lineItem                : [{ position: 186 , importance: #MEDIUM } ],
      identification          : [{ position: 186 }]
      }
      saleorder               : abap.char(10);
      @UI                     : {
      lineItem                : [{ position: 187 , importance: #MEDIUM } ],
      identification          : [{ position: 187 }]
      }
      saleorderitem           : abap.numc(6);
      @UI                     : {
      lineItem                : [{ position: 188 , importance: #MEDIUM } ],
      identification          : [{ position: 188 }]
      }
      ref1                    : abap.char(20);
      @UI                     : {
      lineItem                : [{ position: 189 , importance: #MEDIUM } ],
      identification          : [{ position: 189 }]
      }
      ref2                    : abap.char(20);
      @UI                     : {
      lineItem                : [{ position: 190 , importance: #MEDIUM } ],
      identification          : [{ position: 190 }]
      }
      ref3                    : abap.char(20);
      @UI                     : {
      lineItem                : [{ position: 191 , importance: #MEDIUM } ],
      identification          : [{ position: 191 }]
      }
      longtext                : abap.char(100);
      @UI                     : {
      lineItem                : [{ position: 192 , importance: #MEDIUM } ],
      identification          : [{ position: 192 }]
      }
      material                : matnr;
      @UI                     : {
      lineItem                : [{ position: 193 , importance: #MEDIUM } ],
      identification          : [{ position: 193 }]
      }
      unit                    : abap.unit(2);
      @UI                     : {
      lineItem                : [{ position: 194 , importance: #MEDIUM } ],
      identification          : [{ position: 194 }]
      }
      name1                   : abap.char(40);
      @UI                     : {
      lineItem                : [{ position: 195 , importance: #MEDIUM } ],
      identification          : [{ position: 195 }]
      }
      name2                   : abap.char(40);
      @UI                     : {
      lineItem                : [{ position: 196 , importance: #MEDIUM } ],
      identification          : [{ position: 196 }]
      }
      city                    : abap.char(40);
      @UI                     : {
      lineItem                : [{ position: 197 , importance: #MEDIUM } ],
      identification          : [{ position: 197 }]
      }
      country                 : abap.char(3);
      @UI                     : {
      lineItem                : [{ position: 198 , importance: #MEDIUM } ],
      identification          : [{ position: 198 }]
      }
      vatregno                : stceg;
      @UI                     : {
      lineItem                : [{ position: 199 , importance: #MEDIUM } ],
      identification          : [{ position: 199 }]
      }
      @Semantics.quantity.unitOfMeasure : 'unit'
      quantity                : menge_d;
      @UI                     : {
      lineItem                : [{ position: 200 , importance: #MEDIUM } ],
      identification          : [{ position: 200 }]
      }
      customer                : abap.char(10);
      @UI                     : {
      lineItem                : [{ position: 201 , importance: #MEDIUM } ],
      identification          : [{ position: 201 }]
      }
      supplier                : lifnr;
      @UI                     : {
      lineItem                : [{ position: 202 , importance: #MEDIUM } ],
      identification          : [{ position: 202 }]
      }
      alternativepayee        : lifnr;
      @UI                     : {
      lineItem                : [{ position: 203 , importance: #MEDIUM } ],
      identification          : [{ position: 203 }]
      }
      mst                     : abap.char(20);
      @UI                     : {
      lineItem                : [{ position: 204 , importance: #MEDIUM } ],
      identification          : [{ position: 204 }]
      }
      hotennc1                : abap.char(40);
      @UI                     : {
      lineItem                : [{ position: 205 , importance: #MEDIUM } ],
      identification          : [{ position: 205 }]
      }
      hotennc2                : abap.char(40);
      @UI                     : {
      lineItem                : [{ position: 206 , importance: #MEDIUM } ],
      identification          : [{ position: 206 }]
      }
      tennccxuathd            : abap.char(80);
      @UI                     : {
      lineItem                : [{ position: 207 , importance: #MEDIUM } ],
      identification          : [{ position: 207 }]
      }
      mstnccxuathd            : abap.char(80);



      _HEADER                 : association to parent ZFI_I_DIS_UP on  $projection.filename = _HEADER.filename
                                                                   and $projection.pst_user = _HEADER.pst_user
                                                                   and $projection.pst_date = _HEADER.pst_date;

}
