Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782386;
	b=thIrbCWMfkeZjvdLYxzw92SBN1n37yZwG66DwW6jafhXMj0a8ApOQ4M/w+6tQfbQUOgA
	 nKSNxi54BVh6+Ctdwas4wHqFDsMh+gyF9VoO1Fu1RgkJ0lQY7gltWuOyBnBIHigBGCCVT
	 S9H+PKA1dZhzr/5XeK4XfZ8rRKtwBWk1cWWFFbPf5ZcV95n5ZNoraoCymEyCCkfM13D+y
	 VqaY/roZ8qh/OrpUcdNuW2K8xltnagjtzjy2TUJ9SWi6v0kXZGw2W1PynEAFYfdW5Mk0V
	 kAraXU/ZB+bwucB3hu29oonx2WQDsNKnsgGdt1xReDLvtEOnVDQNsnZQzsEB86dqimw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eBdf9mFYUWPSEX8Kj7adbXppbMu3F4qi73IVgCRBTtU=;
	b=adIe5NSwK2plOxeKam2yU4QM8OXtAVTEWp//7X6lS38S4/nlkiOUyOo5YuOFkiE/zVAg
	 noOWUdRNSKrMjlabAB1AAKjW9D+mJXht5MVj3OAqcAQsPovWjJ/5JqEjt1fMCXZaZU0Sd
	 zTMv/pC3iHROb9GN1wLtVbsuT/tNEkS9T4hkz18WycnUYK612xQO6TqOLd5k32pFS2yQW
	 2DVGuA0zjvupw2dDC1IGAT5uzhHVgr3JdqMcNYVFj1R38WKbnKCvHlgx5Tl2ZNxs9LCMg
	 YuZEcu8qYbeRcOEDGpjLAWsa8JAAWIOjGyCHcZ9Z60sM9cLb/C+0dnBqCzu0qSbYtPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vw9iP6W8;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACB60A2602
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEACB60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vw9iP6W8
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so4572906c88.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782385; x=1793387185; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBdf9mFYUWPSEX8Kj7adbXppbMu3F4qi73IVgCRBTtU=;
        b=vw9iP6W8iNq9ct7x4H/tFlAgk0Nf9kUspCcHtCPwKU9tkYnVD4xihk4KcAF5Cn2mXx
         NMOOCFue7CIe73rt7+AK5mNPdrb8VVXdVH+Ih/ASgGAKOSiVPkeQQzjhXVsZ55hrL799
         r3l8OjqXIDaz8pv6Rk3GNZltiaBLxiH5kwh78WaLDG9/aN/sThXb14Nc48xGLpC+skTU
         Wh91N03cWyta4+Ir4IMNakCH/LsM7Ddy/D6CD+qL4WmJ6yV4iv8Xqq4KsBFIdirUdakW
         dQVZ6XzzSEcWErQ45v6FsomZfwRA7mItDwmjG5W/ymCWdSlLTecYtp4RUXiU8JF+bG/s
         WD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782385; x=1793387185;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBdf9mFYUWPSEX8Kj7adbXppbMu3F4qi73IVgCRBTtU=;
        b=1cHrE3WiSwBQb0HLgjSsSXLSox3vB0q5mFGTWhvsY6ykyhVgzfmhtPIajqZ9keWPyI
         WvaQtjhJj26Wxzo6C9k1i86Z2fRk5U6j01f2ln7gveK47yrBLCr+hnzBK8urmOKmpaeA
         pTb0Ww/wg4nbCpw+sNp2DQg60YaT15xyTBiwCH+3sn9SFIQjUMpgMJ/GViaQgZgPm0wR
         vYS/JyRcOiACTFEhm0g6YxRRKPGY8iZqiH+uHfKWURyNbVhuodDVury2kmRE6pv20gls
         0tGD++OTOho1HpT0S4WQfKxZtnyqZMomXLyZFGPKDL6Xq/wBA9ObgWtPDJAHBcC8xJs8
         3Pww==
