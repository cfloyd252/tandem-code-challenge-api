CREATE TABLE "question" (
  "id" SERIAL PRIMARY KEY,
  "question" TEXT NOT NULL,
  "memory_value" SMALLINT DEFAULT 1,
  "correct_count" SMALLINT DEFAULT 0,
  "incorrect_count" SMALLINT DEFAULT 0,
  "subject_id" INTEGER REFERENCES "subject"(id)
    ON DELETE CASCADE NOT NULL,
  "next" INTEGER REFERENCES "question"(id)
    ON DELETE SET NULL
);

ALTER TABLE "subject"
  ADD COLUMN "head" INTEGER REFERENCES "question"(id)
    ON DELETE SET NULL;