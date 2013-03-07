CREATE TABLE invitees (
    invite_id INT NOT NULL,
    FOREIGN KEY (invite_id) REFERENCES invites(id),
    invitee_id INT NOT NULL,
    UNIQUE (invitee_id),
    FOREIGN KEY (invitee_id) REFERENCES users(id),
    used TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) ENGINE = InnoDB;

# TODO re-add sender!=recipient check
#
# delimiter |
# CREATE TRIGGER check_invite_sender_recipient BEFORE UPDATE ON inviteds
# FOR EACH ROW BEGIN 
#     IF NEW.recipient = OLD.sender THEN
#         SET NEW.recipient = NULL;
#     END IF;
# END
# |
# delimiter ;
# 