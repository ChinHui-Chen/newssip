<?php

class PostController extends Controller
{
	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column2';
	public $portlets=array();
	public $fbMetaData='';

	/**
	 * Transfer timestamp to facebook-like time ago format
	 */
	private function fbtime($date)
	{
	    if(empty($date)) {
	        return "No date provided";
	    }
	    
	    $periods = array("second", "minute", "hour", "day", "week", "month", "year", "decade");
	    $lengths = array("60","60","24","7","4.35","12","10");
	    
	    $now = time();
	    $unix_date = strtotime($date);

	       // check validity of date
	    if(empty($unix_date)) {    
	        return "Bad date";
	    }
	
	    // is it future date or past date
	    if($now > $unix_date) {    
	        $difference     = $now - $unix_date;
	        $tense         = "ago";
	        
	    } else {
	        $difference     = $unix_date - $now;
	        $tense         = "from now";
	    }
	    
	    for($j = 0; $difference >= $lengths[$j] && $j < count($lengths)-1; $j++) {
	        $difference /= $lengths[$j];
	    }
	    
	    $difference = round($difference);
	    
	    if($difference != 1) {
	        $periods[$j].= "s";
	    }
	    
	    return "$difference $periods[$j] {$tense}";
	}

	public function init()
	{
		$model = Category::model()->findAllByAttributes(array("parent_id"=>1));
		$this->portlets['category'] = $model;
		
		$this->portlets['post'] = "";
		//$tags = Tag::model()->findAll();
		//$this->portlets['tags'] = $tags;
	}
	