X-Forwarded-Encrypted: i=1; AKwUvBy9mLuDGMFQtqK9LjKmflMvZvBNw4C4ic3S8Y/1kYPR6BUWwxu3fnAsI4zjhOOfIR0m9SU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwRRcb9OrFthwhAIp7aRoiH5pJgjm0QhAl8SU+crRpHD+P/QP2
	/RZv7fyt7AJPN5ZlWqM5i0K388NzlzNJDkO337ukZmrnb8PNgPFlqNYYcmN45vcZc9CkdMgXpGX
	6vAbWMy9h0Q==
X-Received: from dlbqq9.prod.google.com ([2002:a05:7022:ed09:b0:194:c5c4:fa82])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:294:10b0:196:e254:db24
 with SMTP id a92af1059eb24-196e254dbbamr2421288c88.21.1792782384390; Fri, 23
 Oct 2026 12:06:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:58 -0700
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
Message-ID: <20261023190558.3050796-12-irogers@google.com>
Subject: [PATCH v7 11/11] perf lock contention: Extend BPF lock contention to
 RCU and SRCU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend 'perf lock contention --use-bpf' to track RCU and SRCU
grace-period and barrier waits:

- Attach fentry/fexit programs to synchronize_rcu(),
  synchronize_rcu_expedited(), synchronize_rcu_tasks(), rcu_barrier(),
  synchronize_srcu(), synchronize_srcu_expedited(), and srcu_barrier()
  when available in BTF.
- Support filtering by lock type ('-Y rcu', '-Y rcu:W', '-Y srcu',
  '-Y srcu:W') and by lock name ('-L rcu' or specific srcu_struct
  symbol names).

Example usage:

  # perf lock con -a -b -Y rcu,srcu -F wait_total,avg_wait -- sleep 1
     total wait     avg wait         type   caller

       35.12 ms      8.78 ms        rcu:W   cleanup_net+0x284
        7.84 ms      3.92 ms       srcu:W   __fsnotify_parent+0x114

  # perf lock con -a -b -l -L rcu -F wait_total,avg_wait -- sleep 1
     total wait     avg wait            address   symbol

       35.12 ms      8.78 ms   ffffffff83754dc0   rcu (rcu)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-lock.txt        |   7 +-
 tools/perf/tests/shell/lock_contention.sh     |  14 ++
 tools/perf/util/bpf_lock_contention.c         | 174 +++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 222 ++++++++++++++----
 tools/perf/util/machine.c                     |  11 +
 5 files changed, 366 insertions(+), 62 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index c17b3e318169..bfeb98c976e3 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -188,11 +188,14 @@ CONTENTION OPTIONS
 	Show lock contention only for given lock types (comma separated list).
 	Available values are:
 	  semaphore, spinlock, rwlock, rwlock:R, rwlock:W, rwsem, rwsem:R, rwsem:W,
-	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, percpu-rwmem, pcpu-sem,
-	  pcpu-sem:R, pcpu-sem:W, mutex
+	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, percpu-rwsem, pcpu-sem,
+	  pcpu-sem:R, pcpu-sem:W, mutex, srcu, srcu:W, rcu, rcu:W
 
 	Note that RW-variant of locks have :R and :W suffix.  Names without the
 	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
+	For RCU and SRCU with --use-bpf, contention tracks grace-period and
+	barrier waits (synchronize_rcu*(), synchronize_srcu*(), rcu_barrier(),
+	srcu_barrier()).
 
 -L::
 --lock-filter=<value>::
diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 5df9a0cd48a3..999dcfd1ef26 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -181,6 +181,13 @@ test_type_filter()
 		err=1
 		exit
 	fi
+
+	perf lock con -a -b -Y rcu -q -- true > /dev/null 2> ${result}
+	if [ "$(grep -c -v -w rcu "${result}")" != "0" ]; then
+		echo "[Fail] BPF result should not have non-rcu locks:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
 }
 
 test_lock_filter()
@@ -224,6 +231,13 @@ test_lock_filter()
 		err=1
 		exit
 	fi
