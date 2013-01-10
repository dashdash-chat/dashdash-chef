CREATE TABLE topics (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    vinebot_id INT NOT NULL,
    FOREIGN KEY (vinebot_id) REFERENCES vinebots(id),
    UNIQUE (vinebot_id),
    body VARCHAR(100) CHARACTER SET utf8,
    created TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
