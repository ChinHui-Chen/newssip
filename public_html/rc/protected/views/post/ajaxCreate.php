<?php 
$this->beginWidget('zii.widgets.jui.CJuiDialog',array(
                'id'=>'postdialog',
                'options'=>array(
                    'title'=>"Post a News",
                    'autoOpen'=>true,
                    'position'=>'top',
                    'width'=>'450px',
                ),
                ));
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'post-form',
	'enableAjaxValidation'=>true,
	'action'=>yii::app()->request->baseUrl.'/post/create',
)); ?>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'src_link'); ?>
		<?php echo $form->textField($model,'src_link',array('size'=>40,'maxlength'=>255, 'value'=>$urlData['url'])); ?>
		<?php echo $form->error($model,'src_link'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model,'title',array('size'=>40,'maxlength'=>128, 'value'=>$urlData['title'])); ?>
		<?php echo $form->error($model,'title'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<textarea rows="6" cols="6" maxlength="256" name="Post[content]" id="Post_content"><?php echo CHtml::encode($urlData['description']); ?></textarea>
		<?php //echo $form->textArea($model,'content',array('size'=>60, 'height'=>60, 'maxlength'=>256, $urlData['description'])); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'category_id'); ?>
		<?php echo $form->dropDownList($model,'category_id', $category_list);

		?>
		<?php echo $form->error($model,'category_id'); ?>
	</div>
	
	<div class="row">
		<label>Tags</label>
<?php $this->widget('application.widgets.multicomplete.MultiComplete', array(
          'model'=>$tag_model,
          'attribute'=>'name',
          'splitter'=>',',
          //'source'=>array('ac1', 'ac2', 'ac3'),
          'sourceUrl'=>yii::app()->createUrl('post/autoCompleteTags'),
          // additional javascript options for the autocomplete plugin
          'options'=>array(
                  'minLength'=>'2',
          ),
          'htmlOptions'=>array(
          ),
  ));
  ?>
	</div>


	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->


<?php $this->endWidget('zii.widgets.jui.CJuiDialog');?>

