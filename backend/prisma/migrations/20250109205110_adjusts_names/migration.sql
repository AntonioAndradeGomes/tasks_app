/*
  Warnings:

  - You are about to drop the column `completedAt` on the `tasks` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "tasks" DROP COLUMN "completedAt",
ADD COLUMN     "completed_at" TIMESTAMP(3);
