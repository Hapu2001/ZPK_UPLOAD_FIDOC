@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Display log FI'
define root view entity ZFI_I_DIS_UP
  as select distinct from zfi_tb_upload
  association [0..1] to I_User         as I_User on $projection.pst_user = I_User.UserID
  composition [0..*] of ZFI_I_DIS_UP_I as _Item
{
  key   zfi_tb_upload.filename,
  key   zfi_tb_upload.pst_user,
  key   zfi_tb_upload.pst_date,
        i_user.UserDescription,
        _Item

}
