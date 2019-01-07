<script language="JavaScript" type="text/javascript" language="JavaScript">
function check(){
	<if var="config_transflex" value="1"><then>var id = document.forms.deposit.id.value;</then><else>var id = '%usr_export%';</else></if>
	var pwd = document.forms.deposit.passwd.value;
	var amount = document.forms.deposit.amount.value;

	if(id==''||pwd==''||amount==''){
		alert('Alle Felder korrekt ausfuellen!');
		return false;
	}
	else if(amount < %config_deposit_min%) {
		alert('Mindstens %config_deposit_min% %curname% muessen eingezahlt werden!');
		return false;
	}
	else {
		var msg = amount+' sollen vom Konto '+id+' abgebucht werden - ist dies korrekt?';
		var empfliste = '';
		if(confirm(msg)){
			document.forms.deposit.absbutton.disabled=true;
			document.forms.deposit.absbutton.value='Bitte warten';
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

<form name="deposit" action="page.php?cat=bank&amp;p=deposit_do" method="post" onsubmit="return check();">
 <center><box title="Einzahlen">
 Hier k&ouml;nnen Sie ihr Konto aufladen!<br />
<center>
<table cellspacing="0">
 <tr>
  <td>Menge</td><td><input type="text" name="amount" /></td>
 </tr> 
 <tr>
  <td>%transname%</td><td><input type="text" name="id" value="%usr_export%" /></td>
 </tr>
 <tr>
  <td>%transpwdname%<br />[<a href="JavaScript:void(0);" onclick="show_otp();">OTP erzeugen</a>]</td><td><input type="password" name="passwd" /></td>
 </tr>
 <tr>
  <td>&nbsp;</td><td align="right"><input type="submit" name="absbutton" value="Einzahlen" /></td>
 </tr>
</table></center></box>
</form><br />
[<a href="page.php?cat=coupon">Halt, ich habe einen Gutschein!</a>]
</center>

