CREATE TABLE twitter_follows (
    from_twitter_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (from_twitter_id) REFERENCES users(twitter_id),
    to_twitter_id VARCHAR(20) NOT NULL,
    PRIMARY KEY (from_twitter_id, to_twitter_id),
    last_updated_on TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
