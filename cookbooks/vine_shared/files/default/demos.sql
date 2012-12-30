CREATE TABLE demos (
    user_id INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(id),
    token VARCHAR(40) NOT NULL,
    password VARCHAR(40) NOT NULL,
    created TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
