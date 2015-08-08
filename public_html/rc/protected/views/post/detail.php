<article>
	<header>
	<h1><?php echo CHtml::Link($model->title, $model->src_link); ?></h1>
	<h2><span class="detailAuthor"><?php echo $model->author->name;?></span><br /><time datetime="<?php echo $model->timestamp;?>" pubdate="pubdate"><?php echo $model->timestamp;?></time></h2>
	</header>
	<p id="detailContent"><?php echo CHtml::encode($model->content)	; ?><?php echo CHtml::Link(" &rsaquo; 看原文 &raquo;", $model->src_link); ?></p>

	<footer>
	<?php 
	if (yii::app()->user->isGuest)
	{
		echo CHtml::Link("我要回應", "#", array("id"=>"reply", "onclick"=>"$('#pls_login').show();"));
	}
	else
	{
		echo CHtml::ajaxLink(
			"我要回應",
			yii::app()->createUrl("post/replyPost/", array("id"=>$model->id)),
			array(
				'type'=>'GET',
				'success'=>'function(data){
						$("#detail").html("").append(data);
					}',
			),
			array("id"=>"reply")
		);	
	}
	?>
	<div id="pls_login" style="display:none;">
		<?php 
			//echo "Please ".CHtml::Link("Login", yii::app()->createUrl("site/login", 
			//			array("path_info"=>yii::app()->request->pathInfo)))."with FB Account First";
			echo "Please ".CHtml::Link("Login", "#", array("onclick"=>"redirectToLogin();"))."with FB Account First";
			
		?>
	</div>
	</footer>
</article>

<!--<div id="fb-root"></div> -->
	<script>
		function catchLikeAction(value)
		{
			alert("Like!");
			<?php
				$ajaxUrl = yii::app()->createAbsoluteUrl("post/updateFBLike/", array("id"=>$model->id));
			?>
			$.ajax({
				url: '<?php echo $ajaxUrl; ?>',
				data: 'update='+value,
				success: function(data){
					<?php $itemID = "NavListItemMetaCount".$model->id; ?>
					<?php
					/*
					// This function should add 1 to commentCount dynamically.
					// But for now it only add to second_nav, not third_nav.
					// Temporarlly trun off this feature.
					// Comment by austintodo@2011.03.08
					$("#<?php echo $itemID; ?>").fadeOut('slow', function(){
							if (data == 1)
							{
								var fb_like_num = parseInt($(this).html()) + 1;
								$(this).text(fb_like_num);
								$(this).fadeIn();
							}
						});
					*/
					?>
				},
				error: function(data){
					//alert("error");
				}
			});
		}
	/*
	  window.fbAsyncInit = function() {
	    FB.init({appId: '<?php echo yii::app()->params["fbAppId"]; ?>', status: true, cookie: true,
		     xfbml: true});
	
		var likeCounter = 0
		FB.Event.subscribe('edge.create', function(response) {
			if (likeCounter == 0)
			{
				likeCounter++;
				catchLikeAction(1);
			}

		});
		FB.Event.subscribe('edge.remove', function(href, widget, response) {
			catchLikeAction(-1);
		});
		headObj = $("head");
		keywordObj = $(headObj).find("meta[property='og:title']");
		newKeywords = $(keywordObj).attr("test title");
		//newKeywords += myKeywords; 
		$(keywordObj).attr("content", newKeywords);
	  };
	
	  (function() {
	    var e = document.createElement('script'); e.async = true;
	    e.src = document.location.protocol +
	      '//connect.facebook.net/zh_TW/all.js';
	    document.getElementById('fb-root').appendChild(e);
	  }());
	*/
	 FB.XFBML.parse();
	</script>
	<?php
		$post_detail_url = yii::app()->createAbsoluteUrl("post/postDetail", array("id"=>$model->id));
	?>
	<fb:like href="<?php echo $post_detail_url; ?>" layout="box_count" show_faces="false" width="450" action="recommend"></fb:like>
	<fb:comments href="<?php echo $post_detail_url; ?>" num_posts="3" width="450"></fb:comments>