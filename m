Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447772;
	b=jYVutf6zjW9W2m6d0aB+sIWprCEJAhRxKNlzQFJoghgSPIyP6i4Fy1AyZkAM+LFqrQAf
	 HP39trixEP4PInHQQhx8W20at4/Gw40OinzNUtNXWnLSny6wW3a0zNzX4/z3mJUhwwkWf
	 cE6SP40UdGualGRmoubrEr8X0ieFY/TEi017dolXp+ih8iJDO/UPMPELjWl8Wt9yjJZ2X
	 PK6IylIXmzhLnjhl2qHezw8yDJn69cuzBTgTZLmcH8yADAGtv3PL8YS8hfw0+eh9G6B+E
	 yVybHuIJjjomh0l/H6hMK7qePgkIBmjUDGtjBizUC773Kv1j+DuAPyIsuXkCKiV/M6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QxIBALQ+rNUcj70CHm6vdqdjPTIgMlgdKvuV3H2Il2o=;
	b=SZfB14vcYY0FEMRzqYdHy7yvk850EhD4YJ5wNK7zxe47l28jarNLuXf4D03jYMJ8vQlM
	 X2V14GL6YXmmGyGBv8O7Tp0pYAFDO7xuwwbdkA0jjiLwwe6GlTkWNvW13a8T7uesyamz9
	 Hg4Xz3A6A7ktByoLaD5zRJPVXW8hzRvHiUDy3bcYZBfTa/0mZs/t3R2aehGMSkHum3Rkd
	 w7W5PnMqDpFHPt1TYK2Bd2BQTFsm/FBH+/kukwZbYu73lA3e2iFFmhYbdbPLGf8f8wkwR
	 OJcN3X7IWDQDQ2baUuJD7qKZ+067kj5Jx8mlwI6eu+TYln00mf4ehQbaP417Q5/C8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EU3NQ4sF;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26960A2609
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 22:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD26960A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EU3NQ4sF
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1665200f4c2so3661392c88.0
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792447770; x=1793052570; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxIBALQ+rNUcj70CHm6vdqdjPTIgMlgdKvuV3H2Il2o=;
        b=EU3NQ4sFsNkJR5K131pA2kk0rvLHFB2pX4vjbntfseJlc1A3HTz52RKVPrV+7tnrP6
         yVrMm/HUqo5EexLWNPbzpnq06ZyuoGpem84rk2nnPk8k7HFI+mv7IE5KTTxZunJrvm9L
         ab7xA/U+TUHQTXFcBRYQ11hkzJlFn87SbbF6sST6JkhtqmybzEbiqzOUOQzyCUFgqMW0
         xAqeD8yYGvJZiMgQ9uikADC2TrPV+82Br4Pb1U6Z5Box6YEval9bs/Rm4DqeSct4kv3r
         rAgMLyZTu1kJ142pM9OP4ABKxa+Wss/wKa5mutAWTwTjzDOugHRKV6Y9lNVtbIUdIu1r
         bB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447770; x=1793052570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxIBALQ+rNUcj70CHm6vdqdjPTIgMlgdKvuV3H2Il2o=;
        b=dURd8f2H3QH82+4zkA7/xzLI+QhXGaH+X0/lD8PR6H02Aeb16xIzQnFNyUFsNyEMac
         Gv8Ixp0v/SqAvkzBdW7ubmVo9KzH3rg6pbBfCtswutB3mwWpB+FinMVcb0av/u71KQQ0
         I2fFnM4mKngFHOW1kj1HINPZOWM+8Ky6qayxNAVbzoKBtOpTfMLVrgOZSsJlseohzDVK
         ubphZAzxPs1VIPX1vlt92+11eRQb0y2CorQCEgi/wK6CLsH61GVzGfGNNkTI8vkMfAxw
         oDNqScTjPYI4mUll7F50cfNRoomjxnKcYvaIGK9XxcNF2P59c3FpquImbjKOsNnYVUrw
         EeoQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+UrrofGjaiHfJYwfJvNMWylrwt3pcdK9syAKlpxTcsz7QljElcWIYmNHkfOV0ap2IbyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKin+VDy6yypI74lc3hgFNkREps+SNJxU/br+YjLoJCOOX5OSTd
	rVZApjvwK1ypjKLB8uBgLsZERXbuEsAQaSsp667chePBt03ibffUqyrTilYbCvk4qDwDTni1aYy
	f5iTyl46zNg==
