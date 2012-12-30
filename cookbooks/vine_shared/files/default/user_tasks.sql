CREATE TABLE user_tasks (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    celery_task_id VARCHAR(255) NOT NULL,
    UNIQUE (celery_task_id),  # This is not a foreign key because the task might not be created yet. Also, I could not get it to work :-/
    celery_task_type ENUM('fetch_follows') NOT NULL,
    # To change: `ALTER TABLE user_tasks MODIFY COLUMN celery_task_type ENUM('fetch_follows') NOT NULL;`
    created TIMESTAMP DEFAULT NOW()
) ENGINE = InnoDB;