	/**
	 * @return array action filters
	 */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view', 'news', 'posts', 'detail', 'list', 'listByCategory', 'listByTag', 'listUserNav', 'listSecondNav', 'listSecondNavByTime', 'listSecondNavByHot', 'listThirdNav', 'postDetail'),
				'users'=>array('*'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update', 'ajaxCreate', 'replyPost', 'ajaxAddComment', 'autoCompleteTags', 'updateFBLike'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Display all posts (Deprecated)
	 */
	public function actionPosts($category_id="0", $sort_by="time")
	{
		if ($sort_by == "hot")
			$order = "replyCount";
		else 
			$order = "t.id";

		$criteria = new CDbCriteria(array(
				'condition'=>'post_type='.Post::POST_TYPE_POST.' or post_type='.Post::POST_TYPE_REPLY,
				'with'=>array('commentCount', 'author', 'replyCount'),
				'order'=>$order.' DESC'
			)); 

		$dataProvider=new CActiveDataProvider('Post', array(
			'pagination'=>array(
				'pageSize'=>10,
			),  
			'criteria'=>$criteria,
		)); 
		$this->render('posts',array(
			'dataProvider'=>$dataProvider,
		)); 	
	}

	/**
	 * List UserNav with ajax request
	 *
	 * @return void
	 * @author austintodo
	 **/
	public function actionListUserNav()
	{
		$categories = Category::model()->findAllByAttributes(array("parent_id"=>1));
		$this->renderPartial("listUserNav", array("categories"=>$categories), false, true);
	}

	/**
	 * List all the posts by the specific category_id.
	 * @param $category_id: category id
	 * @return array()
	 * @author austintodo
	 */
	private function listByCategory($category_id, $sort_by="time")
	{
		if ($sort_by == "hot")
			$order = "replyCount";
		else 
			$order = "timestamp";

		if ($category_id == 1)
		{
			$criteria = new CDbCriteria(array(
				'condition'=>'post_type='.Post::POST_TYPE_NEWS,
				'with'=>array('commentCount', 'author', 'replyCount', 'fbLikeCount'),
				'order'=>$order.' DESC'
			)); 
		}
		else
		{
			$criteria = new CDbCriteria(array(
				'condition'=>'post_type=:post_type AND category_id=:id',
				'params'=>array('post_type'=>Post::POST_TYPE_NEWS,
								'id'=>$category_id),
				'with'=>array('commentCount', 'author', 'replyCount', 'fbLikeCount'),
				'order'=>$order.' DESC'
			)); 
		}
	
		$dataProvider=new CActiveDataProvider('Post', array(
			'pagination'=>array(
				'pageSize'=>10,
			),  
			'criteria'=>$criteria,
		)); 
		
		$posts = $dataProvider->getData();
		
		// Get the number of likes from facebook
		/*
		$urls = "";
		foreach ($posts as $post)
		{
			//$urls .= yii::app()->createAbsoluteUrl("post/postDetail/".$post->id).",";
			$urls .= "http://matrix.csie.org:3390/rc/post/postDetail/".$post->id.",";
		}
		$jsonurl = "http://graph.facebook.com/?ids=".substr($urls, 0, -1);
		$json = file_get_contents($jsonurl,0,null,null);
		$json_output = json_decode($json);
		$share_num = array();
		foreach ( $json_output as $fb_post )
		{
			if (isset($fb_post->shares))
				$share_num[$fb_post->id] = $fb_post->shares;
			else
				$share_num[$fb_post->id] = 0;
		}
		*/
		/*
		$final_post = array();
		foreach ($posts as $post)
		{
			$p = array(
				'id'=>$post->id,
				'title'=>$post->title,
				'author'=>$post->author->name,
				'replyCount'=>$post->replyCount,
				//'share_num'=>$share_num['http://matrix.csie.org:3390/rc/post/postDetail/'.$post['id']])
				'fbLikeCount'=>$post->fbLikeCount);
			array_push($final_post, $p);
		}
		*/
		//$this->portlets['post'] = $final_post;
		//return $final_post;
		return $posts;
	}


	/**
	 * List SecondNav with ajax request
	 * @param $id: category_id
	 * @return void
	 * @author austintodo
	 **/
	public function actionListSecondNav($id, $sort_by="time")
	{
		$posts = $this->listByCategory($id, $sort_by);
		$this->renderPartial("listSecondNav", array("posts"=>$posts), false, true);
	}

	/**
	 * List SecondNav with posts in all category, order by time
	 *
	 * @return void
	 * @author austintodo
	 **/
	public function actionListSecondNavByTime()
	{
		$criteria = new CDbCriteria(array(
			'condition'=>'post_type=:post_type',
			'params'=>array('post_type'=>Post::POST_TYPE_NEWS),
			'with'=>array('commentCount', 'author', 'replyCount', 'fbLikeCount'),
			'order'=>'timestamp DESC',
			'limit'=>20,
		)); 
	
		$dataProvider=new CActiveDataProvider('Post', array(
			'pagination'=>array(
				'pageSize'=>20,
			),  
			'criteria'=>$criteria,
		));
		
		$this->renderPartial("listSecondNav", array("posts"=>$dataProvider->getData()), false, true);
	}

	/**
	 * List SecondNav with posts in all category, order by hotness in a period
	 *
	 * @return void
	 * @author austintodo
	 **/
	public function actionListSecondNavByHot()
	{
		$criteria = new CDbCriteria(array(
			'condition'=>'post_type=:post_type',
			'params'=>array('post_type'=>Post::POST_TYPE_NEWS),
			'with'=>array('commentCount', 'author', 'replyCount', 'fbLikeCount'),
			'order'=>'FbLike.post_id DESC',
			'limit'=>20,
		)); 
	
		$dataProvider=new CActiveDataProvider('Post', array(
			'pagination'=>array(
				'pageSize'=>20,
			),  
			'criteria'=>$criteria,
		));
		
		$this->renderPartial("listSecondNav", array("posts"=>$dataProvider->getData()), false, true);
	}


	/**
	 * List ThirdNav(replies) with ajax request
	 * @param $id: post_id
	 * @return void
	 * @author austintodo
	 **/
	public function actionListThirdNav($id)
	{
		//$model = $this->loadModel($id);
		$criteria = new CDbCriteria(array(
			'condition'=>'t.id=:root_id',
			'params'=>array('root_id'=>$id),
			'with'=>array('replies'=>array(
						'with'=>array("posts"),
					)),
			'order'=>'timestamp DESC'
		));
		$dataProvider = new CActiveDataProvider('Post', array(
			'criteria'=>$criteria,
		));
		/*
		$criteria = new CDbCriteria(array(
				'condition'=>'t.parent_id=:parent_id or t.'.$model->id,
				'with'=>array('posts'),
				'order'=>'reply_id DESC'
			));
		$dataProvider = new CActiveDataProvider('PostReply', array(
			'criteria'=>$criteria,
		));
		*/
		$this->renderPartial("listThirdNav", array("posts"=>$dataProvider->getData()), false, true);
	}

	/** 
	 * Show posts by category
	 *//*
	public function actionListByCategory($id="0", $sort_by="time")
	{		
		$this->updateSecondNav($id, $sort_by);
		// Load the index of the category
		$id = 1;
		$model = $this->loadModel($id);
		$criteria = new CDbCriteria(array(
				'condition'=>'t.parent_id='.$model->parent_id,
				'with'=>array('posts'),
				'order'=>'reply_id DESC'
			));
		$dataProvider = new CActiveDataProvider('PostReply', array(
			'criteria'=>$criteria,
		));
		
		// Get the comment object
		$comment = $this->newComment($model);

		$this->renderPartial('listByCategory', array(
			'model'=>$model,
		), false, true);
	
	}

*/
	/** 
	 * Show posts by tag
	 */
	public function actionListByTag($tag_id="0", $sort_by="time")
	{
		if ($sort_by == "hot")
			$order = "replyCount";
		else 
			$order = "timestamp";

		$criteria = new CDbCriteria(array(
			"condition"=>"t.tag_id=:tag_id",
			"params"=>array("tag_id"=>$tag_id),
			"with"=>array(
				"post"=>array(
					'with'=>array('commentCount', 'author', 'replyCount'),
				)
			),
		));
		
		$dataProvider=new CActiveDataProvider('PostTag', array(
			'pagination'=>array(
				'pageSize'=>10,
			),  
			'criteria'=>$criteria,
		)); 

		$this->renderPartial('list', array(
			'dataArray'=>$dataProvider->getData()), false, true
		);
	}

	/**
	 * Display all news posts
	 * @param integer $category_id the ID of the category
	 * @param varchar $sort_by the sort method
	 */
	public function actionNews($category_id="0", $sort_by="time")
	{	
		if ($sort_by == "hot")
			$order = "replyCount";
		else 
			$order = "timestamp";

		if ($category_id == 1)
		{
			$criteria = new CDbCriteria(array(
				'condition'=>'post_type='.Post::POST_TYPE_NEWS,
				'with'=>array('commentCount', 'author', 'replyCount'),
				'order'=>$order.' DESC'
			)); 
		}
		else
		{
			$criteria = new CDbCriteria(array(
				'condition'=>'post_type='.Post::POST_TYPE_NEWS.' AND category_id='.$category_id,
				'with'=>array('commentCount', 'author', 'replyCount'),
				'order'=>$order.' DESC'
			)); 
		}
		$category = Category::model()->findByPk($category_id);
		if ($category->parent_id != 0)
			//$this->portlets['root'] = array('name'=>'home', 'id'=>'1');
		//else
		{
			$this->portlets['root'] = Category::model()->findByPk($category->parent_id);
			$this->portlets['category'] = Category::model()->findAllByAttributes(array("parent_id"=>$category->id));
		}
		
		$dataProvider=new CActiveDataProvider('Post', array(
			'pagination'=>array(
				'pageSize'=>10,
			),  
			'criteria'=>$criteria,
		)); 
		
		$this->render('newsList', array(
			'dataArray'=>$dataProvider->getData(),
			'category'=>$category,
		));

	}

	/**
	 * Display the detail of the post and the hierarchy of the replies
	 * @param integer $id the ID of the post
	 */
	public function actionDetail($id)
	{
		// Load the detail of a post here
		$model = $this->loadModel($id);
		//No need to load replies here.
		//comment by austintodo @ 2011.03.01
		/*
		$criteria = new CDbCriteria(array(
				'condition'=>'t.parent_id='.$model->parent_id,
				'with'=>array('posts'),
				'order'=>'reply_id DESC'
			));
		$dataProvider = new CActiveDataProvider('PostReply', array(
			'criteria'=>$criteria,
		));
		*/
		
		// Get the comment object
		$comment = $this->newComment($model);

		$this->renderPartial('detail', array(
			'model'=>$model,
			'comment'=>$comment,
		), false, true);
	}

	/**
	 * Display both posts of the selected category and the detail of the post.
	 * Used in absolute URL
	 * 
	 */
	public function actionPostDetail($id)
	{	
		//$this->updateSecondNav($id);
		// Load the detail of a post here
		$model = $this->loadModel($id);
		$criteria = new CDbCriteria(array(
				'condition'=>'t.parent_id='.$model->parent_id,
				'with'=>array('posts'),
			));
		$dataProvider = new CActiveDataProvider('PostReply', array(
			'criteria'=>$criteria,
		));

		/*
		// Load the post of the category

		$criteria = new CDbCriteria(array(
				'condition'=>'post_type=:post_type AND category_id=:id',
				'params'=>array('post_type'=>Post::POST_TYPE_NEWS,
								'id'=>$model->category_id),
				'with'=>array('commentCount', 'author', 'replyCount'),
			)); 
		$dataProvider=new CActiveDataProvider('Post', array(
			'pagination'=>array(
				'pageSize'=>10,
			),  
			'criteria'=>$criteria,
		)); 
		
		$this->portlets['post'] = $dataProvider->getData();
		*/
		//$this->portlets['posts'] = $this->listByCategory($model->category_id);
		
		$this->fbMetaData = array("title"=>$model->title);
		$this->render('postDetail', array(
			'model'=>$model,
		), false, true);
	}


	/**
	 * Return the suggested tags
	 * Ref: http://www.yiiframework.com/extension/multicomplete/
	 */
	public function actionAutoCompleteTags($term)
	{
		if(Yii::app()->request->isAjaxRequest && !empty($term))
		{
			$variants = array();
			$criteria = new CDbCriteria;
			$criteria->addSearchCondition('name',$term.'%',false);
			$tags = Tag::model()->findAll($criteria);
			if(!empty($tags))
			{
				foreach($tags as $tag)
				{
				    $variants[] = $tag->attributes['name'];
				}
			}
			echo CJSON::encode($variants);
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');	
	}


	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id)
	{
		$this->render('view',array(
			'model'=>$this->loadModel($id),
		));
	}


	/**
	 * Create a new model.
	 * IF creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAjaxCreate()
	{
		function cut_str($string, $sublen, $start = 0, $code = 'UTF-8')
		{
			if($code == 'UTF-8')
			{
				$pa = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/";
				preg_match_all($pa, $string, $t_string);

				if(count($t_string[0]) - $start > $sublen) 
					return join('', array_slice($t_string[0], $start, $sublen))."..";
				return join('', array_slice($t_string[0], $start, $sublen));
			}
			else
			{
				$start = $start*2;
				$sublen = $sublen*2;
				$strlen = strlen($string);
				$tmpstr = '';
				for($i=0; $i<$strlen; $i++){
					if($i>=$start && $i<($start+$sublen))
					{
						if(ord(substr($string, $i, 1))>129) 
							$tmpstr.= substr($string, $i, 2);
						else 
							$tmpstr.= substr($string, $i, 1);
					}
					if(ord(substr($string, $i, 1))>129) 
						$i++;
				}
				if(strlen($tmpstr)<$strlen ) 
					$tmpstr.= "..";
				return $tmpstr;
			}
		}	

		function file_get_contents_utf8($fn) { 
			$content = file_get_contents($fn); 
			return mb_convert_encoding($content, 'UTF-8', 
					mb_detect_encoding($content, 'big5, UTF-8, ISO-8859-1')); 
		} 

		function getMetaTitle($content)
		{
			//$pattern = "|<[\s]*title[\s]*>([^<]+)<[\s]*/[\s]*title[\s]*>|Ui";
			$pattern = "/<title>(.+)<\/title>/siU";
		/*	$pattern = "<meta\s+name=['\"]??title['\"]??\s+content=['\"]??(.+)['\"]??\s*\/?>"; */
			if(preg_match($pattern, $content, $match))
				return $match[1];
			else
				return false;
		}
		