+
+	perf lock con -a -b -L rcu -q -- true > /dev/null 2> ${result}
+	if [ "$(grep -c -v -w rcu "${result}")" != "0" ]; then
+		echo "[Fail] BPF result should not have non-rcu locks:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
 }
 
 test_stack_filter()
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c20bd075664e..081a1ecc10a6 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -16,6 +16,10 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <inttypes.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 
 #include "bpf_skel/lock_contention.skel.h"
 #include "bpf_skel/lock_data.h"
@@ -180,6 +184,133 @@ static void init_numa_data(struct lock_contention *con)
 	free(buf);
 }
 
+static bool has_bpf_fentry_support(struct btf *btf)
+{
+	/*
+	 * Verify both BPF_TRACE_FENTRY trampoline support (5.5+) and
+	 * bpf_get_func_arg() helper availability (5.17+) used by
+	 * get_lock_addr() in the SRCU fentry/fexit hooks.
+	 */
+	struct bpf_insn insns[] = {
+		{ .code = BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg = BPF_REG_2, .imm = 0 },
+		{ .code = BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg = BPF_REG_3,
+		  .src_reg = BPF_REG_10 },
+		{ .code = BPF_ALU64 | BPF_ADD | BPF_K, .dst_reg = BPF_REG_3, .imm = -8 },
+		{ .code = BPF_JMP | BPF_CALL, .imm = BPF_FUNC_get_func_arg },
+		{ .code = BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg = BPF_REG_0, .imm = 0 },
+		{ .code = BPF_JMP | BPF_EXIT },
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.expected_attach_type = BPF_TRACE_FENTRY,
+	);
+	s32 btf_id;
+	int prog_fd, link_fd;
+
+	if (!btf)
+		return false;
+
+	btf_id = btf__find_by_name_kind(btf, "synchronize_rcu", BTF_KIND_FUNC);
+	if (btf_id <= 0)
+		return false;
+
+	opts.attach_btf_id = btf_id;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), &opts);
+	if (prog_fd < 0)
+		return false;
+
+	link_fd = bpf_raw_tracepoint_open(NULL, prog_fd);
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+	return link_fd >= 0;
+}
+
+static void configure_rcu_contention_progs(struct lock_contention *con,
+					   bool has_rcu_lock)
+{
+	static const struct {
+		size_t prog_offset;
+		const char *func;
+		bool is_srcu;
+	} rcu_progs[] = {
+		{ offsetof(struct lock_contention_bpf, progs.fentry_synchronize_rcu),
+		  "synchronize_rcu", false },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_synchronize_rcu),
+		  "synchronize_rcu", false },
+		{ offsetof(struct lock_contention_bpf, progs.fentry_synchronize_rcu_expedited),
+		  "synchronize_rcu_expedited", false },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_synchronize_rcu_expedited),
+		  "synchronize_rcu_expedited", false },
+		{ offsetof(struct lock_contention_bpf, progs.fentry_synchronize_rcu_tasks),
+		  "synchronize_rcu_tasks", false },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_synchronize_rcu_tasks),
+		  "synchronize_rcu_tasks", false },
+		{ offsetof(struct lock_contention_bpf, progs.fentry_rcu_barrier),
+		  "rcu_barrier", false },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_rcu_barrier),
+		  "rcu_barrier", false },
+		{ offsetof(struct lock_contention_bpf, progs.fentry_synchronize_srcu),
+		  "synchronize_srcu", true },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_synchronize_srcu),
+		  "synchronize_srcu", true },
+		{ offsetof(struct lock_contention_bpf, progs.fentry_synchronize_srcu_expedited),
+		  "synchronize_srcu_expedited", true },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_synchronize_srcu_expedited),
+		  "synchronize_srcu_expedited", true },
+		{ offsetof(struct lock_contention_bpf, progs.fentry_srcu_barrier),
+		  "srcu_barrier", true },
+		{ offsetof(struct lock_contention_bpf, progs.fexit_srcu_barrier),
+		  "srcu_barrier", true },
+	};
+	struct symbol *sym;
+	struct map *kmap;
+	bool need_rcu = true, need_srcu = true;
+	bool fentry_ok;
+
+	sym = machine__find_kernel_symbol_by_name(con->machine, "rcu_state", &kmap);
+	if (sym) {
+		/*
+		 * Offset by 1 byte so rcu_state_addr is distinct from
+		 * &rcu_state.node[0].lock at offset 0 of rcu_state.
+		 */
+		skel->rodata->rcu_state_addr = map__unmap_ip(kmap, sym->start) + 1;
+		map__put(kmap);
+	} else {
+		skel->rodata->rcu_state_addr = 1ULL;
+	}
+
+	if (con->filters->nr_types) {
+		need_rcu = false;
+		need_srcu = false;
+		for (int i = 0; i < con->filters->nr_types; i++) {
+			if (con->filters->types[i] & LCB_F_RCU)
+				need_rcu = true;
+			if (con->filters->types[i] & LCB_F_SRCU)
+				need_srcu = true;
+		}
+	}
+
+	if (con->filters->nr_syms || con->filters->nr_addrs || con->filters->nr_slabs) {
+		if (!has_rcu_lock && !con->filters->nr_addrs)
+			need_rcu = false;
+		if (!con->filters->nr_addrs && !con->filters->nr_slabs)
+			need_srcu = false;
+	}
+
+	fentry_ok = (need_rcu || need_srcu) && has_bpf_fentry_support(con->btf);
+
+	for (size_t i = 0; i < ARRAY_SIZE(rcu_progs); i++) {
+		struct bpf_program **progp = (void *)skel + rcu_progs[i].prog_offset;
+		bool want = rcu_progs[i].is_srcu ? need_srcu : need_rcu;
+		bool enable = fentry_ok && want &&
+			      btf__find_by_name_kind(con->btf, rcu_progs[i].func,
+						     BTF_KIND_FUNC) > 0;
+
+		bpf_program__set_autoload(*progp, enable);
+	}
+}
+
 int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
