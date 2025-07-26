CREATE TABLE `tagalog-app-2_user_word_progress` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`userId` text(255) NOT NULL,
	`wordId` integer NOT NULL,
	`known` integer NOT NULL,
	`lessonNumber` integer NOT NULL,
	`createdAt` integer DEFAULT (unixepoch()) NOT NULL,
	`updatedAt` integer,
	FOREIGN KEY (`userId`) REFERENCES `tagalog-app-2_user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`wordId`) REFERENCES `tagalog-app-2_words_table`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `user_word_progress_user_id_idx` ON `tagalog-app-2_user_word_progress` (`userId`);--> statement-breakpoint
CREATE INDEX `user_word_progress_word_id_idx` ON `tagalog-app-2_user_word_progress` (`wordId`);--> statement-breakpoint
CREATE INDEX `user_word_progress_lesson_idx` ON `tagalog-app-2_user_word_progress` (`lessonNumber`);