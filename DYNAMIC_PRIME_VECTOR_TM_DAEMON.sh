#!/usr/bin/env bash
# DYNAMIC_PRIME_VECTOR_TM resident loop — runs the continuous TM (HZ, default 1)
set -u
HZ="${1:-${DPV_HZ:-1}}"
LOG="${DPV_LOG:-dynamic_prime_vector_tm_daemon.log}"
DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd || pwd)"
SCRIPT="${DPV_SCRIPT:-$DIR/DYNAMIC_PRIME_VECTOR_TM.sh}"
RAW_URL="https://raw.githubusercontent.com/letsgo0226/-DYNAMIC_PRIME_VECTOR_TM.sh/main/DYNAMIC_PRIME_VECTOR_TM.sh"
WORKDIR="${DPV_WORKDIR:-$DIR/run}"
mkdir -p "$WORKDIR"
if [[ ! -f "$SCRIPT" ]]; then
  command -v curl >/dev/null || exit 127
  SCRIPT="${TMPDIR:-/tmp}/DYNAMIC_PRIME_VECTOR_TM.sh"
  curl -fsSL "$RAW_URL" -o "$SCRIPT" || exit 1
fi
command -v python3 >/dev/null || exit 127
echo "{\"daemon\":\"DYNAMIC_PRIME_VECTOR_TM\",\"hz\":$HZ,\"mode\":\"continuous\",\"ts\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" | tee -a "$LOG"
# restart wrapper: TM is the loop; assert each stdout tick line + state.json
while true; do
  rm -f "$WORKDIR/HALT"
  (cd "$WORKDIR" && HZ="$HZ" bash "$SCRIPT") 2>>"$LOG" | while IFS= read -r line; do
    TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    echo "$line" >>"$LOG.ticks"
    if python3 - "$WORKDIR/state.json" "$line" <<'PY'
import json,sys
try:
  tick=json.loads(sys.argv[2])
  o=json.load(open(sys.argv[1]))
except Exception:
  raise SystemExit(2)
h=o.get("hologram") or {}
ok=(o.get("model")=="DYNAMIC_PRIME_VECTOR_TM"
    and isinstance(o.get("t"), int) and o.get("t")>=1
    and isinstance(tick.get("t"), int)
    and tick.get("t")==o.get("t")
    and h.get("sha") is False
    and h.get("reconstruct") is True)
raise SystemExit(0 if ok else 2)
PY
    then echo "{\"ts\":\"$TS\",\"status\":\"pass\",\"tick\":$line}" >>"$LOG"
    else echo "{\"ts\":\"$TS\",\"status\":\"assert_fail\",\"tick\":$line}" >>"$LOG"
    fi
  done
  echo "{\"ts\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"status\":\"restart\"}" >>"$LOG"
  sleep 1
done
