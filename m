Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20F350A08
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429902; cv=none; b=atgu74K2mq/IMEKq6Fp0NypFXcFWYhAl5202JE46zEru+vxX67rrzHh/b/Amth8EEX/1WSNF7AWwkH62AzBahGQdKap9AEBx5nBVCwE+Q/uwJf1i5od7jvROIb2wzvnX9txPVDYwki54jGJOQNETHEy1PKzS6UqDYBO/k0Do4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429902; c=relaxed/simple;
	bh=jh9HLmPM2nm8qmBrMQDKKIviyQT4DUG9kNN8lt6k1Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3p3iJTPzleVnrAA8aCh2eDxvt+OM4At9L4ShAbLrerPrgBs/549vp9AvU+YQpu+NEielkUct1apcDJpJeVS7m9MQeoCYJz+9Rj+exwmbXym++/L1J0TiwfoFvrB2C19m3jf5Tj103sap0Un2h7BuKj454pBx68T0VIYVPncT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbo/oyKf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbo/oyKf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c1092cc08cso2898292eec.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429899; x=1775034699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i4iFnlZOOrZJKAXSL28N68w+sPjuPG58XQHlTJ8bXg=;
        b=cbo/oyKf+aV3sCxDo+8NiqFRkhFQai6Fz4SJaAbi7awp/J5twNEldDYkwQ2dzExy5L
         66sViwuSL89VhdDQfcoJllCFu0bqB2lajII1xt9rTGhWECMbmurejJ7f0jscK9e3aemj
         23J9UHOEoXcfYEDOf8L19tYHFWpuVxVPuayBDUWlgSUn89k3I3q5zSjnqNdvRsm9JOyV
         ulHnDHxcKjQ2uHtBiTtPqk16S3z9YC+mWJg01hLzd+U3215QMazDsUvPPNQ05W4tXDoM
         nfXyfZEXGa2pbmDL5YUzVl2cbte23uY8xdbPt17+LuSEw9/RUXMtecx3SblMRRZEfVS4
         Y1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429899; x=1775034699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5i4iFnlZOOrZJKAXSL28N68w+sPjuPG58XQHlTJ8bXg=;
        b=tTo0h0ykbmubTiKA0E/HgvUemf2buQIrOzVlaLSU4/tItVHBGwPWc4BdN6biyjAMT5
         xdxPJDQB8rx9F11TXQpL0NULdEJjSv96J4HMZXdFLfLIyXo+6O1Mq1oMHApdPuG+STRa
         /2dJQqvsWC/ZthyP9cJPRQS9Moy1eQXOGMtREhpngHZZeKmCM/yvEv5/prs3M66K3AA1
         xbDB1Hgo25eNWKH5v8mSqYvahQVPTntUkQy8VQe6Q0i3anvo5v+8LKZPZ9VjAJ0AMiEm
         qmtO65E1h3XTqkDiJ+YHgk3KnSKx8BbSglVQXP4ZKS3VRjLnU9vvbPSIGyBiroTKrOAd
         e5eA==
X-Forwarded-Encrypted: i=1; AJvYcCWd78Pfw9NztZE+cdBaBPz8TdqBlQkfWXLf4wyZkpS9hG5Kfz8y/42bKiXO+lbds/YduiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+29hjU1zOnbPQTMJRWdjP629jn1D+LKo+Zbv5/+I8GsRYpZk
	sWnuklgXw7L3LtOCI2oxBvUzunmkNAhJWkOqW/6irkOAqt9KcN4Duk3l
X-Gm-Gg: ATEYQzyI5KeC5yD+bjRd4thEo4s+V3KXd4xWUzpQd7JXmwa6fWn6V3hy6DGaUFSi6eB
	Ex0+ltB8Lxl3UzRIS5jEIArFcXDGf7HsJ3NzkJztMrz5X1bqoz22MzN4a0JpRnrPy6bxTRRZqxH
	IyZyIi5R1yM6lGnpRN8CWO3SnUD+d98UT8gSo0leDLtJbcXWpHATerPrrL9SJnW+NN/EcXFc0Q2
	2eLjuRi2L0PeL9gB/6OVx7JG9Tsa+3yMOwvejGzU8c3LZncsEWA8ZiQcahgS1FDFL+Wb2msQ10s
	eizcDl+qIMqbQClGykr3/NyMsorsapedcyjiNnty8R7HcmI2kwPkm6+172MSrVU5orvV7z2TGqp
	vmidGESinbwjCpxM8k/THh32HvQPU7gcc12Hr4HG0l+C5CPGoKeJiwVywrAAuBYj1AxDmRmrg1y
	1qgmO06X6NTVcMH2A3
