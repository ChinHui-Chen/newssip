<h1><?php echo ucfirst(($category->name)); ?></h1>

<?php 

foreach($dataArray as $data)
{
	echo '<div class="items">';
	echo '<aside>100</aside>';
	echo '<article>';
	echo '<h2>'.CHtml::Link($data->title, array("/post/detail/", "id"=>$data->id)).'</h2>';
	//echo '<p>'.mb_substr($data->content, 0, 40, UTF-8').'...</p>';
	echo '<div>';
	echo '<span>Comments: '.$data->commentCount.'</span>';
	echo '<span>Replies: '.$data->replyCount.'</span>';
	echo '<author>'.$data->author->name.'</author>';
	echo '<timestamp>'.$data->timestamp.'</timestamp>';
	echo '</div>';
	echo '</article>';
	echo '</div>';
}

?>
