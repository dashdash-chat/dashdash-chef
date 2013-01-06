CREATE TABLE foursquare_friends (
    vine_user_id INT NOT NULL,
    FOREIGN KEY (vine_user_id) REFERENCES users(id),
    friend_foursquare_id VARCHAR(20) NOT NULL,
    PRIMARY KEY (vine_user_id, friend_foursquare_id),
    friend_twitter_handle VARCHAR(15) DEFAULT NULL
) ENGINE = InnoDB;
