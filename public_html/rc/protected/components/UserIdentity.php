<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CBaseUserIdentity
{
	const ERROR_FB_NOT_SIGNIN = 3;

	private $_name;
	private $_id;
	private $_facebook;
		
	public function __construct($facebook) {
		$this->_facebook = $facebook;
	}
	
	/**
	 * Authenticates a user.
	 * The example implementation makes sure if the username and password
	 * are both 'demo'.
	 * In practical applications, this should be changed to authenticate
	 * against some persistent user identity storage (e.g. database).
	 * @return boolean whether authentication succeeds.
	 */
	public function authenticate()
	{		
		$session = $this->_facebook->getSession();
		Yii::trace($session, "session");
		
		$me = null;
		if($session) {
			try {				
				$me = $this->_facebook->api('/me');
				Yii::trace($me, "me");
			} catch (FacebookApiException $e) {
				error_log($e);
			}
			
		
			if(!$me)
				$this->errorCode = self::ERROR_FB_NOT_SIGNIN;
			else {
				$fb_uid = $this->_facebook->getUser();
				$user = User::model()->find("fb_uid=:fb_uid", array(':fb_uid' => $fb_uid));
				
				if($user === null) {
					$user = new User();
					$user->name = $me['name'];
					$user->fb_uid = $fb_uid;
					$user->reg_time = new CDbExpression('NOW()');
				} 
				
				$user->last_login_time = new CDbExpression('NOW()');
				$user->save();
				
				$this->_id = $user->id;
				$this->_name = $user->name;
				
				$this->errorCode = self::ERROR_NONE;
			}
		}
			
		return !$this->errorCode;
	}
	
	public function getId() {
		return $this->_id;
	}
	
	public function getName() {
		return $this->_name;
	}
}