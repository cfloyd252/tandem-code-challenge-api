CREATE TABLE "question" (
  "id" SERIAL PRIMARY KEY,
  "question" TEXT NOT NULL,
  "correct_count" SMALLINT DEFAULT 0,
  "incorrect_count" SMALLINT DEFAULT 0,
  "subject_id" INTEGER REFERENCES "subject"(id)
    ON DELETE CASCADE NOT NULL
);