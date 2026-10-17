Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A63C5848
	for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257304; cv=none; b=SAsWnwWmG9OAtVUsjW/GPgLhS0e/NRsrSH/iMSxrYQ2Wwf1STwKkL/bJz5OeBUuFD0f7A56u0DU3ku99DLylQB1szUA/ZWFTRiVEQ8HRbDrWmwEJlxvjt9RGcBgoZNDYav00tWpx0CbzqscY9fv/SpunwpihWEJfBl28AHRcgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257304; c=relaxed/simple;
	bh=FvNDdlV8qZU4KqpKToxLVap5NdrBUrN+8J6hCmEp0sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKIEYpiM00LTvmJM8yF82EdibQchqEoLcaPvnD/zS/TdmZLm089kYA47PVBMTygsucWFdUPgp6aYQECKsE5ApqhBOPaezQP269Yi2vdIck4rke/DgvWXQ0jBBnGq8C8KcaNEzCwH0sVcGZ1gv6XnSFG3+PXioWlLCiquolwJroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frEKp/lv; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frEKp/lv"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1756810eec.1
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792257300; x=1792862100; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OIe7LQRvRV1IH2afl4BAfBj193lRDmUZFN/jxErLCnc=;
        b=frEKp/lvFJEixuyQLJEMjd48g0uOn3DdQ+L4uTbF6/PYNt4a7cm3UZzAGlkAV9FWpE
         TAdc426D8XHtBExxIioYcLKgjKI8jlImZSS/1Jhn1fw3ZBCcG5XY9aqJB4zXeMbdVlv9
         J9kP1ZARD+5cRGQomNuLd5WmDHaqs//Od3ciQ1lhu87W8G5i+mtKKsQAcBhLZdlnBznZ
         3rhvOuJWN7AmkaNUCqIUqNeo9OXDausyIhEpT6GvMUfMBUlLdtrVZJqudPMQLGzco18t
         ZbxiXyJ1AJiOOgf6IDiREmVj4cuwSYu6p8J/BMi1iJEltglOxt51Pjjqv77u+mkYt8eO
         M7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257300; x=1792862100;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OIe7LQRvRV1IH2afl4BAfBj193lRDmUZFN/jxErLCnc=;
        b=qArz51zJjPiqatl+S+VSGPoPtwX4gwZvUG1XTVSJf1vnPVQp1AmQ+SrzBJ32YKExV6
         RTc4e5tpmUagdukRuD5/A0Yhl+VIu3XRizKqAu6TtwRLXRddzWGSEx6Y7FkOikdF7tVZ
         ckQsfVuZBZW7P2kvkLkRf81zbSMxIbsNvn0oWuW9THU+AO7tV9gmL+UT6a93+MCAsMeD
         hkCF79fFlyGoOu675NM8TeRqk8w1rKOeRmcHzqNF9OjD5GawpsLxel/JNZx1oyBjlcaj
         xfD5aiTDwEw/e00sw2N5XDxwQh5Ycs8O0tx87vt9z2Gl6sL6If/RdyzaBxIAUenrmtXd
         H+9A==
X-Forwarded-Encrypted: i=1; AKwUvBzNtSvybtQr3qA2ow/lYpKU3d3xSoq05eR93Lnu5zVyhxAfnxFez6Q5znuZ9F/iH7cnGno=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRMuOv3yle8ETu+aLLr+hSWrQUZWvLjwVUbQj/sqUK/8PfmHcB
	acEh7IHkopUN0Q1GlgT2tVYM3vD2jhy0/RhB8c27NP8/HKkoC++i5phfxPCLJtvtNwwNwMYY96s
	2N4fbA9nexg==
