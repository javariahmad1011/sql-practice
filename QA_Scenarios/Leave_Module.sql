-- Leave Module - Workflow and Date Validation
-- Purpose: Validate leave request dates, status values, and overlapping approved leave.
-- -----------------------------------------------------------------------------

-- Invalid date ranges.
SELECT leave_request_id,
       employee_id,
       start_date,
       end_date
FROM leave_requests
WHERE end_date < start_date;

-- Invalid workflow statuses.
SELECT leave_request_id,
       status
FROM leave_requests
WHERE status NOT IN ('Pending', 'Approved', 'Rejected', 'Cancelled');

-- Overlapping approved leave for the same employee.
SELECT a.leave_request_id AS request_a,
       b.leave_request_id AS request_b,
       a.employee_id
FROM leave_requests a
JOIN leave_requests b
  ON b.employee_id = a.employee_id
 AND b.leave_request_id > a.leave_request_id
 AND a.status = 'Approved'
 AND b.status = 'Approved'
 AND a.start_date <= b.end_date
 AND b.start_date <= a.end_date;

-- Expected Output / Validation Evidence
-- QA PASS expectation for each validation: zero rows unless overlapping leave is explicitly permitted.
-- Any returned request IDs provide defect-ready evidence.

-- Best Practices
-- 1. Validate inclusive/exclusive date semantics from the business rules.
-- 2. Exclude cancelled/rejected requests from overlap rules when appropriate.
-- 3. Test single-day leave where start_date = end_date.
-- 4. Validate concurrent submissions for race-condition risks if balance limits apply.
