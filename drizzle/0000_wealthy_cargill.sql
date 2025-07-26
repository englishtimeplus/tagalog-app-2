CREATE TABLE `tagalog-app-2_account` (
	`userId` text(255) NOT NULL,
	`type` text(255) NOT NULL,
	`provider` text(255) NOT NULL,
	`providerAccountId` text(255) NOT NULL,
	`refresh_token` text,
	`access_token` text,
	`expires_at` integer,
	`token_type` text(255),
	`scope` text(255),
	`id_token` text,
	`session_state` text(255),
	PRIMARY KEY(`provider`, `providerAccountId`),
	FOREIGN KEY (`userId`) REFERENCES `tagalog-app-2_user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `account_user_id_idx` ON `tagalog-app-2_account` (`userId`);--> statement-breakpoint
CREATE TABLE `tagalog-app-2_post` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text(256),
	`createdById` text(255) NOT NULL,
	`createdAt` integer DEFAULT (unixepoch()) NOT NULL,
	`updatedAt` integer,
	FOREIGN KEY (`createdById`) REFERENCES `tagalog-app-2_user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `created_by_idx` ON `tagalog-app-2_post` (`createdById`);--> statement-breakpoint
CREATE INDEX `name_idx` ON `tagalog-app-2_post` (`name`);--> statement-breakpoint
CREATE TABLE `tagalog-app-2_session` (
	`sessionToken` text(255) PRIMARY KEY NOT NULL,
	`userId` text(255) NOT NULL,
	`expires` integer NOT NULL,
	FOREIGN KEY (`userId`) REFERENCES `tagalog-app-2_user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `session_userId_idx` ON `tagalog-app-2_session` (`userId`);--> statement-breakpoint
CREATE TABLE `tagalog-app-2_user_progress` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`userId` text(255) NOT NULL,
	`currentPage` integer DEFAULT 1 NOT NULL,
	`totalPages` integer DEFAULT 1 NOT NULL,
	`wordsCompleted` integer DEFAULT 0 NOT NULL,
	`totalWords` integer DEFAULT 0 NOT NULL,
	`lastAccessed` integer DEFAULT (unixepoch()) NOT NULL,
	`createdAt` integer DEFAULT (unixepoch()) NOT NULL,
	`updatedAt` integer,
	FOREIGN KEY (`userId`) REFERENCES `tagalog-app-2_user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `user_progress_user_id_idx` ON `tagalog-app-2_user_progress` (`userId`);--> statement-breakpoint
CREATE INDEX `user_progress_last_accessed_idx` ON `tagalog-app-2_user_progress` (`lastAccessed`);--> statement-breakpoint
CREATE TABLE `tagalog-app-2_user` (
	`id` text(255) PRIMARY KEY NOT NULL,
	`name` text(255),
	`email` text(255) NOT NULL,
	`emailVerified` integer DEFAULT (unixepoch()),
	`image` text(255),
	`password` text(255)
);
--> statement-breakpoint
CREATE TABLE `tagalog-app-2_verification_token` (
	`identifier` text(255) NOT NULL,
	`token` text(255) NOT NULL,
	`expires` integer NOT NULL,
	PRIMARY KEY(`identifier`, `token`)
);
--> statement-breakpoint
CREATE TABLE `tagalog-app-2_words_table` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`no` integer NOT NULL,
	`tagalog` text(255) NOT NULL,
	`english` text(255) NOT NULL,
	`example` text(255) NOT NULL,
	`translation` text(255) NOT NULL,
	`chunk` text(255) NOT NULL,
	`audio1` text(255),
	`audio2` text(255),
	`createdAt` integer NOT NULL
);
--> statement-breakpoint
CREATE INDEX `no_idx` ON `tagalog-app-2_words_table` (`no`);