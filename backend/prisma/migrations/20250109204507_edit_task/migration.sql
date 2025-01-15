-- AlterTable
ALTER TABLE "tasks" ADD COLUMN     "completedAt" TIMESTAMP(3),
ALTER COLUMN "due_at" DROP NOT NULL;
