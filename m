Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782377;
	b=I55FOTsJeBUP3pWRLhC7VVvIk4Rxz7i0DI6VvksbprCXQKyFzhv/cXxn67CIQLiJnfJS
	 BNW6uz7GdNbsQjRpHd30h1HpadnP+5OE0wG4+RvJ83drmQi9ongzbfWi8gAP6ww8k0RXW
	 GynT41F+RCt5KWrArZNFJnOLedPPh77ySiW6MJUKP7I4FIAvFVNaJj5b6vqRF9VMupJLn
	 7NgvIAujtnid/Ok20XkS7zc0iLG7WiMBIChhIjq1LJ5C5m+RD7yfEPYYu8d4gRxnkRgRo
	 7D5SmJXsdvwgb4JNl9gDnIZ8sChkjnCec2wap3mCXgPks74bcACXKPUnwakoPsH8hSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/259c62n7+Wa6c4+4n64d2z7iIiiXK+7ST8++ApfVj8=;
	b=I/Qu5mlLSf2v+5Vcwjmy+SOQv4/9Ftj/6RhaDq60V9TFbYns9+iv/DEMt3+RVAF6HcBj
	 Y59wTuJPgLuebyMW62RR9LXprzFAcXeNuj+6tQUcpDzxx65Pjl+9sMrkYZ4v5Vtmzgsfg
	 RKa03bmrFDXwEyiO6inMtg7gZG6g7IfZ77yqsZcN1NqDDAl5fUJb+KxRno3g7Ce6Znpip
	 vGEtgOEbf/5uKTxjMhIpyUzh7cxWz/Wtn8RNIZvrdm8tRh3rezI0lxUgNR8a3RQuZzy+u
	 12erONc8S61+f8pONsspKu/yj1NnKnT1vkkqWXRS4FSyZOV2qHqF5sO9rOA1tdl+e5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TbSyUA3Y;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47994606A323
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47994606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TbSyUA3Y
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so1072774c88.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782375; x=1793387175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/259c62n7+Wa6c4+4n64d2z7iIiiXK+7ST8++ApfVj8=;
        b=TbSyUA3YUWLJPorSSjoOy79WQFQ1lYInA3xZcdwC2H+Iu84G9JmcsZsswV4GrIo15+
         EWsl85wpAA0jwkShpXqWiI+3Xka/aNbrRGjQQFnKBnx9Q2su9BKUMYo1o/NjxWktp7gL
         cXKG3EvZh6Y0o/WoeTmVJyIe0my8d+EjCi0HjuBmm7aauwQzXeeqHtNQtLyGhGeZJ0m0
         n8Ksp4HRpda169w9rWnbzQp7cX8mNptwtWjkl8Tcy48UEpSkB2DoszcuYhi8jcThohAd
         IhW3TzjP7XoZzgqYaKMjxJsbquTY4UoUsyN10BkzcUL9O5HtVu8LkqzT8PATROMHHSMe
         0LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782375; x=1793387175;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/259c62n7+Wa6c4+4n64d2z7iIiiXK+7ST8++ApfVj8=;
        b=I4MwGXN+UV/VMWvrxxNaoxxuHLwVMtHAaSVBGfAkkmUb5FGWG/BR43wFllv99dpmxk
         jVQYVVE4LhVwOpHqtKqZWmd/V/GOuCIg5SiD7pbQLttIspIJUbYJqWBfCCJ76KCfuEIk
         JH2zKAzP/ZEha24DxLGsNSPoNhg28lOvHqQ5s3/skmFmOBlOkMxHY8cSZwwVUT4sx5LW
         Gty18q+wzbe97w2Gyi4ebt5xb41c+rseAth0cNYV/K4VyyYdxq1iINHiDNiC2Tdce83/
         NJZrAjQOaBp/SWcH1Rq8xjoSt4iOdNOzlJfjhxZT0IGBzVZ3RhClZMLGP9HfhW+f0teZ
         i3Vw==
X-Forwarded-Encrypted: i=1; AKwUvBw8q4oTzTWmqDq3hfNetURA3ZjAWB7LTrVkh/Hf7bsCjHGrbvx8TawKGfmaSlC+rqJykik=@vger.kernel.org
X-Gm-Message-State: AFq9FYIef5m9PKVsxfqC8DII7boqSDaEur8LQhtPofc6c2L6I4Mrm8/B
	Jp38QQqiLKIAvic5GG6p4NX1/XTMZ1ZnNqmt5pkx8YEOGVYQH4MUjG8ugtJQIbalKt1XNWeqTGd
	DhGCPzuhz1g==
