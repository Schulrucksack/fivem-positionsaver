

CREATE TABLE `user_identifiers` (
    `steamname` VARCHAR(40) NOT NULL
    `steamid` VARCHAR(40) NOT NULL
    `discord` VARCHAR(40) NOT NULL
    `fivem` VARCHAR(40) NOT NULL
    `ip` VARCHAR(40) NOT NULL
);

CREATE TABLE `user_information` (
    `steamname` VARCHAR(60) NOT NULL,
    `steamid` VARCHAR(60) NOT NULL,
    `position` VARCHAR(60) NULL DEFAULT '{-269.4, -955.3, 31.2}',
    PRIMARY KEY (`steamid`),
    CONSTRAINT `FK_user_information_user_identifiers`
    FOREIGN KEY (`steamid`)
    REFERENCES `user_identifiers` (`steamid`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);