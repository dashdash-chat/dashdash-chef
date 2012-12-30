CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    UNIQUE (name),
    email VARCHAR(255) DEFAULT NULL,
    UNIQUE (email),
    twitter_id VARCHAR(20) DEFAULT NULL,
    UNIQUE KEY (twitter_id),
    twitter_token VARCHAR(200) DEFAULT NULL,
    twitter_secret VARCHAR(200) DEFAULT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
# We need these only if we're not importing from a previous dump
# INSERT INTO users (name) VALUES ('admin1');
# INSERT INTO users (name) VALUES ('admin2');
# INSERT INTO users (name) VALUES ('_leaves');
# INSERT INTO users (name) VALUES ('_graph');
