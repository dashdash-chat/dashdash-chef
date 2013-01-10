CREATE TABLE artificial_follows (
    from_user_id INT NOT NULL,
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    to_user_id INT NOT NULL,
    FOREIGN KEY (to_user_id) REFERENCES users(id),
    PRIMARY KEY (from_user_id, to_user_id),
    created TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
