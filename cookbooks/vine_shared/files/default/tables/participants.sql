CREATE TABLE participants (
    vinebot_id INT NOT NULL,
    FOREIGN KEY (vinebot_id) REFERENCES vinebots(id),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    PRIMARY KEY (vinebot_id, user_id)
) ENGINE = InnoDB;
