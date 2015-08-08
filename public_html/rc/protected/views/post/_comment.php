<?php
	echo '<article>';
	echo '<span class="push-author">'.$comment->author->name.'</span>: ';
	echo '<span class="push-content">'.$comment->content.'</span>';
	echo '<span class="push-timestamp">'.$comment->timestamp.'</span>';
	echo '</article>';
?>