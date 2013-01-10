CREATE TABLE edges (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    from_id INT NOT NULL,
    to_id INT DEFAULT NULL,
    FOREIGN KEY (from_id) REFERENCES users(id),
    FOREIGN KEY (to_id) REFERENCES users(id),
    UNIQUE (from_id, to_id),
    vinebot_id INT NOT NULL,
    FOREIGN KEY (vinebot_id) REFERENCES vinebots(id),
    last_updated_on TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
