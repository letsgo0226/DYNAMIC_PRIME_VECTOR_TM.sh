# DYNAMIC_PRIME_VECTOR_TM.sh

Dynamic prime-vector TM (continuous tick / `p_n` machine). Repo: `-DYNAMIC_PRIME_VECTOR_TM.sh`.

| Artifact | Role |
|----------|------|
| `DYNAMIC_PRIME_VECTOR_TM.sh` | One-liner (~1539B; continuous unless `MAX_TICKS`/`HALT`) |
| `DYNAMIC_PRIME_VECTOR_TM_DAEMON.sh` | Resident wrapper (default HZ=1) |
| `.github/workflows/dynamic-prime-vector-tm.yml` | Actions `*/5` |

```sh
MAX_TICKS=5 HZ=100 bash DYNAMIC_PRIME_VECTOR_TM.sh
nohup bash DYNAMIC_PRIME_VECTOR_TM_DAEMON.sh 1 >> dynamic_prime_vector_tm_daemon.log 2>&1 &
```

Bound: formal / symbolic only — not RH/TOE.