X-Received: from dlbsj2-n1.prod.google.com ([2002:a05:7022:f902:10b0:158:5d29:90be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f50f:b0:144:f85a:a188
 with SMTP id a92af1059eb24-19928f1525amr372c88.2.1792782374523; Fri, 23 Oct
 2026 12:06:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:53 -0700
In-Reply-To: <20261023190558.3050796-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022203003.1779152-1-irogers@google.com> <20261023190558.3050796-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023190558.3050796-7-irogers@google.com>
Subject: [PATCH v7 06/11] perf bpf-filter: Extend lock_held() to other kernel
 lock types
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the lock_held() BPF sample filter beyond global mutexes to
support:
- Other global/static kernel lock symbols (rwsem, spinlock, rwlock,
  rt-mutex, percpu-rwsem, semaphore) and hexadecimal kernel lock
  addresses.
- Lock types and flags: mutex, spinlock, rwsem, rwsem:R, rwsem:W,
  rwlock, rwlock:R, rwlock:W, rt-mutex, percpu-rwsem, pcpu-sem:W,
  semaphore.

For rt-mutexes and write-locked rwsems, perf_sample_filter inspects the
lock's owner field directly in kernel memory. For locks and modes without
an authoritative per-task owner pointer (spinlocks, rwlocks, semaphores,
reader-locked rwsems, percpu-rwsems, and lock type filters), attach BPF
fentry/fexit hooks on kernel lock acquire and release functions to track
held locks in the held_locks BPF LRU hash map.

Use classify_lock_sym() both when selecting which hooks to load and when
resolving the filter, so the two agree. A '*_sem' suffix may be either a
semaphore (console_sem) or an rw_semaphore (namespace_sem), so hook both
and allow read mode.

Note that counting semaphores (down*() / up()) do not enforce same-task
ownership in the kernel: when a semaphore is used as a cross-task
completion/signaling mechanism, fexit/down and fentry/up will not pair
on the same task ID. Semaphore hooks are therefore only enabled when
'semaphore' or a '*_sem' symbol (such as console_sem) is explicitly
specified, and held_locks uses BPF_MAP_TYPE_LRU_HASH so any unpaired
cross-task entries are automatically evicted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |  53 +-
 tools/perf/util/bpf-filter.c                 | 601 ++++++++++++-
 tools/perf/util/bpf_skel/sample-filter.h     |  17 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 851 ++++++++++++++++++-
 4 files changed, 1470 insertions(+), 52 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 34dd9b1a5365..d603820b51c9 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -221,15 +221,50 @@ OPTIONS
 
 	The 'lock_held(<lock>)' predicate (or '!lock_held(<lock>)') filters
 	samples based on whether the specified kernel lock is currently held
-	by the kernel thread.  To differentiate between shared/read holding
-	and exclusive/write holding, use 'lock_held_read(<lock>)' (alias
-	'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)' (alias
-	'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to <lock>.
-	<lock> can be a kernel mutex symbol name (e.g.
-	'lock_held(cgroup_mutex)').  When filtering on a mutex symbol
-	('*_mutex'), 'perf_sample_filter' inspects the lock's 'owner' field
-	directly in kernel memory on each sample without attaching any BPF
-	fentry/fexit hooks.
+	by the kernel thread or CPU.  To differentiate between shared/read
+	holding and exclusive/write holding, use 'lock_held_read(<lock>)'
+	(alias 'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)'
+	(alias 'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to
+	<lock> (e.g. 'lock_held(rwsem:R)' or 'lock_held(rwsem:W)').
+	<lock> can be a kernel lock symbol name (e.g.
+	'lock_held(cgroup_mutex)'), a hexadecimal lock address, or a lock type
+	('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
+	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
+	'semaphore').  Both read/shared and write/exclusive tracking are
+	supported for 'rwsem' and 'rwlock'; 'mutex', 'spinlock', 'rt-mutex',
+	'semaphore', and 'percpu-rwsem' ('percpu_down_write()') support
+	write/exclusive tracking only.  Note that 'semaphore' tracking
+	('down*()' / 'up()') assumes binary mutex-like usage where the
+	acquiring task also releases the semaphore (such as 'console_sem'),
+	rather than cross-task completion signaling.
+
+	For example, 'lock_held()' can be combined with memory allocation or
+	reclaim events to detect allocations or direct memory reclaim occurring
+	while a kernel lock is held (which can stall lock waiters for extended
+	periods):
+
+	  # perf record -a -g -e vmscan:mm_vmscan_direct_reclaim_begin \
+	      --filter 'lock_held(mutex) || lock_held(rwsem)'
+	  # perf record -a -g -e kmem:mm_page_alloc \
+	      --filter 'gfp_flags & 0x400' \
+	      --filter 'lock_held(mutex) || lock_held(rwsem)'
+	  # perf record -a -g -e major-faults \
+	      --filter 'lock_held(mutex) || lock_held(rwsem)'
+
+	When filtering on a specific mutex symbol ('*_mutex') or rt-mutex
+	symbol ('*_rt_mutex'), 'perf_sample_filter' inspects the lock's
+	'owner' field directly in kernel memory on each sample without attaching
+	any BPF fentry/fexit hooks.  For locks that do not maintain an
+	authoritative per-task owner pointer (such as spinlocks, rwlocks,
+	semaphores, reader-locked rwsems, and lock type filters), it attaches
+	BPF fentry/fexit programs to kernel lock acquire and release functions
+	to track held locks in a BPF map.  These BPF hooks run on every kernel
+	lock acquisition and release for the attached lock family, even when no
+	perf sample is being taken.  To minimize this overhead, only the hooks
+	for the relevant lock family and mode are attached when known, whereas
+	raw hex addresses or symbols without a recognizable lock-type suffix
+	attach hooks across all lock families (including high-frequency
+	spinlocks).
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 5d8f60649c5d..91fa9f97b639 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -66,6 +66,7 @@
 #include "util/cap.h"
 #include "util/debug.h"
 #include "util/evsel.h"
+#include "util/lock-contention.h"
 #include "util/symbol_conf.h"
 #include "util/target.h"
 #include "util/thread_map.h"
@@ -75,6 +76,7 @@
 #include <util/bpf-filter-flex.h>
 #include <util/bpf-filter-bison.h>
 
+#include "bpf_skel/lock_data.h"
 #include "bpf_skel/sample-filter.h"
 #include "bpf_skel/sample_filter.skel.h"
 
@@ -179,6 +181,163 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	return -1;
 }
 
+/*
+ * Program groups for `lock_held(...)` BPF tracing hooks.
+ *
+ * When a `lock_held(...)` filter is specified, only the BPF tracing program
+ * groups required for the requested lock(s) are autoloaded and attached.
+ * If no `lock_held(...)` filter is present, none of these programs are loaded.
+ */
+enum lock_prog_group {
+	LOCK_PROG_MUTEX         = 1U << 0,
+	LOCK_PROG_RWSEM_READ    = 1U << 1,
+	LOCK_PROG_RWSEM_WRITE   = 1U << 2,
+	LOCK_PROG_RWSEM         = LOCK_PROG_RWSEM_READ | LOCK_PROG_RWSEM_WRITE,
+	LOCK_PROG_SPIN          = 1U << 3,
+	LOCK_PROG_RWLOCK_READ   = 1U << 4,
+	LOCK_PROG_RWLOCK_WRITE  = 1U << 5,
+	LOCK_PROG_RWLOCK        = LOCK_PROG_RWLOCK_READ | LOCK_PROG_RWLOCK_WRITE,
+	LOCK_PROG_RTMUTEX       = 1U << 6,
+	LOCK_PROG_SEM           = 1U << 7,
+	LOCK_PROG_PERCPU_RWSEM  = 1U << 8,
+	LOCK_PROG_ALL           = 0x1ffU & ~LOCK_PROG_SEM,
+};
+
+static unsigned int lock_flags_to_prog_group(unsigned int flags)
+{
+	if (flags & LCB_F_MUTEX)
+		return LOCK_PROG_MUTEX;
+	if (flags & LCB_F_RT)
+		return LOCK_PROG_RTMUTEX;
+	if (flags & LCB_F_PERCPU)
+		return LOCK_PROG_PERCPU_RWSEM;
+	if (flags == LCB_F_SPIN)
+		return LOCK_PROG_SPIN;
+	if (flags & LCB_F_SPIN)
+		return (flags & LCB_F_READ) ? LOCK_PROG_RWLOCK_READ : LOCK_PROG_RWLOCK_WRITE;
+	if (flags & LCB_F_READ)
+		return LOCK_PROG_RWSEM_READ;
+	if (flags & LCB_F_WRITE)
+		return LOCK_PROG_RWSEM_WRITE;
+	return LOCK_PROG_SEM;
+}
+
+struct lock_prog_desc {
+	size_t prog_offset;
+	const char *btf_func;
+	unsigned int group;
+};
+
+#define LOCK_FPROG(field, func, grp) \
+	{ offsetof(struct sample_filter_bpf, progs.field), func, grp }
+
+/*
+ * fentry/fexit programs tracking lock acquire and release in held_locks. Each
+ * is only autoloaded by configure_lock_progs() when its group is needed.
+ *
+ * Note, a specific global mutex or rt_mutex symbol (e.g. cgroup_mutex) is
+ * checked directly via its owner field and needs no hooks. The mutex hooks
+ * are still needed when the mutex address isn't known ahead of time or many
+ * mutexes match: lock type filters (lock_held(mutex)), hex addresses and
+ * symbols of unknown lock type.
+ */
+static const struct lock_prog_desc lock_progs[] = {
+	/* Mutex */
+	LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit__mutex_lock_nest_lock, "_mutex_lock_nest_lock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interruptible", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_interruptible_nested",
+		   LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit__mutex_lock_killable, "_mutex_lock_killable", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fexit__mutex_trylock_nest_lock, "_mutex_trylock_nest_lock", LOCK_PROG_MUTEX),
+	LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),
+	/* RW semaphore */
+	LOCK_FPROG(fexit_down_read, "down_read", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_nested, "down_read_nested", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_interruptible, "down_read_interruptible", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_killable, "down_read_killable", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_killable_nested, "down_read_killable_nested",
+		   LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_read_trylock, "down_read_trylock", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fexit_down_write, "down_write", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_nested, "down_write_nested", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit__down_write_nest_lock, "_down_write_nest_lock", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_killable, "down_write_killable", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_killable_nested, "down_write_killable_nested",
+		   LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_down_write_trylock, "down_write_trylock", LOCK_PROG_RWSEM_WRITE),
+	LOCK_FPROG(fexit_downgrade_write, "downgrade_write", LOCK_PROG_RWSEM),
+	LOCK_FPROG(fentry_up_read, "up_read", LOCK_PROG_RWSEM_READ),
+	LOCK_FPROG(fentry_up_write, "up_write", LOCK_PROG_RWSEM_WRITE),
+	/* Spinlock */
+	LOCK_FPROG(fexit_raw_spin_lock, "_raw_spin_lock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_nested, "_raw_spin_lock_nested", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_nest_lock, "_raw_spin_lock_nest_lock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irq, "_raw_spin_lock_irq", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irq_disable, "_raw_spin_lock_irq_disable", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irqsave, "_raw_spin_lock_irqsave", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_irqsave_nested, "_raw_spin_lock_irqsave_nested",
+		   LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_lock_bh, "_raw_spin_lock_bh", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_trylock, "_raw_spin_trylock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fexit_raw_spin_trylock_bh, "_raw_spin_trylock_bh", LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock, "_raw_spin_unlock", LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_irq, "_raw_spin_unlock_irq", LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_irq_enable, "_raw_spin_unlock_irq_enable",
+		   LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_irqrestore, "_raw_spin_unlock_irqrestore",
+		   LOCK_PROG_SPIN),
+	LOCK_FPROG(fentry_raw_spin_unlock_bh, "_raw_spin_unlock_bh", LOCK_PROG_SPIN),
+	/* RWlock */
+	LOCK_FPROG(fexit_raw_read_lock, "_raw_read_lock", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_lock_irq, "_raw_read_lock_irq", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_lock_irqsave, "_raw_read_lock_irqsave", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_lock_bh, "_raw_read_lock_bh", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_read_trylock, "_raw_read_trylock", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock, "_raw_read_unlock", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock_irq, "_raw_read_unlock_irq", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock_irqrestore, "_raw_read_unlock_irqrestore",
+		   LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fentry_raw_read_unlock_bh, "_raw_read_unlock_bh", LOCK_PROG_RWLOCK_READ),
+	LOCK_FPROG(fexit_raw_write_lock, "_raw_write_lock", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_nested, "_raw_write_lock_nested", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_irq, "_raw_write_lock_irq", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_irqsave, "_raw_write_lock_irqsave", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_lock_bh, "_raw_write_lock_bh", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fexit_raw_write_trylock, "_raw_write_trylock", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock, "_raw_write_unlock", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock_irq, "_raw_write_unlock_irq", LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock_irqrestore, "_raw_write_unlock_irqrestore",
+		   LOCK_PROG_RWLOCK_WRITE),
+	LOCK_FPROG(fentry_raw_write_unlock_bh, "_raw_write_unlock_bh", LOCK_PROG_RWLOCK_WRITE),
+	/* RT-Mutex */
+	LOCK_FPROG(fexit_rt_mutex_lock, "rt_mutex_lock", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_lock_nested, "rt_mutex_lock_nested", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit__rt_mutex_lock_nest_lock, "_rt_mutex_lock_nest_lock", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_lock_interruptible, "rt_mutex_lock_interruptible",
+		   LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_lock_killable, "rt_mutex_lock_killable", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fexit_rt_mutex_trylock, "rt_mutex_trylock", LOCK_PROG_RTMUTEX),
+	LOCK_FPROG(fentry_rt_mutex_unlock, "rt_mutex_unlock", LOCK_PROG_RTMUTEX),
+	/* Semaphore */
+	LOCK_FPROG(fexit_down, "down", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_interruptible, "down_interruptible", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_killable, "down_killable", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_timeout, "down_timeout", LOCK_PROG_SEM),
+	LOCK_FPROG(fexit_down_trylock, "down_trylock", LOCK_PROG_SEM),
+	LOCK_FPROG(fentry_up, "up", LOCK_PROG_SEM),
+	/* Percpu-RWsem */
+	LOCK_FPROG(fexit_percpu_down_write, "percpu_down_write", LOCK_PROG_PERCPU_RWSEM),
+	LOCK_FPROG(fentry_percpu_up_write, "percpu_up_write", LOCK_PROG_PERCPU_RWSEM),
+};
+
+#undef LOCK_FPROG
+
 static int split_lock_name_mode(const char *name, int expr_part,
 				char *base_buf, size_t buf_sz,
 				bool *has_amp, unsigned int *mode_out)
@@ -225,6 +384,72 @@ static int split_lock_name_mode(const char *name, int expr_part,
 	return 0;
 }
 
+/*
+ * Parse a lock type name or flags name (e.g. "mutex", "rwsem", "rwsem:R",
+ * "spinlock", "percpu-rwsem").
+ *
+ * A lock type name may correspond to up to two flag combinations (e.g.
+ * "rwsem" matches both `LCB_F_READ` and `LCB_F_WRITE`). These are packed
+ * into `*encoded_pair` as `flag1 | (flag2 << 8)` (with 0xff if `flag2` is
+ * unused) for O(1) lookup in BPF, and accumulated as a bitmask in `*type_mask`.
+ */
+static bool parse_lock_type_name(const char *name, unsigned int mode,
+				 struct sample_filter_bpf *skel,
+				 u64 *encoded_pair, unsigned int *prog_groups)
+{
+	bool found = false;
+	u32 flag1 = 0xff, flag2 = 0xff;
+	unsigned int groups = 0;
+	const char *lookup = !strcmp(name, "pcpu-sem") ? "percpu-rwsem" : name;
+
+	for (size_t i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+		u32 f = lock_type_table[i].flags;
+		bool is_read = (f & LCB_F_READ) != 0;
+
+		if (strcmp(lock_type_table[i].lock_name, lookup) &&
+		    strcmp(lock_type_table[i].flags_name, name))
+			continue;
+
+		/*
+		 * percpu_down_read() / percpu_up_read() fast paths are inlined
+		 * per-CPU counter increments without function entry points, so
+		 * only writer holding (percpu_down_write / percpu_up_write) can
+		 * be tracked for percpu-rwsem. rwlock-rt is also not hooked.
+		 */
+		if ((f & LCB_F_PERCPU) && is_read)
+			continue;
+		if ((f & LCB_F_RT) && (f & (LCB_F_READ | LCB_F_WRITE)))
+			continue;
+		if ((f & LCB_F_MUTEX) && (f & LCB_F_SPIN))
+			continue;
+
+		if (is_read && !(mode & PBF_LOCK_MODE_READ))
+			continue;
+		if (!is_read && !(mode & PBF_LOCK_MODE_WRITE))
+			continue;
+
+		if (!found)
+			flag1 = f;
+		else if (f != flag1)
+			flag2 = f;
+		if (skel && f < LCB_F_TYPE_MAX) {
+			skel->bss->has_lock_type = 1;
+			skel->bss->lock_type_filter[f] = 1;
+		}
+		groups |= lock_flags_to_prog_group(f);
+		found = true;
+	}
+
+	if (!found)
+		return false;
+
+	if (encoded_pair)
+		*encoded_pair = flag1 | ((u64)flag2 << 8);
+	if (prog_groups)
+		*prog_groups |= groups;
+	return true;
+}
+
 struct lock_sym_cb_args {
 	const char *name;
 	u64 addr;
@@ -315,11 +540,138 @@ static int find_kernel_lock_sym(const char *name, u64 *addr)
 	return 0;
 }
 
+static bool parse_lock_hex_addr(const char *str, u64 *addr)
+{
+	char *end;
+	unsigned long long val;
+
+	if (!str || !*str)
+		return false;
+
+	errno = 0;
+	val = strtoull(str, &end, 16);
+	if (*end != '\0' || errno != 0 || val == 0)
+		return false;
+
+	*addr = val;
+	return true;
+}
+
 static bool btf_has_func(struct btf *btf, const char *name)
 {
 	return btf && name && btf__find_by_name_kind(btf, name, BTF_KIND_FUNC) > 0;
 }
 
+static unsigned int supported_lock_prog_groups(struct btf *btf)
+{
+	unsigned int supported = 0;
+
+	if (!btf)
+		return 0;
+
+	if ((btf_has_func(btf, "mutex_lock") || btf_has_func(btf, "mutex_lock_nested")) &&
+	    btf_has_func(btf, "mutex_unlock"))
+		supported |= LOCK_PROG_MUTEX;
+
+	if ((btf_has_func(btf, "down_read") || btf_has_func(btf, "down_read_nested")) &&
+	    btf_has_func(btf, "up_read"))
+		supported |= LOCK_PROG_RWSEM_READ;
+
+	if ((btf_has_func(btf, "down_write") || btf_has_func(btf, "down_write_nested")) &&
+	    btf_has_func(btf, "up_write"))
+		supported |= LOCK_PROG_RWSEM_WRITE;
+
+	/*
+	 * Require both acquire and all unlock entry points in BTF so we never
+	 * attach spinlock/rwlock acquire hooks when unlock functions are
+	 * inlined (e.g. !CONFIG_UNINLINE_SPIN_UNLOCK or CONFIG_INLINE_*_UNLOCK).
+	 */
+	if ((btf_has_func(btf, "_raw_spin_lock") || btf_has_func(btf, "_raw_spin_lock_nested")) &&
+	    btf_has_func(btf, "_raw_spin_unlock") &&
+	    btf_has_func(btf, "_raw_spin_unlock_irq") &&
+	    btf_has_func(btf, "_raw_spin_unlock_irqrestore") &&
+	    btf_has_func(btf, "_raw_spin_unlock_bh"))
+		supported |= LOCK_PROG_SPIN;
+
+	if (btf_has_func(btf, "_raw_read_lock") &&
+	    btf_has_func(btf, "_raw_read_unlock") &&
+	    btf_has_func(btf, "_raw_read_unlock_irq") &&
+	    btf_has_func(btf, "_raw_read_unlock_irqrestore") &&
+	    btf_has_func(btf, "_raw_read_unlock_bh"))
+		supported |= LOCK_PROG_RWLOCK_READ;
+
+	if ((btf_has_func(btf, "_raw_write_lock") || btf_has_func(btf, "_raw_write_lock_nested")) &&
+	    btf_has_func(btf, "_raw_write_unlock") &&
+	    btf_has_func(btf, "_raw_write_unlock_irq") &&
+	    btf_has_func(btf, "_raw_write_unlock_irqrestore") &&
+	    btf_has_func(btf, "_raw_write_unlock_bh"))
+		supported |= LOCK_PROG_RWLOCK_WRITE;
+
+	if ((btf_has_func(btf, "rt_mutex_lock") || btf_has_func(btf, "rt_mutex_lock_nested")) &&
+	    btf_has_func(btf, "rt_mutex_unlock"))
+		supported |= LOCK_PROG_RTMUTEX;
+
+	if (btf_has_func(btf, "down") && btf_has_func(btf, "up"))
+		supported |= LOCK_PROG_SEM;
+
+	if (btf_has_func(btf, "percpu_down_write") && btf_has_func(btf, "percpu_up_write"))
+		supported |= LOCK_PROG_PERCPU_RWSEM;
+
+	return supported;
+}
+
+/*
+ * Enable or disable autoload for each lock-tracking BPF program in the
+ * skeleton before `sample_filter_bpf__load()` is called.
+ *
+ * Each program is enabled only if its group is in `needed_groups` and its
+ * target kernel function or tracepoint exists in the running kernel's BTF.
+ */
+static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
+				unsigned int needed_groups,
+				unsigned int required_groups,
+				bool is_tracepoint)
+{
+	unsigned int supported_groups = supported_lock_prog_groups(btf);
+	unsigned int enabled_progs = 0;
+
+	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
+
+	if ((required_groups & supported_groups) != required_groups ||
+	    (needed_groups && !(needed_groups & supported_groups))) {
+		pr_err("Error: Kernel BTF lacks required lock/unlock tracing entry points\n");
+		return -ENOTSUP;
+	}
+
+	needed_groups &= supported_groups;
+	if (skel)
+		skel->bss->track_rwsem_read = !!(needed_groups & LOCK_PROG_RWSEM_READ);
+
+	for (size_t i = 0; i < ARRAY_SIZE(lock_progs); i++) {
+		struct bpf_program **progp = (void *)skel + lock_progs[i].prog_offset;
+		struct bpf_program *prog = *progp;
+		bool enable = false;
+
+		if ((needed_groups & lock_progs[i].group) && btf &&
+		    lock_progs[i].btf_func) {
+			if (btf__find_by_name_kind(btf, lock_progs[i].btf_func,
+						   BTF_KIND_FUNC) > 0)
+				enable = true;
+		}
+
+		if (enable)
+			enabled_progs++;
+		bpf_program__set_autoload(prog, enable);
+	}
+
+	if (needed_groups && !enabled_progs) {
+		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
+		return -ENOTSUP;
+	}
+	return 0;
+}
+
 /* Kind of lock a global/static kernel lock symbol refers to. */
 enum lock_sym_class {
 	LOCK_SYM_UNKNOWN,
@@ -443,10 +795,22 @@ static enum lock_sym_class classify_lock_sym(struct btf *btf, const char *name)
 	return LOCK_SYM_UNKNOWN;
 }
 
+/*
+ * Pre-scan a single filter expression prior to loading the BPF skeleton in
+ * order to determine which BPF maps need to be sized and which lock tracing
+ * program groups need to be autoloaded.
+ */
 static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 				  struct btf **btf,
-				  bool *has_lock_filter)
+				  bool *has_lock_filter,
+				  unsigned int *prog_groups,
+				  unsigned int *required_groups)
 {
+	char base[128];
+	bool has_amp;
+	unsigned int mode, groups = 0;
+	u64 dummy;
+
 	if (expr->term != PBF_TERM_LOCK_HELD || !expr->lock_name)
 		return;
 
@@ -457,6 +821,68 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 		if (libbpf_get_error(*btf))
 			*btf = NULL;
 	}
