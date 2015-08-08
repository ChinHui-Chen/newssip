-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Mar 04, 2011, 09:00 AM
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
INSERT INTO `category` VALUES(2, '政治', 1);
INSERT INTO `category` VALUES(3, '社會', 1);
INSERT INTO `category` VALUES(4, '體育', 1);
INSERT INTO `category` VALUES(5, '科技', 1);
INSERT INTO `category` VALUES(6, '財經', 1);
INSERT INTO `category` VALUES(7, '演藝娛樂', 1);
INSERT INTO `category` VALUES(8, '健康', 1);
INSERT INTO `category` VALUES(9, '生活', 1);
INSERT INTO `category` VALUES(10, '新奇', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `comment`
--

INSERT INTO `comment` VALUES(1, 1, 1, 'hha', '2011-02-25 19:40:00');
INSERT INTO `comment` VALUES(2, 1, 1, 'kljlkjlkj', '2011-02-25 20:07:56');
INSERT INTO `comment` VALUES(3, 1, 1, 'aaa', '2011-02-25 20:10:00');
INSERT INTO `comment` VALUES(4, 1, 1, 'aaannn', '2011-02-25 20:10:14');

-- --------------------------------------------------------

--
-- 資料表格式： `fb_like`
--

CREATE TABLE `fb_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `fb_like`
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
  `category_id` tinyint(3) NOT NULL,
  `parent_id` int(10) NOT NULL DEFAULT '0',
  `src_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `post_type` (`post_type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- 列出以下資料庫的數據： `post`
--

INSERT INTO `post` VALUES(1, 1, '建商：政府出手太重了 房地產信心會下來-Yahoo!奇摩新聞', '針對財政部祭出奢侈稅打房，不少建商認為出手太重，遠雄集團副總蔡宗易表示，這項措施，雖不影響自住，但房地產信心會整個下來，民眾財富會縮水，波及層面相當廣。他說，有錢人已經....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110225/2/2n20j.html', '2011-02-25 19:29:13');
INSERT INTO `post` VALUES(2, 1, '爸收賄1500元 兒子檢舉獲50萬-Yahoo!奇摩新聞', '台中市有一位民眾在去年五都選舉期間，收賄一千五百元，他還分給兒子五百元，沒想到被兒子檢舉賄選，結果兒子獲得檢舉獎金五十萬，但爸爸卻得面臨三年以下有期徒刑。選舉期間宣傳旗....', 1, 8, 0, 'http://tw.news.yahoo.com/article/url/d/a/110225/69/2n1xr.html', '2011-02-25 19:36:55');
INSERT INTO `post` VALUES(3, 1, '「一生一屋」打炒房 民批太嚴格-Yahoo!奇摩新聞', '政府打炒房，針對非自用住宅2年內轉手加徵特別稅，現在對於自用住宅的定義也打算要從嚴認定，以全戶全家人為單位，只能擁有一個自用住宅，結果建商聽了跳腳，部分民眾認為，父母想....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110226/11/2n3u2.html', '2011-02-26 21:27:17');
INSERT INTO `post` VALUES(4, 1, '「紅狐」大陸空照失事　飛官解密贈勳-Yahoo!奇摩新聞', '在兩岸緊張對峙的年代，台灣的空軍成立了黑貓中隊和黑蝙蝠中隊，到對岸執行情蒐任務，其實還有一個「紅狐中隊」負責飛到對岸，執行空中照相的任務，把這些照片情報帶回台灣分析；紅....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110226/8/2n457.html', '2011-02-26 21:40:52');
INSERT INTO `post` VALUES(5, 1, '塞爆了！台灣燈會單日擠百萬人交通全癱-Yahoo!奇摩新聞', '真的是塞爆了！建國百年台灣燈會，由於適逢連續假日，不少外縣市遊客紛紛前往苗栗參觀，結果台鐵竹南站人潮爆量，不但月台上黑壓壓的一面，就連站前廣場也擠滿了遊客，估計單日的進....', 1, 9, 0, 'http://tw.news.yahoo.com/article/url/d/a/110227/1/2n4we.html', '2011-02-27 08:10:40');
INSERT INTO `post` VALUES(6, 1, '錢少事多還挨罵 兒科鬧醫師荒-Yahoo!奇摩新聞', '中國時報【黃天如／台北報導】受到少子化及健保給付偏低的影響，兒科近年成了「賠錢貨」，各大醫院兒科都在鬧「人荒」。兒科醫學會表示，相較於耳鼻喉科清理耳垢，健保給付一五六元....', 1, 8, 0, 'http://tw.news.yahoo.com/article/url/d/a/110227/4/2n4jt.html', '2011-02-27 08:10:57');
INSERT INTO `post` VALUES(7, 1, '囂張!持萬用鑰匙 偷百件古玩-Yahoo!奇摩新聞', '民眾防竊觀念提升，竊嫌也變通尋找高科技手法，想盡辦法進入行竊，一名毒蟲拿著一把萬用鑰匙橫行北部地區，日前他鎖定桃園一間機械工廠闖空門，不僅搬光業者的上百件古玩收藏，拔走....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110226/11/2n3uj.html', '2011-02-27 08:11:16');
INSERT INTO `post` VALUES(8, 1, '應徵道士！招考後實習 月薪約3萬-Yahoo!奇摩新聞', '〔自由時報記者林相美／台北報導〕想當道士，可不簡單！台北府城隍廟近年招考道士，設有兩道關卡，大學畢業以上的學歷優先錄取，第一關面試，先了解報考者對道士工作的興趣，第二關....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110227/78/2n4ol.html', '2011-02-27 11:02:59');
INSERT INTO `post` VALUES(9, 1, '彩虹眷村 遭噴漆毀壁畫-Yahoo!奇摩新聞', '寫上「老不修」洗不掉 彩虹爺爺怒：不畫了【蔡智銘、王煌忠、黃任膺╱台中報導】台中巿新興景點「彩虹眷村」、在網友口耳相傳下，每年吸引逾50萬人次參觀，但彩繪壁畫昨卻遭不肖....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110227/143/2n4x8.html', '2011-02-27 11:05:22');
INSERT INTO `post` VALUES(10, 1, 'Re: 彩虹眷村 遭噴漆毀壁畫-Yahoo!奇摩新聞', 'aaaa', 3, 3, 9, NULL, '2011-03-01 22:06:47');
INSERT INTO `post` VALUES(11, 1, 'Re: 彩虹眷村 遭噴漆毀壁畫-Yahoo!奇摩新聞', 'yyyy', 3, 3, 9, NULL, '2011-03-01 22:42:40');
INSERT INTO `post` VALUES(12, 2, 'iPad2發表 賈伯斯現身-Yahoo!奇摩新聞', '（路透舊金山2日電）創造平板電腦熱潮超過1年後，蘋果公司（Apple Inc）今天推出引爆風潮的iPad第2代，而主角賈伯斯（Steve Jobs）意外現身。這1年變化....', 1, 5, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/16/2nd1l.html', '2011-03-03 07:58:36');
INSERT INTO `post` VALUES(13, 1, '中國軍機接近釣魚台  日戰機升空-Yahoo!奇摩新聞', '日本自衛隊的雷達在東海上空，偵測到兩架中國軍機，據說，它們一度接近釣魚台，日本戰機升空攔截。讀賣新聞報導，日本自衛隊今早在發現中國軍機接近釣魚台之後，從那霸基地派了兩架....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/1/2ndqm.html', '2011-03-03 20:25:17');
INSERT INTO `post` VALUES(14, 1, '「紅包」換骨灰！ 5人收賄 年A破億-Yahoo!奇摩新聞', '殯儀館人員收受紅包，台北市以及新北市加起來至少五人涉案，而且每個環節都有人收，殯葬業者私下透露，一具遺體從入冰庫到火化，包給殯儀館的紅包都在5000到7000元，尤其火....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/142/2nebw.html', '2011-03-03 20:30:29');
INSERT INTO `post` VALUES(15, 1, '胡金龍好守備 普荷斯連吞3K-Yahoo!奇摩新聞', '大都會今天到紅雀主場作客，胡金龍在七局以遞補游擊手上場，打第九棒，上場就展現製造出局的精彩守備，九局唯一的打擊機會，擊成內野滾地球出局，目前出賽五場累積8打數1安打，打....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/2/2ndwa.html', '2011-03-03 20:42:18');
INSERT INTO `post` VALUES(16, 1, '路嘉欣不急嫁莫子儀 隱藏「事業線」-Yahoo!奇摩新聞', '路嘉欣和男友莫子儀感情穩定，最近男友得了流感，她卻沒事，小路笑說：「因為我天天運動，每天固定做瑜伽，身體很強壯。」路嘉欣與男友莫子儀交往多年，感情對路嘉欣來說，「是不可....', 1, 7, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/2/2nd8c.html', '2011-03-03 20:43:18');
INSERT INTO `post` VALUES(17, 1, '匈牙利工廠大火 驚見「火龍捲風」 | 國際焦點 | 全球觀察 | 聯合新聞網', '', 1, 3, 0, 'http://udn.com/NEWS/WORLD/WOR3/6187045.shtml', '2011-03-03 20:57:11');

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

INSERT INTO `post_reply` VALUES(9, 10);
INSERT INTO `post_reply` VALUES(9, 11);

-- --------------------------------------------------------

--
-- 資料表格式： `post_tag`
--

CREATE TABLE `post_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`,`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 列出以下資料庫的數據： `post_tag`
--


-- --------------------------------------------------------

--
-- 資料表格式： `tag`
--

CREATE TABLE `tag` (
  `id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- 列出以下資料庫的數據： `tag`
--

INSERT INTO `tag` VALUES(1, 'International');
INSERT INTO `tag` VALUES(2, 'Gossiping');
INSERT INTO `tag` VALUES(3, 'Business');
INSERT INTO `tag` VALUES(4, 'Entertainment');
INSERT INTO `tag` VALUES(5, 'Techonology');
INSERT INTO `tag` VALUES(6, 'Politics');
INSERT INTO `tag` VALUES(7, 'Society');
INSERT INTO `tag` VALUES(8, 'Sports');
INSERT INTO `tag` VALUES(9, 'Travel');
INSERT INTO `tag` VALUES(10, 'Mac');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- 列出以下資料庫的數據： `user`
--

INSERT INTO `user` VALUES(1, '黃彥傑', '', '1599191717', '2011-02-25 19:29:07', '2011-03-03 20:14:05');
INSERT INTO `user` VALUES(2, 'Huang Austin', '', '100002121616360', '2011-03-03 07:52:48', '2011-03-04 08:52:56');