X-Received: from dycrm8.prod.google.com ([2002:a05:693c:2a08:b0:353:41aa:1e9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:271d:b0:353:5d0a:dba4
 with SMTP id 5a478bee46e88-361a2449313mr5237390eec.36.1792257299781; Sat, 17
 Oct 2026 10:14:59 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:14:36 -0700
In-Reply-To: <20261017171437.2066343-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017054555.1655407-1-irogers@google.com> <20261017171437.2066343-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017171437.2066343-6-irogers@google.com>
Subject: [PATCH v2 5/6] perf lock contention: Extend BPF lock contention to
 RCU and SRCU
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
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
 tools/perf/util/bpf_lock_contention.c         | 167 +++++++++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 200 ++++++++++++++----
 tools/perf/util/machine.c                     |  11 +
 5 files changed, 348 insertions(+), 51 deletions(-)

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
index 5df9a0cd48a3..c6d37c910d4b 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -181,6 +181,13 @@ test_type_filter()
 		err=1
 		exit
 	fi
+
+	perf lock con -a -b -Y rcu -q -- true > /dev/null 2> ${result}
+	if [ "$(grep -c -v rcu "${result}")" != "0" ]; then
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
+	if [ "$(grep -c -v rcu "${result}")" != "0" ]; then
+		echo "[Fail] BPF result should not have non-rcu locks:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
 }
 
 test_stack_filter()
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c20bd075664e..fa7df9187b08 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -16,6 +16,7 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <inttypes.h>
+#include <unistd.h>
 
 #include "bpf_skel/lock_contention.skel.h"
 #include "bpf_skel/lock_data.h"
@@ -180,6 +181,129 @@ static void init_numa_data(struct lock_contention *con)
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
+		skel->rodata->rcu_state_addr = map__unmap_ip(kmap, sym->start);
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
@@ -187,6 +311,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 	bool has_mmap_lock = false;
+	bool has_rcu_lock = false;
 
 	/* make sure it loads the kernel map before lookup */
 	map__load(machine__kernel_map(con->machine));
@@ -200,6 +325,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_value_size(skel->maps.stacks, con->max_stack * sizeof(u64));
 	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.tstamp, con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.tstamp_rcu, con->map_nr_entries);
 
 	if (con->aggr_mode == LOCK_AGGR_TASK)
 		bpf_map__set_max_entries(skel->maps.task_data, con->map_nr_entries);
@@ -249,6 +375,10 @@ int lock_contention_prepare(struct lock_contention *con)
 				has_mmap_lock = true;
 				continue;
 			}
+			if (!strcmp(con->filters->syms[i], "rcu")) {
+				has_rcu_lock = true;
+				continue;
+			}
 
 			sym = machine__find_kernel_symbol_by_name(con->machine,
 								  con->filters->syms[i],
@@ -269,7 +399,7 @@ int lock_contention_prepare(struct lock_contention *con)
 			addrs[con->filters->nr_addrs++] = map__unmap_ip(kmap, sym->start);
 			con->filters->addrs = addrs;
 		}
-		naddrs = con->filters->nr_addrs ?: has_mmap_lock;
+		naddrs = con->filters->nr_addrs ?: (has_mmap_lock || has_rcu_lock);
 		skel->rodata->has_addr = 1;
 	}
 
@@ -305,6 +435,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->rodata->needs_callstack = con->save_callstack;
 	skel->rodata->lock_owner = con->owner;
 	skel->rodata->has_mmap_lock = has_mmap_lock;
+	skel->rodata->has_rcu_lock = has_rcu_lock;
 
 	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
 		if (cgroup_is_v2("perf_event"))
@@ -321,6 +452,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_max_entries(skel->maps.slab_filter, nslabs);
 
 	init_numa_data(con);
+	configure_rcu_contention_progs(con, has_rcu_lock);
 
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
@@ -503,23 +635,30 @@ static void account_end_timestamp(struct lock_contention *con)
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
@@ -604,6 +743,8 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 			return "mmap_lock";
 		if (flags & LCD_F_SIGHAND_LOCK)
 			return "siglock";
+		if (flags & LCD_F_RCU_LOCK)
+			return "rcu";
 
 		/* global locks with symbols */
 		sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, &kmap);
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 0f2118006005..58d45c43150b 100644
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
@@ -172,6 +185,7 @@ const volatile int aggr_mode;
 
 const volatile __u64 contig_page_data_addr;
 const volatile __u64 node_data_addr;
+const volatile __u64 rcu_state_addr;
 const volatile int nr_nodes;
 const volatile int sizeof_zone;
 
@@ -218,7 +232,7 @@ static inline __u64 get_current_cgroup_id(void)
 	return BPF_CORE_READ(cgrp, kn, id);
 }
 
