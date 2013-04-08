-- MySQL dump 10.13  Distrib 5.1.63, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: vine
-- ------------------------------------------------------
-- Server version	5.1.63-0ubuntu0.10.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `artificial_follows`
--

LOCK TABLES `artificial_follows` WRITE;
/*!40000 ALTER TABLE `artificial_follows` DISABLE KEYS */;
INSERT INTO `artificial_follows` (`from_user_id`, `to_user_id`, `created`) VALUES (44,46,'2012-11-26 19:20:44'),(13,49,'2012-04-04 00:00:00');
/*!40000 ALTER TABLE `artificial_follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `commands`
--

LOCK TABLES `commands` WRITE;
/*!40000 ALTER TABLE `commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `demos`
--

LOCK TABLES `demos` WRITE;
/*!40000 ALTER TABLE `demos` DISABLE KEYS */;
INSERT INTO `demos` (`user_id`, `token`, `password`, `created`) VALUES (35,'abcd1234','demo_password','2012-11-10 17:58:30');
/*!40000 ALTER TABLE `demos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `edges`
--

LOCK TABLES `edges` WRITE;
/*!40000 ALTER TABLE `edges` DISABLE KEYS */;
INSERT INTO `edges` (`id`, `from_id`, `to_id`, `vinebot_id`, `last_updated_on`) VALUES (273,44,49,275,'2012-11-26 19:34:17'),(280,46,44,249,'2012-11-26 19:34:18'),(294,44,46,249,'2012-11-30 08:54:39'),(301,46,49,268,'2012-11-30 08:54:40'),(302,49,44,275,'2012-11-30 08:54:40'),(311,44,35,274,'2012-12-09 19:41:49'),(312,35,44,274,'2012-12-09 19:41:51');
/*!40000 ALTER TABLE `edges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `invites`
--

LOCK TABLES `invites` WRITE;
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
INSERT INTO `invites` (`id`, `code`, `sender`, `max_uses`, `visible`, `created`) VALUES (9,'004',9,1,1,'2012-11-30 08:17:41'),(10,'005',35,2,1,'2013-04-04 21:49:03');
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `invitees`
--

LOCK TABLES `invitees` WRITE;
/*!40000 ALTER TABLE `invitees` DISABLE KEYS */;
INSERT INTO `invitees` (`invite_id`, `invitee_id`, `used`) VALUES (9,53,'2012-12-30 18:17:41'),(10,44,'2013-04-04 22:49:03');
/*!40000 ALTER TABLE `invitees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `participants`
--

LOCK TABLES `participants` WRITE;
/*!40000 ALTER TABLE `participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `recipients`
--

LOCK TABLES `recipients` WRITE;
/*!40000 ALTER TABLE `recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `twitter_follows`
--

LOCK TABLES `twitter_follows` WRITE;
/*!40000 ALTER TABLE `twitter_follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_tasks`
--

LOCK TABLES `user_tasks` WRITE;
/*!40000 ALTER TABLE `user_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `twitter_id`, `twitter_token`, `twitter_secret`, `created`, `is_active`) VALUES (9,'admin1',NULL,'9',NULL,NULL,'2012-08-30 00:17:31',1),(10,'admin2',NULL,'10',NULL,NULL,'2012-08-30 00:18:04',1),(12,'_graph',NULL,'12',NULL,NULL,'2012-08-30 00:18:30',1),(15,'_leaves',NULL,'15',NULL,NULL,'2012-09-02 22:38:47',1),(11,'_helpbot',NULL,'11',NULL,NULL,'2013-04-04 00:00:00',1),(13,'vineim',NULL,'13',NULL,NULL,'2013-04-04 00:00:00',1),(35,'alice',NULL,'35',NULL,NULL,'2012-09-12 03:14:11',1),(44,'jabberwocky',NULL,'44',NULL,NULL,'2012-09-16 22:23:40',1),(46,'dormouse',NULL,'46',NULL,NULL,'2012-09-18 19:25:24',1),(49,'cheshire_cat',NULL,'49',NULL,NULL,'2012-09-28 07:56:32',1),(52,'lehrburger',NULL,NULL,'270715706-mW6EkI0awC5au9E3r3eHiAbZj67xcC6M1dTxsQ37','6JlecKlUyyXyq9s60JC3VbbCQ4bbRszkmAKq7asHXFE','2012-11-28 06:40:00',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `vinebots`
--

LOCK TABLES `vinebots` WRITE;
/*!40000 ALTER TABLE `vinebots` DISABLE KEYS */;
INSERT INTO `vinebots` (`id`, `uuid`) VALUES (249,'b„¸ÃsOAå?[+ÄgVµ'),(268,'Zö˝KuMﬁåzC7ù\'e'),(274,'Tcäàú@%•_\\<æœñ'),(275,'1›∫cësAuü{ëP9_«ë');
/*!40000 ALTER TABLE `vinebots` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-06  7:08:41
