<?php
/**
	Cuneros API Modul for FrameWork X
	(C) 2019 by bastie dot space
*/
require_once("lib/cuneros_api.class.inc.php");

/** Data Section - do NOT change ANYTHING!
	exportid,exportpwd,exportadd;Cuneros;Cuneros Benutzername;OTP
*/

class Trans {
	/** PHP 5 Version */

	public $version = "0.1"; //constant
	protected $config; // array
	protected $access; // Access Instance

	/** Constructor Trans (
		array $config (Configuration from DB)
	 );
	*/

	public function __construct($config) {
		$this->config = $config;
	}
	
	public function init_api($user, $otp) {
		$this->access = new Access($otp, $user, $this->config["exportpasswd"], $this->config["exportid"]);
	}

	public function api_stats_update() {
		transupdate($this->access->data->api_data->account_balance,
			$this->access->data->api_data->safe_balance,
			$this->access->data->api_data->requests_left,
			$this->access->data->api_data->requests_left
		);
	}
	/** method Get (
		string $usr, (get from User (KlammID))
		string $usrpwd, (Password of User (Losepasswort))
		string $amount, (Amount of "Lose")
		string $subject (Subject -> will be urlencoded)
	 );
	*/
	

	function Get($usr,$usrpwd,$amount,$subject) {
		$this->init_api($usr, $usrpwd);
		$data = $this->access->get($amount, $subject);

		$check[0] = $this->Check();
		$check[1] = $this->access->data->api_data->account_balance;
		$check[2] = urldecode($usr);
		$this->api_stats_update();

	 return $check;
	}
	
	/** method Send (
		string $usr, (send to User (KlammID))
		string $amount, (Amount of "Lose")
		string $subject (Subject -> will be urlencoded)
	 );
	*/
	
	function Send($usr,$usrpwd,$amount,$subject) {
		$this->init_api($usr, $usrpwd);
		$data = $this->access->send($amount, $subject);

		$check[0] = $this->Check();
		$check[1] = $this->access->data->api_data->account_balance;
		$check[2] = urldecode($usr);

		$this->api_stats_update();

	 return $check;
	}

	/** method Validate (
		string $usr, (validate User)
		string $usrpwd (Password of User)
	 );
	*/

	function Validate($usr,$usrpwd) {
		$this->init_api($usr, $usrpwd);
		$data = $this->access->info();

		$check[0] = $this->Check();
		$check[1] = $this->access->data->api_data->account_balance;
		$check[2] = urldecode($usr);
		$this->api_stats_update();

	 return $check;

	}
	
	/** method Secure (
	  int $amount
	 );
	*/
	
	function Secure($amount, $id = 0) {
		$this->init_api('', '');
		$data = $this->access->send_safe($amount, $id);

		$check[0] = $this->Check();
		$check[1] = $this->access->data->api_data->account_balance;
		$this->api_stats_update();

		return $check;
	}
	
	/** protected method Check (
		int $errnum (given by script)
	 );
	*/

	function Check() {
		if ($this->access->get_status()) return "0";
		else if ($this->access->get_error_number() == 720) return $this->access->get_error_message() . ' Detektierte IP: '.$this->access->server_ip;
		else return $this->access->get_error_message();
	}

	function getAbuse() {
		return $this->access->get_blocked_users();
	}
}

