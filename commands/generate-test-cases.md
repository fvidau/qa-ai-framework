# Generate Test Cases — Universal Template

## Purpose
Reusable prompt template for generating structured test cases for any domain.
Replace the variables in `## Context` before using.

---

## How to use

1. Fill in the `## Context` section with your system details
2. Paste the full prompt into Claude
3. Get structured, risk-prioritized test cases ready for Jira, TestRail or your `.feature` files

---

## Context (edit before use)

```
SYSTEM_NAME: Banking API
DOMAIN: Fintech / Payments
FEATURES_UNDER_TEST:
  - Authentication
  - Balance inquiry
  - Money transfer
  - Transaction status

BUSINESS_GOAL: Ensure safe, consistent, and reliable money movement

CRITICAL_FLOWS:
  1. Login
  2. Check balance
  3. Transfer money
  4. Validate transaction

MAIN_RISKS:
  - Duplicate transactions
  - Incorrect balances
  - Unauthorized access
  - Inconsistent transaction states
  - Slow responses in critical flows
```

---

## Prompt Template

```
You are a QA Analyst generating test cases for the following system:

System: {{SYSTEM_NAME}}
Domain: {{DOMAIN}}
Business goal: {{BUSINESS_GOAL}}

Features under test:
{{FEATURES_UNDER_TEST}}

Critical flows:
{{CRITICAL_FLOWS}}

Main risks to cover:
{{MAIN_RISKS}}

---

Rules:
- Prioritize business-critical scenarios
- Avoid generic or abstract test ideas
- Include at least 8 test cases
- Cover at least one Positive, one Negative, and one Edge case
- Assign risk level: P0 (critical), P1 (high), P2 (medium)
- Use concrete, domain-specific behavior

Output format for each test case:

1. Title: ...
   - Type: Positive | Negative | Edge
   - Risk: P0 | P1 | P2
   - Scenario: ...
   - Expected result: ...
   - Business impact: ...
   - Notes: (optional)

Generate the test cases now.
```

---

## Examples by domain

| Domain | System name | Key risks |
|---|---|---|
| Fintech | Banking API | Duplicate tx, incorrect balance, unauthorized access |
| Ecommerce | Checkout flow | Double charge, stock race condition, coupon abuse |
| Auth | Login / Register | Brute force, token expiry, session hijack |
| UI | Registration form | Empty fields, invalid email, password mismatch |

---

## Changelog

| Date | Change |
|---|---|
| 2026-04-16 | Refactored from banking-specific to universal parametrizable template |
| original | Banking API context — `generate-test-cases.md` |
