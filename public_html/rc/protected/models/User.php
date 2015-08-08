<?php

/**
 * This is the model class for table "user".
 *
 * The followings are the available columns in table 'user':
 * @property string $id
 * @property string $name
 * @property string $email
 * @property string $fb_uid
 * @property string $reg_time
 * @property string $last_login_time
 */
class User extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @return User the static model class
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
		return 'user';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, reg_time', 'required'),
			array('name, fb_uid', 'length', 'max'=>16),
			array('email', 'length', 'max'=>64),
			array('last_login_time', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, email, fb_uid, reg_time, last_login_time', 'safe', 'on'=>'search'),
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
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Name',
			'email' => 'Email',
			'fb_uid' => 'Fb UID',
			'reg_time' => 'Reg Time',
			'last_login_time' => 'Last Login Time',
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

		$criteria->compare('id',$this->id,true);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('fb_uid',$this->fb_uid,true);
		$criteria->compare('reg_time',$this->reg_time,true);
		$criteria->compare('last_login_time',$this->last_login_time,true);

		return new CActiveDataProvider(get_class($this), array(
			'criteria'=>$criteria,
		));
	}
}