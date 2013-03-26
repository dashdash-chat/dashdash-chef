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
    onboarding_stage SMALLINT NOT NULL DEFAULT 0,
    created TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
