<?php

/**
 *	Cuneros API Class for PHP scripts
 *	(C) 2019 by bastie dot space
 */

class Access {
    public $otp = false;
    public $api_key = '';
    public $project_id = 1;
    public $server = 'https://www.cuneros.de/api/';
    public $user = "";
    public $amount = 0;
    public $response = false;
    public $error_id = 0;
    public $error_string = "";
    public $server_ip = "";

	public function __construct($otp, $user, $api_key, $project_id) {
		$this->otp = $otp;
		$this->user = $user;
		$this->api_key = $api_key;
		$this->project_id = $project_id;
	}

	protected function gen_hash($otp, $src, $dst, $api_key, $action, $amount) {
		$str = sprintf("%s%s%s%s%s%s", $otp, $src, $dst, $api_key, $action, $amount);
		$hash = hash("sha512", $str);
		return $hash;
	}

	protected function build_params($src, $dst, $action, $amount, $subject, $own_id) {

	        $hash = $this->gen_hash($this->otp, $src, $dst, $this->api_key, $action, $amount);

	        return array(
	            'hash' => $hash,
	            'src' => $src,
	            'dst' => $dst,
//	            'api_key' => $this->api_key, // api key is no longer mandatory, as it is included in the hash.
        	    'action' => $action,
        	    'amount' => $amount,
        	    'subject' => $subject,
        	    'project' => $this->project_id,
        	    'otp' => $this->otp,
                    'external_id' => $own_id
        	);
	}

	protected function server_request($server, $action_url, $data) {
		$string = $server . $action_url . "?" . $data;
		$fp  = file_get_contents($string);
		return json_decode($fp);
	}


	protected function request($src, $dst, $action, $amount, $subject, $own_id) {
		$action_url = 'access/';
		$dat = http_build_query($this->build_params($src, $dst, $action, $amount, $subject, $own_id));
		$data = $this->server_request($this->server, $action_url, $dat);
		$this->error_id = $data->error_code;
		$this->error_string = $data->error_message;
		$this->server_ip = $data->ip;
		return $data;
	}

	public function info() {
		return $this->request($this->user, 0, "info", 0, "", "");
	}

	public function send($amount, $subject, $own_id=False) {
		return $this->request(0, $this->user, "send", $amount, $subject, $own_id);
	}

	public function get($amount, $subject, $own_id=False) {
		return $this->request($this->user, 0, "get", $amount, $subject, $own_id);
	}

	public function get_error_number() {
		return $this->error_id;
	}
	public function get_error_message() {
		return $this->error_string;
	}
	public function get_status() {
		return (0 == $this->error_id);
	}

	public function check_transaction($own_id) {
		return $this->request(0, 0, "check_transaction", 0, '', $own_id);
	}
	public function send_safe($amount, $own_id) {
		return $this->request(0, 0, "safe", $amount, "", $own_id);
	}


	public function get_blocked_users() {
		return 	$this->server_request($this->server, "blocks/", "");
	}

	public function get_blocked_user($username) {
		$str = "blocks/" . $username . "/";
		return 	$this->server_request($this->server, $str, "");
	}


}