@@ -187,6 +318,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 	bool has_mmap_lock = false;
+	bool has_rcu_lock = false;
 
 	/* make sure it loads the kernel map before lookup */
 	map__load(machine__kernel_map(con->machine));
@@ -200,6 +332,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_value_size(skel->maps.stacks, con->max_stack * sizeof(u64));
 	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.tstamp, con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.tstamp_rcu, con->map_nr_entries);
 
 	if (con->aggr_mode == LOCK_AGGR_TASK)
 		bpf_map__set_max_entries(skel->maps.task_data, con->map_nr_entries);
@@ -249,6 +382,10 @@ int lock_contention_prepare(struct lock_contention *con)
 				has_mmap_lock = true;
 				continue;
 			}
+			if (!strcmp(con->filters->syms[i], "rcu")) {
+				has_rcu_lock = true;
+				continue;
+			}
 
 			sym = machine__find_kernel_symbol_by_name(con->machine,
 								  con->filters->syms[i],
@@ -269,7 +406,7 @@ int lock_contention_prepare(struct lock_contention *con)
 			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap, sym->start);
 			con->filters->addrs = addrs;
 		}
-		naddrs = con->filters->nr_addrs ?: has_mmap_lock;
+		naddrs = con->filters->nr_addrs ?: (has_mmap_lock || has_rcu_lock);
 		skel->rodata->has_addr = 1;
 	}
 
@@ -305,6 +442,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->rodata->needs_callstack = con->save_callstack;
 	skel->rodata->lock_owner = con->owner;
 	skel->rodata->has_mmap_lock = has_mmap_lock;
+	skel->rodata->has_rcu_lock = has_rcu_lock;
 
 	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
 		if (cgroup_is_v2("perf_event"))
@@ -321,6 +459,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_max_entries(skel->maps.slab_filter, nslabs);
 
 	init_numa_data(con);
+	configure_rcu_contention_progs(con, has_rcu_lock);
 
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
@@ -503,23 +642,30 @@ static void account_end_timestamp(struct lock_contention *con)
 	enum lock_aggr_mode aggr_mode = con->aggr_mode;
 	struct tstamp_data ts_data, *cpu_data;
 