		function getMetaDesc($content)
		{
			$pattern = "<meta\s+name=['\"]??description['\"]??\s+content=['\"]??(.+)['\"]??\s*\/?>";
		
			// Remove it when done
			if(preg_match("/$pattern/siU", $content, $match))
				return $match[1];
			else
				return false;
		}
		$model = new Post;

		// Check for valid.
		$this->performAjaxValidation($model);
		
		// Create Tag Model		
		$tag_model = new Tag;

		// Retrieve category list	
		$category_list = array();
		$category_list['category_id'] = CHtml::listData($this->portlets['category'], 'id', 'name');
	
		// Need to speed up	
		// Extract html content
		$urlData = array();
		if (isset($_POST['url']))
		{
			$url = $_POST['url'];
			$urlData['url'] = $url;
		
			// First phrase
			$content = @file_get_contents_utf8($url);
			$urlDataFlag = false ;

			if( ( $urlData['title'] = getMetaTitle($content) ) == false ){
				$urlDataFlag = true ;
			}
			if( ( $urlData['description'] = getMetaDesc($content) ) == false ) {
				$urlDataFlag = true ;
			}
//			$urlData['title'] = getMetaTitle($content);
//			$urlData['description'] = getMetaDesc($content);
			
			// Second phrase
			if( $urlDataFlag ){
				$boilerpipeUrl = "http://boilerpipe-web.appspot.com/extract?url=$url&output=json" ;
				$struHTML = json_decode( file_get_contents($boilerpipeUrl) );
				
				if( $struHTML->{'status'} === "success" ){
					$urlData['title'] = $struHTML->{'response'}->{'title'} ;
					$urlData['description'] = $struHTML->{'response'}->{'content'} ;
				}

				// Handle error msg
			}

			// Cut str
			$urlData['title'] = cut_str( $urlData['title'] , 20 , 0  ) ;
			$urlData['description'] = cut_str( $urlData['description'] , 80 , 0  ) ;
		}

