BEGIN;

TRUNCATE
  "response",
  "question",
  "subject",
  "user";

INSERT INTO "user" ("id", "username", "name", "password")
VALUES
  (
    1,
    'guest',
    'Guest',
    -- password = "pass"
    '$2a$10$fCWkaGbt7ZErxaxclioLteLUgg4Q3Rp09WW0s/wSLxDKYsaGYUpjG'
  );

INSERT INTO "subject" ("id", "name", "user_id")
VALUES
  (1, 'Tandem', 1);

INSERT INTO "question" ("id", "subject_id", "question", "response", "next")
VALUES
  (1, 1, 'What was Tandem previous name?', 'excuse me', 2),
  (2, 1, 'In Shakespeare"s play Julius Caesar, Caesar"s last words were...', 'cat', 3),
  (3, 1, 'perro', 'dog', 4),
  (4, 1, 'quien', 'who', 5),
  (5, 1, 'donde', 'where', 6),
  (6, 1, 'baño', 'bath', 7),
  (7, 1, 'adios', 'goodbye', 8),
  (8, 1, 'quiero', 'I want', 9),
  (9, 1, 'bienvenidos', 'welcome', 10),
  (10, 1, 'salud', 'cheers', null);

UPDATE "language" SET head = 1 WHERE id = 1;

-- because we explicitly set the id fields
-- update the sequencer for future automatic id setting
SELECT setval('word_id_seq', (SELECT MAX(id) from "word"));
SELECT setval('language_id_seq', (SELECT MAX(id) from "language"));
SELECT setval('user_id_seq', (SELECT MAX(id) from "user"));

COMMIT;