X-Received: from dybb25.prod.google.com ([2002:a05:693c:6099:b0:35b:a6b8:4806])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b043:10b0:144:c128:4c4d
 with SMTP id a92af1059eb24-185139aa945mr12935475c88.38.1792447769437; Mon, 19
 Oct 2026 15:09:29 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:09:11 -0700
In-Reply-To: <20261019220915.3943592-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018053710.2572636-1-irogers@google.com> <20261019220915.3943592-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019220915.3943592-4-irogers@google.com>
Subject: [PATCH v4 3/7] perf lock contention: Share common BPF and lock type
 definitions in lock_data.h
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, eranian@google.com, 
	ddhariwal@google.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
(get_lock_owner, get_current_mmap_lock, get_current_siglock,
get_lock_addr, check_lock_type, do_collect_zone_lock,
do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
tools/perf/util/bpf_skel/lock_data.h so they can be reused by BPF
sample filtering.

Also add rw_semaphore.count and struct rt_mutex_base to the minimal
vmlinux.h and extend get_lock_owner() to support rt_mutex and check
the mutex handoff flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c                     |  27 --
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 265 +--------------
 tools/perf/util/bpf_skel/lock_data.h          | 320 ++++++++++++++++++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   5 +
 tools/perf/util/lock-contention.c             |  18 +
 tools/perf/util/lock-contention.h             |  13 +
 6 files changed, 374 insertions(+), 274 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 778923c92f42..a031709a2cc2 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1482,33 +1482,6 @@ static void sort_result(void)
 	}
 }
 
-static const struct {
-	unsigned int flags;
-	/*
-	 * Name of the lock flags (access), with delimeter ':'.
-	 * For example, rwsem:R of rwsem:W.
-	 */
-	const char *flags_name;
-	/* Name of the lock (type), for example, rwlock or rwsem. */
-	const char *lock_name;
-} lock_type_table[] = {
-	{ 0,				"semaphore",	"semaphore" },
-	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
-	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock" },
-	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
-	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
-	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
-	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
-	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
-	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
-	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
-	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
-	{ LCB_F_MUTEX,			"mutex",	"mutex" },
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for optimistic spinning only */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex:spin",	"mutex-spin" },
-};
-
 static const char *get_type_flags_name(unsigned int flags)
 {
 	flags &= LCB_F_TYPE_MASK;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 0d9c6f55050e..0f2118006005 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -8,23 +8,9 @@
 
 #include "lock_data.h"
 
-/* for collect_lock_syms().  4096 was rejected by the verifier */
-#define MAX_CPUS  1024
-
-/* for collect_zone_lock().  It should be more than the actual zones. */
-#define MAX_ZONES  10
-
 /* for do_lock_delay().  Arbitrarily set to 1 million. */
 #define MAX_LOOP  (1U << 20)
 
-/* lock contention flags from include/trace/events/lock.h */
-#define LCB_F_SPIN	(1U << 0)
-#define LCB_F_READ	(1U << 1)
-#define LCB_F_WRITE	(1U << 2)
-#define LCB_F_RT	(1U << 3)
-#define LCB_F_PERCPU	(1U << 4)
-#define LCB_F_MUTEX	(1U << 5)
-
 /* callstack storage  */
 struct {
 	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
@@ -96,13 +82,6 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } task_data SEC(".maps");
 
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(key_size, sizeof(__u64));
-	__uint(value_size, sizeof(__u32));
-	__uint(max_entries, MAX_ENTRIES);
-} lock_syms SEC(".maps");
-
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u32));
@@ -138,6 +117,13 @@ struct {
 	__uint(max_entries, 1);
 } cgroup_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, MAX_ENTRIES);
+} lock_syms SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(long));
@@ -159,22 +145,6 @@ struct {
 	__uint(max_entries, 1);
 } lock_delays SEC(".maps");
 