		$this->renderPartial('ajaxCreate',array(
			'urlData'=>$urlData,
			'model'=>$model,
			'category_list'=>$category_list,
			'tag_model'=>$tag_model,
		), false, true);
	}
	
	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new Post;

		// Uncomment the following line if AJAX validation is needed
		// ** Do not remove this line due to some weird Yii bugs
		// ** Without this line the post will double-saved in chrome.
		// ** commented by austintodo@2011.02.25
		$this->performAjaxValidation($model);
		
		if(isset($_POST['Post']) and isset($_POST['Tag']))
		{
			$tag_ids = array();
			foreach(explode(", ", $_POST['Tag']['name']) as $tag_name)
			{
				$tag_model = Tag::model()->findAll(
						"name=:name", array("name"=>$tag_name));
				//$tag_model = Tag::model()->findbyPk(6);
				if (empty($tag_model))
					break;
				array_push($tag_ids, $tag_model[0]->id);
			}
			$model->tag = $tag_ids;
		
			$_POST['Post']['user_id'] = Yii::app()->user->getId();
			$_POST['Post']['post_type'] = Post::POST_TYPE_NEWS;
			$model->attributes=$_POST['Post'];
			
			if ($model->save())
				$this->redirect(array('postDetail','id'=>$model->id));
			else
				Yii::trace("Could not save the user. SQL");	
		}
	}

	/**
	 * Reply a post
	 * @param integer $id the ID of the post
	 */
	public function actionReplyPost($id)
	{
		$model = new Post;
		// Uncomment the following line if AJAX validation is needed
		$this->performAjaxValidation($model);

		$parent_post = Post::model()->findByPk($id);
		if ($parent_post->parent_id != 0)
			$root_post_id = $parent_post->parent_id;
		else
			$root_post_id = $parent_post->id;

		if(isset($_POST['Post']))
		{
			$_POST['Post']['user_id'] = Yii::app()->user->getId();
			$_POST['Post']['post_type'] = Post::POST_TYPE_REPLY;
			
			$_POST['Post']['parent_id'] = $id;
			$_POST['Post']['category_id'] = $parent_post->category_id;
			$model->attributes=$_POST['Post'];
			if($model->save())
			{
				$reply_model = new PostReply;
				$reply_model->attributes = array("parent_id"=>$id, "reply_id"=>$model->id);
				if ($reply_model->save())
					$this->redirect(array('postDetail','id'=>$model->id));
			}
		}

		$this->renderPartial('replyPost',array(
			'model'=>$model,
			'parent_post'=>$parent_post,
			'root_post_id'=>$root_post_id,
		), false, true);
	}

	/**
	 * Save the "like" action.
	 * TODO: implement UNLIKE action
	 * @param $id: post_id, $update: 1 for like, -1 for unlike
	 * @return void
	 * @author austintodo
	 **/
	public function actionUpdateFBLike($id, $update)
	{
		$fb_like = new FbLike();
		$fb_log = array();
		$fb_log['post_id'] = $id;
		$fb_log['user_id'] = yii::app()->user->getId();
		if ($update == 1)
			$fb_like->attributes = $fb_log;
			if ($fb_like->save())
				echo "1";
			else
				echo "0";
		yii::app()->end();
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Post']))
		{
			$model->attributes=$_POST['Post'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'index' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadModel($id)->delete();

			// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
			if(!isset($_GET['ajax']))
				$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('Post');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Post('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Post']))
			$model->attributes=$_GET['Post'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadModel($id)
	{
		$model=Post::model()->findByPk((int)$id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='post-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}

	public function actionAjaxAddComment($id)
	{
		$post = $this->loadModel($id);
		$comment = new Comment;
		if (isset($_POST['Comment']))
		{
			$_POST['Comment']['user_id'] = Yii::app()->user->getId();
			$_POST['Comment']['post_id'] = $post->id;
			$comment->attributes = $_POST['Comment'];
			if ($post->addComment($comment))
			{
				$comment = Comment::model()->findByPk($comment->id);
				$this->renderPartial("_comment", array("comment"=>$comment), false, true);
			}
		}
		else
		{
			echo 'aa';
		}
	}

	protected function newComment($post)
	{
		$comment = new Comment;
		if (isset($_POST['Comment']))
		{
			$_POST['Comment']['user_id'] = Yii::app()->user->getId();
			$_POST['Comment']['post_id'] = $post->id;
			$comment->attributes = $_POST['Comment'];
			if ($post->addComment($comment))
			{
				Yii::app()->user->setFlash('commentSubmitted', 'Thank you...');
				$this->refresh();
			}
		}
		return $comment;
	}
}
