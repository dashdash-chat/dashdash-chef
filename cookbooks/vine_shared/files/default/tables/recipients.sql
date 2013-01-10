CREATE TABLE recipients (
    message_id INT NOT NULL,
    FOREIGN KEY (message_id) REFERENCES messages(id),
    recipient_id INT NOT NULL,
    FOREIGN KEY (recipient_id) REFERENCES users(id)
) ENGINE = InnoDB;
