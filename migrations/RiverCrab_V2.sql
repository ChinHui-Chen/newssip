-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Feb 01, 2011, 02:15 PM
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `category`
--

INSERT INTO `category` VALUES(1, 'politics');
INSERT INTO `category` VALUES(2, 'sports');
INSERT INTO `category` VALUES(3, 'technology');
INSERT INTO `category` VALUES(4, 'life');

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `comment`
--


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
  `parent_id` int(10) DEFAULT NULL,
  `src_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` int(10) unsigned zerofill NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `post_type` (`post_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

--
-- 列出以下資料庫的數據： `post`
--

INSERT INTO `post` VALUES(18, 1, '嗆首善惹非議　陳揮文道歉：修養不足', '大陸首善陳光標在台灣高調發紅包，根據TVBS最新民調有5成民眾支持，3成8反對！不過，陳光標這趟來台插曲，和政論名嘴陳揮文電話連線，因為陳揮文咄咄逼人口氣，引發輿論反彈，說他沒有修養，陳揮文在報紙投書願意自我反省道歉；陳光標獲知消息，說陳揮文是陳家小老弟，想請他吃飯聊一聊。\r\n\r\n政論名嘴陳揮文道歉了，因為這段和大陸首善陳光標的激動call in。政論名嘴陳揮文道歉了，因為這段和大陸首善陳光標的激動call in。陳光標(2011.1.25)：「去學學馬克思資本論吧！」陳揮文(2011.1.25)：「啊...學什麼，再講一遍，有種再講一遍，再講啊，你很乖，我叫你講，還真的再講一遍，夠乖...。」\r\n\r\n「有種再講一遍」，名嘴陳揮文好幾次激動嗆電話那頭的陳光標，這翻激烈言論接連被讀者投書「教壞小孩大小」，連最起碼的尊重都沒有。\r\n\r\n網路上也同步引起廣泛討論，網友消遣陳揮文很兇喔，被網友戲稱獅子丸的陳揮文，也被嗆聲那他到底捐過多少，還叫窮人要有骨氣！政論名嘴陳揮文(2011.1.27)：「不顧形象教壞小孩，我都接受，我跟大家道歉。」\r\n\r\n隔2天陳揮文在節目上，為自己態度不佳微微站起來鞠躬致歉，就怕觀眾沒看到！31日陳揮文還在報紙民意論壇，說自己忝為評論員難辭其咎，為修養不足道歉，願意反省檢討。\r\n\r\n但陳揮文本人就是不願受訪。大陸企業家陳光標：「像陳兄弟啊，都像自己家的兄弟一樣，我在家跟我弟弟妹妹也經常吵嘴啊，但是不影響感情，他也不應該...跟我道歉。」\r\n\r\n可沒扯破臉，陳光標還說要請小兄弟陳揮文吃飯，坐下來溝通溝通。其實TVBS最新民調有50%的人贊成陳光標高調發紅包的行善方式，38%的民眾不支持。\r\n\r\n行善這話題，不只名嘴關心！', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110131/8/2lqnl.html', 0000000001, '2011-01-31 23:36:46');
INSERT INTO `post` VALUES(19, 2, '初三高雄到台北 恐要7.5小時', '明晚就是小年夜，許多民眾想提早返鄉過年，國道高速公路局預估，明天中午以後，國道無論南下或北上，車流量將增加；2月5日大年初三下午是北上車流尖峰，當天下午4點從高雄出發到台北，可能得花上7.5小時。\r\n\r\n岡山收費站副站長侯銀生指出，或許是天冷或民眾都還趕著家裡大掃除，昨天路過岡山收費站的車流量，反而比一般例假日少一些，並沒大幅增加，返鄉車潮可能在明天增加，希望民眾上高速公路前，要有心理準備。\r\n\r\n據國道高速公路局預估，2月2日除夕由台北南下高雄的車潮，將由上午6點多開始增加，由高雄北上的車潮，可能在上午11點多起到下午3點之間暴增。\r\n\r\n2月5日大年初三，由高雄北上的車潮將從上午8點起持續增加，至下午4點達高峰，行車速度只有40公里至60公里，從高雄到台北可能需花7.5小時。\r\n\r\n國道高速公路局為避免車流量過高，2月5日、6日上午9點到下午3點，在國道一號中山高速公路高雄端至內壢，以及在國道三號屏東九如至桃園大溪，實施高乘載管制。\r\n\r\n侯銀生說，通常春節假期都是在收假前1天，國道會出現車潮，民眾擔心收假前1天上路會塞車，多會提早1天出發，避免塞車，但久而久之，反而北上車流量最多的時段，就出現在大年初三。\r\n\r\n侯銀生說，為了因應返鄉過年的車潮，今天起，除了ETC車道以外，小型車可以通行各大、小型車道，但也請民眾上高速公路前，能先在加油站或超商購妥回數券，好儘快紓解突然暴增的車流。', 1, 0, 'http://tw.news.yahoo.com/article/url/d/a/110131/2/2lqd0.html', 0000000004, '2011-01-31 23:36:46');
INSERT INTO `post` VALUES(20, 3, '有沒有軍訓課實彈打靶練習的八卦', '在高中的時候\r\n\r\n軍訓課都有校外的實彈把打練習\r\n\r\n在基隆的大武崙山上吧\r\n\r\n一字排開趴在地上對著一個牆壁射擊....\r\n\r\n男女生都要\r\n\r\n小弟我跟幾個同學有幸幫2所學校1000多人裝子彈= =\r\n\r\n一人5~6顆子彈手都快斷了= =\r\n\r\n不過最後有多的子彈\r\n\r\n我們裝子彈的同學一人打了2個彈夾\r\n\r\n但是連發一按下去子彈三兩下就噴完了\r\n\r\n還被旁邊接子彈軍人罵說國軍的槍不能這樣操...\r\n\r\n但是你趴下去根本看不到你有沒有打在靶上?\r\n\r\n根本沒甚麼意義 聽說只剩台北跟高雄有跟中實彈練習\r\n\r\n教官還跟我們說要惜福....\r\n\r\n有沒有高中要實彈練習\r\n\r\n軍訓課還要練習拆裝65k2步槍的八卦', 2, 20, NULL, 0000000004, '2011-02-01 07:39:53');
INSERT INTO `post` VALUES(21, 1, 'Re:有沒有軍訓課實彈打靶練習的八卦', '說到這個實在讓小弟想po個文\r\n\r\n小弟1860T 那時候當兵 還有非常重的學長學弟制\r\n\r\n我們營區在龍潭那 好死不好外面就有一個靶場\r\n\r\n記得離退伍不到三個月的時候\r\n\r\n忽然被連長找我們幾個同T過去\r\n\r\n連長說 快裝檢了 這裡有很多多餘彈藥 去後面靶場打掉吧\r\n\r\n我的媽壓 算一算大概有兩千多發65k2子彈\r\n\r\n就這樣 我跟我三個同T到後面靶場打靶\r\n\r\n超可怕的 四支步槍 2000多發子彈 拿去黑市賣應該有不少錢吧\r\n\r\n害我門一路上都小心翼翼\r\n\r\n我們大概花了一天才打完所有子彈\r\n\r\n打到槍管都發熱了= =\r\n\r\n最後連寶特瓶也拿來打', 3, 20, NULL, 0000000004, '2011-02-01 07:39:53');
INSERT INTO `post` VALUES(22, 2, 'Re:有沒有軍訓課實彈打靶練習的八卦', '高二的時候曾經去參加過實彈射擊\r\n\r\n是在基隆的內木山靶場\r\n\r\n那時候有幸擔任出公差幫忙裝彈夾\r\n\r\n還有去兵營裡面把子彈跟槍從彈藥庫裡面領出\r\n\r\n打完實彈射擊之後還剩下一大堆子彈\r\n\r\n我們這些公差就把那些子彈都打完\r\n\r\n但是....\r\n\r\n我記得很清楚的是\r\n\r\n旁邊的阿兵哥叫我調三連發趕快打完耶...\r\n\r\n打了快二十個彈匣\r\n\r\n\r\n\r\n結果打完之後 發現少彈殼\r\n\r\n所有人開始地毯式搜索 找了快兩個小時才找到\r\n\r\n打完之後的心得是...\r\n\r\n肩窩好痛 加上...耳朵聽力永遠受損...(受損是真的有去給醫生判定)\r\n\r\n現在左耳一直都是耳鳴狀態 一直不懂為什麼明明就是右耳離槍比較近 卻是左耳受傷', 2, 20, NULL, 0000000004, '2011-02-01 10:16:01');

-- --------------------------------------------------------

--
-- 資料表格式： `post_reply`
--

CREATE TABLE `post_reply` (
  `parent_id` int(11) NOT NULL,
  `reply_id` int(11) NOT NULL,
  PRIMARY KEY (`reply_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
  `fb_account` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- 列出以下資料庫的數據： `user`
--

INSERT INTO `user` VALUES(1, 'todo', 'todo2015@gmail.com', 'todo2015@gmail.com', '2011-01-23 17:48:32', '0000-00-00 00:00:00');
INSERT INTO `user` VALUES(2, 'dongo', 'dongogo@gmail.com', 'dongogo@gmail.com', '2011-01-23 17:48:32', '0000-00-00 00:00:00');
INSERT INTO `user` VALUES(3, 'neantd', 'neantd@gmail.com', 'neantd@gmail.com', '2011-01-23 17:49:41', '0000-00-00 00:00:00');
