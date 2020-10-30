BEGIN;

TRUNCATE
  "response",
  "question",
  "subject",
  "user";

INSERT INTO "user" ("id", "username", "first_name", "password")
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

INSERT INTO "response" ("id", "correct", "incorrect_one", "incorrect_two", "incorrect_three")
VALUES
  (1, 'Devmynd', 'Tandem', 'Burger Shack', 'Extraordinary Humans'),
  (2, 'Et tu, Brute?', 'Iacta alea est!', 'Vidi, vini, vici', 'Aegri somnia vana'),
  (3, 'Ambush', 'Chowder', 'Pride', 'Destruction'),
  (4, '31 mph', '42 mph', '13 mph', '9 mph'),
  (5, '5', '3', '9', '7'),
  (6, 'Q', 'M', 'Z', 'X'),
  (7, 'Beefalo', 'Cowson', 'Bicow', 'Mooson'),
  (8, 'Lake Superior', 'Lake Baikal', 'Lake Michigan', 'Lake Victoria'),
  (9, 'World Wide Web', 'Wild Wild West', 'War World Web', 'Wally Wally World'),
  (10, '22', '20', '55', '77'),
  (11, 'Pandora', 'Lilith', 'Eve', 'Hera'),
  (12, 'Paris', 'London', 'Belgium', 'Munich'),
  (13, 'The Moon', 'California', 'Siberia', 'China'),
  (14, 'Vermeer', 'Van Gogh', 'Picasso', 'Da Vinci'),
  (15, 'Octothorpe', 'Number sign', 'Hash Sign', 'Pound'),
  (16, 'England', 'Japan', 'Ethiopia', 'Canada'),
  (17, 'Unicorn', 'Bear', 'Rabbit', 'Seal'),
  (18, 'Detroit', 'Alaska', 'Russia', 'Washington'),
  (19, '700', '500', '200', '1000'),
  (20, '$0.05', '$0.25', '$1', '$5'),
  (21, 'Perform transactions in Latin', 'Receive withdrawls in rosary beads', 'Vote for the Pope', 'Purchase indulgences');


INSERT INTO "question" ("id", "subject_id", "question", "responses")
VALUES
  (1, 1, 'What was Tandem previous name?', 1),
  (2, 1, 'In Shakespeare"s play Julius Caesar, Caesar"s last words were...', 2),
  (3, 1, 'A group of tigers are referred to as:', 3),
  (4, 1, 'What is the top speed an average cat can travel?', 4),
  (5, 1, 'A cat can jump to _____ times its own height:', 5),
  (6, 1, 'What is the only letter that doesn"t appear in a US state name?', 6),
  (7, 1, 'What is the name for a cow-bison hybrid?', 7),
  (8, 1, 'What is the largest freshwater lake in the world?', 8),
  (9, 1, 'In a website address bar, what does WWW stand for?', 9),
  (10, 1, 'In a game of bingo, what number is represented by the name two little ducks?', 10),
  (11, 1, 'According to Greek mythology, who was the first woman on Earth?', 11),
  (12, 1, 'In which European city would you find Orly airport?', 12),
  (13, 1, 'Where would you find the Sea of Tranquility?', 13),
  (14, 1, 'Which artist painted "Girl with a Pearl Earrin"?', 14),
  (15, 1, 'What is the official name for the "hashtag" symbol?', 15),
  (16, 1, 'Not American at all, where is apple pie from?', 16),
  (17, 1, 'What is the national animal of Scotland?', 17),
  (18, 1, 'Where in the world is the only place where Canada is *due south*', 18),
  (19, 1, 'Approximately how many grapes go into a bottle of wine?', 19),
  (20, 1, 'How much does a US One Dollar Bill cost to make?', 20),
  (21, 1, 'The Vatican bank has the only ATM in the world that allows users to do what?', 21);

-- because we explicitly set the id fields
-- update the sequencer for future automatic id setting
SELECT setval('response_id_seq', (SELECT MAX(id) from "response"));
SELECT setval('question_id_seq', (SELECT MAX(id) from "question"));
SELECT setval('subject_id_seq', (SELECT MAX(id) from "subject"));
SELECT setval('user_id_seq', (SELECT MAX(id) from "user"));

COMMIT;