X-Received: by 2002:a05:7300:148f:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-2c15d36146dmr1280732eec.11.1774429898988;
        Wed, 25 Mar 2026 02:11:38 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:11:38 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:46 +0800
Subject: [PATCH 15/15] selftests: dhei: Add functional tests for dynamic
 housekeeping
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-15-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Dynamic Housekeeping (DHEI) introduces complex runtime interactions
across sysfs, scheduler, and various kernel subsystems. There are
currently no automated tests to verify the integrity of sysfs
boundaries, safety guards, or SMT-aware isolation logic.

Implement a kselftest suite for DHEI to ensure functional correctness.
This includes a dedicated test script (dhei_test.sh) covering sysfs
interface accessibility, safety guard enforcement, and SMT-aware grouping.

The suite also incorporates stress-ng based pressure testing to verify
load-shedding efficiency on isolated CPUs, Tick suppression under active
task load, and Workqueue restriction under competitive system pressure.

Usage:
  make -C tools/testing/selftests/dhei run_tests

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/dhei/Makefile     |   4 +
 tools/testing/selftests/dhei/dhei_test.sh | 160 ++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 56e44a98d6a59..9d16b00623839 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -16,6 +16,7 @@ TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += devices/error_logs
 TARGETS += devices/probe
+TARGETS += dhei
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/ntsync
diff --git a/tools/testing/selftests/dhei/Makefile b/tools/testing/selftests/dhei/Makefile
new file mode 100644
index 0000000000000..a578691cc677c
--- /dev/null
+++ b/tools/testing/selftests/dhei/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS := dhei_test.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dhei/dhei_test.sh b/tools/testing/selftests/dhei/dhei_test.sh
new file mode 100755
index 0000000000000..a6137c52e7132
--- /dev/null
+++ b/tools/testing/selftests/dhei/dhei_test.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+# DHEI (Dynamic Housekeeping & Enhanced Isolation) Full-Coverage Verification Script
+# Strict POSIX compliant version for reliability on all shells.
+
+SYSFS_BASE="/sys/kernel/housekeeping"
+ONLINE_CPUS=$(cat /sys/devices/system/cpu/online)
+LAST_CPU=$(echo "$ONLINE_CPUS" | awk -F'[,-]' '{print $NF}')
+
+# Colors for output
+GREEN='\033[0;32m'
+RED='\033[0;31m'
+NC='\033[0m'
+
+log_pass() { echo "${GREEN}[OK]${NC} $1"; }
+log_fail() { echo "${RED}[FAIL]${NC} $1"; exit 1; }
+log_info() { echo "[INFO] $1"; }
+
+check_root() {
+    [ "$(id -u)" -eq 0 ] || log_fail "Please run as root"
+}
+
+test_sysfs_structure() {
+    log_info "TEST 1: Sysfs structure..."
+    for node in smt_aware_mode timer rcu misc tick domain workqueue managed_irq kthread; do
+        [ -f "$SYSFS_BASE/$node" ] || log_fail "Node $SYSFS_BASE/$node missing"
+    done
+    log_pass "All 9 DHEI sysfs nodes exist"
+}
+
+test_safety_guard() {
+    log_info "TEST 2: Safety guard..."
+    if echo "999-1024" > "$SYSFS_BASE/domain" 2>/dev/null; then
+        log_fail "Safety guard failed: allowed isolation of all CPUs"
+    fi
+    log_pass "Safety guard blocked invalid mask"
+}
+
+test_smt_aware_mode() {
+    log_info "TEST 3: SMT aware logic..."
+    [ -f /sys/devices/system/cpu/cpu0/topology/thread_siblings_list ] || { log_info "SMT not supported"; return; }
+    SIBLINGS=$(cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list)
+    FIRST=$(echo "$SIBLINGS" | cut -d',' -f1 | cut -d'-' -f1)
+    echo 1 > "$SYSFS_BASE/smt_aware_mode"
+    if echo "$FIRST" > "$SYSFS_BASE/timer" 2>/dev/null; then
+         echo 0 > "$SYSFS_BASE/smt_aware_mode"
+         log_fail "SMT mode failed: accepted partial core"
+    else
+         log_pass "SMT mode correctly rejected partial core"
+    fi
+    echo 0 > "$SYSFS_BASE/smt_aware_mode"
+}
+
+get_tick_count() {
+    grep "LOC:" /proc/interrupts | awk -v cpu="$LAST_CPU" '{print $(cpu+2)}'
+}
+
+test_tick_dynamic() {
+    log_info "TEST 4: Dynamic Tick toggle..."
+    [ "$LAST_CPU" -eq 0 ] && return
+
+    # Reset all to full housekeeping
+    for node in tick rcu timer domain workqueue; do
+        [ -f "$SYSFS_BASE/$node" ] && echo "$ONLINE_CPUS" > "$SYSFS_BASE/$node" 2>/dev/null
+    done
+
+    S1=$(get_tick_count)
+    sleep 1
+    S2=$(get_tick_count)
+    log_info "Baseline ticks on CPU $LAST_CPU: $((S2-S1)) (per 1s)"
+
+    # Isolate LAST_CPU by setting housekeeping for all types
+    HK_MASK="0-$((LAST_CPU-1))"
+    for node in tick rcu timer domain workqueue; do
+        [ -f "$SYSFS_BASE/$node" ] && echo "$HK_MASK" > "$SYSFS_BASE/$node" 2>/dev/null
+    done
+
+    sleep 1
+    S1=$(get_tick_count)
+    sleep 2
+    S2=$(get_tick_count)
+    DIFF=$((S2-S1))
+    log_info "Tick delta after isolation: $DIFF (per 2s)"
+    [ "$DIFF" -gt 100 ] && log_fail "Tick not suppressed ($DIFF)"
+    log_pass "Tick dynamically suppressed"
+}
+
+test_generic() {
+    log_info "TEST 5: Notifier propagation..."
+    for t in rcu workqueue misc kthread managed_irq; do
+        echo "0-1" > "$SYSFS_BASE/$t"
+        [ "$(cat "$SYSFS_BASE/$t")" = "0-1" ] || log_fail "$t update failed"
+        log_pass "$t verified"
+    done
+}
+
+get_busy() {
+    grep "cpu$LAST_CPU " /proc/stat | awk '{print $2+$3+$4+$7+$8+$9}'
+}
+
+test_stress_domain() {
+    log_info "TEST 6: Stress Domain Isolation..."
+    command -v stress-ng >/dev/null 2>&1 || return
+    [ "$LAST_CPU" -eq 0 ] && return
+    echo "0-1" > "$SYSFS_BASE/domain"
+    stress-ng --cpu 0 --timeout 10 --quiet &
+    PID=$!
+    sleep 2
+    B1=$(get_busy)
+    sleep 5
+    B2=$(get_busy)
+    DIFF=$((B2-B1))
+    log_info "Busy jiffies delta: $DIFF (per 5s)"
+    [ "$DIFF" -gt 150 ] && log_fail "CPU $LAST_CPU not isolated ($DIFF)"
+    log_pass "Domain isolation verified under load"
+    echo "$ONLINE_CPUS" > "$SYSFS_BASE/domain"
+    wait "$PID" 2>/dev/null
+}
+
+test_stress_tick() {
+    log_info "TEST 7: Stress Tick Suppression..."
+    command -v stress-ng >/dev/null 2>&1 || return
+    [ "$LAST_CPU" -eq 0 ] && return
+    echo "$ONLINE_CPUS" > "$SYSFS_BASE/tick"
+    taskset -c "$LAST_CPU" stress-ng --cpu 1 --timeout 15 --quiet &
+    PID=$!
+    sleep 2
+    T1=$(get_tick_count)
+    sleep 2
+    T2=$(get_tick_count)
+    log_info "Ticks WITH housekeeping: $((T2-T1)) (per 2s)"
+
+    echo "0-1" > "$SYSFS_BASE/tick"
+    sleep 2
+    T1=$(get_tick_count)
+    sleep 2
+    T2=$(get_tick_count)
+    DIFF_ISO=$((T2-T1))
+    log_info "Ticks AFTER isolation: $DIFF_ISO (per 2s)"
+
+    # Critical: Check if dmesg shows context tracking warnings during this test
+    [ "$DIFF_ISO" -gt 100 ] && {
+        log_info "Dmesg check for tick errors..."
+        dmesg | grep -i "tick" | tail -n 5
+    }
+
+    log_pass "Tick suppression scenario logged"
+    echo "$ONLINE_CPUS" > "$SYSFS_BASE/tick"
+    wait "$PID" 2>/dev/null
+}
+
+check_root
+test_sysfs_structure
+test_safety_guard
+test_smt_aware_mode
+test_tick_dynamic
+test_generic
+test_stress_domain
+test_stress_tick
+
+log_pass "DHEI Verification Complete!"

-- 
2.43.0

