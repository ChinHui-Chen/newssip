<?php

/**
 * This is the model class for table "post_reply".
 *
 * The followings are the available columns in table 'post_reply':
 * @property integer $parent_id
 * @property integer $reply_id
 */
class PostReply extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @return PostReply the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'post_reply';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('parent_id, reply_id', 'required'),
			array('parent_id, reply_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('parent_id, reply_id', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'posts' => array(self::BELONGS_TO, 'Post', 'reply_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'parent_id' => 'Parent',
			'reply_id' => 'Reply',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('parent_id',$this->parent_id);
		$criteria->compare('reply_id',$this->reply_id);

		return new CActiveDataProvider(get_class($this), array(
			'criteria'=>$criteria,
		));
	}
}
