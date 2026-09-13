-- Login Module - Authentication Database Validation
-- Purpose: Validate account state and login audit records after positive and negative authentication tests.
-- -----------------------------------------------------------------------------

-- Scenario 1: Active user should exist exactly once.
SELECT user_id,
       email,
       status,
       failed_login_count,
       locked_until
FROM users
WHERE LOWER(email) = LOWER('qa.login@example.com');

-- Scenario 2: Successful login should create a success audit event.
SELECT event_id,
       user_id,
       event_type,
       result,
       event_time
FROM login_events
WHERE user_id = 7001
  AND event_type = 'LOGIN'
  AND result = 'SUCCESS'
ORDER BY event_time DESC;

-- Scenario 3: Locked account must not have a SUCCESS event during the lock window.
SELECT le.event_id,
       le.event_time,
       u.locked_until
FROM users u
JOIN login_events le
  ON le.user_id = u.user_id
WHERE u.user_id = 7001
  AND u.locked_until IS NOT NULL
  AND le.result = 'SUCCESS'
  AND le.event_time < u.locked_until;

-- Expected Output / Validation Evidence
-- Scenario 1 expectation: exactly one row with status = Active.
-- Scenario 2 expectation: latest login action appears as SUCCESS.
-- Scenario 3 QA PASS expectation: zero rows.

-- Best Practices
-- 1. Never validate or expose plaintext passwords; they must not exist in the database.
-- 2. Use server-side timestamps when checking lockout windows.
-- 3. Correlate audit events using user ID and test execution time, not email alone.
-- 4. Avoid destructive authentication tests against shared real-user accounts.
