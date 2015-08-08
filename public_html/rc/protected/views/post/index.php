<script>
$(document).ready(function(){
	$.ajax({
		url: '<?php echo yii::app()->createUrl(yii::app()->controller->id."/listUserNav"); ?>',
		success: function(data){
			$("#user_nav").html("").append(data);
		}
	});
	
	
});
</script>

<p>This is Index</p>



<?php
/*
<?php
$this->breadcrumbs=array(
	'Posts',
);

$this->menu=array(
	array('label'=>'Create Post', 'url'=>array('create')),
	array('label'=>'Manage Post', 'url'=>array('admin')),
);
?>

<h1>Posts</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
*/
?>