-	/* Iterate per-task tstamp map (key = TID) */
-	ts_fd = bpf_map__fd(skel->maps.tstamp);
+	/* Iterate per-task tstamp maps (key = TID) */
+	int ts_fds[] = {
+		bpf_map__fd(skel->maps.tstamp),
+		bpf_map__fd(skel->maps.tstamp_rcu),
+	};
+
 	stat_fd = bpf_map__fd(skel->maps.lock_stat);
 
-	prev_key = NULL;
-	while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
-		if (bpf_map_lookup_elem(ts_fd, &key, &ts_data) == 0) {
-			int pid = key;
+	for (size_t i = 0; i < ARRAY_SIZE(ts_fds); i++) {
+		ts_fd = ts_fds[i];
+		prev_key = NULL;
+		while (!bpf_map_get_next_key(ts_fd, prev_key, &key)) {
+			if (bpf_map_lookup_elem(ts_fd, &key, &ts_data) == 0) {
+				int pid = key;
 
-			if (aggr_mode == LOCK_AGGR_TASK && con->owner)
-				pid = ts_data.flags;
+				if (aggr_mode == LOCK_AGGR_TASK && con->owner)
+					pid = ts_data.flags;
 
-			update_lock_stat(stat_fd, pid, end_ts, aggr_mode,
-					 &ts_data);
-		}
+				update_lock_stat(stat_fd, pid, end_ts, aggr_mode,
+						 &ts_data);
+			}
 
-		prev_key = &key;
+			prev_key = &key;
+		}
 	}
 
 	/* Now it'll check per-cpu tstamp map which doesn't have TID. */
@@ -604,6 +750,8 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 			return "mmap_lock";
 		if (flags & LCD_F_SIGHAND_LOCK)
 			return "siglock";
+		if (flags & LCD_F_RCU_LOCK)
+			return "rcu";
 
 		/* global locks with symbols */
 		sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, &kmap);
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index c70c3955e559..8ae3fc889528 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -59,6 +59,18 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } tstamp SEC(".maps");
 
+/*
+ * Separate per-task timestamp map for RCU/SRCU grace-period and barrier waits
+ * so they do not collide with inner sleeping lock contentions (such as
+ * rcu_barrier_mutex or srcu_cb_mutex) acquired during the wait.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct tstamp_data);
+	__uint(max_entries, MAX_ENTRIES);
+} tstamp_rcu SEC(".maps");
+
 /* maintain per-CPU timestamp at the beginning of contention */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
@@ -160,6 +172,7 @@ const volatile int has_addr;
 const volatile int has_cgroup;
 const volatile int has_slab;
 const volatile int has_mmap_lock;
+const volatile int has_rcu_lock;
 const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
@@ -170,6 +183,8 @@ const volatile int lock_delay;
 /* determine the key of lock stat */
 const volatile int aggr_mode;
 
+const volatile __u64 rcu_state_addr;
+
 int enabled;
 
 int perf_subsys_id = -1;
@@ -213,7 +228,7 @@ static inline __u64 get_current_cgroup_id(void)
 	return BPF_CORE_READ(cgrp, kn, id);
 }
 
