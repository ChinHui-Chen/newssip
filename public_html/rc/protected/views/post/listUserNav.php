<nav>
	<ul>
		<li>
			<?php
			echo CHtml::ajaxLink(
		 		"<div><div class=\"NavListItemActualLinkText\">最新文章</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>",
				yii::app()->createUrl("post/listSecondNavByTime/"),
		 		array(
		 			'type'=>'GET',
		 			'success'=>'function(data){
							updateSecondNav(data, 1);
							readjustDimensions(); // <- in main.php
		 				}',
		 		),
		 		array()
		 	);	
			?>
		</li>
		<li>
			<?php
			/*
			echo CHtml::ajaxLink(
		 		"<div><div class=\"NavListItemActualLinkText\">Hottest News</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>",
				yii::app()->createUrl("post/listSecondNavByHot/"),
		 		array(
		 			'type'=>'GET',
		 			'success'=>'function(data){
		 					$("#second_nav").html("").append(data);
							readjustDimensions(); // <- in main.php
		 				}',
		 		),
		 		array()
		 	);
			*/
			?>
		</li>
		<?php
			 foreach($categories as $category)
			 {
			 	echo "<li>";
			 	echo CHtml::ajaxLink(
			 		"<div><div class=\"NavListItemActualLinkText\">".$category->name."</div><div class=\"NavListItemRightArrow\"><div>&rsaquo;</div></div></div>",
					yii::app()->createUrl("post/listSecondNav/".$category->id),
			 		array(
			 			'type'=>'GET',
			 			'success'=>'function(data){
			 					updateSecondNav(data, 1);
								readjustDimensions(); // <- in main.php
			 				}',
			 		),
			 		array()
			 	);
			 	echo "</li>";
			 }
		?>
	</ul>
</nav>