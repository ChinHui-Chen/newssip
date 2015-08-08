-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Feb 25, 2011, 08:48 PM
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- 列出以下資料庫的數據： `post`
--

INSERT INTO `post` VALUES(1, 1, '建商：政府出手太重了 房地產信心會下來-Yahoo!奇摩新聞', '針對財政部祭出奢侈稅打房，不少建商認為出手太重，遠雄集團副總蔡宗易表示，這項措施，雖不影響自住，但房地產信心會整個下來，民眾財富會縮水，波及層面相當廣。他說，有錢人已經....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110225/2/2n20j.html', '2011-02-25 19:29:13');
INSERT INTO `post` VALUES(2, 1, '爸收賄1500元 兒子檢舉獲50萬-Yahoo!奇摩新聞', '台中市有一位民眾在去年五都選舉期間，收賄一千五百元，他還分給兒子五百元，沒想到被兒子檢舉賄選，結果兒子獲得檢舉獎金五十萬，但爸爸卻得面臨三年以下有期徒刑。選舉期間宣傳旗....', 1, 8, 0, 'http://tw.news.yahoo.com/article/url/d/a/110225/69/2n1xr.html', '2011-02-25 19:36:55');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- 列出以下資料庫的數據： `user`
--

INSERT INTO `user` VALUES(1, '黃彥傑', '', '1599191717', '2011-02-25 19:29:07', '2011-02-25 20:07:48');
