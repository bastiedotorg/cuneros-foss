<script language="JavaScript">
function show_otp() {
        var url = 'https://www.cuneros.de/otp/%config_exportid%/';
        fenster = window.open(url, "Cuneros OTP", "width=750,height=760,status=yes,scrollbars=yes,resizable=yes");
        fenster.focus();
}

function Check() {
	if(Checkp()) return checkPass();
	else return false;
}

function Checkp() {
	var pwd1 = document.forms.register.u_passwd.value;
	var pwd2 = document.forms.register.u_passwd2.value;
	if(pwd1 != pwd2) {
		alert(unescape('Passw%F6rter stimmen nicht %FCberein!'));
		return false;
	}
	else return true;
}

function checkPass() {
	//Initialize variables
	var errorMsg = "";
	var space  = " ";
	var worth = 10;

	fieldvalue  = document.register.u_passwd.value;
	fieldlength = fieldvalue.length;

	//It must not contain a space
	if (fieldvalue.indexOf(space) > -1) {
		errorMsg += "\nDas Passwort sollte kein Leerzeichen enthalten.\n";
		worth -= 1;
	}

	//It must contain at least one number character
	if (!(fieldvalue.match(/\d/))) {
		errorMsg += "\nGute Passw%F6rter enthalten mindestens eine Ziffer.\n";
		worth -= 3;
	}
	//It must start with at least one letter
	if (!(fieldvalue.match(/^[a-zA-Z]+/))) {
		errorMsg += "\nGute Passw%F6rter enthalten mindestens einen Buchstaben.\n";
		worth -= 4;
	}
	//It must contain at least one upper case character
	if (!(fieldvalue.match(/[A-Z]/))) {
		errorMsg += "\nGute Passw%F6rter enthalten mindestens einen Gro%DFbuchstaben.\n";
		worth -= 1;
	}
	//It must contain at least one lower case character
	if (!(fieldvalue.match(/[a-z]/))) {
		errorMsg += "\nGute Passw%F6rter enthalten mindestens einen Kleinbuchstaben.\n";
		worth -= 1;
	}
	//It must contain at least one special character
	if (!(fieldvalue.match(/\W+/))) {
		errorMsg += "\nGute Passw%F6rter enthalten mindestens ein Sonderzeichen - #,@,%,!\n";
		worth -= 1;
	}
	//It must be at least 7 characters long.
	if (!(fieldlength >= 7)) {
		errorMsg += "\nGute Passw%F6rter sind mindestend 7 Zeichen lang.\n";
		worth -= 3;
	}
	
	if(worth < 1) worth = 0;
	//If there is a problem with the password, display message
	if (errorMsg != "" && worth < 7){
          msg = "______________________________________________________\n\n";
          msg += "Das Passwort weist Schwachstellen auf - Wertung " + worth + " von 10 Punkten\n";
          msg += "W%E4hlen Sie bitte m%F6glichst ein anderes!\n";
          msg += "______________________________________________________\n";
          return confirm(unescape(msg + errorMsg + "\n\n"));
     } else return true;
}
</script>

<form name="register" action="page.php?cat=default&amp;p=register_do" method="post" onsubmit="return Check();">
<center><box title="Anmeldung">
Hier kannst du dich registrieren.
<center>
<table width="400" cellpadding="2" cellspacing="0">
 <tr>
  <td>Gew&uuml;nschter Name</td><td><input type="text" name="u_name" /></td>
 </tr><if var="config_reg_pass_mail" value="1"><then><tr><td colspan="2">Das Passwort wird per Mail zugeschickt!</td></tr></then><else>
 <tr>
  <td>Passwort</td><td><input type="password" name="u_passwd" /> [<a href="JavaScript:void(0);" onclick="window.open('password.php?level=2','passwd','height=200,width=400');">generieren</a>]</td>
 </tr>
 <tr>
  <td>Passwort best&auml;tigen</td><td><input type="password" name="u_passwd2" /></td>
 </tr></else></if>
 <tr>
  <td>eM@il-Adresse</td><td><input type="text" name="email" /></td>
 </tr>
 <tr>
  <td>%transname%</td><td><input type="text" name="export_usr" /></td>
 </tr>
 <tr>
  <td>%transpwdname%<br />(wird nicht gespeichert!)<br />[<a href="JavaScript:void(0);" onclick="show_otp();">OTP erzeugen</a>]</td><td><input type="password" name="export_pwd" /></td>
 </tr>
<tr><td colspan="2">Mit Klick auf Registrieren akzeptierst du die <a href="page.php?p=agb">AGB</a>.</td></tr>
 <tr>
  <td>&nbsp;</td><td align="right"><input type="submit" value="Registrieren!" /></td>
 </tr>
</table></center></box>
</center>
</form>

