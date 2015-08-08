<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="zh-tw" />
	
	<?php 
		if (isset($this->fbMetaData) and isset($this->fbMetaData['title']))
		{
			echo '<meta property="og:title" content="'.$this->fbMetaData['title'].'"/>';
			echo '<meta property="og:type" content="news"/>';
		}
	?>
	
	
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/main.css" />
  	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/header.css" />
  	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/aside.css" />
  	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/content.css" />
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/form.css" />

	<title><?php echo CHtml::encode($this->pageTitle); ?></title>
	<?php
	Yii::app()->clientScript->registerCoreScript('jquery.ui');
	?>
	<script>
	function readjustDimensions(){
		var targetHeight = $(window).height() - $("#main_header").outerHeight() - $("#main_footer").outerHeight();
		$("#main_section").css("height", targetHeight + "px");
		$("#user_nav").css("max-height", targetHeight + "px");
		$("#second_nav").css("max-height", targetHeight + "px");
		$("#third_nav").css("max-height", targetHeight + "px");
		$("#detail").css("max-height", targetHeight + "px");
	}
	$(window).resize(readjustDimensions);
	$(window).ready(readjustDimensions);	
	$(window).load(readjustDimensions); // after logo loads we need to resize again
	$(document).ready(function(){$("#second_nav").hide();$("#third_nav").hide();});
	function updateSecondNav(data, type)
	{
		if (type == 1)
		{
			$("#second_nav").show(500);
			$("#second_nav").html("").append(data);
		}
			
	}
	function updateDetail(data, title, url)
	{
		document.title = title;
		$("#detail").html("").append(data);
		var state = {data: data, title: title, url: url}
		history.pushState(state, title, url);
	}
	function replaceDetail(data, title, url)
	{
		$("#detail").html("").append(data);
		var state = {data: data, title: title, url: url}
		history.replaceState(state, title, url);
	}
	function redirectToLogin()
	{
		window.location="<?php echo yii::app()->createUrl('site/login/'); ?>/?path_info=" + document.URL;
	}
	window.onpopstate = function(event){
		//alert("location: " + document.location + ", state: " + JSON.stringify(event.state));
		if (event.state != null && event.state.url != null && event.state.data != null)
			replaceDetail(event.state.data, event.state.title, event.state.url);
	};
	/*
	function slideLeftHide()
	{
		return this.each(function(){
			$(this).hide('slide', {direction: 'left'}, 1000);
		});
	}
	*/
	</script>
</head>

<body>
	<header id="main_header">
		<div id="logo">
			<?php echo CHtml::Link('<img src="'.Yii::app()->request->baseUrl.'/images/title_180_50.jpg"/>', Yii::app()->createUrl("post/index")); ?>
		</div>

		<form action="">
			<input value placeholder="Submit a link" name="url" id="search-query" type="text" size="60" />
			<?php 
				if (yii::app()->user->isGuest )
				{
					echo CHtml::htmlButton("Go", array("id"=>"search-submit", "onclick"=>"$('#login_notification').show();"));
				}
				else
				{
					echo CHtml::ajaxSubmitButton("Go", 
							$this->createUrl('post/ajaxCreate'), 
							array('onclick'=>'$("#postdialog").dialog("open"); return false;',
									'update'=>'#postdialog'),
							array('id'=>'search-submit')
						);
				}
			?>	
		</form>
		<div id="login_notification" style="display:none;"><?php echo "Please ".CHtml::Link("Login", yii::app()->createUrl("site/login", 
				array("path_info"=>yii::app()->request->pathInfo)))."with FB Account First";
		?></div>
		<div id="postdialog"></div>

		<div id="global-nav" style="float:right;">
			<?php //echo CHtml::Link("All News", Yii::app()->baseUrl."/post/news/1"); ?>
			<?php 
				if (yii::app()->user->isGuest)
					echo CHtml::Link("Login", yii::app()->createUrl("/site/login")); 
				else
					echo CHtml::Link("Logout(".yii::app()->user->name.")", Yii::app()->baseUrl."/site/logout"); 	
			?>
		</div>

		
		<div id="fb-root"></div>
			<script>
		      window.fbAsyncInit = function() {
			    FB.init({appId: '<?php echo yii::app()->params["fbAppId"]; ?>', status: true, cookie: true,
			             xfbml: true});

				var likeCounter = 0
				FB.Event.subscribe('edge.create', function(response) {
					if (likeCounter == 0)
					{
						likeCounter++;
						//catchLikeAction(1);
					}

				});
				FB.Event.subscribe('edge.remove', function(href, widget, response) {
					//catchLikeAction(-1);
				});
				FB.Event.subscribe('auth.login', function(response){
					//window.location.href =("<?php echo yii::app()->createAbsoluteUrl('site/login'); ?>");	
				});
				FB.Event.subscribe('auth.logout', function(response){
					//window.location.href =("<?php echo yii::app()->createAbsoluteUrl('site/logout'); ?>");	
				});
			  };

			  (function() {
			    var e = document.createElement('script'); e.async = true;
			    e.src = document.location.protocol +
			      '//connect.facebook.net/zh_TW/all.js';
			    document.getElementById('fb-root').appendChild(e);
			  }());
			</script>
		<?php
		//<fb:login-button id="fb_login_button"></fb:login-button>
		?>
	</header>

	<section id="main_section">
		<?php echo $content; ?>	
	</section>
	
	<footer id="main_footer">
		Copyright &copy; <?php echo date('Y'); ?> by RiverCrab.<br/>
		All Rights Reserved.
	</footer>
</body>
</html>

