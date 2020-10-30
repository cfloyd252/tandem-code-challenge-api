CREATE TABLE "response" (
  "id" SERIAL PRIMARY KEY,
  "correct" TEXT NOT NULL,
  "incorrect_one" TEXT NOT NULL,
  "incorrect_two" TEXT NOT NULL,
  "incorrect_three" TEXT NOT NULL
);

ALTER TABLE "question"
  ADD COLUMN "responses" INTEGER REFERENCES "response"(id)
    ON DELETE SET NULL;