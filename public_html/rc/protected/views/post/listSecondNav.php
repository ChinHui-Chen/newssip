<nav>
	<ul>
		<?php
			if (isset($posts) and count($posts) > 0) {
				foreach ($posts as $post) {
					//$link_content = "<div><div class=\"NavListItemMetaCount\"><div>".$post->fbLikeCount."</div></div><div class=\"NavListItemActualLinkText\">".$post->title."</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>";
					$link_content = "<div><div class=\"NavListItemMetaCount\">".CHtml::tag("div", array("id"=>"NavListItemMetaCount".$post->id), $post->fbLikeCount, true)."</div><div class=\"NavListItemActualLinkText\">".CHtml::encode($post->title)."</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>";
					echo "<li>";
					echo $post->author->name;
					echo $post->timestamp;
					echo $post->replyCount;
					if ($post->replyCount > 0)
					{
						echo CHtml::ajaxLink(
							$link_content,
							yii::app()->createUrl("post/listThirdNav/".$post->id),
							array(
								'type'=>'GET',
								'success'=>'function(data){
										//$("#third_nav").show("slide", {direction: "right"}, 1000);
										$("#third_nav").show(500);
										$("#third_nav").html("").append(data);
										readjustDimensions(); // <- in main.php
									}',
							),
							array("id"=>"second_nav_".$post->id,
									"href"=>yii::app()->createUrl("post/postDetail", array("id"=>$post->id)))
						);
					}
					else
					{
						//echo CHtml::Link($link_content, yii::app()->createUrl("post/postDetail/".$post->id));
						echo CHtml::ajaxLink(
							$link_content,
							yii::app()->createUrl("post/detail/".$post->id),
							array(
								'type'=>'GET',
								'success'=>'function(data){
										//$("#third_nav").hide("slide", {direction: "left"}, 1000);
										$("#third_nav").hide(500);
										updateDetail(data, "'.$post->title.'","'.yii::app()->createUrl("post/postDetail/".$post->id).'");
										readjustDimensions(); // <- in main.php
									}',
							),
							array("id"=>"second_nav_".$post->id)
									//"href"=>yii::app()->createUrl("post/postDetail", array("id"=>$post->id)))
						);
					}
					echo "</div></div></li>";
				}
			}
		?>
	</ul>
</nav>

