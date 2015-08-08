<nav>
	<ul>
		<?php
			if (isset($posts) and count($posts) > 0) {
				foreach ($posts as $post)
				{
					$link_content = "<div><div class=\"NavListItemMetaCount\"><div>".CHtml::tag("div", array("id"=>"NavListItemMetaCount".$post->id), $post->fbLikeCount, true)."</div></div><div class=\"NavListItemActualLinkText\">".CHtml::encode($post->title)."</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>";					
					echo "<li>";
					// I haven't decided yet to use normal href or ajax here.
					// commented by austintodo@2011.03.05
					//echo CHtml::Link($link_content, yii::app()->createUrl("post/postDetail/".$post->id));

					echo CHtml::ajaxLink(
						$link_content,
						yii::app()->createUrl("post/detail/".$post->id),
						array(
							'type'=>'GET',
							'success'=>'function(data){
									updateDetail(data, "'.$post->title.'","'.yii::app()->createUrl("post/postDetail/".$post->id).'");
									$("#detail").html("").append(data);
									readjustDimensions(); // <- in main.php
								}',
						),
						array("id"=>"third_nav_".$post->id)
					);

					foreach ($post->replies as $reply) {
						echo "<li>";
						$link_content = "<div><div class=\"NavListItemMetaCount\"><div>".CHtml::tag("div", array("id"=>"NavListItemMetaCount".$reply->posts->id), $reply->posts->fbLikeCount, true)."</div></div><div class=\"NavListItemActualLinkText\">".CHtml::encode($reply->posts->title)."</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>";					
						//echo CHtml::Link($link_content, yii::app()->createUrl("post/postDetail/".$reply->posts->id));

						echo CHtml::ajaxLink(
							$link_content,
							yii::app()->createUrl("post/detail/".$reply->posts->id),
							array(
								'type'=>'GET',
								'success'=>'function(data){
										updateDetail(data, "'.$reply->posts->title.'","'.yii::app()->createUrl("post/postDetail/".$reply->posts->id).'");
										//$("#detail").html("").append(data);
										readjustDimensions(); // <- in main.php
									}',
							),
							array("id"=>"third_nav_".$reply->posts->id)
						);

					}
				}
			}
		?>
	</ul>
</nav>

