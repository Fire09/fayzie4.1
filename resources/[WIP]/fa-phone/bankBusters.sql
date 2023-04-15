CREATE TABLE `_bankbusters` (
	`bankName` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`expires` INT(11) NULL DEFAULT NULL,
	`status` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`bankid` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `_bankbusters_queue` (
	`leaderStateID` INT(11) NULL DEFAULT NULL,
	`bankName` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`bankID` INT(11) NULL DEFAULT NULL
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `characters`
	ADD COLUMN `claimedBank` INT NULL AFTER `alias`;
