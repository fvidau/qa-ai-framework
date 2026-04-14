# Generate Banking API Test Cases

## Purpose
Reusable prompt for generating API test cases that focus on business-critical banking flows.

## Prompt Template
Use this template to generate practical test cases for banking APIs. Include only specific scenarios with a clear risk level, expected result, and business impact.

---

You are generating API test cases for a banking system that supports:
- authentication
- balance inquiry
- money transfer
- transaction status

Prioritize business-critical scenarios and avoid generic cases.

For each test case, provide:
- Test title
- Scenario type: Positive, Negative, or Edge
- Risk level: P0, P1, or P2
- Expected result
- Business impact
- Minimal request and response focus

### Context and priorities
- Focus on safe, consistent, reliable money movement
- Protect against duplicate transactions, incorrect balances, unauthorized access, and inconsistent states
- Validate authentication, input rules, amount limits, account state, and status codes
- Prefer cases that exercise end-to-end business behavior

### Output format
1. Title: ...
   - Type: Positive/Negative/Edge
   - Risk: P0/P1/P2
   - Scenario: ...
   - Expected result: ...
   - Business impact: ...
   - Notes: ...

### Example scenarios to cover
- Successful transfer with sufficient balance
- Invalid token or missing auth header
- Insufficient funds
- Duplicate transaction retry with same idempotency key
- Self-transfer rejection
- Transfer exact available balance
- Closed or frozen account
- Pending transaction status after timeout
- Input validation for amount and account IDs
- Concurrent transfer conflict

### Requirements
- Include at least 8 test cases
- Include at least one Positive, one Negative, and one Edge case
- Do not include abstract or generic test ideas like "verify all error codes"
- Use concrete business behavior from banking context
- Include expected HTTP status codes when relevant

---

Generate the test cases now.