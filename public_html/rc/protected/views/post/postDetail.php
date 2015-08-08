<?php
	$listUserNavUrl = yii::app()->createUrl(yii::app()->controller->id."/listUserNav");
	$listSecondNavUrl = yii::app()->createUrl(yii::app()->controller->id."/listSecondNav", array("id"=>$model->category_id));
	if ($model->replyCount > 0 or $model->parent_id != 0)
	{
		if ($model->parent_id != 0)
			$listThirdNavUrl = yii::app()->createUrl(yii::app()->controller->id."/listThirdNav", array("id"=>$model->parent_id));
		else
			$listThirdNavUrl = yii::app()->createUrl(yii::app()->controller->id."/listThirdNav", array("id"=>$model->id));
	}
?>

<script>
$(document).ready(function(){
	//$("#third_nav").hide();
	$.ajax({
		url: '<?php echo $listUserNavUrl; ?>',
		success: function(data){
			$("#user_nav").html("").append(data);
			$.ajax({
				url: '<?php echo $listSecondNavUrl; ?>',
				success: function(data){
					updateSecondNav(data, 1);
					//$("#second_nav").html("").append(data);
					<?php if ($model->replyCount > 0 or $model->parent_id != 0): ?>
					$.ajax({
						url: "<?php echo $listThirdNavUrl; ?>",
						success: function(data){
							$("#third_nav").show();
							$("#third_nav").html("").append(data);
						},
						error: function(data){
							alert("error");
						}
					});
					<?php endif;?>
				}
			});			
		}
	});
});
</script>
<?php
$this->renderPartial('detail', array("model"=>$model));
?>
