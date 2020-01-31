use vk;
DELETE FROM messages WHERE created_at > current_date();