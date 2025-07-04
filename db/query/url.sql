-- name: CreateUrl :one
INSERT INTO urls(
    original_url,
    short_code,
    is_custom,
    expired_at
) VALUES (
    $1,$2,$3,$4
) 
RETURNING *;

-- name: IsShortCodeAvailable :one
SELECT NOT EXISTS (
    SELECT 1
    FROM urls
    WHERE short_code = $1
) AS is_available;

-- name: UrlExpiredAt :one
SELECT expired_at
FROM urls
WHERE short_code = $1;

-- name: GetUrlByShortCode :one
SELECT *
FROM urls
WHERE short_code = $1;

-- name: AddUrlClick :exec
UPDATE urls
SET clicks = clicks + sqlc.arg(add_count)
WHERE id = sqlc.arg(id);
