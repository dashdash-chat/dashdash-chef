CREATE TABLE invites (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(22) NOT NULL,
    sender INT DEFAULT NULL,
    recipient INT DEFAULT NULL,
    FOREIGN KEY (recipient) REFERENCES users(id),
    FOREIGN KEY (sender) REFERENCES users(id),
    UNIQUE (code),
    UNIQUE KEY recipient (recipient, sender),
    used TIMESTAMP DEFAULT 0,
    created TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) ENGINE = InnoDB;
