<nav>
<ul>
<?php
foreach($dataArray as $data)
{
/*
	echo '<li>';
	echo '<div class="listitems">';
	echo '<article>';
	echo '<a href="#" class="second-nav-link" id="'.$data->post['id'].'">'.$data->post['title'].'</a>';
	*/
	/*
	echo '<p>'.CHtml::ajaxLink(
					$data->post['title'], 
					yii::app()->createUrl('post/detail/'.$data->post['id']),
					array(
						"type"=>"GET",
						"success"=>'function(data){
							$("#main_content").replaceWith(data);
						}',
					),
					array("class"=>"second-nav-link", "id"=>"")).'</p>';
					*/
	//echo '<p>'.mb_substr($data->content, 0, 40, UTF-8').'...</p>';
	/*
	echo '<div>';
	echo '<span>Comments: '.$data->post['commentCount'].'</span>';
	echo '<span>Replies: '.$data->post['replyCount'].'</span>';
	echo '<span class="item-author">'.$data->post['author']['name'].'</span>';
	echo '<span class="item-timestamp">'.$data->post['timestamp'].'</span>';
	echo '</div>';
	echo '</article>';
	
	
	echo '</div>';
	echo '</li>';
*/
	
	echo '<li>';
	echo '<div class="listitems">';
	echo '<article>';	
	echo '<a href="#" class="second-nav-link" id="'.$data->id.'">'.$data->title.'</a>';
	echo '<div>';
		echo '<span>Comments: '.$data->commentCount.'</span>';
		echo '<span>Replies: '.$data->replyCount.'</span>';
		echo '<span class="item-author">'.$data->author->name.'</span>';
		echo '<span class="item-timestamp">'.$data->timestamp.'</span>';
	echo '</div>';
	echo '</article>';
	echo '</div>';
	echo '</li>';
	
}
//print_r( Yii::app()->getClientScript());

?>
</ul>
</nav>