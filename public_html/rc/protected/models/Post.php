<?php

/**
 * This is the model class for table "Post".
 *
 * The followings are the available columns in table 'Post':
 * @property string $id
 * @property string $user_id
 * @property string $title
 * @property string $content
 * @property integer $post_type
 * @property integer $category_id
 * @property integer $parent_id
 * @property string $src_link
 * @property string $timestamp
 */
class Post extends CActiveRecord
{
	const POST_TYPE_NEWS = 1;
	const POST_TYPE_POST = 2;
	const POST_TYPE_REPLY = 3;

	/**
	 * Use this function to implement MANY_MANY save/update
	 * Ref: http://www.yiiframework.com/extension/cadvancedarbehavior/
	*/

	public function behaviors()
	{
		return array( 'CAdvancedArBehavior' => array(
			'class' => 'application.extensions.CAdvancedArBehavior'));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * @return Post the static model class
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
		return 'post';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('user_id, title, post_type, category_id', 'required'),
			array('post_type, parent_id', 'numerical', 'integerOnly'=>true),
			array('category_id', 'length', 'max'=>3),
			array('user_id', 'length', 'max'=>10),
			array('title', 'length', 'max'=>128),
			array('src_link', 'length', 'max'=>255),
			array('content', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, user_id, title, content, post_type, category_id, parent_id, src_link, timestamp', 'safe', 'on'=>'search'),
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
			'author' => array(self::BELONGS_TO, 'User', 'user_id'),
			'comments' => array(self::HAS_MANY, 'Comment', 'post_id',
				'order'=>'comments.timestamp ASC'),
			'commentCount' => array(self::STAT, 'Comment', 'post_id'),
			'replyCount' => array(self::STAT, 'PostReply', 'parent_id'),
			'replies' => array(self::HAS_MANY, 'PostReply', 'parent_id'),
			'tag'=>array(self::MANY_MANY, 'Tag', 'post_tag(post_id, tag_id)'),
			'fbLikeCount' => array(self::STAT, 'FbLike', 'post_id')
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'user_id' => 'User',
			'title' => 'Title',
			'content' => 'Content',
			'post_type' => 'Post Type',
			'category_id'=>'Category',
			'parent_id' => 'Parent',
			'src_link' => 'Src Link',
			'timestamp' => 'Timestamp',
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
		$criteria->compare('user_id',$this->user_id,true);
		$criteria->compare('title',$this->title,true);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('post_type',$this->post_type);
		$criteria->compare('category_id',$this->category_id,true);
		$criteria->compare('parent_id',$this->parent_id);
		$criteria->compare('src_link',$this->src_link,true);
		$criteria->compare('timestamp',$this->timestamp,true);

		return new CActiveDataProvider(get_class($this), array(
			'criteria'=>$criteria,
		));
	}

	public function addComment($comment)
	{
		$comment->post_id = $this->id;
		return $comment->save();
	}
	
	/*
	public function addTag($tag)
	{
		$tag->post_id = $this->id;
		return $tag->save();
	}
	*/
}
