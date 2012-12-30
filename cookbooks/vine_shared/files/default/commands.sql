CREATE TABLE commands (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    vinebot_id INT DEFAULT NULL,
    FOREIGN KEY (vinebot_id) REFERENCES vinebots(id),
    sender_id INT DEFAULT NULL,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    command_name VARCHAR(20) NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT TRUE,
    token VARCHAR(20) DEFAULT NULL,  # no need to assume this is an ID, will just lose data on bad commands
    string TEXT DEFAULT NULL,
    sent_on TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