+	if (split_lock_name_mode(expr->lock_name, expr->part, base,
+				 sizeof(base), &has_amp, &mode) < 0 || has_amp)
+		return;
+
+	if (parse_lock_type_name(base, mode, NULL, NULL, &groups)) {
+		*prog_groups |= groups;
+		*required_groups |= groups;
+		return;
+	}
+
+	if (parse_lock_hex_addr(base, &dummy)) {
+		*prog_groups |= LOCK_PROG_ALL;
+		return;
+	}
+
+	switch (classify_lock_sym(*btf, base)) {
+	case LOCK_SYM_MUTEX:
+	case LOCK_SYM_RTMUTEX:
+		/* Inspected directly via lock->owner; no tracing hooks needed. */
+		return;
+	case LOCK_SYM_PERCPU_RWSEM:
+		*prog_groups |= LOCK_PROG_PERCPU_RWSEM;
+		*required_groups |= LOCK_PROG_PERCPU_RWSEM;
+		return;
+	case LOCK_SYM_RWSEM:
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_RWSEM_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_RWSEM_WRITE;
+		*prog_groups |= groups;
+		*required_groups |= groups;
+		return;
+	case LOCK_SYM_SEM:
+		*prog_groups |= LOCK_PROG_SEM;
+		*required_groups |= LOCK_PROG_SEM;
+		return;
+	case LOCK_SYM_SEM_OR_RWSEM:
+		/* Hook both semaphore and rw_semaphore entry points. */
+		groups = LOCK_PROG_SEM;
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_RWSEM_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_RWSEM_WRITE;
+		*prog_groups |= groups;
+		return;
+	case LOCK_SYM_SPIN:
+		*prog_groups |= LOCK_PROG_SPIN;
+		*required_groups |= LOCK_PROG_SPIN;
+		return;
+	case LOCK_SYM_RWLOCK:
+		if (mode & PBF_LOCK_MODE_READ)
+			groups |= LOCK_PROG_RWLOCK_READ;
+		if (mode & PBF_LOCK_MODE_WRITE)
+			groups |= LOCK_PROG_RWLOCK_WRITE;
+		*prog_groups |= groups;
+		*required_groups |= groups;
+		return;
+	case LOCK_SYM_UNKNOWN:
+	default:
+		*prog_groups |= LOCK_PROG_ALL;
+		return;
+	}
 }
 
 /*
@@ -465,18 +891,25 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
  * the caller to free.
  */
 static void prescan_lock_filters(struct evsel *evsel, struct btf **btf,
-				 bool *has_lock_filter)
+				 bool *has_lock_filter,
+				 unsigned int *prog_groups,
+				 unsigned int *required_groups)
 {
 	struct perf_bpf_filter_expr *expr, *group;
 
 	*btf = NULL;
 	*has_lock_filter = false;
+	*prog_groups = 0;
+	*required_groups = 0;
 
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
-		prescan_one_lock_expr(expr, btf, has_lock_filter);
+		prescan_one_lock_expr(expr, btf, has_lock_filter, prog_groups,
+				      required_groups);
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
-			list_for_each_entry(group, &expr->groups, list)
-				prescan_one_lock_expr(group, btf, has_lock_filter);
+			list_for_each_entry(group, &expr->groups, list) {
+				prescan_one_lock_expr(group, btf, has_lock_filter,
+						      prog_groups, required_groups);
+			}
 		}
 	}
 }
