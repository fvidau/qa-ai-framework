# API Testing Rules – Banking API

## Validation Rules

### Authentication
- **Must validate** token presence before any protected endpoint
- **Must validate** token expiry and refresh behavior
- **Must reject** requests with missing or invalid Authorization header
- **Must handle** both Bearer token format and custom schemes

### Request Validation
- **All monetary amounts** must be validated as decimals with max 2 decimal places
- **Account IDs** must be non-empty alphanumeric strings
- **TransactionIDs** must be unique and idempotent-safe
- **Required fields** must reject null/empty values with 400 Bad Request
- **Extra fields** should be accepted without error (forward compatibility)

### Balance & Transfer Rules
- **Never allow** negative balance after transfer
- **Never allow** transfer amounts that exceed available balance
- **Must validate** source and destination accounts exist before processing
- **Must prevent** self-transfers (same source and destination)
- **Minimum transfer** amount > 0.00, **Maximum** per business limits

---

## Status Codes – Expected Behavior

| Scenario | Code | Expected |
|----------|------|----------|
| Successful auth/transaction | 200, 201 | Response body with transaction ID |
| Invalid token | 401 | No access to resource |
| Insufficient permissions | 403 | User cannot access endpoint |
| Missing required field | 400 | Error message specifying field |
| Account not found | 404 | Clear "resource not found" message |
| Duplicate transaction (within 60s) | 409 | Prevent double-charge |
| Server error | 500 | Transaction state must be rolled back |

---

## Error Handling

### Must-Have Error Fields
Every error response must include:
- `error_code` (machine-readable)
- `message` (human-readable)
- `timestamp` (when error occurred)
- `request_id` (for support tracing)

### Transaction Failure Handling
- **Failed transfer** must not deduct from source account
- **Partially completed transfer** (e.g., timeout after debit) must trigger automatic reversal or clear compensation flow
- **Balance inquiry during failed transfer** must show pre-transaction state
- **No silent failures** – client must always know transaction state (pending, success, failed)

### Timeout & Retry Logic
- **Endpoint timeout** ≤ 30s for balance inquiry
- **Endpoint timeout** ≤ 60s for transfers
- **Idempotency key** must handle retries without duplicate charges
- **Clients must retry** on 5xx errors; **must NOT retry** on 4xx errors

---

## Edge Cases

### Zero & Boundary Values
- **Transfer amount = 0.00** → 400 Bad Request (invalid amount)
- **Transfer amount = 0.01** → 200 OK (valid minimum)
- **Balance = 0.00** → Valid state, further transfers blocked
- **Negative balance attempt** → 400 Bad Request (balance rule violation)

### Concurrency Issues
- **Two simultaneous transfers** from same account → Only one succeeds, other gets 409 Conflict
- **Balance check + transfer race** → Transfer fails if balance is insufficient at execution time
- **Transaction listed before settled** → Must show correct pending status, not final status

### Account States
- **Closed account** → 403 Forbidden with "account inactive" message
- **Frozen account** → 403 Forbidden, audit reason available
- **Transferred money to suspended account** → Reject, don't hold in limbo
- **Account with no transaction history** → Should not affect balance inquiry

### Timestamp & Timezone
- **All timestamps** must be UTC in ISO 8601 format
- **Transaction timestamp** must be server-generated, never client-provided
- **Time skew** (client clock drift) must not affect transaction ordering

---

## Business Risk Considerations

### Critical – Prevent Revenue Loss
- [ ] **Duplicate charges** – Test idempotency with exact retry within 60s window
- [ ] **Phantom transactions** – Verify failed transfers don't appear in transaction list
- [ ] **Missing transactions** – Verify all successful transfers appear in both accounts' history
- [ ] **Balance inconsistency** – Source balance + destination balance must equal pre-transfer total

### Critical – Compliance & Security
- [ ] **Unauthorized access** – Non-owner cannot view or transfer another account's money
- [ ] **Audit trail** – Every transaction logged with actor, amount, timestamp, result
- [ ] **No amount tampering** – API never accepts client-provided final balance, only calculates
- [ ] **Fraud flagging** – Unusual patterns (high frequency, large amounts) logged

### High – Reliability
- [ ] **Partial failure recovery** – After server crash mid-transfer, system self-heals to consistent state
- [ ] **Slow query handling** – Balance inquiry under load must not return stale data
- [ ] **Connection drop** – Client cannot poll same transaction ID twice without knowing first attempt's result

### Medium – User Experience  
- [ ] **Clear error messages** – "Insufficient funds" vs "Account not found" vs "Service unavailable"
- [ ] **Transaction ID in response** – Always provided so client can query status later
- [ ] **Rate limiting headers** – Clients informed of rate limits; 429 Too Many Requests when exceeded

---

## Test Data Scenarios

### Valid Paths
- Happy path: auth → check balance → transfer → confirm → verify both sides
- Edge case: transfer exact available balance
- Retry case: successful transfer re-submitted with same idempotency key

### Failure Paths  
- Insufficient funds
- Invalid account
- Expired token (reauth required)
- Concurrent transfers exceed available balance
- Network timeout mid-transfer (query final state)

---
## Risk-Based Prioritization

### P0 – Critical (Must never fail)
- Money transfer execution
- Balance consistency after transaction
- Duplicate transaction prevention
- Unauthorized access

### P1 – High
- Transaction history accuracy
- Idempotency behavior
- Timeout and retry consistency

### P2 – Medium
- Error message clarity
- Rate limiting feedback
- Non-critical edge validations

### P3 – Low
- Extra fields handling
- Minor formatting validations