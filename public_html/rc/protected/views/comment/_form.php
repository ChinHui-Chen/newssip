<div class="wide form">
	<?php 
		$form = $this->beginWidget('CActiveForm', array(
					'id'=>'comment-form',
					'enableAjaxValidation'=>false,
				)); 
	?>

	<?php echo $form->labelEx($model,'content'); ?>
	<?php echo $form->textField($model,'content',array('size'=>60,'maxlength'=>128)); ?>

	<?php echo CHtml::submitButton($model->isNewRecord ? 'Push' : 'Save'); ?>

	<?php $this->endWidget(); ?>
</div>


<?php
/*
<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'comment-form',
	'enableAjaxValidation'=>false,
)); ?>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<?php echo $form->textField($model,'content',array('size'=>60,'maxlength'=>128)); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->
*/ 
?>