@@ -546,14 +979,27 @@ static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
 	return -EINVAL;
 }
 
-static int resolve_lock_expr(struct btf *btf, struct perf_bpf_filter_expr *expr,
+/*
+ * Resolve a `lock_held(<name>)` filter expression into `entry->op`,
+ * `entry->part` (`enum perf_bpf_lock_target_kind`), and `entry->value`,
+ * and populate the corresponding BPF filter maps and BSS control flags.
+ *
+ * Resolution order:
+ * 1. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
+ *    `rwlock`, `percpu-rwsem`, `semaphore`, etc.
+ * 2. Hexadecimal lock address.
+ * 3. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
+ */
+static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
+			     struct perf_bpf_filter_expr *expr,
 			     struct perf_bpf_filter_entry *entry)
 {
 	const char *name = expr->lock_name;
 	char base[128];
 	bool has_amp;
 	unsigned int mode;
-	u64 addr = 0;
+	u64 addr = 0, encoded_pair = 0;
+	u8 one = 1;
 	int ret;
 
 	ret = normalize_lock_expr_op(expr, &entry->op);
@@ -566,33 +1012,90 @@ static int resolve_lock_expr(struct btf *btf, struct perf_bpf_filter_expr *expr,
 		return -EINVAL;
 	}
 
+	if (parse_lock_type_name(base, mode, skel, &encoded_pair, NULL)) {
+		entry->part = PBF_LOCK_TYPE | mode;
+		entry->value = encoded_pair;
+		return 0;
+	}
+
+	if (parse_lock_type_name(base, PBF_LOCK_MODE_ANY, NULL, NULL, NULL)) {
+		pr_err("Error: Lock type '%s' does not support the requested read/write mode\n",
+		       name);
+		return -EINVAL;
+	}
+
+	if (parse_lock_hex_addr(base, &addr)) {
+		entry->part = PBF_LOCK_ADDR | mode;
+		entry->value = addr;
+		if (skel) {
+			int fd = bpf_map__fd(skel->maps.lock_addr_filter);
+
+			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+			skel->bss->has_lock_addr = 1;
+		}
+		return 0;
+	}
+
 	if (btf_has_func(btf, base)) {
 		pr_err("Error: '%s' is a kernel function, not a lock\n", name);
 		return -EINVAL;
 	}
 
-	if (classify_lock_sym(btf, base) == LOCK_SYM_MUTEX) {
-		ret = find_kernel_lock_sym(base, &addr);
-		if (ret == 0) {
-			if (!(mode & PBF_LOCK_MODE_WRITE)) {
-				pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
-				       name);
-				return -EINVAL;
-			}
-			entry->part = PBF_LOCK_ADDR | mode | PBF_LOCK_DIRECT_MUTEX;
-			entry->value = addr;
-			return 0;
+	ret = find_kernel_lock_sym(base, &addr);
+	if (ret == 0) {
+		unsigned int direct_flag = 0;
+		bool exclusive = false;
+
+		switch (classify_lock_sym(btf, base)) {
+		case LOCK_SYM_RTMUTEX:
+			direct_flag = PBF_LOCK_DIRECT_RTMUTEX;
+			exclusive = true;
+			break;
+		case LOCK_SYM_MUTEX:
+			direct_flag = PBF_LOCK_DIRECT_MUTEX;
+			exclusive = true;
+			break;
+		case LOCK_SYM_RWSEM:
+			direct_flag = PBF_LOCK_DIRECT_RWSEM;
+			break;
+		case LOCK_SYM_PERCPU_RWSEM:
+		case LOCK_SYM_SEM:
+		case LOCK_SYM_SPIN:
+			exclusive = true;
+			break;
+		case LOCK_SYM_SEM_OR_RWSEM:
+		case LOCK_SYM_RWLOCK:
+		case LOCK_SYM_UNKNOWN:
+		default:
+			break;
+		}
+
+		if (exclusive && !(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
 		}
-		if (ret == -EACCES)
-			return ret;
+
+		entry->part = PBF_LOCK_ADDR | mode | direct_flag;
+		entry->value = addr;
+		if (skel && direct_flag != PBF_LOCK_DIRECT_MUTEX &&
+		    direct_flag != PBF_LOCK_DIRECT_RTMUTEX) {
+			int fd = bpf_map__fd(skel->maps.lock_addr_filter);
+
+			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+			skel->bss->has_lock_addr = 1;
+		}
+		return 0;
 	}
+	if (ret == -EACCES)
+		return ret;
 
 	pr_err("Error: Cannot resolve kernel lock '%s'\n", name);
 	return -EINVAL;
 }
 
-static int get_filter_entries(struct evsel *evsel, struct btf *btf,
-			      struct perf_bpf_filter_entry *entry)
+static int get_filter_entries(struct evsel *evsel, struct sample_filter_bpf *skel,
+			      struct btf *btf, struct perf_bpf_filter_entry *entry)
 {
 	int i = 0, ret;
 	struct perf_bpf_filter_expr *expr;
@@ -609,7 +1112,7 @@ static int get_filter_entries(struct evsel *evsel, struct btf *btf,
 		entry[i].term = expr->term;
 		entry[i].value = expr->val;
 		if (expr->term == PBF_TERM_LOCK_HELD) {
-			ret = resolve_lock_expr(btf, expr, &entry[i]);
+			ret = resolve_lock_expr(skel, btf, expr, &entry[i]);
 			if (ret < 0)
 				return ret;
 		}
@@ -627,7 +1130,7 @@ static int get_filter_entries(struct evsel *evsel, struct btf *btf,
 				entry[i].term = group->term;
 				entry[i].value = group->val;
 				if (group->term == PBF_TERM_LOCK_HELD) {
-					ret = resolve_lock_expr(btf, group, &entry[i]);
+					ret = resolve_lock_expr(skel, btf, group, &entry[i]);
 					if (ret < 0)
 						return ret;
 				}
@@ -875,12 +1378,14 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	bool needs_idx_hash = !target__has_cpu(target);
 	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
 	bool has_lock_filter = false;
+	unsigned int prog_groups = 0, required_groups = 0;
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
 		return -1;
 
-	prescan_lock_filters(evsel, &btf, &has_lock_filter);
+	prescan_lock_filters(evsel, &btf, &has_lock_filter, &prog_groups,
+			     &required_groups);
 
 	if ((has_lock_filter || is_tracepoint) && geteuid() != 0 &&
 	    !perf_cap__capable(CAP_BPF)) {
@@ -889,15 +1394,14 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	ret = get_filter_entries(evsel, btf, entry);
-	if (ret < 0) {
-		pr_err("Failed to process filter entries\n");
-		goto err;
-	}
-
 	if (needs_idx_hash && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
 		int zero = 0;
 
+		ret = get_filter_entries(evsel, NULL, NULL, entry);
+		if (ret < 0) {
+			pr_err("Failed to process filter entries\n");
+			goto err;
+		}
 		/* The filters map is shared among other processes */
 		ret = create_idx_hash(evsel, entry);
 		if (ret < 0)
@@ -931,7 +1435,6 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		}
 
 		close(fd);
-		btf__free(btf);
 		free(entry);
 		return 0;
 	}
@@ -943,8 +1446,16 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
-	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
+	if (has_lock_filter) {
+		bpf_map__set_max_entries(skel->maps.held_locks, MAX_ENTRIES);
+		bpf_map__set_max_entries(skel->maps.lock_addr_filter, MAX_FILTERS);
+		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
+					   is_tracepoint);
+		if (ret < 0)
+			goto err;
+	} else {
+		configure_lock_progs(skel, NULL, 0, 0, is_tracepoint);
+	}
 
 	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
@@ -952,8 +1463,23 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	if (has_lock_filter)
+	ret = get_filter_entries(evsel, skel, btf, entry);
+	if (ret < 0) {
+		pr_err("Failed to process filter entries\n");
+		goto err;
+	}
+
+	if (has_lock_filter) {
+		bpf_program__set_autoattach(skel->progs.perf_sample_filter, false);
+		bpf_program__set_autoattach(skel->progs.perf_tp_sample_filter, false);
+
+		ret = sample_filter_bpf__attach(skel);
+		if (ret < 0) {
+			pr_err("Failed to attach lock sample-filter BPF programs\n");
+			goto err;
+		}
 		skel->bss->lock_enabled = 1;
+	}
 
 	i = 0;
 	fd = bpf_map__fd(skel->maps.filters);
@@ -1228,8 +1754,9 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
+	configure_lock_progs(skel, NULL, 0, 0, false);
+
 	/* pinned program will use pid-hash */
-	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
 	bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
@@ -1324,7 +1851,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
+	configure_lock_progs(skel, NULL, 0, 0, false);
 	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index ca1cf586ed6e..c240eee782f8 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -59,7 +59,8 @@ enum perf_bpf_filter_term {
 	 * The lock specification kind is stored in `entry.part`
 	 * (`enum perf_bpf_lock_target_kind`), `entry.op` is normalized to
 	 * `PBF_OP_EQ` (match when held) or `PBF_OP_NEQ` (match when not held),
-	 * and the resolved target address is stored in `entry.value`.
+	 * and the resolved target address or type flag encoding is stored in
+	 * `entry.value`.
 	 */
 	PBF_TERM_LOCK_HELD,
 };
@@ -71,10 +72,16 @@ enum perf_bpf_filter_term {
 enum perf_bpf_lock_target_kind {
 	PBF_LOCK_NONE = 0,
 	/*
-	 * Specific global or static lock address resolved from kallsyms.
-	 * `entry.value` holds the kernel address.
+	 * Specific global or static lock address (resolved from kallsyms or
+	 * given as a hex address). `entry.value` holds the kernel address.
 	 */
 	PBF_LOCK_ADDR,
+	/*
+	 * Lock type filter (`mutex`, `spinlock`, `rwsem`, `rwsem:R`, etc.).
+	 * `entry.value` packs up to two `LCB_F_*` flag combinations in the
+	 * low two bytes: `flag1 | (flag2 << 8)` (with 0xff indicating unused).
+	 */
+	PBF_LOCK_TYPE,
 };
 
 /*
@@ -83,6 +90,8 @@ enum perf_bpf_lock_target_kind {
  *   Bit  4:    PBF_LOCK_MODE_READ      (match read/shared lock holding)
  *   Bit  5:    PBF_LOCK_MODE_WRITE     (match write/exclusive lock holding)
  *   Bit  6:    PBF_LOCK_DIRECT_MUTEX   (inspect struct mutex owner)
+ *   Bit  7:    PBF_LOCK_DIRECT_RWSEM   (inspect struct rw_semaphore writer owner)
+ *   Bit  8:    PBF_LOCK_DIRECT_RTMUTEX (inspect struct rt_mutex_base / rt_mutex owner)
  */
 #define PBF_LOCK_KIND_MASK	0x0fU
 #define PBF_LOCK_MODE_READ	(1U << 4)
@@ -90,6 +99,8 @@ enum perf_bpf_lock_target_kind {
 #define PBF_LOCK_MODE_ANY	(PBF_LOCK_MODE_READ | PBF_LOCK_MODE_WRITE)
 #define PBF_LOCK_MODE_MASK	PBF_LOCK_MODE_ANY
 #define PBF_LOCK_DIRECT_MUTEX	(1U << 6)
+#define PBF_LOCK_DIRECT_RWSEM	(1U << 7)
+#define PBF_LOCK_DIRECT_RTMUTEX	(1U << 8)
 
 /* BPF map entry for filtering */
 struct perf_bpf_filter_entry {
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 42556ab0e2d5..e527fbaf8a46 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -8,6 +8,44 @@
 #include "lock_data.h"
 #include "sample-filter.h"
 
+/*
+ * Key for the `held_locks` BPF hash map tracking currently held kernel locks.
+ *
+ * - `addr_or_id`:
+ *     - PBF_LOCK_ADDR:  kernel virtual address of the lock instance
+ *     - PBF_LOCK_CLASS: `enum lock_class_sym` (LOCK_CLASS_RQLOCK / LOCK_CLASS_ZONE_LOCK)
+ *     - PBF_LOCK_SLAB:  kernel `struct kmem_cache *` address
+ *     - PBF_LOCK_TYPE:  `LCB_F_*` lock type flags
+ * - `owner_id`:
+ *     - For sleeping locks: kernel task TID (`(__u32)bpf_get_current_pid_tgid()`),
+ *       since the holder may sleep and migrate across CPUs while holding the lock.
+ *     - For spinning locks (`LCB_F_SPIN` without `LCB_F_MUTEX`) or idle tasks
+ *       (`pid == 0`): `0x80000000U | bpf_get_smp_processor_id()`, since preemption
+ *       is disabled on the holding CPU and spinlocks such as `rq_lock` may be
+ *       acquired by one task and released by the next task across `context_switch()`.
+ * - `kind`: `enum perf_bpf_lock_target_kind`.
+ */
+struct held_lock_key {
+	__u64 addr_or_id;
+	__u32 owner_id;
+	__u32 kind;
+};
+
+/*
+ * Value for `held_locks` entries.
+ * `read_count` and `write_count` separately track shared/read (`LCB_F_READ`)
+ * and exclusive/write acquisitions (including nested class/slab/type
+ * acquisitions by the same owner). `flags` stores the `LCB_F_*` type flags of
+ * the lock so release tracepoints that do not carry flags (such as
+ * `lock:contended_release`) can decrement matching class/slab/type entries.
+ */
+struct held_lock_val {
+	__u32 read_count;
+	__u32 write_count;
+	__u32 flags;
+	__u32 pad;
+};
+
 /* BPF map that will be filled by user space */
 struct filters {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -44,13 +82,65 @@ struct lost_count {
 	__uint(max_entries, 1);
 } dropped SEC(".maps");
 
+/*
+ * Currently held kernel locks tracked by fentry/fexit hooks.
+ * Uses BPF_MAP_TYPE_LRU_HASH so that if a counting semaphore (down/up) or
+ * non-owner rwsem is acquired in one task and released in another task or
+ * interrupt handler (cross-context signaling), any orphaned entry is
+ * automatically evicted rather than exhausting the map.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__type(key, struct held_lock_key);
+	__type(value, struct held_lock_val);
+	__uint(max_entries, 1);
+} held_locks SEC(".maps");
+
+/* Target lock addresses for PBF_LOCK_ADDR filters. */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u64);
+	__type(value, __u8);
+	__uint(max_entries, 1);
+} lock_addr_filter SEC(".maps");
+
 volatile const int use_idx_hash;
 
-/* Control flag set by userspace when lock_held(...) filters are active. */
+/* Control flags set by userspace when lock_held(...) filters are active. */
 int lock_enabled;
+int has_lock_addr;
+int has_lock_type;
+int track_rwsem_read;
+__u8 lock_type_filter[LCB_F_TYPE_MAX];
 
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
+/*
+ * Direct lock owner inspection helper using `get_lock_owner()` from `lock_data.h`.
+ *
+ * For locks that maintain a task_struct pointer in their `owner` field
+ * (`struct mutex`, write-locked `struct rw_semaphore`, and `struct rt_mutex`),
+ * `perf_sample_filter` can inspect the lock structure directly in kernel memory
+ * and compare the owner against `current` (`bpf_get_current_task()`).
+ *
+ * Note that for reader-locked `rw_semaphore`s, `__up_read()` does not clear
+ * `sem->owner` when `CONFIG_DEBUG_RWSEMS` is disabled, so reader locks and
+ * spinlocks are checked via the `held_locks` BPF map instead.
+ */
+static __always_inline bool is_rwsem_writer_owner(__u64 lock_addr, __u64 curr)
+{
+	struct rw_semaphore___new *rwsem = (void *)lock_addr;
+
+	if (bpf_core_field_exists(rwsem->count.counter) &&
+	    !(BPF_CORE_READ(rwsem, count.counter) & 1UL))
+		return false;
+	if (bpf_core_field_exists(rwsem->owner.counter) &&
+	    (BPF_CORE_READ(rwsem, owner.counter) & 1UL))
+		return false;
+
+	return (__u64)get_lock_owner(lock_addr, LCB_F_WRITE) == curr;
+}
+
 static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 curr, __u32 part)
 {
 	if (!curr)
@@ -59,24 +149,85 @@ static __always_inline bool is_direct_lock_owner(__u64 lock_addr, __u64 curr, __
 	if ((part & PBF_LOCK_DIRECT_MUTEX) &&
 	    (__u64)get_lock_owner(lock_addr, LCB_F_MUTEX) == curr)
 		return true;
+	if ((part & PBF_LOCK_DIRECT_RWSEM) &&
+	    is_rwsem_writer_owner(lock_addr, curr))
+		return true;
+	if ((part & PBF_LOCK_DIRECT_RTMUTEX) &&
+	    (__u64)get_lock_owner(lock_addr, LCB_F_RT) == curr)
+		return true;
 	return false;
 }
 
+static __always_inline bool match_held_val(struct held_lock_val *val, __u32 mode)
+{
+	if (!val)
+		return false;
+	if ((mode & PBF_LOCK_MODE_READ) && val->read_count > 0)
+		return true;
+	if ((mode & PBF_LOCK_MODE_WRITE) && val->write_count > 0)
+		return true;
+	return false;
+}
+
+static __always_inline __u64 is_lock_in_map(__u64 addr_or_id, __u32 kind,
+					    __u32 mode, __u32 pid, __u32 cpu_id)
+{
+	struct held_lock_key key = {
+		.addr_or_id = addr_or_id,
+		.owner_id = pid,
+		.kind = kind,
+	};
+	struct held_lock_val *val;
+
+	if (pid) {
+		val = bpf_map_lookup_elem(&held_locks, &key);
+		if (match_held_val(val, mode))
+			return 1;
+	}
+
+	key.owner_id = cpu_id;
+	val = bpf_map_lookup_elem(&held_locks, &key);
+	if (match_held_val(val, mode))
+		return 1;
+
+	return 0;
+}
+
+static __always_inline __u64 is_lock_type_in_map(__u64 target, __u32 mode,
+						 __u32 pid, __u32 cpu_id)
+{
+	__u32 flag1 = target & 0xff;
+	__u32 flag2 = (target >> 8) & 0xff;
+
+	if (is_lock_in_map(flag1, PBF_LOCK_TYPE, mode, pid, cpu_id))
+		return 1;
+	if (flag2 != 0xff && is_lock_in_map(flag2, PBF_LOCK_TYPE, mode, pid, cpu_id))
+		return 1;
+	return 0;
+}
+
 static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
 {
 	__u64 curr = bpf_get_current_task();
+	__u32 pid = (__u32)bpf_get_current_pid_tgid();
+	__u32 cpu_id = 0x80000000U | bpf_get_smp_processor_id();
 	__u32 kind = entry->part & PBF_LOCK_KIND_MASK;
 	__u32 mode = entry->part & PBF_LOCK_MODE_MASK;
+	__u64 lock_addr;
 
 	if (!mode)
 		mode = PBF_LOCK_MODE_ANY;
 
 	switch (kind) {
 	case PBF_LOCK_ADDR:
+		lock_addr = entry->value;
 		if ((mode & PBF_LOCK_MODE_WRITE) &&
-		    is_direct_lock_owner(entry->value, curr, entry->part))
+		    is_direct_lock_owner(lock_addr, curr, entry->part))
 			return true;
-		return false;
+		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id) != 0;
+
+	case PBF_LOCK_TYPE:
+		return is_lock_type_in_map(entry->value, mode, pid, cpu_id) != 0;
 
 	default:
 		return false;
@@ -444,4 +595,698 @@ int perf_tp_sample_filter(void *ctx)
 	return 0;
 }
 
+static __always_inline __u32 get_lock_owner_id(__u32 flags)
+{
+	__u32 owner_id;
+
+	if ((flags & (LCB_F_SPIN | LCB_F_MUTEX)) == LCB_F_SPIN)
+		return 0x80000000U | bpf_get_smp_processor_id();
+
+	owner_id = (__u32)bpf_get_current_pid_tgid();
+	if (!owner_id)
+		owner_id = 0x80000000U | bpf_get_smp_processor_id();
+	return owner_id;
+}
+
+static __always_inline void update_held_lock_count(__u64 addr_or_id, __u32 owner_id,
+						   __u32 kind, __u32 flags, bool acquired)
+{
+	struct held_lock_key key = {
+		.addr_or_id = addr_or_id,
+		.owner_id = owner_id,
+		.kind = kind,
+	};
+	struct held_lock_val *val;
+	bool is_read = (flags & LCB_F_READ) != 0;
+
+	val = bpf_map_lookup_elem(&held_locks, &key);
+	if (acquired) {
+		if (val) {
+			if (is_read)
+				__sync_fetch_and_add(&val->read_count, 1);
+			else
+				__sync_fetch_and_add(&val->write_count, 1);
+		} else {
+			struct held_lock_val first = {
+				.read_count = is_read ? 1 : 0,
+				.write_count = is_read ? 0 : 1,
+				.flags = flags,
+			};
+
+			bpf_map_update_elem(&held_locks, &key, &first, BPF_ANY);
+		}
+	} else if (val) {
+		if (is_read) {
+			if (val->read_count <= 1 && val->write_count == 0)
+				bpf_map_delete_elem(&held_locks, &key);
+			else if (val->read_count > 0)
+				__sync_fetch_and_add(&val->read_count, -1);
+		} else {
+			if (val->write_count <= 1 && val->read_count == 0)
+				bpf_map_delete_elem(&held_locks, &key);
+			else if (val->write_count > 0)
+				__sync_fetch_and_add(&val->write_count, -1);
+		}
+	}
+}
+
+#define LCB_F_READ_IRQSAVE	(1U << 30)
+#define LCB_F_READ_IRQ_BH	(1U << 31)
+
+static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 flags, __u32 owner_id)
+{
+	struct held_lock_key addr_key = {
+		.addr_or_id = lock_addr,
+		.owner_id = owner_id,
+		.kind = PBF_LOCK_ADDR,
+	};
+	struct held_lock_val *existing;
+	bool matched = false;
+	bool is_read = (flags & LCB_F_READ) != 0;
+	__u32 type_flag = flags & LCB_F_TYPE_MASK;
+	bool match_type = false;
+
+	if (!lock_enabled || !lock_addr)
+		return 0;
+
+	if (has_lock_addr && bpf_map_lookup_elem(&lock_addr_filter, &lock_addr))
+		matched = true;
+
+	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag]) {
+		match_type = true;
+		matched = true;
+	}
+
+	if (!matched)
+		return 0;
+
+	existing = bpf_map_lookup_elem(&held_locks, &addr_key);
+	if (existing) {
+		/*
+		 * On CONFIG_GENERIC_LOCKBREAK=y && !CONFIG_DEBUG_LOCK_ALLOC
+		 * kernels, _raw_read_lock_irq() and _raw_read_lock_bh() call
+		 * the out-of-line _raw_read_lock_irqsave(). Clear the marker
+		 * and skip the duplicate outer fexit increment.
+		 */
+		if ((flags & LCB_F_READ_IRQ_BH) &&
+		    (existing->flags & LCB_F_READ_IRQSAVE)) {
+			existing->flags &= ~LCB_F_READ_IRQSAVE;
+			return 0;
+		}
+		/* Non-reader locks are not recursive; avoid double-counting */
+		if (!is_read && existing->write_count > 0)
+			return 0;
+		if (is_read) {
+			__sync_fetch_and_add(&existing->read_count, 1);
+			if (flags & LCB_F_READ_IRQSAVE)
+				existing->flags |= LCB_F_READ_IRQSAVE;
+			else
+				existing->flags &= ~LCB_F_READ_IRQSAVE;
+		} else {
+			__sync_fetch_and_add(&existing->write_count, 1);
+		}
+	} else {
+		struct held_lock_val first = {
+			.read_count = is_read ? 1 : 0,
+			.write_count = is_read ? 0 : 1,
+			.flags = flags & (LCB_F_TYPE_MASK | LCB_F_READ_IRQSAVE),
+		};
+
+		if (bpf_map_update_elem(&held_locks, &addr_key, &first, BPF_ANY) < 0)
+			return 0;
+	}
+
+	if (match_type)
+		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, type_flag, true);
+
+	return 0;
+}
+
+static __always_inline int record_lock_acquired(void *ctx, __u32 flags)
+{
+	return record_lock_acquired_owner(get_lock_addr(ctx), flags, get_lock_owner_id(flags));
+}
+
+static __always_inline int record_lock_released_addr(__u64 lock_addr, __u32 flags)
+{
+	__u32 owner_id = get_lock_owner_id(flags);
+	struct held_lock_key addr_key = {
+		.addr_or_id = lock_addr,
+		.owner_id = owner_id,
+		.kind = PBF_LOCK_ADDR,
+	};
+	struct held_lock_val *existing;
+	__u32 type_flag = flags & LCB_F_TYPE_MASK;
+	bool is_read = (flags & LCB_F_READ) != 0;
+
+	if (!lock_enabled || !lock_addr)
+		return 0;
+
+	existing = bpf_map_lookup_elem(&held_locks, &addr_key);
+	if (!existing)
+		return 0;
+
+	if (is_read) {
+		if (existing->read_count == 0)
+			return 0;
+		if (existing->read_count == 1 && existing->write_count == 0) {
+			bpf_map_delete_elem(&held_locks, &addr_key);
+		} else {
+			existing->flags &= ~LCB_F_READ_IRQSAVE;
+			__sync_fetch_and_add(&existing->read_count, -1);
+		}
+	} else {
+		if (existing->write_count == 0)
+			return 0;
+		if (existing->read_count == 0)
+			bpf_map_delete_elem(&held_locks, &addr_key);
+		else
+			existing->write_count = 0;
+	}
+
+	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag])
+		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, flags, false);
+
+	return 0;
+}
+
+static __always_inline int record_lock_released(void *ctx, __u32 flags)
+{
+	return record_lock_released_addr(get_lock_addr(ctx), flags);
+}
+
+/* Mutex acquire/release hooks */
+SEC("fexit/mutex_lock")
+int BPF_PROG(fexit_mutex_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_nested")
+int BPF_PROG(fexit_mutex_lock_nested, void *lock, unsigned int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/_mutex_lock_nest_lock")
+int BPF_PROG(fexit__mutex_lock_nest_lock, void *lock, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_io")
+int BPF_PROG(fexit_mutex_lock_io, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_io_nested")
+int BPF_PROG(fexit_mutex_lock_io_nested, void *lock, unsigned int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_MUTEX);
+}
+
+SEC("fexit/mutex_lock_interruptible")
+int BPF_PROG(fexit_mutex_lock_interruptible, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/mutex_lock_interruptible_nested")
+int BPF_PROG(fexit_mutex_lock_interruptible_nested, void *lock, unsigned int subclass, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/mutex_lock_killable")
+int BPF_PROG(fexit_mutex_lock_killable, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/_mutex_lock_killable")
+int BPF_PROG(fexit__mutex_lock_killable, void *lock, unsigned int subclass,
+	     void *nest_lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/mutex_trylock")
+int BPF_PROG(fexit_mutex_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fexit/_mutex_trylock_nest_lock")
+int BPF_PROG(fexit__mutex_trylock_nest_lock, void *lock, void *nest_lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_MUTEX);
+	return 0;
+}
+
+SEC("fentry/mutex_unlock")
+int BPF_PROG(fentry_mutex_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_MUTEX);
+}
+
+/* RW semaphore acquire/release hooks */
+SEC("fexit/down_read")
+int BPF_PROG(fexit_down_read, void *sem)
+{
+	return record_lock_acquired(ctx, LCB_F_READ);
+}
+
+SEC("fexit/down_read_nested")
+int BPF_PROG(fexit_down_read_nested, void *sem, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_READ);
+}
+
+SEC("fexit/down_read_interruptible")
+int BPF_PROG(fexit_down_read_interruptible, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_read_killable")
+int BPF_PROG(fexit_down_read_killable, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_read_killable_nested")
+int BPF_PROG(fexit_down_read_killable_nested, void *sem, int subclass, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_read_trylock")
+int BPF_PROG(fexit_down_read_trylock, void *sem, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return 0;
+}
+
+SEC("fexit/down_write")
+int BPF_PROG(fexit_down_write, void *sem)
+{
+	return record_lock_acquired(ctx, LCB_F_WRITE);
+}
+
+SEC("fexit/down_write_nested")
+int BPF_PROG(fexit_down_write_nested, void *sem, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_WRITE);
+}
+
+SEC("fexit/_down_write_nest_lock")
+int BPF_PROG(fexit__down_write_nest_lock, void *sem, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_WRITE);
+}
+
+SEC("fexit/down_write_killable")
+int BPF_PROG(fexit_down_write_killable, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fexit/down_write_killable_nested")
+int BPF_PROG(fexit_down_write_killable_nested, void *sem, int subclass, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fexit/down_write_trylock")
+int BPF_PROG(fexit_down_write_trylock, void *sem, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fexit/downgrade_write")
+int BPF_PROG(fexit_downgrade_write, void *sem)
+{
+	if (track_rwsem_read)
+		record_lock_acquired(ctx, LCB_F_READ);
+	return record_lock_released(ctx, LCB_F_WRITE);
+}
+
+SEC("fentry/up_read")
+int BPF_PROG(fentry_up_read, void *sem)
+{
+	return record_lock_released(ctx, LCB_F_READ);
+}
+
+SEC("fentry/up_write")
+int BPF_PROG(fentry_up_write, void *sem)
+{
+	return record_lock_released(ctx, LCB_F_WRITE);
+}
+
+/* Spinlock acquire/release hooks */
+SEC("fexit/_raw_spin_lock")
+int BPF_PROG(fexit_raw_spin_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_nested")
+int BPF_PROG(fexit_raw_spin_lock_nested, void *lock, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_nest_lock")
+int BPF_PROG(fexit_raw_spin_lock_nest_lock, void *lock, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irq")
+int BPF_PROG(fexit_raw_spin_lock_irq, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irq_disable")
+int BPF_PROG(fexit_raw_spin_lock_irq_disable, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irqsave")
+int BPF_PROG(fexit_raw_spin_lock_irqsave, void *lock, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_irqsave_nested")
+int BPF_PROG(fexit_raw_spin_lock_irqsave_nested, void *lock, int subclass, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_lock_bh")
+int BPF_PROG(fexit_raw_spin_lock_bh, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN);
+}
+
+SEC("fexit/_raw_spin_trylock")
+int BPF_PROG(fexit_raw_spin_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN);
+	return 0;
+}
+
+SEC("fexit/_raw_spin_trylock_bh")
+int BPF_PROG(fexit_raw_spin_trylock_bh, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN);
+	return 0;
+}
+
+SEC("fentry/_raw_spin_unlock")
+int BPF_PROG(fentry_raw_spin_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_irq")
+int BPF_PROG(fentry_raw_spin_unlock_irq, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_irq_enable")
+int BPF_PROG(fentry_raw_spin_unlock_irq_enable, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(fentry_raw_spin_unlock_irqrestore, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+SEC("fentry/_raw_spin_unlock_bh")
+int BPF_PROG(fentry_raw_spin_unlock_bh, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN);
+}
+
+/* RWlock acquire/release hooks */
+SEC("fexit/_raw_read_lock")
+int BPF_PROG(fexit_raw_read_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fexit/_raw_read_lock_irq")
+int BPF_PROG(fexit_raw_read_lock_irq, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ | LCB_F_READ_IRQ_BH);
+}
+
+SEC("fexit/_raw_read_lock_irqsave")
+int BPF_PROG(fexit_raw_read_lock_irqsave, void *lock, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ | LCB_F_READ_IRQSAVE);
+}
+
+SEC("fexit/_raw_read_lock_bh")
+int BPF_PROG(fexit_raw_read_lock_bh, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ | LCB_F_READ_IRQ_BH);
+}
+
+SEC("fexit/_raw_read_trylock")
+int BPF_PROG(fexit_raw_read_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_READ);
+	return 0;
+}
+
+SEC("fentry/_raw_read_unlock")
+int BPF_PROG(fentry_raw_read_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fentry/_raw_read_unlock_irq")
+int BPF_PROG(fentry_raw_read_unlock_irq, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fentry/_raw_read_unlock_irqrestore")
+int BPF_PROG(fentry_raw_read_unlock_irqrestore, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fentry/_raw_read_unlock_bh")
+int BPF_PROG(fentry_raw_read_unlock_bh, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_READ);
+}
+
+SEC("fexit/_raw_write_lock")
+int BPF_PROG(fexit_raw_write_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_nested")
+int BPF_PROG(fexit_raw_write_lock_nested, void *lock, int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_irq")
+int BPF_PROG(fexit_raw_write_lock_irq, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_irqsave")
+int BPF_PROG(fexit_raw_write_lock_irqsave, void *lock, unsigned long flags)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_lock_bh")
+int BPF_PROG(fexit_raw_write_lock_bh, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fexit/_raw_write_trylock")
+int BPF_PROG(fexit_raw_write_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_SPIN | LCB_F_WRITE);
+	return 0;
+}
+
+SEC("fentry/_raw_write_unlock")
+int BPF_PROG(fentry_raw_write_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fentry/_raw_write_unlock_irq")
+int BPF_PROG(fentry_raw_write_unlock_irq, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fentry/_raw_write_unlock_irqrestore")
+int BPF_PROG(fentry_raw_write_unlock_irqrestore, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+SEC("fentry/_raw_write_unlock_bh")
+int BPF_PROG(fentry_raw_write_unlock_bh, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_SPIN | LCB_F_WRITE);
+}
+
+/* RT-Mutex acquire/release hooks */
+SEC("fexit/rt_mutex_lock")
+int BPF_PROG(fexit_rt_mutex_lock, void *lock)
+{
+	return record_lock_acquired(ctx, LCB_F_RT);
+}
+
+SEC("fexit/rt_mutex_lock_nested")
+int BPF_PROG(fexit_rt_mutex_lock_nested, void *lock, unsigned int subclass)
+{
+	return record_lock_acquired(ctx, LCB_F_RT);
+}
+
+SEC("fexit/_rt_mutex_lock_nest_lock")
+int BPF_PROG(fexit__rt_mutex_lock_nest_lock, void *lock, void *nest_lock)
+{
+	return record_lock_acquired(ctx, LCB_F_RT);
+}
+
+SEC("fexit/rt_mutex_lock_interruptible")
+int BPF_PROG(fexit_rt_mutex_lock_interruptible, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_RT);
+	return 0;
+}
+
+SEC("fexit/rt_mutex_lock_killable")
+int BPF_PROG(fexit_rt_mutex_lock_killable, void *lock, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, LCB_F_RT);
+	return 0;
+}
+
+SEC("fexit/rt_mutex_trylock")
+int BPF_PROG(fexit_rt_mutex_trylock, void *lock, int ret)
+{
+	if (ret)
+		record_lock_acquired(ctx, LCB_F_RT);
+	return 0;
+}
+
+SEC("fentry/rt_mutex_unlock")
+int BPF_PROG(fentry_rt_mutex_unlock, void *lock)
+{
+	return record_lock_released(ctx, LCB_F_RT);
+}
+
+/* Semaphore acquire/release hooks */
+SEC("fexit/down")
+int BPF_PROG(fexit_down, void *sem)
+{
+	return record_lock_acquired(ctx, 0);
+}
+
+SEC("fexit/down_interruptible")
+int BPF_PROG(fexit_down_interruptible, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fexit/down_killable")
+int BPF_PROG(fexit_down_killable, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fexit/down_timeout")
+int BPF_PROG(fexit_down_timeout, void *sem, long timeout, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fexit/down_trylock")
+int BPF_PROG(fexit_down_trylock, void *sem, int ret)
+{
+	if (ret == 0)
+		record_lock_acquired(ctx, 0);
+	return 0;
+}
+
+SEC("fentry/up")
+int BPF_PROG(fentry_up, void *sem)
+{
+	return record_lock_released(ctx, 0);
+}
+
+/* Percpu-rwsem write acquire/release hooks */
+SEC("fexit/percpu_down_write")
+int BPF_PROG(fexit_percpu_down_write, void *sem)
+{
+	return record_lock_acquired(ctx, LCB_F_PERCPU | LCB_F_WRITE);
+}
+
+SEC("fentry/percpu_up_write")
+int BPF_PROG(fentry_percpu_up_write, void *sem)
+{
+	return record_lock_released(ctx, LCB_F_PERCPU | LCB_F_WRITE);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.56.0.307.g5fe7bd680c-goog

