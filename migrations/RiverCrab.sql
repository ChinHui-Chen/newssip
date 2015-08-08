-- phpMyAdmin SQL Dump
-- version 3.3.7deb2build0.10.10.1
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Jan 28, 2011, 07:27 PM
-- 伺服器版本: 5.1.49
-- PHP 版本: 5.3.3-1ubuntu9.3

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
-- 資料表格式： `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `content` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`,`user_id`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- 列出以下資料庫的數據： `comment`
--

INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `timestamp`) VALUES
(1, 5, 1, 'comment from user 1 to post 5', '2011-01-23 17:58:22'),
(2, 5, 2, 'comment from user 2 to post 5', '2011-01-23 17:58:22');

-- --------------------------------------------------------

--
-- 資料表格式： `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `summary` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `parent_id` int(10) NOT NULL,
  `src_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` int(10) unsigned zerofill DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- 列出以下資料庫的數據： `post`
--

INSERT INTO `post` (`id`, `user_id`, `title`, `summary`, `content`, `parent_id`, `src_link`, `category_id`, `timestamp`) VALUES
(1, 1, 'Title1', 'Summary1', 'Content1', 0, NULL, NULL, '2011-01-23 17:48:52'),
(2, 1, 'Title2', 'Summary2', 'Content2', 0, NULL, NULL, '2011-01-23 17:48:52'),
(3, 2, 'Title3', 'Summary3', 'Content3', 0, NULL, NULL, '2011-01-23 17:49:21'),
(4, 2, 'Title4', 'Summary4', 'Content4', 0, NULL, NULL, '2011-01-23 17:49:21'),
(5, 3, 'Title5', 'Summary5', 'Content5', 0, NULL, NULL, '2011-01-23 17:49:21'),
(6, 3, 'Title6', 'Summary6', 'Content6', 0, NULL, NULL, '2011-01-23 17:49:21'),
(7, 2, 'Re: Title 3', 'summary 7, re summary 3', 'content 7, re summary 3', 3, NULL, NULL, '2011-01-24 09:02:51');

-- --------------------------------------------------------

--
-- 資料表格式： `user`
--

CREATE TABLE IF NOT EXISTS `user` (
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

INSERT INTO `user` (`id`, `name`, `email`, `fb_account`, `reg_time`, `last_login_time`) VALUES
(1, 'todo', 'todo2015@gmail.com', 'todo2015@gmail.com', '2011-01-23 17:48:32', '0000-00-00 00:00:00'),
(2, 'dongo', 'dongogo@gmail.com', 'dongogo@gmail.com', '2011-01-23 17:48:32', '0000-00-00 00:00:00'),
(3, 'neantd', 'neantd@gmail.com', 'neantd@gmail.com', '2011-01-23 17:49:41', '0000-00-00 00:00:00');
