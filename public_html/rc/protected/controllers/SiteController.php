<?php

class SiteController extends Controller
{
	//public $layout='//layouts/column1';
	
	private $_facebook = null;
	private $_identity = null;
	
	public function __construct($id, $module=null) {
		parent::__construct($id, $module);
		
		if($this->_facebook === null) {
			$this->_facebook = new Facebook(array(
					'appId' => Yii::app()->params['fbAppId'],
					'secret' => Yii::app()->params['fbAppSecret'],
					'cookie' => true,
				));
		}
	}
	
	/**
	 * Declares class-based actions.
	 */
	public function actions()
	{
		return array(
			// captcha action renders the CAPTCHA image displayed on the contact page
			'captcha'=>array(
				'class'=>'CCaptchaAction',
				'backColor'=>0xFFFFFF,
			),
			// page action renders "static" pages stored under 'protected/views/site/pages'
			// They can be accessed via: index.php?r=site/page&view=FileName
			'page'=>array(
				'class'=>'CViewAction',
			),
		);
	}

	/**
	 * This is the default 'index' action that is invoked
	 * when an action is not explicitly requested by users.
	 */
	public function actionIndex()
	{
		// renders the view file 'protected/views/site/index.php'
		// using the default layout 'protected/views/layouts/main.php'
		$this->render('index');
	}

	/**
	 * This is the action to handle external exceptions.
	 */
	public function actionError()
	{
		if($error=Yii::app()->errorHandler->error)
		{
			if(Yii::app()->request->isAjaxRequest)
				echo $error['message'];
			else
				$this->render('error', $error);
		}
	}

	/**
	 * Displays the contact page
	 */
	public function actionContact()
	{
		$model=new ContactForm;
		if(isset($_POST['ContactForm']))
		{
			$model->attributes=$_POST['ContactForm'];
			if($model->validate())
			{
				$headers="From: {$model->email}\r\nReply-To: {$model->email}";
				mail(Yii::app()->params['adminEmail'],$model->subject,$model->body,$headers);
				Yii::app()->user->setFlash('contact','Thank you for contacting us. We will respond to you as soon as possible.');
				$this->refresh();
			}
		}
		$this->render('contact',array('model'=>$model));
	}
	
	public function actionLogin($path_info="") {
		if($this->_identity === null) {
			$this->_identity = new UserIdentity($this->_facebook);
			//$this->_identity = new FbUserIdentity();
			$this->_identity->authenticate();
		}
				
		if($this->_identity->errorCode === UserIdentity::ERROR_NONE) {
			Yii::app()->user->login($this->_identity, 0);
			if ($path_info === "")
				$this->redirect(Yii::app()->homeUrl);
			else
				$this->redirect($path_info);
		} else {
			$this->redirect($this->_facebook->getLoginUrl());
		}
		//Yii::trace($this->_identity->errorCode, "error code");
	}
	
	public function actionLogout() {
		if(!Yii::app()->user->isGuest) {
			Yii::app()->user->logout();
			$this->redirect($this->_facebook->getLogoutUrl());
		} else {
			$this->redirect(Yii::app()->homeUrl);
		}
	}
	/**
	 * Register user with facebook information
	 *
	 * @return void
	 * @author austintodo
	 **/
	public function actionReg()
	{	
		$this->render("reg");
	}
}
