-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Feb 21, 2011, 09:06 AM
-- 伺服器版本: 5.1.44
-- PHP 版本: 5.3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `RiverCrab`
--

-- --------------------------------------------------------

--
-- 資料表格式： `category`
--

CREATE TABLE `category` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- 列出以下資料庫的數據： `category`
--

INSERT INTO `category` VALUES(1, 'all', 0);
INSERT INTO `category` VALUES(2, 'international', 1);
INSERT INTO `category` VALUES(3, 'gossiping', 1);
INSERT INTO `category` VALUES(4, 'business', 1);
INSERT INTO `category` VALUES(5, 'entertainment', 1);
INSERT INTO `category` VALUES(6, 'technology', 1);
INSERT INTO `category` VALUES(7, 'politics', 1);
INSERT INTO `category` VALUES(8, 'society', 1);
INSERT INTO `category` VALUES(9, 'sports', 1);
INSERT INTO `category` VALUES(10, 'travel', 1);
INSERT INTO `category` VALUES(13, 'apple', 6);
INSERT INTO `category` VALUES(14, 'nokia', 6);

-- --------------------------------------------------------

--
-- 資料表格式： `comment`
--

CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `content` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`,`user_id`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- 列出以下資料庫的數據： `comment`
--

INSERT INTO `comment` VALUES(1, 26, 6, 'aaa', '2011-02-19 09:45:25');
INSERT INTO `comment` VALUES(2, 26, 6, 'bbb', '2011-02-19 09:46:10');
INSERT INTO `comment` VALUES(3, 26, 6, 'ccc', '2011-02-19 09:46:13');
INSERT INTO `comment` VALUES(4, 26, 6, 'bbbb', '2011-02-19 09:54:21');
INSERT INTO `comment` VALUES(5, 26, 7, 'haha', '2011-02-19 10:20:51');
INSERT INTO `comment` VALUES(6, 27, 6, 'haha', '2011-02-19 23:26:41');
INSERT INTO `comment` VALUES(7, 56, 6, 'aaa', '2011-02-20 17:09:40');
INSERT INTO `comment` VALUES(8, 55, 6, 'bbb', '2011-02-20 17:09:50');
INSERT INTO `comment` VALUES(9, 59, 6, 'aaaa', '2011-02-20 21:05:02');
INSERT INTO `comment` VALUES(10, 61, 6, 'fvjhfjh', '2011-02-20 21:06:14');

-- --------------------------------------------------------

--
-- 資料表格式： `post`
--

CREATE TABLE `post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `post_type` tinyint(4) NOT NULL COMMENT '1 for news, 2 for post, 3 for reply',
  `parent_id` int(10) NOT NULL DEFAULT '0',
  `src_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` tinyint(3) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `post_type` (`post_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=62 ;

--
-- 列出以下資料庫的數據： `post`
--

INSERT INTO `post` VALUES(18, 5, '嗆首善惹非議　陳揮文道歉：修養不足', '大陸首善陳光標在台灣高調發紅包，根據TVBS最新民調有5成民眾支持，3成8反對！不過，陳光標這趟來台插曲，和政論名嘴陳揮文電話連線，因為陳揮文咄咄逼人口氣，引發輿論反彈，說他沒有修養，陳揮文在報紙投書願意自我反省道歉；陳光標獲知消息，說陳揮文是陳家小老弟，想請他吃飯聊一聊。\r\n\r\n政論名嘴陳揮文道歉了，因為這段和大陸首善陳光標的激動call in。政論名嘴陳揮文道歉了，因為這段和大陸首善陳光標的激動call in。陳光標(2011.1.25)：「去學學馬克思資本論吧！」陳揮文(2011.1.25)：「啊...學什麼，再講一遍，有種再講一遍，再講啊，你很乖，我叫你講，還真的再講一遍，夠乖...。」\r\n\r\n「有種再講一遍」，名嘴陳揮文好幾次激動嗆電話那頭的陳光標，這翻激烈言論接連被讀者投書「教壞小孩大小」，連最起碼的尊重都沒有。\r\n\r\n網路上也同步引起廣泛討論，網友消遣陳揮文很兇喔，被網友戲稱獅子丸的陳揮文，也被嗆聲那他到底捐過多少，還叫窮人要有骨氣！政論名嘴陳揮文(2011.1.27)：「不顧形象教壞小孩，我都接受，我跟大家道歉。」\r\n\r\n隔2天陳揮文在節目上，為自己態度不佳微微站起來鞠躬致歉，就怕觀眾沒看到！31日陳揮文還在報紙民意論壇，說自己忝為評論員難辭其咎，為修養不足道歉，願意反省檢討。\r\n\r\n但陳揮文本人就是不願受訪。大陸企業家陳光標：「像陳兄弟啊，都像自己家的兄弟一樣，我在家跟我弟弟妹妹也經常吵嘴啊，但是不影響感情，他也不應該...跟我道歉。」\r\n\r\n可沒扯破臉，陳光標還說要請小兄弟陳揮文吃飯，坐下來溝通溝通。其實TVBS最新民調有50%的人贊成陳光標高調發紅包的行善方式，38%的民眾不支持。\r\n\r\n行善這話題，不只名嘴關心！', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110131/8/2lqnl.html', 8, '2011-01-31 23:36:46');
INSERT INTO `post` VALUES(19, 5, '初三高雄到台北 恐要7.5小時', '明晚就是小年夜，許多民眾想提早返鄉過年，國道高速公路局預估，明天中午以後，國道無論南下或北上，車流量將增加；2月5日大年初三下午是北上車流尖峰，當天下午4點從高雄出發到台北，可能得花上7.5小時。\r\n\r\n岡山收費站副站長侯銀生指出，或許是天冷或民眾都還趕著家裡大掃除，昨天路過岡山收費站的車流量，反而比一般例假日少一些，並沒大幅增加，返鄉車潮可能在明天增加，希望民眾上高速公路前，要有心理準備。\r\n\r\n據國道高速公路局預估，2月2日除夕由台北南下高雄的車潮，將由上午6點多開始增加，由高雄北上的車潮，可能在上午11點多起到下午3點之間暴增。\r\n\r\n2月5日大年初三，由高雄北上的車潮將從上午8點起持續增加，至下午4點達高峰，行車速度只有40公里至60公里，從高雄到台北可能需花7.5小時。\r\n\r\n國道高速公路局為避免車流量過高，2月5日、6日上午9點到下午3點，在國道一號中山高速公路高雄端至內壢，以及在國道三號屏東九如至桃園大溪，實施高乘載管制。\r\n\r\n侯銀生說，通常春節假期都是在收假前1天，國道會出現車潮，民眾擔心收假前1天上路會塞車，多會提早1天出發，避免塞車，但久而久之，反而北上車流量最多的時段，就出現在大年初三。\r\n\r\n侯銀生說，為了因應返鄉過年的車潮，今天起，除了ETC車道以外，小型車可以通行各大、小型車道，但也請民眾上高速公路前，能先在加油站或超商購妥回數券，好儘快紓解突然暴增的車流。', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110131/2/2lqd0.html', 2, '2011-01-31 23:36:46');
INSERT INTO `post` VALUES(20, 5, '有沒有軍訓課實彈打靶練習的八卦', '在高中的時候\r\n\r\n軍訓課都有校外的實彈把打練習\r\n\r\n在基隆的大武崙山上吧\r\n\r\n一字排開趴在地上對著一個牆壁射擊....\r\n\r\n男女生都要\r\n\r\n小弟我跟幾個同學有幸幫2所學校1000多人裝子彈= =\r\n\r\n一人5~6顆子彈手都快斷了= =\r\n\r\n不過最後有多的子彈\r\n\r\n我們裝子彈的同學一人打了2個彈夾\r\n\r\n但是連發一按下去子彈三兩下就噴完了\r\n\r\n還被旁邊接子彈軍人罵說國軍的槍不能這樣操...\r\n\r\n但是你趴下去根本看不到你有沒有打在靶上?\r\n\r\n根本沒甚麼意義 聽說只剩台北跟高雄有跟中實彈練習\r\n\r\n教官還跟我們說要惜福....\r\n\r\n有沒有高中要實彈練習\r\n\r\n軍訓課還要練習拆裝65k2步槍的八卦', 2, 20, NULL, 8, '2011-02-01 07:39:53');
INSERT INTO `post` VALUES(21, 5, 'Re:有沒有軍訓課實彈打靶練習的八卦', '說到這個實在讓小弟想po個文\r\n\r\n小弟1860T 那時候當兵 還有非常重的學長學弟制\r\n\r\n我們營區在龍潭那 好死不好外面就有一個靶場\r\n\r\n記得離退伍不到三個月的時候\r\n\r\n忽然被連長找我們幾個同T過去\r\n\r\n連長說 快裝檢了 這裡有很多多餘彈藥 去後面靶場打掉吧\r\n\r\n我的媽壓 算一算大概有兩千多發65k2子彈\r\n\r\n就這樣 我跟我三個同T到後面靶場打靶\r\n\r\n超可怕的 四支步槍 2000多發子彈 拿去黑市賣應該有不少錢吧\r\n\r\n害我門一路上都小心翼翼\r\n\r\n我們大概花了一天才打完所有子彈\r\n\r\n打到槍管都發熱了= =\r\n\r\n最後連寶特瓶也拿來打', 3, 20, NULL, 8, '2011-02-01 07:39:53');
INSERT INTO `post` VALUES(22, 5, 'Re:有沒有軍訓課實彈打靶練習的八卦', '高二的時候曾經去參加過實彈射擊\r\n\r\n是在基隆的內木山靶場\r\n\r\n那時候有幸擔任出公差幫忙裝彈夾\r\n\r\n還有去兵營裡面把子彈跟槍從彈藥庫裡面領出\r\n\r\n打完實彈射擊之後還剩下一大堆子彈\r\n\r\n我們這些公差就把那些子彈都打完\r\n\r\n但是....\r\n\r\n我記得很清楚的是\r\n\r\n旁邊的阿兵哥叫我調三連發趕快打完耶...\r\n\r\n打了快二十個彈匣\r\n\r\n\r\n\r\n結果打完之後 發現少彈殼\r\n\r\n所有人開始地毯式搜索 找了快兩個小時才找到\r\n\r\n打完之後的心得是...\r\n\r\n肩窩好痛 加上...耳朵聽力永遠受損...(受損是真的有去給醫生判定)\r\n\r\n現在左耳一直都是耳鳴狀態 一直不懂為什麼明明就是右耳離槍比較近 卻是左耳受傷', 2, 20, NULL, 8, '2011-02-01 10:16:01');
INSERT INTO `post` VALUES(23, 6, '中職開幕戰319開打 聯盟對今年票房審慎樂觀', '中華職棒聯盟18日公佈中華職棒22年球季賽程，開幕戰將於3月19日正式開打，由去年總冠軍兄弟象迎戰興農牛，地點在高雄澄清湖棒球場；走過簽賭打假球風暴，聯盟對於今年票房也轉趨樂觀。\r\n\r\n根據中華職棒公佈的賽程，今年球季共有240場賽程，上下半季各120場，開幕戰由兄弟象迎戰興農牛，明星賽則預計7月23、24日舉行，總冠軍賽則安排在10月22日展開。\r\n\r\n聯盟賽務部主任王惠民表示，今年場次以大台中地區62場最多；台北天母球場因舉辦IBAF世界少棒賽的關係，上半季並未安排賽程，下半季從8月13日開始有5場比賽，新莊則有25場賽程；花東地區連2年並未排賽程，羅東球場由去年的8場減至只剩1場。\r\n\r\n由於爆發簽賭打假球案，去年職棒票房人數並不理想，上半年甚至暴跌將近5成，但下半年跌幅明顯減緩，讓聯盟對於今年票房期待相對樂觀。賽務部主任王惠民說：『(原音)我們覺得今年應該比去年理想啦！因為去年剛剛遇到比較大的衝擊，所以球迷熱情會降低是可以預期；不過我們去年上半季衰退的幅度，在下半季已經明顯趨緩了，所以它可能有一些止跌的跡象應該已經有出現，所以今年我們對整體票房人數是審慎樂觀啦！』\r\n\r\n外界關心的亞洲職棒大賽，王惠民表示，目前計畫11月11日至15日舉行，日本和韓國都表達參加意願，詳細的賽程還有待最後確認。', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110218/58/2mnpp.html', 9, '2011-02-18 21:26:58');
INSERT INTO `post` VALUES(24, 6, '中職開幕戰319開打 聯盟對今年票房審慎樂觀', '中華職棒聯盟18日公佈中華職棒22年球季賽程，開幕戰將於3月19日正式開打，由去年總冠軍兄弟象迎戰興農牛，地點在高雄澄清湖棒球場；走過簽賭打假球風暴，聯盟對於今年票房也轉趨樂觀。\r\n\r\n根據中華職棒公佈的賽程，今年球季共有240場賽程，上下半季各120場，開幕戰由兄弟象迎戰興農牛，明星賽則預計7月23、24日舉行，總冠軍賽則安排在10月22日展開。\r\n\r\n聯盟賽務部主任王惠民表示，今年場次以大台中地區62場最多；台北天母球場因舉辦IBAF世界少棒賽的關係，上半季並未安排賽程，下半季從8月13日開始有5場比賽，新莊則有25場賽程；花東地區連2年並未排賽程，羅東球場由去年的8場減至只剩1場。\r\n\r\n由於爆發簽賭打假球案，去年職棒票房人數並不理想，上半年甚至暴跌將近5成，但下半年跌幅明顯減緩，讓聯盟對於今年票房期待相對樂觀。賽務部主任王惠民說：『(原音)我們覺得今年應該比去年理想啦！因為去年剛剛遇到比較大的衝擊，所以球迷熱情會降低是可以預期；不過我們去年上半季衰退的幅度，在下半季已經明顯趨緩了，所以它可能有一些止跌的跡象應該已經有出現，所以今年我們對整體票房人數是審慎樂觀啦！』\r\n\r\n外界關心的亞洲職棒大賽，王惠民表示，目前計畫11月11日至15日舉行，日本和韓國都表達參加意願，詳細的賽程還有待最後確認。', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110218/58/2mnpp.html', 9, '2011-02-18 21:27:09');
INSERT INTO `post` VALUES(25, 6, '智慧手機也成遊戲機 體感遊戲領潮流', '遊戲玩法多元，除了比手畫腳可操控的體感遊戲再升級，今年電玩展上，搶先曝光全球第一款結合遊戲機的智慧手機，隱藏式的遊戲機按鈕，只要輕輕一推，智慧手機當場變成掌上型遊戲機，一機兩用，光在手機就能體驗玩遊戲的臨場感。（陳奕華報導）\r\n\r\n行動裝置發達，玩遊戲再也不受時間、地域限制，有鑑於智慧型手機當道，為了讓玩家可以同時體驗玩game的快感，業者跨界合作，推出全世界第一款兼具遊戲機功能的智慧手機，平常摺疊起來是智慧手機，側邊滑開，馬上變身為遊戲機，雙機合一，搶占行動娛樂大餅。\r\n\r\n索尼愛立信行動通訊台灣區行銷總監黃怡超說：「這是全世界第一款結合智慧型手機以及遊戲機，經過PlayStation所認證過的智慧型遊戲手機Xperia Play，我們手機上的設計跟遊戲機一模一樣，除了左右方向鍵，另外不管你要加速、方向感的選擇，或另外加速與射擊部分，都有單獨設計按鈕出來，玩任何遊戲的時候，其實它的感受就跟玩遊戲機或親自坐車子裡面玩賽車是一樣。」\r\n\r\n行動娛樂大躍進，體感遊戲不輸陣，遊戲體驗再升級！今年電玩展上，兩大TV game大廠首次體感遊戲正面交鋒，「台灣索尼電腦娛樂」與「台灣微軟」分別在展場主打最新體感遊戲主機：PS Move和Kinect，業者甚至引進280吋巨幅3D螢幕牆，現場播出遊戲影片3D版，另外，全球麥可迷期待已久的「Michael Jackson The Experience」也在電玩展上重現麥可經典舞步，此外，最新線上遊戲、Web Game、電競周邊，帶給玩家全新最新體驗和玩法。', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110218/1/2mn8d.html', 6, '2011-02-18 21:28:16');
INSERT INTO `post` VALUES(26, 6, '40奈米3D電視晶片 全球首顆', '工商時報【記者涂志豪／台北報導】\r\n\r\n台積電及台灣大學昨（16）日共同發表產學合作成果，成功研發出全球第1顆以40奈米製程製作之自由視角3D電視機上盒晶片，可望較現行技術提供更精緻、多元的視訊影像體驗。此項成果為視訊處理及半導體製程技術在3D領域的重大突破，該晶片也將在2月下旬於國際固態電路研討會上（ISSCC）正式發表。\r\n\r\n此次台灣大學DSP/IC設計實驗室研發的3D電視機上盒晶片，能讓觀眾無論在任何位置都可以看到不同角度的物件影像，彷彿物件真實地存在於眼前。', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110217/4/2mjlb.html', 6, '2011-02-18 21:31:15');
INSERT INTO `post` VALUES(27, 6, '「雞排英雄」真實上演　搶救夜市大作戰-Yahoo!奇摩新聞', '電影「雞排英雄」，夜市攤販為了搶救被賣掉的土地，發動抗議，這一幕在真實生活中上演！苗栗英才路夜市擁有13年歷史，去年底遭人舉發佔用人行道，從此被禁止在馬路邊擺攤，一群學....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110219/8/2mphv.html', 1, '2011-02-19 23:26:28');
INSERT INTO `post` VALUES(28, 6, 'NBA》全明星賽　綠衫軍、熱火聯手挑戰布萊恩-Yahoo!奇摩新聞', '詹姆斯（LeBron James）說全明星週末期間，熱火和塞爾提克會試圖聯手打敗布萊恩（Kobe Bryant）帶領的西區明星隊。「走出斯台普斯中心球館後，我們（熱火與....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110219/13/2mpl6.html', 1, '2011-02-20 08:13:00');
INSERT INTO `post` VALUES(29, 6, 'NBA》全明星賽　綠衫軍、熱火聯手挑戰布萊恩-Yahoo!奇摩新聞', '詹姆斯（LeBron James）說全明星週末期間，熱火和塞爾提克會試圖聯手打敗布萊恩（Kobe Bryant）帶領的西區明星隊。「走出斯台普斯中心球館後，我們（熱火與....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110219/13/2mpl6.html', 9, '2011-02-20 08:13:01');
INSERT INTO `post` VALUES(30, 6, 'NBA》全明星賽　綠衫軍、熱火聯手挑戰布萊恩-Yahoo!奇摩新聞', '詹姆斯（LeBron James）說全明星週末期間，熱火和塞爾提克會試圖聯手打敗布萊恩（Kobe Bryant）帶領的西區明星隊。「走出斯台普斯中心球館後，我們（熱火與....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110219/13/2mpl6.html', 9, '2011-02-20 08:13:06');
INSERT INTO `post` VALUES(31, 6, '5克拉鑽戒套牢！　陳德容閃電結婚-Yahoo!奇摩新聞', '藝人陳德容閃電結婚，而對象就是上星期被拍到跟她一起挑婚紗的地產小開王贊策，2個人交往兩年，戀情開花結果，但是從挑婚紗到步入禮堂，不到一星期時間籌備，速度相當快，外界好奇....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110219/8/2mp0q.html', 1, '2011-02-20 08:13:47');
INSERT INTO `post` VALUES(32, 6, '我要結婚了! 侯佩岑4月當新娘', '一家知名精品店的旗艦店開幕，請到林志玲和侯佩岑等人到場站台，林志玲穿了性感小洋裝、露出事業線，而侯佩岑也大方公佈她的婚期就在四月份，還說要舉辦告別單身派對。  林志玲、侯佩岑、阮經天，這俊男美女搭配，一出場閃光燈就沒停過，尤其志玲姐姐這身深V性感裝扮，讓一旁的侯佩岑看了一眼自嘆不如，兩位曾經跟周杰倫名字連在一起的美女，難得同台參加趴替，還能順便討論什麼時候要替侯佩岑舉辦告別單身PARTY，因為他確定婚期就在今年四月。  優雅包頭斜瀏海、一身黃黑色亮片深V小洋裝，大露事業線，跟準新娘侯佩岑的綠色平口洋裝風采大不相同，但也各有特色，而另一位主角阮經天穿著亮橘色西裝外套、搭配黃領襯衫，他自己笑稱，看起來就像巴西國旗，今晚就像來踢足球的，加上最近趕拍動作片電影、每天都要練功，讓他這幾天有點腿軟。 [影音新聞請見：http://news.cts.com.tw/cts/entertain/201102/201102190674678.html]', 1, 0, 'http://tw.video.news.yahoo.com/video/entertainment-19457753/4-24243386', 1, '2011-02-20 08:19:58');
INSERT INTO `post` VALUES(33, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '中國時報【黃文博／台南報導】台南市一家托嬰中心的保母，將八個月大哭鬧女嬰放進置物櫃卅五分鐘後猝死，過程均被監視器拍下，案發後保母張翊玟相當自責，精神一度崩潰進醫院就醫。....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:20:16');
INSERT INTO `post` VALUES(34, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:23:26');
INSERT INTO `post` VALUES(35, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:27:12');
INSERT INTO `post` VALUES(36, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:27:13');
INSERT INTO `post` VALUES(37, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:27:17');
INSERT INTO `post` VALUES(38, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 2, '2011-02-20 08:27:19');
INSERT INTO `post` VALUES(39, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:31:41');
INSERT INTO `post` VALUES(40, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:31:55');
INSERT INTO `post` VALUES(41, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:32:40');
INSERT INTO `post` VALUES(42, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:36:32');
INSERT INTO `post` VALUES(43, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:36:34');
INSERT INTO `post` VALUES(44, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '			中國時報【黃文博／台南報導】台南市一家托嬰中心的保母，將八個月大哭鬧女嬰放進置物櫃卅五分鐘後猝死，過程均被監視器拍下，案發後保母張翊玟相當自責，精神一度崩潰進醫院就醫。....		', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:37:26');
INSERT INTO `post` VALUES(45, 6, '離譜保母 女嬰放置物櫃猝死-Yahoo!奇摩新聞', '			中國時報【黃文博／台南報導】台南市一家托嬰中心的保母，將八個月大哭鬧女嬰放進置物櫃卅五分鐘後猝死，過程均被監視器拍下，案發後保母張翊玟相當自責，精神一度崩潰進醫院就醫。....		', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpto.html', 1, '2011-02-20 08:37:28');
INSERT INTO `post` VALUES(46, 6, '被拒收第一天 珍與兒女過周末-Yahoo!奇摩新聞', '中國時報【羅融／台北報導】前總統陳水扁夫人吳淑珍前天被評估不適合入監，與扁家親近的台北市議員江志銘說，吳淑珍經過一天的舟車勞頓，前晚很早就入睡，住在台南的女兒陳幸妤一家....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpty.html', 1, '2011-02-20 08:38:09');
INSERT INTO `post` VALUES(47, 6, '被拒收第一天 珍與兒女過周末-Yahoo!奇摩新聞', '中國時報【羅融／台北報導】前總統陳水扁夫人吳淑珍前天被評估不適合入監，與扁家親近的台北市議員江志銘說，吳淑珍經過一天的舟車勞頓，前晚很早就入睡，住在台南的女兒陳幸妤一家....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpty.html', 1, '2011-02-20 08:39:01');
INSERT INTO `post` VALUES(48, 6, '被拒收第一天 珍與兒女過周末-Yahoo!奇摩新聞', '中國時報【羅融／台北報導】前總統陳水扁夫人吳淑珍前天被評估不適合入監，與扁家親近的台北市議員江志銘說，吳淑珍經過一天的舟車勞頓，前晚很早就入睡，住在台南的女兒陳幸妤一家....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpty.html', 1, '2011-02-20 08:39:14');
INSERT INTO `post` VALUES(49, 6, '被拒收第一天 珍與兒女過周末-Yahoo!奇摩新聞', '中國時報【羅融／台北報導】前總統陳水扁夫人吳淑珍前天被評估不適合入監，與扁家親近的台北市議員江志銘說，吳淑珍經過一天的舟車勞頓，前晚很早就入睡，住在台南的女兒陳幸妤一家....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpty.html', 1, '2011-02-20 08:39:51');
INSERT INTO `post` VALUES(50, 6, '被拒收第一天 珍與兒女過周末-Yahoo!奇摩新聞', '中國時報【羅融／台北報導】前總統陳水扁夫人吳淑珍前天被評估不適合入監，與扁家親近的台北市議員江志銘說，吳淑珍經過一天的舟車勞頓，前晚很早就入睡，住在台南的女兒陳幸妤一家....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpty.html', 1, '2011-02-20 08:39:55');
INSERT INTO `post` VALUES(51, 6, '被拒收第一天 珍與兒女過周末-Yahoo!奇摩新聞', '中國時報【羅融／台北報導】前總統陳水扁夫人吳淑珍前天被評估不適合入監，與扁家親近的台北市議員江志銘說，吳淑珍經過一天的舟車勞頓，前晚很早就入睡，住在台南的女兒陳幸妤一家....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/4/2mpty.html', 1, '2011-02-20 08:40:20');
INSERT INTO `post` VALUES(52, 6, '阿信秘戀13年  蛋蛋妹無名份癡等-Yahoo!奇摩新聞', '專案組／台北報導「五月天」主唱阿信才華洋溢，能唱能寫又能畫，感情生活卻十分神秘，甚至一度被懷疑是同志，前天本報直擊他與「傳說」中的女友「蛋蛋妹」共進晚餐，在寒風中散步，....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/78/2mq30.html', 1, '2011-02-20 08:41:46');
INSERT INTO `post` VALUES(54, 6, '救國團改選  李鍾桂時代結束-Yahoo!奇摩新聞', '（中央社記者林思宇台北19日電）創團59年的救國團今天召開團員大會，選出新任團務指導委員，現任召集人李鍾桂未獲選；同時李鍾桂也早表示不再續任，宣告救國團正式結束24年的....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110219/5/2mpmk.html', 2, '2011-02-20 11:07:28');
INSERT INTO `post` VALUES(55, 6, '北韓挖隧道 疑擬3度核子試爆-Yahoo!奇摩新聞', '（法新社首爾20日電）    今天1份報告報導，北韓已開始在核子測試場處挖掘隧道，顯然是為了第3度核子試爆而來。聯合新聞通訊社（Yonhap News Agency）引....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/19/2mqn7.html', 2, '2011-02-20 16:53:44');
INSERT INTO `post` VALUES(56, 6, '家貧偷畫具 愛心湧 岑爸護女婉謝-Yahoo!奇摩新聞', '雲林縣虎尾鎮，一名小五女童很愛畫畫，但是爸爸失業，沒錢買畫具給她，開學前夕女童在書局偷了水彩和畫筆，被店家報警送警局，父親接到消息趕到警局時非常心疼，父女相擁而泣，事情....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/142/2mqmq.html', 2, '2011-02-20 16:55:34');
INSERT INTO `post` VALUES(57, 6, ' 	促辯論  呂：別選舉才沾醬油 - 中央社即時新聞 CNA-NEWS.COM ', '（中央社記者陳虹瑾台北20日電）前副總統呂秀蓮今天說，民主進步黨中央通過總統與區域立委提名採全民調，不符黨員期待，建議舉辦總統初選全國巡迴政見發表會，「不是選舉到了才在Long Stay，沾醬油。」', 1, 0, 'http://www.cna.com.tw/ShowNews/Detail.aspx?pNewsID=201102200130&pType0=aALL&pTypeSel=0', 2, '2011-02-20 19:18:18');
INSERT INTO `post` VALUES(58, 6, 'BBC 中文网 - 國際新聞 - 簡訊：巴林示威者街頭安營扎寨', '當局撤走安全部隊之後，成千上萬示威者在巴林首都麥納麥街頭安營扎寨。', 1, 0, 'http://www.bbc.co.uk/zhongwen/trad/world/2011/02/110220_brief_bahrain_protests.shtml', 2, '2011-02-20 19:50:36');
INSERT INTO `post` VALUES(59, 6, '慎防茉莉花 傳中國已抓15人｜兩岸新聞｜中時電子報', '受到中東人民起義鼓舞，中國出現網民號召「中國茉莉花革命」，呼籲北京、上海、廣州等13個城市的民眾，到特定地點要求改善民生、司法獨立、政治改革和新聞自由。\r\n', 1, 0, 'http://news.chinatimes.com/mainland/50506345/132011022000619.html', 2, '2011-02-20 19:51:58');
INSERT INTO `post` VALUES(60, 6, '憤怒！馬重批扁貪污　但強調不涉司法-Yahoo!奇摩新聞', '吳淑珍最終沒入監服刑，部分藍軍嗆說，「下回不投馬了」！馬總統昨天緊急滅火說，他不能干預個案，今天更首度在臉書「發怒」了，他以「憤怒」的強烈字眼，痛批扁涉貪濫權，還辦起網....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/8/2mqth.html', 2, '2011-02-20 21:05:32');
INSERT INTO `post` VALUES(61, 6, '天燈墜成災　關渡公園撿130殘骸-Yahoo!奇摩新聞', '元宵佳節，除了平溪以外，現在很多地方也有民眾放天燈，但是關渡自然公園卻成了受災區！元宵節隔天工作人員發現園區內的池塘、樹上都掛滿了天燈殘骸，總共130個，比往年還要多數....', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110220/8/2mqtf.html', 3, '2011-02-20 21:06:07');

-- --------------------------------------------------------

--
-- 資料表格式： `post_reply`
--

CREATE TABLE `post_reply` (
  `parent_id` int(11) NOT NULL,
  `reply_id` int(11) NOT NULL,
  PRIMARY KEY (`reply_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 列出以下資料庫的數據： `post_reply`
--

INSERT INTO `post_reply` VALUES(20, 20);
INSERT INTO `post_reply` VALUES(20, 21);
INSERT INTO `post_reply` VALUES(20, 22);

-- --------------------------------------------------------

--
-- 資料表格式： `user`
--

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `fb_uid` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- 列出以下資料庫的數據： `user`
--

INSERT INTO `user` VALUES(5, 'Shao-Chen Wang', '', '1821168480', '2011-02-08 16:07:22', '2011-02-08 16:26:38');
INSERT INTO `user` VALUES(6, '黃彥傑', '', '1599191717', '2011-02-15 15:06:08', '2011-02-20 21:08:24');
INSERT INTO `user` VALUES(7, 'Huang Austin', '', '100002121616360', '2011-02-19 10:20:40', '2011-02-19 10:20:40');