-static inline int can_record(u64 *ctx)
+static __always_inline int can_record(__u64 lock, __u32 flags)
 {
 	bool is_addr_ok = false;
 
@@ -237,7 +252,6 @@ static inline int can_record(u64 *ctx)
 
 	if (has_type) {
 		__u8 *ok;
-		__u32 flags = (__u32)ctx[1];
 
 		ok = bpf_map_lookup_elem(&type_filter, &flags);
 		if (!ok)
@@ -246,10 +260,9 @@ static inline int can_record(u64 *ctx)
 
 	if (has_addr) {
 		__u8 *ok;
-		__u64 addr = ctx[0];
 
-		ok = bpf_map_lookup_elem(&addr_filter, &addr);
-		if (!ok && !has_slab && !has_mmap_lock)
+		ok = bpf_map_lookup_elem(&addr_filter, &lock);
+		if (!ok && !has_slab && !has_mmap_lock && !has_rcu_lock)
 			return 0;
 
 		is_addr_ok = !!ok;
@@ -267,26 +280,27 @@ static inline int can_record(u64 *ctx)
 	if (is_addr_ok)
 		return 1;
 
-	/* slab and mmap_lock are part of the addr_filter */
+	/* slab, mmap_lock, and rcu_lock are part of the addr_filter */
 	if (has_slab && bpf_get_kmem_cache) {
 		__u8 *ok;
-		__u64 addr = ctx[0];
 		long kmem_cache_addr;
 
-		kmem_cache_addr = (long)bpf_get_kmem_cache(addr);
+		kmem_cache_addr = (long)bpf_get_kmem_cache(lock);
 		ok = bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr);
 		if (ok)
 			return 1;
-		else if (!has_mmap_lock)
+		else if (!has_mmap_lock && !has_rcu_lock)
 			return 0;
 	}
 
-	if (has_mmap_lock) {
-		__u64 lock = ctx[0];
-		__u32 flag = ctx[1];
+	if (has_mmap_lock || has_rcu_lock) {
+		__u32 ltype = check_lock_type(lock, flags);
 
-		if (check_lock_type(lock, flag) != LCD_F_MMAP_LOCK)
-			return 0;
+		if (has_mmap_lock && ltype == LCD_F_MMAP_LOCK)
+			return 1;
+		if (has_rcu_lock && ltype == LCD_F_RCU_LOCK)
+			return 1;
+		return 0;
 	}
 
 	return 1;
@@ -346,6 +360,7 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 {
 	__u32 pid;
 	struct tstamp_data *pelem;
+	void *map;
 
 	/* Use per-cpu array map for spinlock and rwlock */
 	if ((flags & (LCB_F_SPIN | LCB_F_MUTEX)) == LCB_F_SPIN) {
@@ -358,8 +373,9 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 		return pelem;
 	}
 
+	map = (flags & (LCB_F_RCU | LCB_F_SRCU)) ? (void *)&tstamp_rcu : (void *)&tstamp;
 	pid = bpf_get_current_pid_tgid();
-	pelem = bpf_map_lookup_elem(&tstamp, &pid);
+	pelem = bpf_map_lookup_elem(map, &pid);
 	/* Do not update the element for nested locks */
 	if (pelem && pelem->lock)
 		return NULL;
@@ -367,12 +383,12 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 	if (pelem == NULL) {
 		struct tstamp_data zero = {};
 
-		if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST) < 0) {
+		if (bpf_map_update_elem(map, &pid, &zero, BPF_NOEXIST) < 0) {
 			__sync_fetch_and_add(&task_fail, 1);
 			return NULL;
 		}
 
-		pelem = bpf_map_lookup_elem(&tstamp, &pid);
+		pelem = bpf_map_lookup_elem(map, &pid);
 		if (pelem == NULL) {
 			__sync_fetch_and_add(&task_fail, 1);
 			return NULL;
@@ -469,21 +485,20 @@ static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
 	}
 }
 
-SEC("tp_btf/contention_begin")
-int contention_begin(u64 *ctx)
+static __always_inline int do_contention_begin(void *ctx, __u64 lock, __u32 flags)
 {
 	struct tstamp_data *pelem;
 
-	if (!enabled || !can_record(ctx))
+	if (!enabled || !can_record(lock, flags))
 		return 0;
 
-	pelem = get_tstamp_elem(ctx[1]);
+	pelem = get_tstamp_elem(flags);
 	if (pelem == NULL)
 		return 0;
 
 	pelem->timestamp = bpf_ktime_get_ns();
-	pelem->lock = (__u64)ctx[0];
-	pelem->flags = (__u32)ctx[1];
+	pelem->lock = lock;
+	pelem->flags = flags;
 	if (aggr_mode == LOCK_AGGR_CGROUP)
 		pelem->cgroup_id = get_current_cgroup_id();
 
@@ -554,8 +569,21 @@ int contention_begin(u64 *ctx)
 			}
 		}
 skip_owner:
-		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
-						  BPF_F_FAST_STACK_CMP | stack_skip);
+		{
+			int skip = stack_skip;
+
+			/*
+			 * Unlike tp_btf/contention_begin (which fires inside a
+			 * lock slowpath via trace_contention_begin), fentry
+			 * RCU/SRCU programs attach directly to the top-level
+			 * wait API, which is 2 frames shallower.
+			 */
+			if (flags & (LCB_F_RCU | LCB_F_SRCU))
+				skip = stack_skip > 2 ? stack_skip - 2 : 0;
+
+			pelem->stack_id = bpf_get_stackid(ctx, &stacks,
+							  BPF_F_FAST_STACK_CMP | skip);
+		}
 		if (pelem->stack_id < 0)
 			__sync_fetch_and_add(&stack_fail, 1);
 	} else if (aggr_mode == LOCK_AGGR_TASK) {
@@ -583,8 +611,7 @@ int contention_begin(u64 *ctx)
 	return 0;
 }
 
