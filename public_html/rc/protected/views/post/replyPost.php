<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'post-form',
	'enableAjaxValidation'=>true,
	//'action'=>yii::app()->request->baseUrl.'/post/replyPost/'.$parent_post['id'],
	'action'=>yii::app()->request->baseUrl.'/post/replyPost/'.$root_post_id,
)); ?>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model,'title',array('size'=>40,'maxlength'=>128, 'value'=>"Re: ".$parent_post['title'])); ?>
		<?php echo $form->error($model,'title'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<textarea rows="16" cols="6" maxlength="256" name="Post[content]" id="Post_content"></textarea>
		<?php //echo $form->textArea($model,'content',array('size'=>60, 'height'=>60, 'maxlength'=>256, $urlData['description'])); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->