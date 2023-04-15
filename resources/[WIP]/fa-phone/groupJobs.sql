CREATE TABLE `job_group` (
  `id` int(11) NOT NULL,
  `src` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `members` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` int(2) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `leader` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `group_members` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `src` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;