-SEC("tp_btf/contention_end")
-int contention_end(u64 *ctx)
+static __always_inline int do_contention_end(__u64 lock, __s32 ret, bool is_rcu)
 {
 	__u32 pid = 0, idx = 0;
 	struct tstamp_data *pelem;
@@ -592,30 +619,34 @@ int contention_end(u64 *ctx)
 	struct contention_data *data;
 	__u64 timestamp;
 	__u64 duration;
-	bool need_delete = false;
+	void *ts_map = NULL;
 
 	if (!enabled)
 		return 0;
 
 	/*
-	 * For spinlock and rwlock, it needs to get the timestamp for the
-	 * per-cpu map.  However, contention_end does not have the flags
-	 * so it cannot know whether it reads percpu or hash map.
-	 *
-	 * Try per-cpu map first and check if there's active contention.
-	 * If it is, do not read hash map because it cannot go to sleeping
-	 * locks before releasing the spinning locks.
+	 * RCU/SRCU fexit hooks always use the dedicated per-task tstamp_rcu
+	 * map. For tp_btf/contention_end, try the per-cpu map first (used by
+	 * spinlocks and rwlocks) and fall back to the per-task tstamp map.
 	 */
-	pelem = bpf_map_lookup_elem(&tstamp_cpu, &idx);
-	if (pelem && pelem->lock) {
-		if (pelem->lock != ctx[0])
-			return 0;
-	} else {
+	if (is_rcu) {
 		pid = bpf_get_current_pid_tgid();
-		pelem = bpf_map_lookup_elem(&tstamp, &pid);
-		if (!pelem || pelem->lock != ctx[0])
+		pelem = bpf_map_lookup_elem(&tstamp_rcu, &pid);
+		if (!pelem || pelem->lock != lock)
 			return 0;
-		need_delete = true;
+		ts_map = &tstamp_rcu;
+	} else {
+		pelem = bpf_map_lookup_elem(&tstamp_cpu, &idx);
+		if (pelem && pelem->lock) {
+			if (pelem->lock != lock)
+				return 0;
+		} else {
+			pid = bpf_get_current_pid_tgid();
+			pelem = bpf_map_lookup_elem(&tstamp, &pid);
+			if (!pelem || pelem->lock != lock)
+				return 0;
+			ts_map = &tstamp;
+		}
 	}
 
 	timestamp = bpf_ktime_get_ns();
@@ -643,7 +674,6 @@ int contention_end(u64 *ctx)
 		 */
 		else {
 			u32 i = 0;
-			s32 ret = (s32)ctx[1];
 			u64 *buf;
 
 			otdata->timestamp = timestamp;
@@ -708,7 +738,7 @@ int contention_end(u64 *ctx)
 		if (lock_owner)
 			key.pid = pelem->flags;
 		else {
-			if (!need_delete)
+			if (!ts_map)
 				pid = bpf_get_current_pid_tgid();
 			key.pid = pid;
 		}
@@ -790,11 +820,109 @@ int contention_end(u64 *ctx)
 		check_lock_delay(pelem->lock);
 
 	pelem->lock = 0;
-	if (need_delete)
-		bpf_map_delete_elem(&tstamp, &pid);
+	if (ts_map)
+		bpf_map_delete_elem(ts_map, &pid);
 	return 0;
 }
 
+SEC("tp_btf/contention_begin")
+int contention_begin(u64 *ctx)
+{
+	return do_contention_begin(ctx, (__u64)ctx[0], (__u32)ctx[1]);
+}
+
+SEC("tp_btf/contention_end")
+int contention_end(u64 *ctx)
+{
+	return do_contention_end((__u64)ctx[0], (__s32)ctx[1], false);
+}
+
+/* RCU grace-period synchronize / barrier contention hooks */
+SEC("fentry/synchronize_rcu")
+int BPF_PROG(fentry_synchronize_rcu)
+{
+	return do_contention_begin(ctx, rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_rcu")
+int BPF_PROG(fexit_synchronize_rcu)
+{
+	return do_contention_end(rcu_state_addr, 0, true);
+}
+
+SEC("fentry/synchronize_rcu_expedited")
+int BPF_PROG(fentry_synchronize_rcu_expedited)
+{
+	return do_contention_begin(ctx, rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_rcu_expedited")
+int BPF_PROG(fexit_synchronize_rcu_expedited)
+{
+	return do_contention_end(rcu_state_addr, 0, true);
+}
+
+SEC("fentry/synchronize_rcu_tasks")
+int BPF_PROG(fentry_synchronize_rcu_tasks)
+{
+	return do_contention_begin(ctx, rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_rcu_tasks")
+int BPF_PROG(fexit_synchronize_rcu_tasks)
+{
+	return do_contention_end(rcu_state_addr, 0, true);
+}
+
+SEC("fentry/rcu_barrier")
+int BPF_PROG(fentry_rcu_barrier)
+{
+	return do_contention_begin(ctx, rcu_state_addr, LCB_F_RCU | LCB_F_WRITE);
+}
+
+SEC("fexit/rcu_barrier")
+int BPF_PROG(fexit_rcu_barrier)
+{
+	return do_contention_end(rcu_state_addr, 0, true);
+}
+
+/* SRCU grace-period synchronize / barrier contention hooks */
+SEC("fentry/synchronize_srcu")
+int BPF_PROG(fentry_synchronize_srcu, void *ssp)
+{
+	return do_contention_begin(ctx, get_lock_addr(ctx), LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_srcu")
+int BPF_PROG(fexit_synchronize_srcu, void *ssp)
+{
+	return do_contention_end(get_lock_addr(ctx), 0, true);
+}
+
+SEC("fentry/synchronize_srcu_expedited")
+int BPF_PROG(fentry_synchronize_srcu_expedited, void *ssp)
+{
+	return do_contention_begin(ctx, get_lock_addr(ctx), LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fexit/synchronize_srcu_expedited")
+int BPF_PROG(fexit_synchronize_srcu_expedited, void *ssp)
+{
+	return do_contention_end(get_lock_addr(ctx), 0, true);
+}
+
+SEC("fentry/srcu_barrier")
+int BPF_PROG(fentry_srcu_barrier, void *ssp)
+{
+	return do_contention_begin(ctx, get_lock_addr(ctx), LCB_F_SRCU | LCB_F_WRITE);
+}
+
+SEC("fexit/srcu_barrier")
+int BPF_PROG(fexit_srcu_barrier, void *ssp)
+{
+	return do_contention_end(get_lock_addr(ctx), 0, true);
+}
+
 const volatile __u64 contig_page_data_addr;
 const volatile __u64 node_data_addr;
 const volatile int nr_nodes;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1d9d3bf57720..0a0f223b3335 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3379,6 +3379,17 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 			return true;
 	}
 
+	{
+		struct symbol *sym = machine__find_kernel_symbol(machine, addr, NULL);
+
+		if (sym && (!strncmp(sym->name, "synchronize_rcu", 15) ||
+			    !strncmp(sym->name, "synchronize_srcu", 16) ||
+			    !strcmp(sym->name, "__synchronize_srcu") ||
+			    !strcmp(sym->name, "rcu_barrier") ||
+			    !strcmp(sym->name, "srcu_barrier")))
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