-struct rw_semaphore___old {
-	struct task_struct *owner;
-} __attribute__((preserve_access_index));
-
-struct rw_semaphore___new {
-	atomic_long_t owner;
-} __attribute__((preserve_access_index));
-
-struct mm_struct___old {
-	struct rw_semaphore mmap_sem;
-} __attribute__((preserve_access_index));
-
-struct mm_struct___new {
-	struct rw_semaphore mmap_lock;
-} __attribute__((preserve_access_index));
-
 struct cas_ctx {
 	struct contention_data *data;
 	u64 duration;
@@ -182,8 +152,6 @@ struct cas_ctx {
 	int min_done;
 };
 
-extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
-
 /* control flags */
 const volatile int has_cpu;
 const volatile int has_task;
@@ -202,6 +170,11 @@ const volatile int lock_delay;
 /* determine the key of lock stat */
 const volatile int aggr_mode;
 
+const volatile __u64 contig_page_data_addr;
+const volatile __u64 node_data_addr;
+const volatile int nr_nodes;
+const volatile int sizeof_zone;
+
 int enabled;
 
 int perf_subsys_id = -1;
@@ -222,8 +195,6 @@ int data_map_full;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
 void bpf_task_release(struct task_struct *p) __ksym __weak;
 
-static inline __u32 check_lock_type(__u64 lock, __u32 flags);
-
 static inline __u64 get_current_cgroup_id(void)
 {
 	struct task_struct *task;
@@ -347,85 +318,6 @@ static inline int update_task_data(struct task_struct *task)
 	return 0;
 }
 
-#ifndef __has_builtin
-# define __has_builtin(x) 0
-#endif
-
-static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
-{
-	struct task_struct *task;
-	__u64 owner = 0;
-
-	if (flags & LCB_F_MUTEX) {
-		struct mutex *mutex = (void *)lock;
-		owner = BPF_CORE_READ(mutex, owner.counter);
-	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
-	/*
-	 * Support for the BPF_TYPE_MATCHES argument to the
-	 * __builtin_preserve_type_info builtin was added at some point during
-	 * development of clang 15 and it's what is needed for
-	 * bpf_core_type_matches.
-	 */
-#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
-		if (bpf_core_type_matches(struct rw_semaphore___old)) {
-			struct rw_semaphore___old *rwsem = (void *)lock;
-			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
-		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
-			struct rw_semaphore___new *rwsem = (void *)lock;
-			owner = BPF_CORE_READ(rwsem, owner.counter);
-		}
-#else
-		/* assume new struct */
-		struct rw_semaphore *rwsem = (void *)lock;
-		owner = BPF_CORE_READ(rwsem, owner.counter);
-#endif
-	}
-
-	if (!owner)
-		return NULL;
-
-	task = (void *)(owner & ~7UL);
-	return task;
-}
-
-static inline __u32 check_lock_type(__u64 lock, __u32 flags)
-{
-	struct task_struct *curr;
-	struct mm_struct___old *mm_old;
-	struct mm_struct___new *mm_new;
-	struct sighand_struct *sighand;
-
-	switch (flags) {
-	case LCB_F_READ:  /* rwsem */
-	case LCB_F_WRITE:
-		curr = bpf_get_current_task_btf();
-		if (curr->mm == NULL)
-			break;
-		mm_new = (void *)curr->mm;
-		if (bpf_core_field_exists(mm_new->mmap_lock)) {
-			if (&mm_new->mmap_lock == (void *)lock)
-				return LCD_F_MMAP_LOCK;
-			break;
-		}
-		mm_old = (void *)curr->mm;
-		if (bpf_core_field_exists(mm_old->mmap_sem)) {
-			if (&mm_old->mmap_sem == (void *)lock)
-				return LCD_F_MMAP_LOCK;
-		}
-		break;
-	case LCB_F_SPIN:  /* spinlock */
-		curr = bpf_get_current_task_btf();
-		sighand = curr->sighand;
-
-		if (sighand && &sighand->siglock == (void *)lock)
-			return LCD_F_SIGHAND_LOCK;
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
 static inline long delay_callback(__u64 idx, void *arg)
 {
 	__u64 target = *(__u64 *)arg;
@@ -908,145 +800,24 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
-extern struct rq runqueues __ksym;
-
-const volatile __u64 contig_page_data_addr;
-const volatile __u64 node_data_addr;
-const volatile int nr_nodes;
-const volatile int sizeof_zone;
-
-struct rq___old {
-	raw_spinlock_t lock;
-} __attribute__((preserve_access_index));
-
-struct rq___new {
-	raw_spinlock_t __lock;
-} __attribute__((preserve_access_index));
-
-static void collect_zone_lock(void)
-{
-	__u64 nr_zones, zone_off;
-	__u64 lock_addr, lock_off;
-	__u32 lock_flag = LOCK_CLASS_ZONE_LOCK;
-
-	zone_off = offsetof(struct pglist_data, node_zones);
-	lock_off = offsetof(struct zone, lock);
-
-	if (contig_page_data_addr) {
-		struct pglist_data *contig_page_data;
-
-		contig_page_data = (void *)(long)contig_page_data_addr;
-		nr_zones = BPF_CORE_READ(contig_page_data, nr_zones);
-
-		for (int i = 0; i < MAX_ZONES; i++) {
-			__u64 zone_addr;
-
-			if (i >= nr_zones)
-				break;
-
-			zone_addr = contig_page_data_addr + (sizeof_zone * i) + zone_off;
-			lock_addr = zone_addr + lock_off;
-
-			bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
-		}
-	} else if (nr_nodes > 0) {
-		struct pglist_data **node_data = (void *)(long)node_data_addr;
-
-		for (int i = 0; i < nr_nodes; i++) {
-			struct pglist_data *pgdat = NULL;
-			int err;
-
-			err = bpf_core_read(&pgdat, sizeof(pgdat), &node_data[i]);
-			if (err < 0 || pgdat == NULL)
-				break;
-
-			nr_zones = BPF_CORE_READ(pgdat, nr_zones);
-			for (int k = 0; k < MAX_ZONES; k++) {
-				__u64 zone_addr;
-
-				if (k >= nr_zones)
-					break;
-
-				zone_addr = (__u64)(void *)pgdat + (sizeof_zone * k) + zone_off;
-				lock_addr = zone_addr + lock_off;
-
-				bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
-			}
-		}
-	}
-}
-
 SEC("raw_tp/bpf_test_finish")
-int BPF_PROG(collect_lock_syms)
+int BPF_PROG(end_timestamp)
 {
-	__u64 lock_addr, lock_off;
-	__u32 lock_flag;
-
-	if (bpf_core_field_exists(struct rq___new, __lock))
-		lock_off = offsetof(struct rq___new, __lock);
-	else
-		lock_off = offsetof(struct rq___old, lock);
-
-	for (int i = 0; i < MAX_CPUS; i++) {
-		struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
-
-		if (rq == NULL)
-			break;
-
-		lock_addr = (__u64)(void *)rq + lock_off;
-		lock_flag = LOCK_CLASS_RQLOCK;
-		bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
-	}
-
-	collect_zone_lock();
-
+	end_ts = bpf_ktime_get_ns();
 	return 0;
 }
 
 SEC("raw_tp/bpf_test_finish")
-int BPF_PROG(end_timestamp)
+int BPF_PROG(collect_lock_syms)
 {
-	end_ts = bpf_ktime_get_ns();
-	return 0;
+	return do_collect_lock_syms(&lock_syms, contig_page_data_addr,
+				    node_data_addr, nr_nodes, sizeof_zone);
 }
 
-/*
- * bpf_iter__kmem_cache added recently so old kernels don't have it in the
- * vmlinux.h.  But we cannot add it here since it will cause a compiler error
- * due to redefinition of the struct on later kernels.
- *
- * So it uses a CO-RE trick to access the member only if it has the type.
- * This will support both old and new kernels without compiler errors.
- */
-struct bpf_iter__kmem_cache___new {
-	struct kmem_cache *s;
-} __attribute__((preserve_access_index));
-
 SEC("iter/kmem_cache")
 int slab_cache_iter(void *ctx)
 {
-	struct kmem_cache *s = NULL;
-	struct slab_cache_data d;
-	const char *nameptr;
-
-	if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
-		struct bpf_iter__kmem_cache___new *iter = ctx;
-
-		s = iter->s;
-	}
-
-	if (s == NULL)
-		return 0;
-
-	nameptr = s->name;
-	bpf_probe_read_kernel_str(d.name, sizeof(d.name), nameptr);
-
-	d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;
-	if (d.id >= LCB_F_SLAB_ID_END)
-		return 0;
-
-	bpf_map_update_elem(&slab_caches, &s, &d, BPF_NOEXIST);
-	return 0;
+	return do_slab_cache_iter(ctx, &slab_caches, &slab_cache_id);
 }
 
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 652e114e6b87..43043d62ea9f 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -45,6 +45,14 @@ struct contention_task_data {
 #define LCB_F_SLAB_ID_END	(1U << 26)
 #define LCB_F_SLAB_ID_MASK	0x03FF0000U
 
+/* lock contention flags from include/trace/events/lock.h */
+#define LCB_F_SPIN	(1U << 0)
+#define LCB_F_READ	(1U << 1)
+#define LCB_F_WRITE	(1U << 2)
+#define LCB_F_RT	(1U << 3)
+#define LCB_F_PERCPU	(1U << 4)
+#define LCB_F_MUTEX	(1U << 5)
+
 #define LCB_F_TYPE_MAX		(1U << 7)
 #define LCB_F_TYPE_MASK		0x0000007FU
 
@@ -76,4 +84,316 @@ struct slab_cache_data {
 	char name[SLAB_NAME_MAX];
 };
 
+#ifdef __BPF__
+
+/* for collect_lock_syms(). 4096 was rejected by the verifier */
+#define MAX_CPUS  1024
+
+/* for collect_zone_lock(). It should be more than the actual zones. */
+#define MAX_ZONES  10
+
+extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
+extern struct rq runqueues __ksym __weak;
+
+#ifndef __has_builtin
+# define __has_builtin(x) 0
+#endif
+
+struct mutex___non_rt {
+	atomic_long_t owner;
+} __attribute__((preserve_access_index));
+
+struct rw_semaphore___old {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
+struct rw_semaphore___new {
+	atomic_long_t count;
+	atomic_long_t owner;
+} __attribute__((preserve_access_index));
+
+struct mm_struct___old {
+	struct rw_semaphore mmap_sem;
+} __attribute__((preserve_access_index));
+
+struct mm_struct___new {
+	struct rw_semaphore mmap_lock;
+} __attribute__((preserve_access_index));
+
+struct rq___old {
+	raw_spinlock_t lock;
+} __attribute__((preserve_access_index));
+
+struct rq___new {
+	raw_spinlock_t __lock;
+} __attribute__((preserve_access_index));
+
+/*
+ * bpf_iter__kmem_cache added recently so old kernels don't have it in the
+ * vmlinux.h.  But we cannot add it here since it will cause a compiler error
+ * due to redefinition of the struct on later kernels.
+ *
+ * So it uses a CO-RE trick to access the member only if it has the type.
+ * This will support both old and new kernels without compiler errors.
+ */
+struct bpf_iter__kmem_cache___new {
+	struct kmem_cache *s;
+} __attribute__((preserve_access_index));
+
+static __always_inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
+{
+	struct task_struct *task;
+	__u64 owner = 0;
+
+	if (flags & LCB_F_MUTEX) {
+		struct mutex___non_rt *mutex = (void *)lock;
+
+		if (bpf_core_field_exists(mutex->owner.counter)) {
+			owner = BPF_CORE_READ(mutex, owner.counter);
+			if (owner & 0x4UL)
+				return NULL;
+		} else if (bpf_core_type_exists(struct rt_mutex_base)) {
+			struct rt_mutex_base *rtm = (void *)lock;
+
+			owner = (__u64)BPF_CORE_READ(rtm, owner);
+			return (void *)(owner & ~1UL);
+		}
+	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
+	/*
+	 * Support for the BPF_TYPE_MATCHES argument to the
+	 * __builtin_preserve_type_info builtin was added at some point during
+	 * development of clang 15 and it's what is needed for
+	 * bpf_core_type_matches.
+	 */
+#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
+		if (bpf_core_type_matches(struct rw_semaphore___old)) {
+			struct rw_semaphore___old *old = (void *)lock;
+
+			owner = (unsigned long)BPF_CORE_READ(old, owner);
+		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
+			struct rw_semaphore___new *new = (void *)lock;
+
+			owner = BPF_CORE_READ(new, owner.counter);
+		}
+#else
+		/* assume new struct */
+		struct rw_semaphore___new *new = (void *)lock;
+
+		if (bpf_core_field_exists(new->owner.counter))
+			owner = BPF_CORE_READ(new, owner.counter);
+#endif
+	} else if (flags == LCB_F_RT) {
+		struct rt_mutex_base *rtm = (void *)lock;
+
+		if (bpf_core_type_exists(struct rt_mutex_base)) {
+			owner = (__u64)BPF_CORE_READ(rtm, owner);
+			return (void *)(owner & ~1UL);
+		}
+	}
+
+	if (!owner)
+		return NULL;
+
+	task = (void *)(owner & ~7UL);
+	return task;
+}
+
+static __always_inline __u64 get_current_mmap_lock(__u64 curr)
+{
+	struct task_struct *task = (void *)curr;
+	struct mm_struct___new *mm_new = NULL;
+	struct mm_struct___old *mm_old = NULL;
+	__u64 mm;
+
+	if (!curr)
+		return 0;
+
+	mm = (__u64)BPF_CORE_READ(task, mm);
+	if (!mm)
+		return 0;
+
+	if (bpf_core_field_exists(mm_new->mmap_lock))
+		return mm + bpf_core_field_offset(mm_new->mmap_lock);
+
+	if (bpf_core_field_exists(mm_old->mmap_sem))
+		return mm + bpf_core_field_offset(mm_old->mmap_sem);
+
+	return 0;
+}
+
+static __always_inline __u64 get_current_siglock(__u64 curr)
+{
+	struct task_struct *task = (void *)curr;
+	struct sighand_struct *sighand = NULL;
+	__u64 sh;
+
+	if (!curr)
+		return 0;
+
+	sh = (__u64)BPF_CORE_READ(task, sighand);
+	if (!sh)
+		return 0;
+
+	return sh + bpf_core_field_offset(sighand->siglock);
+}
+
+/*
+ * Read the 1st function argument (`lock` / `sem` / `ssp`) as a 64-bit scalar.
+ *
+ * Using `bpf_get_func_arg()` rather than reading `ctx[0]` directly ensures the
+ * BPF verifier tracks the address as a `SCALAR_VALUE` instead of a typed
+ * `PTR_TO_BTF_ID`, which is required when passing the address to kfuncs such
+ * as `bpf_get_kmem_cache(u64 addr)`.
+ */
+static __always_inline __u64 get_lock_addr(void *ctx)
+{
+	__u64 lock_addr = 0;
+
+	bpf_get_func_arg(ctx, 0, &lock_addr);
+	return lock_addr;
+}
+
+static __always_inline __u32 check_lock_type(__u64 lock, __u32 flags)
+{
+	__u64 curr;
+
+	switch (flags) {
+	case LCB_F_READ:  /* rwsem */
+	case LCB_F_WRITE:
+		curr = bpf_get_current_task();
+		if (get_current_mmap_lock(curr) == lock)
+			return LCD_F_MMAP_LOCK;
+		break;
+	case LCB_F_SPIN:  /* spinlock */
+		curr = bpf_get_current_task();
+		if (get_current_siglock(curr) == lock)
+			return LCD_F_SIGHAND_LOCK;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static __always_inline void do_collect_zone_lock(void *lock_syms_map,
+						 __u64 contig_page_data_addr,
+						 __u64 node_data_addr,
+						 int nr_nodes,
+						 int sizeof_zone)
+{
+	__u64 nr_zones, zone_off;
+	__u64 lock_addr, lock_off;
+	__u32 lock_flag = LOCK_CLASS_ZONE_LOCK;
+
+	zone_off = offsetof(struct pglist_data, node_zones);
+	lock_off = offsetof(struct zone, lock);
+
+	if (contig_page_data_addr) {
+		struct pglist_data *contig_page_data;
+
+		contig_page_data = (void *)(long)contig_page_data_addr;
+		nr_zones = BPF_CORE_READ(contig_page_data, nr_zones);
+
+		for (int i = 0; i < MAX_ZONES; i++) {
+			__u64 zone_addr;
+
+			if (i >= nr_zones)
+				break;
+
+			zone_addr = contig_page_data_addr + (sizeof_zone * i) + zone_off;
+			lock_addr = zone_addr + lock_off;
+
+			bpf_map_update_elem(lock_syms_map, &lock_addr, &lock_flag, BPF_ANY);
+		}
+	} else if (node_data_addr && nr_nodes > 0) {
+		struct pglist_data **node_data = (void *)(long)node_data_addr;
+
+		for (int i = 0; i < nr_nodes; i++) {
+			struct pglist_data *pgdat = NULL;
+			int err;
+
+			err = bpf_core_read(&pgdat, sizeof(pgdat), &node_data[i]);
+			if (err < 0)
+				break;
+			if (pgdat == NULL)
+				continue;
+
+			nr_zones = BPF_CORE_READ(pgdat, nr_zones);
+			for (int k = 0; k < MAX_ZONES; k++) {
+				__u64 zone_addr;
+
+				if (k >= nr_zones)
+					break;
+
+				zone_addr = (__u64)(void *)pgdat + (sizeof_zone * k) + zone_off;
+				lock_addr = zone_addr + lock_off;
+
+				bpf_map_update_elem(lock_syms_map, &lock_addr, &lock_flag, BPF_ANY);
+			}
+		}
+	}
+}
+
+static __always_inline int do_collect_lock_syms(void *lock_syms_map,
+						__u64 contig_page_data_addr,
+						__u64 node_data_addr,
+						int nr_nodes,
+						int sizeof_zone)
+{
+	__u64 lock_addr, lock_off;
+	__u32 lock_flag;
+
+	if (bpf_core_field_exists(struct rq___new, __lock))
+		lock_off = offsetof(struct rq___new, __lock);
+	else
+		lock_off = offsetof(struct rq___old, lock);
+
+	if (&runqueues) {
+		for (int i = 0; i < MAX_CPUS; i++) {
+			struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
+
+			if (rq == NULL)
+				break;
+
+			lock_addr = (__u64)(void *)rq + lock_off;
+			lock_flag = LOCK_CLASS_RQLOCK;
+			bpf_map_update_elem(lock_syms_map, &lock_addr, &lock_flag, BPF_ANY);
+		}
+	}
+
+	do_collect_zone_lock(lock_syms_map, contig_page_data_addr,
+			     node_data_addr, nr_nodes, sizeof_zone);
+
+	return 0;
+}
+
+static __always_inline int do_slab_cache_iter(void *ctx, void *slab_caches_map,
+					      __u32 *slab_cache_id)
+{
+	struct kmem_cache *s = NULL;
+	struct slab_cache_data d = {};
+	const char *nameptr;
+
+	if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
+		struct bpf_iter__kmem_cache___new *iter = ctx;
+
+		s = iter->s;
+	}
+
+	if (s == NULL)
+		return 0;
+
+	nameptr = s->name;
+	bpf_probe_read_kernel_str(d.name, sizeof(d.name), nameptr);
+
+	d.id = ++(*slab_cache_id) << LCB_F_SLAB_ID_SHIFT;
+	if (d.id >= LCB_F_SLAB_ID_END)
+		return 0;
+
+	bpf_map_update_elem(slab_caches_map, &s, &d, BPF_NOEXIST);
+	return 0;
+}
+
+#endif /* __BPF__ */
+
 #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index 94e42b022ab1..b75ddc6846bb 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -76,6 +76,7 @@ struct signal_struct {
 } __attribute__((preserve_access_index));
 
 struct rw_semaphore {
+	atomic_long_t count;
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
@@ -83,6 +84,10 @@ struct mutex {
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
+struct rt_mutex_base {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
 struct kernfs_node {
 	u64 id;
 } __attribute__((preserve_access_index));
diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 119a7206f3cd..a1bb78d6e29c 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -22,6 +22,24 @@ struct callstack_filter {
 static LIST_HEAD(callstack_filters);
 struct hlist_head *lockhash_table;
 
+const struct perf_lock_type lock_type_table[] = {
+	{ 0,				"semaphore",	"semaphore" },
+	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
+	{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R",	"rwlock" },
+	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
+	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
+	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
+	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
+	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
+	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
+	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
+	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
+	{ LCB_F_MUTEX,			"mutex",	"mutex" },
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
+	/* alias for optimistic spinning only */
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex:spin",	"mutex-spin" },
+};
+
 int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
 		     int unset __maybe_unused)
 {
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 59c94190b092..68e9bd77e8a9 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -129,6 +129,19 @@ struct thread_stat {
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
 
+struct perf_lock_type {
+	unsigned int flags;
+	/*
+	 * Name of the lock flags (access), with delimiter ':'.
+	 * For example, rwsem:R or rwsem:W.
+	 */
+	const char *flags_name;
+	/* Name of the lock (type), for example, rwlock or rwsem. */
+	const char *lock_name;
+};
+
+extern const struct perf_lock_type lock_type_table[14];
+
 struct evlist;
 struct machine;
 struct target;
-- 
2.56.0.212.g129ede20d9-goog

