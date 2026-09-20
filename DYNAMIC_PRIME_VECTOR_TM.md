# DYNAMIC_PRIME_VECTOR_TM

Dynamic prime-vector TM (tick / PC / `p_n` state machine). Hologram reconstructs; `sha=false`.

The one-liner is already a continuous loop (`HZ`, `MAX_TICKS`, `HALT`).

## Run

```sh
# continuous (default HZ=1)
bash DYNAMIC_PRIME_VECTOR_TM.sh

# finite certificate
MAX_TICKS=5 HZ=100 bash DYNAMIC_PRIME_VECTOR_TM.sh

curl -fsSL https://raw.githubusercontent.com/letsgo0226/-DYNAMIC_PRIME_VECTOR_TM.sh/main/DYNAMIC_PRIME_VECTOR_TM.sh | MAX_TICKS=3 HZ=100 bash
```

## Resident

- Daemon: `DYNAMIC_PRIME_VECTOR_TM_DAEMON.sh` (continuous TM, default **HZ=1**)
- Actions: `.github/workflows/dynamic-prime-vector-tm.yml` (`*/5`, `MAX_TICKS=5`)

## Bound

Formal / symbolic prime-vector certificate only — not RH/TOE.
