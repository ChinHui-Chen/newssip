-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Mar 11, 2011, 07:07 PM
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
INSERT INTO `category` VALUES(2, '國際', 1);
INSERT INTO `category` VALUES(3, '綜合', 1);
INSERT INTO `category` VALUES(4, '體育', 1);
INSERT INTO `category` VALUES(5, '科技', 1);
INSERT INTO `category` VALUES(6, '財經', 1);
INSERT INTO `category` VALUES(7, '娛樂', 1);

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
-- 資料表格式： `fb_like`
--

CREATE TABLE `fb_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_id_2` (`post_id`,`user_id`),
  KEY `post_id` (`post_id`,`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `fb_like`
--

INSERT INTO `fb_like` VALUES(1, 47, 2);
INSERT INTO `fb_like` VALUES(2, 49, 2);
INSERT INTO `fb_like` VALUES(3, 50, 2);
INSERT INTO `fb_like` VALUES(4, 51, 2);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=74 ;

--
-- 列出以下資料庫的數據： `post`
--

INSERT INTO `post` VALUES(1, 2, '捷運逃票 絕大多數是學生-Yahoo!奇摩新聞', '中國時報【潘欣彤／台北報導】台北捷運去年因逃票被逮者，達五百廿四人，大部分竟是學生！市議員周威佑昨公布逃票統計，強調不少學生逃票成功後「呷好倒相報」，抓到後才知「要罰一....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110304/4/2nf1j.html', '2011-03-04 10:32:37');
INSERT INTO `post` VALUES(2, 2, '建仔搶25人名單 明模擬賽升級對抗賽-Yahoo!奇摩新聞', '【賴德剛╱美國佛州維耶拉報導】王建民將於台灣時間今天午夜或明天清晨投模擬賽，因為剛轉隊來的高哲雷尼(Tom Gorzelanny)同時間也要投模擬賽，很可能這場模擬賽會....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110304/143/2nfhv.html', '2011-03-04 10:33:06');
INSERT INTO `post` VALUES(3, 2, '林威助搶先發 老將、新秀卡位 - Yahoo!奇摩運動', '〔特派記者林世民／日本九州福岡報導〕「今年春訓狀況比前幾年都好，特別在看球、跟球方面，感覺很不錯，有信心可以跟其他選手競爭先發。」期待擺脫前2年低潮的林威助，今....', 1, 4, 0, 'http://tw.sports.yahoo.com/article/aurl/d/a/110304/35/6ic3.html', '2011-03-04 10:37:37');
INSERT INTO `post` VALUES(4, 2, '復健在一起…齊默曼變麻吉-Yahoo!奇摩新聞', '〔特派記者林三豐／美國佛州維拉報導〕王建民加入國民隊剛滿1年不久，在這裡也結交不少新朋友，最麻吉的不是跟他搭檔傳接球的馬奎斯，而是經常一起練跑的喬丹．齊默曼，建仔的答案....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110304/78/2nf9f.html', '2011-03-04 10:48:26');
INSERT INTO `post` VALUES(5, 2, '變相漲價! 蛋糕越做越小-Yahoo!奇摩新聞', '物價上漲有多嚴重，其實從一個蛋糕就可以看出來，立委蔡錦隆拿著蛋糕質問行政院長吳敦義，因為物價上漲蛋糕整個變小了，要吳敦義，給個交代。每年過生日，每年都要吃生日蛋糕，今年....', 1, 9, 0, 'http://tw.news.yahoo.com/article/url/d/a/110302/11/2nbyn.html', '2011-03-04 10:49:12');
INSERT INTO `post` VALUES(6, 2, '發展條例鬆綁開發  環團憂公有地財團化-Yahoo!奇摩新聞', '「離島建設條例」通過後，各地立委陸續提出多項建設發展條例，但環保團體抨擊，這些條例排除土地法令的限制，讓財團以促進經濟開發之名，搶走人民的土地，而且審議的過程草率、充滿....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/1/2ne0o.html', '2011-03-04 10:50:01');
INSERT INTO `post` VALUES(7, 2, '工程款花去哪? 公廁.路燈最大宗!-Yahoo!奇摩新聞', '來看看這些議員，極力爭取的小型工程款，到底錢花在哪裡，我們發現這些工程款，大都用在公廁跟路燈，有議員就說，這些工程款，基本上就是他們回饋選民的籌碼，像是高雄市，給議員1....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110303/69/2nds5.html', '2011-03-04 10:55:19');
INSERT INTO `post` VALUES(8, 2, '台商被丟棄無人島 曾拍偶像劇-Yahoo!奇摩新聞', '夏姓台商被綁匪丟棄在澎湖的險礁，險礁是一座無人島，曾經是偶像劇「原味的夏天」的拍攝地點，因此聲名大噪，細緻的貝殼沙和湛藍的海水，在夏天時是相當熱門的旅遊景點，但在冬天就....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110302/11/2nb4g.html', '2011-03-04 10:55:45');
INSERT INTO `post` VALUES(9, 2, '女大生迷糊丟包包  民眾「食」金不昧-Yahoo!奇摩新聞', '第四分局春社派出所警員保永強於日前晚間擔服值班勤務，一名粘姓女大生（81年次）到派出所求助，表示包包放於機車腳踏墊上，騎到一半突然發現不見了，因內有書本皮包等貴重物品，....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110302/91/2nbhw.html', '2011-03-04 10:59:00');
INSERT INTO `post` VALUES(10, 2, 'CO2沒滅火反救命　2女換氣過度獲救-Yahoo!奇摩新聞', '二氧化碳也能用來救命，彰化2名婦人，因為家人過世太悲痛，大哭一場後，突然全身癱軟，上氣不接下氣，消防隊趕到現場，判斷是「換氣過度」症，立刻幫他們套上面罩，吸入二氧化碳，....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110301/8/2n8vq.html', '2011-03-04 11:00:29');
INSERT INTO `post` VALUES(11, 1, '奢侈稅 增訂「豁免條款」-Yahoo!奇摩新聞', '為避免奢侈稅「錯殺無辜」，財政部將增訂「豁免條款」，只要認定沒有炒作性質的不動產買賣，都不會被課到奢侈稅；不過只要被查到逃漏奢侈稅，最重會被罰三倍。此外，財政部傾向，把....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/2/2nht6.html', '2011-03-05 17:01:45');
INSERT INTO `post` VALUES(12, 1, 'ESPN預測：建仔 可投22場比賽奪7勝-Yahoo!奇摩新聞', '王建民今年復出不成問題，「未來事件交易所」看好他會在4月分重回大聯盟，ESPN夢幻棒球則預測建仔可以拿到7勝。未來事件交易所針對王建民在MLB初登板的時間，作為合約命題....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/2/2nhuc.html', '2011-03-05 17:04:23');
INSERT INTO `post` VALUES(13, 1, '「婚禮獻父母」唐不挑晉升穩重人夫-Yahoo!奇摩新聞', '中國時報【謝菀婷、王雨晴／綜合報導】昔日「東區唐不挑」唐志中結婚，夜店浪子感情靠岸，圈內友人都覺得不可思議，同為夜店咖的庹宗康說：「以前他眼神浮浮的現在穩重多了。」開心....', 1, 7, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/4/2nhbm.html', '2011-03-05 17:22:39');
INSERT INTO `post` VALUES(14, 1, 'Re: ESPN預測：建仔 可投22場比賽奪7勝-Yahoo!奇摩新聞', 'testes', 3, 4, 12, NULL, '2011-03-05 17:50:45');
INSERT INTO `post` VALUES(15, 1, 'Re: 「婚禮獻父母」唐不挑晉升穩重人夫-Yahoo!奇摩新聞', 'hahahah', 3, 7, 13, NULL, '2011-03-05 18:09:50');
INSERT INTO `post` VALUES(16, 1, 'Re: CO2沒滅火反救命　2女換氣過度獲救-Yahoo!奇摩新聞', 'still not good', 3, 3, 10, NULL, '2011-03-05 18:10:43');
INSERT INTO `post` VALUES(17, 1, 'Re: 台商被丟棄無人島 曾拍偶像劇-Yahoo!奇摩新聞', '....', 3, 3, 8, NULL, '2011-03-05 18:10:59');
INSERT INTO `post` VALUES(18, 2, '白天晴朗  今晚起鋒面到轉濕冷-Yahoo!奇摩新聞', '今天白天天氣較穩定溫暖，氣溫持續回升；日夜溫差大；北部、中南部及澎湖、金門、馬祖陽光露臉，中午高溫可達26度以上，白天只有東半部局部短暫雨；入夜後到明天受鋒面通過及強烈....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/1/2nj9n.html', '2011-03-06 09:39:58');
INSERT INTO `post` VALUES(19, 2, '中市夜店火災  疑空間狹小9人葬身二樓夾層-Yahoo!奇摩新聞', '台中市中興街「捷克丹尼pub」，凌晨發生火災，多數夜店客人逃出，不過，仍造成九死七傷的慘劇，消防隊員進入搜尋之後，發現在舞台區上方，也就是挑高樓層的二樓看台區，有九個人....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/1/2nj9m.html', '2011-03-06 09:40:11');
INSERT INTO `post` VALUES(20, 2, '王牌再起 邁大步 肌肉緊繃1局退場 教練：沒問題-Yahoo!奇摩新聞', '【賴德剛╱美國佛州維耶拉報導】睽違2年，王建民昨天終於又在春訓熱身賽登板，在國民隊的分組模擬賽先發，投1局、4名打者，用16球，10個好球6個壞球，面對第4棒打者投到1....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/143/2nj86.html', '2011-03-06 09:41:06');
INSERT INTO `post` VALUES(21, 2, 'ESPN預測：建仔 可投22場比賽奪7勝-Yahoo!奇摩新聞', '王建民今年復出不成問題，「未來事件交易所」看好他會在4月分重回大聯盟，ESPN夢幻棒球則預測建仔可以拿到7勝。未來事件交易所針對王建民在MLB初登板的時間，作為合約命題....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/2/2nhuc.html', '2011-03-06 09:41:21');
INSERT INTO `post` VALUES(22, 2, '正版iPad2還沒出 山寨版已蠢蠢欲動-Yahoo!奇摩新聞', '蘋果電腦的熱門商品「iPad2」，雖然要等到三月十一號才會上市，不過山寨商品廠商怎麼可能會放過這樣的機會，香港太陽報報導說，正版的「iPad2」還沒上市，山寨的「iPa....', 1, 5, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/1/2ni8f.html', '2011-03-06 09:41:31');
INSERT INTO `post` VALUES(23, 2, 'iPad2提前引爆平板大戰-Yahoo!奇摩新聞', '（中央社記者張良知台北5日電）當品牌廠商於德國漢諾威電腦展（CeBIT）努力推出自家平板電腦之際，蘋果iPad2的問世，搶走全球目光，iPad2計劃3月11日在美上市，....', 1, 5, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/5/2ni9z.html', '2011-03-06 09:41:42');
INSERT INTO `post` VALUES(24, 2, '台電拔樁工程 民宅劇烈搖晃-Yahoo!奇摩新聞', '台電4日上午在台北市昆陽街進行地下電纜工程，大型吊掛機具拔除基樁時，卻造成地面大震動，附近住宅出現劇烈搖晃，民眾通通嚇了一大跳，還以為發生大地震，里長痛罵，施工前根本沒....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110304/11/2ng7e.html', '2011-03-06 09:41:54');
INSERT INTO `post` VALUES(25, 2, 'AV女優原味丁 買家打翻醋罈-Yahoo!奇摩新聞', '中國時報【陳鴻偉／台北報導】號稱台灣最大的ＡＶ女優討論網站，由一劍浣春秋主持的ＡＶ─ＮＯ１，上月底邀請女優小川阿佐美來台，盛大舉辦「淫尻攝影會」。事後將她穿過的火辣比基....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2nivo.html', '2011-03-06 09:42:18');
INSERT INTO `post` VALUES(26, 2, 'Android不降價恐沒得玩-Yahoo!奇摩新聞', '工商時報【記者張志榮╱台北報導】iPad2真正讓競爭對手不寒而慄的關鍵，不在於多新或多炫的軟硬體規格，而是成本優勢，摩根大通證券昨（4）日明講，除非Android平板電....', 1, 5, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/4/2nhd6.html', '2011-03-06 09:42:31');
INSERT INTO `post` VALUES(27, 2, 'iPad退價差 台灣用戶條件多-Yahoo!奇摩新聞', '〔自由時報記者卓怡君、楊雅民、陳炳宏、劉力仁、編譯劉千郁／綜合報導〕美國蘋果公布iPad第一代退款方案，在當地時間三月二日前十四天內購買商品的客戶可以要求退價差，或是要....', 1, 5, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/78/2nhh4.html', '2011-03-06 09:42:41');
INSERT INTO `post` VALUES(28, 2, '擺滿瓦斯桶也住  學生宿舍怕怕-Yahoo!奇摩新聞', '（中央社記者許秩維台北5日電）樓上住著學生，樓下卻是擺滿瓦斯桶的商家，大學生外宿的安全令人憂心。等到意外發生才來追究和補救，為時已晚，應該事前做好預防。3日凌晨，東華大....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/5/2nhzg.html', '2011-03-06 09:42:52');
INSERT INTO `post` VALUES(29, 2, '打呼聲不再惱人！　上顎裝支架治打鼾-Yahoo!奇摩新聞', '不少人可能都有打呼的困擾，現在醫界推出一種新技術，只要在上顎裝上支架，就能夠減少軟顎震動，供稱這種新的治療打鼾療效比傳統手術好，不需要住院治療，不需要全身麻醉，不過價錢....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/8/2nifg.html', '2011-03-06 09:44:07');
INSERT INTO `post` VALUES(30, 2, '坦克轟民宅 利比亞激戰70死 格達費反撲-Yahoo!奇摩新聞', '英精兵待命進軍【歐陽梅芬╱綜合外電報導】利比亞東部的反抗軍，昨在產油小鎮拉奴夫角擊退政府軍後，乘勝追擊，繼續往西向格達費的故鄉暨大本營--賽特挺進。西部札威雅鎮的反抗軍....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/143/2nj7w.html', '2011-03-06 09:44:18');
INSERT INTO `post` VALUES(31, 2, '「我除了瘋一無所有」網友惡搞格達費-Yahoo!奇摩新聞', '中國時報【潘勛／綜合報導】利比亞狂人格達費近日斥責反抗軍的咆哮，以及幾近語無倫次的發言，已經成為國際笑柄，還激發許多創意，拿格達費當素材來挖苦嘲笑的短片、漫畫及笑話，在....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2niyf.html', '2011-03-06 09:44:31');
INSERT INTO `post` VALUES(32, 2, '新聞幕後／狂人出生地蘇爾特  格達費最後灘頭堡-Yahoo!奇摩新聞', '編譯羅彥傑／特譯控制利比亞東部大城班加西的反抗軍若要揮軍首都的黎波里，西進途中無法迴避的決戰點將是海岸城市蘇爾特，這裡不但是強人格達費的出生地，也是其部族格達法族的心臟....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/78/2nj0l.html', '2011-03-06 09:44:41');
INSERT INTO `post` VALUES(33, 2, '建仔模擬賽140公里 「比想像中快」 - Yahoo!奇摩運動', '〔特派記者林三豐／美國佛州維拉報導〕王建民昨天投完小聯盟比賽，相當關心自己球速，得知最快投到87英里（約140公里），伸卡球平均也有83英里，他笑說：「比想像中....', 1, 4, 0, 'http://tw.sports.yahoo.com/article/aurl/d/a/110306/35/6ioy.html', '2011-03-06 10:04:34');
INSERT INTO `post` VALUES(34, 2, '建仔模擬賽記取2009教訓 主動告知不適 - Yahoo!奇摩運動', '〔特派記者林三豐／美國佛州維拉報導〕儘管王建民昨天春訓首場模擬賽因右手肌肉緊繃提前結束，但他主動告知教練，不希望冒險練投，也符合國民隊總教練瑞格曼春訓開始前所說....', 1, 4, 0, 'http://tw.sports.yahoo.com/article/aurl/d/a/110306/35/6iox.html', '2011-03-06 10:08:47');
INSERT INTO `post` VALUES(35, 2, '小禎《犀利》毒舌 朱芯儀慘淪腳尾飯-Yahoo!奇摩新聞', '中國時報【朱方蟬／台北報導】《犀利人妻》收視再創佳績，不僅隋棠入戲太深，連小禎也撩落去，網友一片叫好的「髒東西」、「生米煮成腳尾飯」都是她憤慨下自行加料的傑作，而小三朱....', 1, 7, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2nix3.html', '2011-03-06 10:09:18');
INSERT INTO `post` VALUES(36, 2, '死刑槍聲 歐盟震撼 籲台廢死-Yahoo!奇摩新聞', '中國時報【羅融、閻紀宇／綜合報導】台灣四日槍決五名死刑犯，引發國際社會關切。歐洲聯盟（歐盟）外交和安全政策高級代表、執委會副主席亞敘頓（Catherine Ashton....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2nitk.html', '2011-03-06 10:10:11');
INSERT INTO `post` VALUES(37, 2, '台灣槍決人犯換來對德外交突破-Yahoo!奇摩新聞', '新頭殼newtalk  2011.03.05  鄭平/編譯報導德國政府人權官員4日在外交部召見台灣駐德代表魏武煉，抗議台灣執行死刑。德國政府並主動在其外交部官方網站公佈....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/135/2ni8w.html', '2011-03-06 10:11:02');
INSERT INTO `post` VALUES(38, 2, '立委補選全勝 小英：重返執政-Yahoo!奇摩新聞', '（中央社記者林紳旭台北5日電）民主進步黨今天拿下台南市與高雄市立法委員補選，民進黨主席蔡英文率黨務主管舉行記者會，鞠躬向人民表達感謝。她表示，民進黨將重返執政，並成為國....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/5/2nimf.html', '2011-03-06 10:11:20');
INSERT INTO `post` VALUES(39, 2, '許添財重返國會 擦亮專業招牌-Yahoo!奇摩新聞', '（中央社記者溫貴香台北5日電）曾以「財政就是施政，財政不行，施政不可能好」理念，將合併前的台南市從負債轉為資產的前台南市長許添財，將重返睽違近10年的立法院，重新擦亮國....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/5/2nikg.html', '2011-03-06 10:11:40');
INSERT INTO `post` VALUES(40, 2, '妻毒死３子 自焚命危 夫棄急救告白：我們快見面了-Yahoo!奇摩新聞', '中國時報【吳敏菁／彰化報導】「謝謝妳辛苦照顧三個孩子，來世還是要娶妳為妻！」遭逢人倫悲劇的林先生，目睹妻子陳蒔慧毒死三子、再自焚慘劇，深夜到醫院探望妻子，眼淚就潰堤，儘....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2nit7.html', '2011-03-06 10:11:54');
INSERT INTO `post` VALUES(41, 2, '好累、很沉重、跟著受苦… 醫師：扭曲現實常抱怨…憂鬱警訊-Yahoo!奇摩新聞', '中國時報【吳敏菁、黃天如／綜合報導】住在有車位的清幽社區，開休旅車上班，大兒子還讀雙語私立幼稚園，鄰居表示，林家不像是經濟有困難。彰化基督教醫院精神科主任王俸鋼也認為，....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2nitr.html', '2011-03-06 10:12:42');
INSERT INTO `post` VALUES(42, 2, '失業尋職難度高 直逼31周-Yahoo!奇摩新聞', '工商時報【記者于國欽／台北報導】行政院主計處最新調查顯示，雖然失業率續創新低，但目前還未找到工作的失業者，平均失業週數已直逼31週，創下近6年多新高，顯示目前這些失業者....', 1, 6, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/4/2nisz.html', '2011-03-06 10:14:34');
INSERT INTO `post` VALUES(43, 2, '台灣賓士：奢侈稅恐短多長空-Yahoo!奇摩新聞', '中國時報【黃琮淵／花蓮報導】奢侈稅即將上路，衝擊300萬元以上的進口豪華車市，市場龍頭台灣賓士總裁康柏瀚(Kern, Eberhard)昨日表示，對於買氣一定會有影響，....', 1, 6, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/4/2nh6t.html', '2011-03-06 10:14:50');
INSERT INTO `post` VALUES(44, 2, '手足皮膚角化症 免疫系統出狀況-Yahoo!奇摩新聞', '記者徐夏蓮／台中報導手腳莫名起水泡、癢、痛，卻又不知道是什麼原因引起？也不知道這是什麼樣的疾病？這樣焦慮、無助的心情曾經困擾著許多罹患「角化症」的病友。病友常四處求醫 ....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/78/2nj3w.html', '2011-03-06 10:15:58');
INSERT INTO `post` VALUES(45, 2, '執不執行死刑  法務部：別消費江國慶案-Yahoo!奇摩新聞', '新頭殼newtalk  2011.03.05  林禾寧/綜合報導法務部在4日槍決5名死囚，引發外界以江國慶冤死案質疑死刑有產生誤判的可能，為此，法務部今（5）日發表聲明....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/135/2nigo.html', '2011-03-06 10:29:34');
INSERT INTO `post` VALUES(46, 2, '「遲早都要來的！」顫抖 吼叫 平靜沒人掉淚-Yahoo!奇摩新聞', '〔自由時報記者蘇福男、鮑建信、王定傳、楊政郡／綜合報導〕「一路好走」、「嗯，遲早都要來的」，北中南五名死囚昨天傍晚伏法，有人平靜，有人發抖，有人大吼發洩，在享用完酒菜後....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/78/2nhfb.html', '2011-03-06 10:30:04');
INSERT INTO `post` VALUES(47, 2, '高爾夫》曾雅妮被「虧」：如果妳是韓國人…-Yahoo!奇摩新聞', '【羅開新聞中心Minsey Weng文】看看電視轉播的畫面，選手身上是不是琳琅滿目各種不同品牌的商標？姑不論每貼一張商標的價碼為何，至少對選手來說，可以彌補旅行各地和平....', 1, 4, 0, 'http://tw.news.yahoo.com/article/url/d/a/110305/102/2ni2w.html', '2011-03-06 10:31:40');
INSERT INTO `post` VALUES(48, 2, '陽光露臉 入夜鋒面報到-中央社即時新聞 CNA-NEWS.COM ', '（中央社記者汪淑芬台北6日電）進入春季，天氣變化很快。中央氣象局表示，今天全台仍溫暖，氣溫持續回升；不過，入夜後鋒面及強烈大陸冷氣團接連報到，氣溫一路下降，中部以北及東北部還會降雨。\r\n\r\n氣象局預報，今天白天全台天氣晴朗穩定並可見到陽光，氣溫比昨天還高。白天高溫東北部及東部攝氏24度到25度，西半部及東南部26度到27度。\r\n\r\n不過，好天氣很快又要轉變。氣象局說，今晚入夜後，鋒面將通過台灣，緊接著強烈大陸冷氣團也會南下，各地氣溫明顯下降；中部以北、東北部及金門、馬祖會有短暫雨。\r\n\r\n氣象局預測，明天白天北部、東北', 1, 2, 0, 'http://www.cna.com.tw/ShowNews/WebNews_Detail.aspx?Type=FirstNews&ID=201103060007', '2011-03-06 10:32:46');
INSERT INTO `post` VALUES(49, 2, '讚破50萬 總統臉書謝粉絲-中央社即時新聞 CNA-NEWS.COM ', '總統馬英九臉書專頁昨晚突破50萬粉絲，馬總統今天表達感謝，並舉辦民調詢問臉書待加強的事項。除了臉書平台，馬總統下午也將與青年面對面互動，爭取年輕族群對施政的認同。', 1, 3, 0, 'http://www.cna.com.tw/ShowNews/WebNews_Detail.aspx?Type=FirstNews&ID=201103060009', '2011-03-06 10:33:10');
INSERT INTO `post` VALUES(50, 2, '郭泓志餵球  道奇稱讚 - 自由電子報 即時新聞', '美國職棒大聯盟道奇隊的台灣左投郭泓志，今天擔任餵球投手，道奇官網指出，郭泓志在20個投球數中，展現出他的進步。\r\n\r\n郭泓志自從春訓向球隊報到以來，身體沒有傳出不適，不過，球隊基於保護郭泓志的立場，即使熱身賽已經開打，郭泓志也未出賽，直到現在才有擔任餵球投手的機會。\r\n\r\n官網指出，郭泓志擔任小聯盟打者的餵球投手，而且投球內容還不錯。\r\n\r\n至於小小郭接下來的任務，官網表示，郭泓志計畫8日進到牛棚練投，最快10日在熱身賽登板。', 1, 4, 0, 'http://iservice.libertytimes.com.tw/liveNews/news.php?no=470169&type=%E9%AB%94%E8%82%B2', '2011-03-06 10:35:39');
INSERT INTO `post` VALUES(51, 2, 'MLB／王建民投不滿1局退場　教頭瑞格曼覺悟 | 頭條新聞 | NOWnews 今日新聞網', '﹝記者陳浚錡／綜合報導﹞日前《華盛頓郵報》報導，王建民指出他最快可能在4月底或5月出賽，此話讓高層有些意見，他遂決定把目標擺在開季，訓練一切順..', 1, 4, 0, 'http://www.nownews.com/2011/03/06/91-2694014.htm', '2011-03-06 10:36:40');
INSERT INTO `post` VALUES(52, 1, '汽柴油價 7日起漲3角-Yahoo!奇摩新聞', '（中央社記者林惠君台北 6日電）台灣中油公司今天宣布，自明天凌晨零時起，調漲各式汽、柴油每公升新台幣0.3元。調整後，零售價格分別為92無鉛汽油每公升32.1元、95無....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110306/5/2njiv.html', '2011-03-06 14:21:10');
INSERT INTO `post` VALUES(53, 1, 'Re: 讚破50萬 總統臉書謝粉絲-中央社即時新聞 CNA-NEWS.COM ', 'hjkhjkhkl\r\n;ljkljklj\r\nlkhjljlk', 3, 3, 49, NULL, '2011-03-06 14:24:58');
INSERT INTO `post` VALUES(54, 1, 'Re: Re: 讚破50萬 總統臉書謝粉絲-中央社即時新聞 CNA-NEWS.COM ', 'hhhh<h1>hahahM</h1>aaaeeerrr<br/>', 3, 3, 53, NULL, '2011-03-06 14:26:18');
INSERT INTO `post` VALUES(55, 1, 'Re: Re: 讚破50萬 總統臉書謝粉絲-中央社即時新聞 CNA-NEWS.COM ', 'test', 3, 3, 53, NULL, '2011-03-07 09:26:02');
INSERT INTO `post` VALUES(56, 1, 'Re: Re: 讚破50萬 總統臉書謝粉絲-中央社即時新聞 CNA-NEWS.COM ', 'aaa', 3, 3, 53, NULL, '2011-03-07 09:26:22');
INSERT INTO `post` VALUES(57, 1, 'Re: 汽柴油價 7日起漲3角-Yahoo!奇摩新聞', 'haha\r\n', 3, 3, 52, NULL, '2011-03-07 12:56:15');
INSERT INTO `post` VALUES(58, 1, 'Re: Re: 汽柴油價 7日起漲3角-Yahoo!奇摩新聞', 'hehe', 3, 3, 52, NULL, '2011-03-07 12:56:22');
INSERT INTO `post` VALUES(59, 1, 'Re: 汽柴油價 7日起漲3角-Yahoo!奇摩新聞', 'hihihi', 3, 3, 52, NULL, '2011-03-07 12:56:32');
INSERT INTO `post` VALUES(60, 1, 'Re: 郭泓志餵球  道奇稱讚 - 自由電子報 即時新聞', 'adsfasdf', 3, 4, 50, NULL, '2011-03-07 14:36:31');
INSERT INTO `post` VALUES(61, 1, 'Re: 建仔模擬賽記取2009教訓 主動告知不適 - Yahoo!奇摩運動', 'oh ya', 3, 4, 34, NULL, '2011-03-07 14:36:47');
INSERT INTO `post` VALUES(62, 1, 'Re: MLB／王建民投不滿1局退場　教頭瑞格曼覺悟 | 頭條新聞 | NOWnews 今日新聞網', 'haha', 3, 4, 51, NULL, '2011-03-07 14:42:39');
INSERT INTO `post` VALUES(63, 1, 'Re: Re: MLB／王建民投不滿1局退場　教頭瑞格曼覺悟 | 頭條新聞 | NOWnews 今日新聞網', 'hit', 3, 4, 51, NULL, '2011-03-07 14:42:55');
INSERT INTO `post` VALUES(64, 1, 'Re: Re: Re: MLB／王建民投不滿1局退場　教頭瑞格曼覺悟 | 頭條新聞 | NOWnews 今日新聞網', 'hi hi ', 3, 4, 51, NULL, '2011-03-07 14:43:09');
INSERT INTO `post` VALUES(65, 1, 'Re: 高爾夫》曾雅妮被「虧」：如果妳是韓國人…-Yahoo!奇摩新聞', '<h1>haha</h1>\r\n<p>asdfasdfsadf</p>\r\n', 3, 4, 47, NULL, '2011-03-07 14:44:32');
INSERT INTO `post` VALUES(66, 1, 'Re: 汽柴油價 7日起漲3角-Yahoo!奇摩新聞', 'wooo it''s so cool!', 3, 3, 52, NULL, '2011-03-07 19:58:08');
INSERT INTO `post` VALUES(67, 1, '12年國教上路後 擬廢除國中基測-Yahoo!奇摩新聞', '教育部長吳清基今天(7日)在立法院教育文化委員會答詢時說，2014年全面實施12年國教後，絕大多數的學校都不再用考試入學方式招生，國中基測的存在必要性降低，可能會予以廢....', 1, 3, 0, 'http://tw.news.yahoo.com/article/url/d/a/110307/58/2nlw5.html', '2011-03-07 19:59:06');
INSERT INTO `post` VALUES(68, 1, 'Re: 12年國教上路後 擬廢除國中基測-Yahoo!奇摩新聞', 'shit', 3, 3, 67, NULL, '2011-03-07 19:59:17');
INSERT INTO `post` VALUES(69, 1, 'Re: Re: 12年國教上路後 擬廢除國中基測-Yahoo!奇摩新聞', 'shits hit', 3, 3, 67, NULL, '2011-03-07 19:59:21');
INSERT INTO `post` VALUES(70, 1, 'Re: Re: 12年國教上路後 擬廢除國中基測-Yahoo!奇摩新聞', 'lkhlkjlkjl', 3, 3, 67, NULL, '2011-03-08 10:09:39');
INSERT INTO `post` VALUES(71, 2, 'Re: 失業尋職難度高 直逼31周-Yahoo!奇摩新聞', 'test', 3, 6, 42, NULL, '2011-03-09 21:04:28');
INSERT INTO `post` VALUES(72, 4, '日本大海嘯湧上陸  萬馬奔騰  人車驚恐逃命-Yahoo!奇摩新聞', '日本東北發生規模8.8的大地震，地震引發大海嘯侵襲東北沿海地區，根據日本NHK電視台做的電視直播顯示，大量海水以萬馬奔騰之姿湧上陸地，越過堤防，侵入農田跟住宅區，港口的....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110311/1/2nvd6.html', '2011-03-11 17:10:02');
INSERT INTO `post` VALUES(73, 4, '日本強震／強震災區　安養院10多人遭活埋5死-Yahoo!奇摩新聞', '日本芮氏規模8.9強震，造成許多災情。日北首相召開記者會，表示地震發生後，各個核能發電廠都停止運轉，日本青森、宮城跟岩手縣大部分地區目前都是停電狀態，發電廠經過確認沒有....', 1, 2, 0, 'http://tw.news.yahoo.com/article/url/d/a/110311/8/2nvew.html', '2011-03-11 17:10:45');

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

INSERT INTO `post_reply` VALUES(12, 14);
INSERT INTO `post_reply` VALUES(13, 15);
INSERT INTO `post_reply` VALUES(10, 16);
INSERT INTO `post_reply` VALUES(8, 17);
INSERT INTO `post_reply` VALUES(49, 53);
INSERT INTO `post_reply` VALUES(53, 54);
INSERT INTO `post_reply` VALUES(53, 55);
INSERT INTO `post_reply` VALUES(53, 56);
INSERT INTO `post_reply` VALUES(52, 57);
INSERT INTO `post_reply` VALUES(52, 58);
INSERT INTO `post_reply` VALUES(52, 59);
INSERT INTO `post_reply` VALUES(50, 60);
INSERT INTO `post_reply` VALUES(34, 61);
INSERT INTO `post_reply` VALUES(51, 62);
INSERT INTO `post_reply` VALUES(51, 63);
INSERT INTO `post_reply` VALUES(51, 64);
INSERT INTO `post_reply` VALUES(47, 65);
INSERT INTO `post_reply` VALUES(52, 66);
INSERT INTO `post_reply` VALUES(67, 68);
INSERT INTO `post_reply` VALUES(67, 69);
INSERT INTO `post_reply` VALUES(67, 70);
INSERT INTO `post_reply` VALUES(42, 71);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- 列出以下資料庫的數據： `user`
--

INSERT INTO `user` VALUES(1, '黃彥傑', '', '1599191717', '2011-02-25 19:29:07', '2011-03-11 15:31:59');
INSERT INTO `user` VALUES(2, 'Huang Austin', '', '100002121616360', '2011-03-03 07:52:48', '2011-03-11 15:34:01');
INSERT INTO `user` VALUES(3, 'Irene Lin', '', '1602343163', '2011-03-05 17:43:20', '2011-03-09 19:25:41');
INSERT INTO `user` VALUES(4, 'Huang Irene', '', '100002150983697', '2011-03-09 19:11:16', '2011-03-11 17:09:28');
