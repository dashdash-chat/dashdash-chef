# We need these only if we're not importing from a previous dump
INSERT INTO users (name) VALUES ('admin1');
INSERT INTO users (name) VALUES ('admin2');
INSERT INTO users (name) VALUES ('_leaves');
INSERT INTO users (name) VALUES ('_graph');
INSERT INTO users (name) VALUES ('dashdashinc');
INSERT INTO users (name, email, twitter_id, twitter_token, twitter_secret) VALUES ('lehrblogger', 'lehrburger@gmail.com', '15988857', '15988857-q6XSpT6KRyIWo6FRaV4lY8IEYpiXRrNMxyIY8dCFV', 'J0UzuFqCVzAmC1c4O8Pzs5LqMo80KOWn2AxNFPbSg8');
INSERT INTO invites (id, code, sender) VALUES (1, 'aaa', 1);
INSERT INTO invitees (invite_id, invitee_id) VALUES (1, 5);
INSERT INTO demos (user_id, token, password) VALUES (5, 'abcd1234', 'test');