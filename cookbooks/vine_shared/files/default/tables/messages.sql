CREATE TABLE messages (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    vinebot_id INT DEFAULT NULL,
    FOREIGN KEY (vinebot_id) REFERENCES vinebots(id),
    sender_id INT DEFAULT NULL,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    parent_message_id INT DEFAULT NULL,
    FOREIGN KEY (parent_message_id) REFERENCES messages(id),
    parent_command_id INT DEFAULT NULL,
    FOREIGN KEY (parent_command_id) REFERENCES commands(id),
    body TEXT NOT NULL,
    sent_on TIMESTAMP DEFAULT NOW(),
    INDEX messages_sent_on (sent_on DESC),
    INDEX messages_sent_on_sender_id (sent_on DESC, sender_id)
) ENGINE = InnoDB;
