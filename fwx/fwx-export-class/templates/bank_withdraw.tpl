<script language="JavaScript" type="text/javascript" language="JavaScript">
function check(){
	<if var="config_transflex" value="1"><then>var id = document.forms.withdraw.id.value;</then><else>var id = '%usr_export%';</else></if>
	var pwd = document.forms.withdraw.passwd.value;
	var amount = document.forms.withdraw.amount.value;
		
		if(id==''||pwd==''||amount==''){
			alert('Alle Felder korrekt ausf&uuml;llen!');
			return false;
		}
		else if(amount < %config_withdrawel_min%) {
			alert('Mindstens %config_withdrawel_min% %curname% m&uuml;ssen ausgezahlt werden!');
			return false;
		}
		else {
				var msg = amount+' sollen auf das Konto '+id+' gebucht werden - ist dies korrekt?';
				var empfliste = '';
				if(confirm(msg)){
					document.forms.withdraw.absbutton.disabled=true;
					document.forms.withdraw.absbutton.value='Bitte warten';
					return true;
				}
				return false;
			}
		}
function show_otp() {
        var url = 'https://www.cuneros.de/otp/%config_exportid%/';
        fenster = window.open(url, "Cuneros OTP", "width=750,height=760,status=yes,scrollbars=yes,resizable=yes");
        fenster.focus();
}

</script>

<form name="withdraw" action="page.php?cat=bank&amp;p=withdraw_do" method="post" onSubmit="return check();">
<input type="hidden" name="hash" value="%hash%" />
 <center><box title="Auszahlen">
Hier k&ouml;nnen Sie sich auszahlen lassen.<br /><br />
<center>
<table cellspacing="0">
 <tr>
  <td>Menge</td><td><input type="text" name="amount" /></td>
 </tr> 
<if var="config_transflex" value="1"><then> <tr>
  <td>%transname%</td><td><input type="text" name="id" value="%usr_export%" /></td>
 </tr></then></if>
 <tr>
  <td>%transpwdname%<br />[<a href="JavaScript:void(0);" onclick="show_otp();">OTP erzeugen</a>]</td><td><input type="password" name="passwd" /></td>
 </tr>
 <if var="config_withdrawel_captcha" value="on"><then><tr><td>SicherheitsCode<br />Geben Sie den nebenstehenden Code ein!</td><td><img src="captcha.php?hash=%hash%" border="0" /><br /><input type="text" name="code" value="" /></td></tr></then></if>
 <tr>
  <td>&nbsp;</td><td align="right"><input type="submit" name="absbutton" value="Auszahlen" /></td>
 </tr>
</table></center>
</box></form>
</center>