-static inline int can_record(u64 *ctx)
+static __always_inline int can_record(__u64 lock, __u32 flags)
 {
 	bool is_addr_ok = false;
 
@@ -242,7 +256,6 @@ static inline int can_record(u64 *ctx)
 
 	if (has_type) {
 		__u8 *ok;
-		__u32 flags = (__u32)ctx[1];
 
 		ok = bpf_map_lookup_elem(&type_filter, &flags);
 		if (!ok)
@@ -251,10 +264,9 @@ static inline int can_record(u64 *ctx)
 
 	if (has_addr) {
 		__u8 *ok;
-		__u64 addr = ctx[0];
 
-		ok = bpf_map_lookup_elem(&addr_filter, &addr);
-		if (!ok && !has_slab && !has_mmap_lock)
+		ok = bpf_map_lookup_elem(&addr_filter, &lock);
+		if (!ok && !has_slab && !has_mmap_lock && !has_rcu_lock)
 			return 0;
 
 		is_addr_ok = !!ok;
@@ -272,26 +284,27 @@ static inline int can_record(u64 *ctx)
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
@@ -351,6 +364,7 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 {
 	__u32 pid;
 	struct tstamp_data *pelem;
+	void *map;
 
 	/* Use per-cpu array map for spinlock and rwlock */
 	if ((flags & (LCB_F_SPIN | LCB_F_MUTEX)) == LCB_F_SPIN) {
@@ -363,8 +377,9 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 		return pelem;
 	}
 
+	map = (flags & (LCB_F_RCU | LCB_F_SRCU)) ? (void *)&tstamp_rcu : (void *)&tstamp;
 	pid = bpf_get_current_pid_tgid();
-	pelem = bpf_map_lookup_elem(&tstamp, &pid);
+	pelem = bpf_map_lookup_elem(map, &pid);
 	/* Do not update the element for nested locks */
 	if (pelem && pelem->lock)
 		return NULL;
@@ -372,12 +387,12 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
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
@@ -474,21 +489,20 @@ static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
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
 
@@ -559,8 +573,21 @@ int contention_begin(u64 *ctx)
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
@@ -588,8 +615,7 @@ int contention_begin(u64 *ctx)
 	return 0;
 }
 
-SEC("tp_btf/contention_end")
-int contention_end(u64 *ctx)
+static __always_inline int do_contention_end(__u64 lock, __s32 ret)
 {
 	__u32 pid = 0, idx = 0;
 	struct tstamp_data *pelem;
@@ -597,7 +623,7 @@ int contention_end(u64 *ctx)
 	struct contention_data *data;
 	__u64 timestamp;
 	__u64 duration;
-	bool need_delete = false;
+	void *ts_map = NULL;
 
 	if (!enabled)
 		return 0;
@@ -613,14 +639,19 @@ int contention_end(u64 *ctx)
 	 */
 	pelem = bpf_map_lookup_elem(&tstamp_cpu, &idx);
 	if (pelem && pelem->lock) {
-		if (pelem->lock != ctx[0])
+		if (pelem->lock != lock)
 			return 0;
 	} else {
 		pid = bpf_get_current_pid_tgid();
 		pelem = bpf_map_lookup_elem(&tstamp, &pid);
-		if (!pelem || pelem->lock != ctx[0])
-			return 0;
-		need_delete = true;
+		if (pelem && pelem->lock == lock) {
+			ts_map = &tstamp;
+		} else {
+			pelem = bpf_map_lookup_elem(&tstamp_rcu, &pid);
+			if (!pelem || pelem->lock != lock)
+				return 0;
+			ts_map = &tstamp_rcu;
+		}
 	}
 
 	timestamp = bpf_ktime_get_ns();
@@ -648,7 +679,6 @@ int contention_end(u64 *ctx)
 		 */
 		else {
 			u32 i = 0;
-			s32 ret = (s32)ctx[1];
 			u64 *buf;
 
 			otdata->timestamp = timestamp;
@@ -713,7 +743,7 @@ int contention_end(u64 *ctx)
 		if (lock_owner)
 			key.pid = pelem->flags;
 		else {
-			if (!need_delete)
+			if (!ts_map)
 				pid = bpf_get_current_pid_tgid();
 			key.pid = pid;
 		}
@@ -795,11 +825,109 @@ int contention_end(u64 *ctx)
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
+	return do_contention_end((__u64)ctx[0], (__s32)ctx[1]);
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
+	return do_contention_end(rcu_state_addr, 0);
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
+	return do_contention_end(rcu_state_addr, 0);
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
+	return do_contention_end(rcu_state_addr, 0);
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
+	return do_contention_end(rcu_state_addr, 0);
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
+	return do_contention_end(get_lock_addr(ctx), 0);
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
+	return do_contention_end(get_lock_addr(ctx), 0);
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
+	return do_contention_end(get_lock_addr(ctx), 0);
+}
+
 SEC("raw_tp/bpf_test_finish")
 int BPF_PROG(end_timestamp)
 {
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
2.56.0.212.g129ede20d9-goog

