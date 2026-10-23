Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782378;
	b=5jnfVfdIqnahscKXDX8HSmv7xQeOteMX+tgN37ZsEQX8EjAmwH2hSBFjZjWQG/DRpp51
	 9ak5sgoHWrN/AETX3cJnuBx64Y3kiIB/n78JLDfR9LgGApnusPuIpR0rg9Bk4oFr3r4b5
	 I0fC+qp1CHxZdVC4nguqDgf9RQuP0rUvu2nQpw48ADAro3tZ+8O6lvAol6dSe9zFHJLoW
	 ye9KOgLwzfBzjHJTr+Z9uYordMtA4Cz+smh0pi0FsG8d7oMNXFeHhisk3M6EklPJgjsau
	 stoBKeTSIRrQxxJtlIcRnbIEUwSlwUF+URk6cNplBBCbcD4iLqCBO5Ef2vepjGEEXzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=i0EQ3ibIMhY4x0aalZu3gEawsXsVraNakStLx592xKk=;
	b=UI3Bc6sC1W1AC00hPC6mCGk6bS4j27JK+3+rLdMtHq2SdXy/j1rvnIIQqAjgmUSGJCZ0
	 KZ5CZab7OLhCUj8l7vvfzVWVLQm2QndIlRYG/bcIUYURhmjqzSlPEd/abC94zVTjNyyMw
	 Ts5Hj8S8+Fl2MQroKEmHB67HsJqlaR5KidnorjkjprN0Ix0b99BADS0j6pD50H2CqR1PG
	 Ka7XzVy//2aQ64gE4miYKxjPEfuyNMPNkafT0GXAviqXLkkKg6MqFzlk73opFMg8hUeNx
	 MFQTJtGHi/1VfudBiAz2wdgLhd9XSQ8VB+f/GOqJsNrdLSgnnRSqQGyrPeA/Bk0QFTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tITRz8aR;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F8606A323
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tITRz8aR
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so3057387eec.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782377; x=1793387177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0EQ3ibIMhY4x0aalZu3gEawsXsVraNakStLx592xKk=;
        b=tITRz8aRM+5mntOzyOIGYct/0aXbiyvU5KNugzAv0bfAL0SS6QUKnwpHTyVg+Wp26A
         bdJXtTKVgtlSFifz0CALwpFOPHP9tsgUWi9xMK60Fx+I+xYyH7VKuXFlWPnHTxuxBix6
         KZlP6FphfdzqmXOluEuG/ybcUAY+tgvFdaZGLC3rtz5BfoxexTISiIfKFU8YYDDmZzos
         xvCjffpJgO8xxbLI7+342jWsSHblm8S2U6I/Jyu+U2XWun1u6qA3lCXlFiIF/rm/jYL4
         u0xB6kH3ItpREmRKPXU2N6isrcdM4IxPYGiIKN1uE5IyQi89WFi/a91E/l3yGzN+J7j6
         JjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782377; x=1793387177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0EQ3ibIMhY4x0aalZu3gEawsXsVraNakStLx592xKk=;
        b=NwxtncRSe7sWMleDAPKBN7+eIW4mrL5fsYe9x6DZRIclTnVbUIcd2zF4nEs0YPkTKJ
         954GdbfMBU1yGFgl16S+Ga0+1ECJmE9eQ6qZFN3i/Uex8yC1dN7SLep2mF/litEUBFwn
         Sa4l8CAzqV1PF+kY8cJ9RKOwVy5kxMy/vwVFQXO6NU2imeGXYJVPXjDn7UlohM/68tml
         HbNApvP9Ar/9GX2TBcbIkhbaGVgqEbG2PHFv6skqPBvfWK4UF7AsmEvfYU5ERITpyKHL
         hEAgyBmtj1BKkKnhLqBEgFvazGxknoKQ1PoES0pOfyPIE6jUk2MbV8hp4osF0Z7GS0il
         gQOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzizltJ2bbmf+c86Xv0u1UFC9S9LgPc86QvPdleVmUPt52n3k+rFvYTagQG4cBrrTwbXQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrBO68Mi3tlAkn2GbXyQNGIJn4blNqD2eftOyqfrx/Y8E0n7+q
	VPZTqyKarx9W1AlwrkY/bvL2QoQxqcuS5L9ASPi2o82Ek3CMuyIAvTfOQDKpzcVbUYr7ItF+upC
	RpSNKOYBINg==
X-Received: from dybmb8.prod.google.com ([2002:a05:7301:1908:b0:358:8b14:a837])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1525:b0:369:a113:756f
 with SMTP id 5a478bee46e88-369e850d487mr265978eec.34.1792782376436; Fri, 23
 Oct 2026 12:06:16 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:54 -0700
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
Message-ID: <20261023190558.3050796-8-irogers@google.com>
Subject: [PATCH v7 07/11] perf bpf-filter: Support per-process and semi-global
 locks in lock_held()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the lock_held() BPF sample filter to support well-known
per-process and semi-global kernel locks:
- mmap_lock (or mmap_sem): current->mm->mmap_lock, supporting both
  read/shared (lock_held_read(mmap_lock) / lock_held(mmap_lock:R)) and
  write/exclusive (lock_held_write(mmap_lock) / lock_held(mmap_lock:W))
  modes. Write ownership is inspected directly via is_rwsem_writer_owner()
  without attaching fentry/fexit hooks.
- siglock: current->sighand->siglock.
- rq_lock: per-CPU scheduler runqueue locks.
- zone_lock: memory management NUMA zone locks.

For rq_lock and zone_lock, reuse do_collect_lock_syms() from lock_data.h
via a raw_tp/bpf_test_finish program run at filter setup time to
populate the lock_syms map with each CPU's rq_lock and each NUMA node's
zone_lock addresses.

Only zone_lock needs NUMA zone data from kallsyms and sysfs, so fail filter
setup if it can't be found rather than attaching a filter that can never
match.

Example usage:

  # perf record -a -g -e cycles --filter 'lock_held(mmap_lock)' \
      -- perf bench mem mmap -t 2 -l 100
  # perf record -a -g -e cycles --filter 'lock_held_read(mmap_lock)' ...
  # perf record -a -g -e cycles --filter 'lock_held_write(mmap_lock)' ...
  # perf record -a -g -e cycles --filter 'lock_held(mmap_lock:W)' ...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |  24 ++-
 tools/perf/util/bpf-filter.c                 | 194 +++++++++++++++++--
 tools/perf/util/bpf_skel/sample-filter.h     |  18 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  67 +++++++
 4 files changed, 277 insertions(+), 26 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d603820b51c9..1c65f90dfb6b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -225,13 +225,15 @@ OPTIONS
 	holding and exclusive/write holding, use 'lock_held_read(<lock>)'
 	(alias 'lock_held_shared(<lock>)') or 'lock_held_write(<lock>)'
 	(alias 'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to
-	<lock> (e.g. 'lock_held(rwsem:R)' or 'lock_held(rwsem:W)').
+	<lock> (e.g. 'lock_held(mmap_lock:R)' or 'lock_held(mmap_lock:W)').
 	<lock> can be a kernel lock symbol name (e.g.
-	'lock_held(cgroup_mutex)'), a hexadecimal lock address, or a lock type
-	('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
+	'lock_held(cgroup_mutex)'), a hexadecimal lock address, a well-known
+	lock name ('mmap_lock', 'siglock', 'rq_lock', 'zone_lock'), or a lock
+	type ('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
 	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
 	'semaphore').  Both read/shared and write/exclusive tracking are
-	supported for 'rwsem' and 'rwlock'; 'mutex', 'spinlock', 'rt-mutex',
+	supported for 'rwsem' (including 'mmap_lock') and 'rwlock'; 'mutex',
+	'spinlock' (including 'siglock', 'rq_lock', 'zone_lock'), 'rt-mutex',
 	'semaphore', and 'percpu-rwsem' ('percpu_down_write()') support
 	write/exclusive tracking only.  Note that 'semaphore' tracking
 	('down*()' / 'up()') assumes binary mutex-like usage where the
@@ -251,8 +253,9 @@ OPTIONS
 	  # perf record -a -g -e major-faults \
 	      --filter 'lock_held(mutex) || lock_held(rwsem)'
 
-	When filtering on a specific mutex symbol ('*_mutex') or rt-mutex
-	symbol ('*_rt_mutex'), 'perf_sample_filter' inspects the lock's
+	When filtering on a specific mutex symbol ('*_mutex'), rt-mutex symbol
+	('*_rt_mutex'), or write-locked 'mmap_lock' ('lock_held_write(mmap_lock)'
+	or 'lock_held(mmap_lock:W)'), 'perf_sample_filter' inspects the lock's
 	'owner' field directly in kernel memory on each sample without attaching
 	any BPF fentry/fexit hooks.  For locks that do not maintain an
 	authoritative per-task owner pointer (such as spinlocks, rwlocks,
@@ -261,10 +264,11 @@ OPTIONS
 	to track held locks in a BPF map.  These BPF hooks run on every kernel
 	lock acquisition and release for the attached lock family, even when no
 	perf sample is being taken.  To minimize this overhead, only the hooks
-	for the relevant lock family and mode are attached when known, whereas
-	raw hex addresses or symbols without a recognizable lock-type suffix
-	attach hooks across all lock families (including high-frequency
-	spinlocks).
+	for the relevant lock family and mode are attached when known (for
+	example, 'lock_held_read(mmap_lock)' only hooks rwsem read functions
+	and 'rq_lock' only hooks spinlock functions), whereas raw hex addresses
+	or symbols without a recognizable lock-type suffix attach hooks across
+	all lock families (including high-frequency spinlocks).
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 91fa9f97b639..7b92cd1bf8a8 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -557,6 +557,69 @@ static bool parse_lock_hex_addr(const char *str, u64 *addr)
 	return true;
 }
 
+/*
+ * Set up the NUMA zone parameters used by collect_lock_syms() to find each
+ * zone's lock for lock_held(zone_lock). Returns a negative error if they
+ * can't be determined, as the filter could then never match.
+ */
+static int init_numa_data(struct sample_filter_bpf *skel, struct btf *btf)
+{
+	u64 addr = 0;
+	char *buf = NULL, *p;
+	size_t len;
+	long last = -1;
+	int ret;
+
+	ret = btf ? btf__find_by_name_kind(btf, "zone", BTF_KIND_STRUCT) : -ENOENT;
+	if (ret >= 0)
+		ret = btf__resolve_size(btf, ret);
+	if (ret <= 0) {
+		pr_err("Error: lock_held(zone_lock) requires struct zone in kernel BTF\n");
+		return -EOPNOTSUPP;
+	}
+	skel->rodata->sizeof_zone = ret;
+
+	/* !CONFIG_NUMA kernels have a single contig_page_data. */
+	ret = find_kernel_lock_sym("contig_page_data", &addr);
+	if (ret == 0) {
+		skel->rodata->contig_page_data_addr = addr;
+		return 0;
+	}
+	if (ret != -ENOENT)
+		return ret;
+
+	ret = find_kernel_lock_sym("node_data", &addr);
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			pr_err("Error: Cannot resolve contig_page_data or node_data for lock_held(zone_lock)\n");
+		return ret;
+	}
+	skel->rodata->node_data_addr = addr;
+
+	if (sysfs__read_str("devices/system/node/online", &buf, &len) < 0) {
+		pr_err("Error: Cannot read online NUMA nodes for lock_held(zone_lock)\n");
+		return -ENOENT;
+	}
+	p = buf;
+	while (p && *p) {
+		char *end;
+
+		last = strtol(p, &end, 0);
+		if (end == p)
+			break;
+		p = end;
+		if (*p == ',' || *p == '-' || *p == '\n')
+			p++;
+	}
+	free(buf);
+	if (last < 0) {
+		pr_err("Error: Cannot parse online NUMA nodes for lock_held(zone_lock)\n");
+		return -EINVAL;
+	}
+	skel->rodata->nr_nodes = last + 1;
+	return 0;
+}
+
 static bool btf_has_func(struct btf *btf, const char *name)
 {
 	return btf && name && btf__find_by_name_kind(btf, name, BTF_KIND_FUNC) > 0;
@@ -630,7 +693,7 @@ static unsigned int supported_lock_prog_groups(struct btf *btf)
 static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
 				unsigned int needed_groups,
 				unsigned int required_groups,
-				bool is_tracepoint)
+				bool needs_lock_syms, bool is_tracepoint)
 {
 	unsigned int supported_groups = supported_lock_prog_groups(btf);
 	unsigned int enabled_progs = 0;
@@ -665,6 +728,8 @@ static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
 		bpf_program__set_autoload(prog, enable);
 	}
 
+	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_syms);
+
 	if (needed_groups && !enabled_progs) {
 		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
 		return -ENOTSUP;
@@ -804,7 +869,9 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 				  struct btf **btf,
 				  bool *has_lock_filter,
 				  unsigned int *prog_groups,
-				  unsigned int *required_groups)
+				  unsigned int *required_groups,
+				  bool *needs_lock_syms,
+				  bool *needs_zone_data)
 {
 	char base[128];
 	bool has_amp;
@@ -825,6 +892,32 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 				 sizeof(base), &has_amp, &mode) < 0 || has_amp)
 		return;
 
+	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
+		/*
+		 * Write ownership of mm->mmap_lock is inspected directly via
+		 * is_rwsem_writer_owner() without tracing hooks; only reader
+		 * tracking requires LOCK_PROG_RWSEM_READ.
+		 */
+		if (mode & PBF_LOCK_MODE_READ) {
+			*prog_groups |= LOCK_PROG_RWSEM_READ;
+			*required_groups |= LOCK_PROG_RWSEM_READ;
+		}
+		return;
+	}
+	if (!strcmp(base, "siglock")) {
+		*prog_groups |= LOCK_PROG_SPIN;
+		*required_groups |= LOCK_PROG_SPIN;
+		return;
+	}
+	if (!strcmp(base, "rq_lock") || !strcmp(base, "zone_lock")) {
+		*prog_groups |= LOCK_PROG_SPIN;
+		*required_groups |= LOCK_PROG_SPIN;
+		*needs_lock_syms = true;
+		/* Only zone_lock needs NUMA zone data from kallsyms/sysfs. */
+		if (!strcmp(base, "zone_lock"))
+			*needs_zone_data = true;
+		return;
+	}
 	if (parse_lock_type_name(base, mode, NULL, NULL, &groups)) {
 		*prog_groups |= groups;
 		*required_groups |= groups;
@@ -893,7 +986,9 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 static void prescan_lock_filters(struct evsel *evsel, struct btf **btf,
 				 bool *has_lock_filter,
 				 unsigned int *prog_groups,
-				 unsigned int *required_groups)
+				 unsigned int *required_groups,
+				 bool *needs_lock_syms,
+				 bool *needs_zone_data)
 {
 	struct perf_bpf_filter_expr *expr, *group;
 
@@ -901,14 +996,18 @@ static void prescan_lock_filters(struct evsel *evsel, struct btf **btf,
 	*has_lock_filter = false;
 	*prog_groups = 0;
 	*required_groups = 0;
+	*needs_lock_syms = false;
+	*needs_zone_data = false;
 
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
 		prescan_one_lock_expr(expr, btf, has_lock_filter, prog_groups,
-				      required_groups);
+				      required_groups, needs_lock_syms,
+				      needs_zone_data);
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
 			list_for_each_entry(group, &expr->groups, list) {
 				prescan_one_lock_expr(group, btf, has_lock_filter,
-						      prog_groups, required_groups);
+						      prog_groups, required_groups,
+						      needs_lock_syms, needs_zone_data);
 			}
 		}
 	}
@@ -985,10 +1084,12 @@ static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
  * and populate the corresponding BPF filter maps and BSS control flags.
  *
  * Resolution order:
- * 1. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
+ * 1. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
+ *    `rq_lock`, `zone_lock`.
+ * 2. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
  *    `rwlock`, `percpu-rwsem`, `semaphore`, etc.
- * 2. Hexadecimal lock address.
- * 3. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
+ * 3. Hexadecimal lock address.
+ * 4. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
  */
 static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 			     struct perf_bpf_filter_expr *expr,
@@ -1012,6 +1113,53 @@ static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 		return -EINVAL;
 	}
 
+	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
+		entry->part = PBF_LOCK_MMAP | mode;
+		entry->value = 0;
+		if (skel && (mode & PBF_LOCK_MODE_READ))
+			skel->bss->has_mmap_lock = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "siglock")) {
+		if (!(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
+		}
+		entry->part = PBF_LOCK_SIGHAND | mode;
+		entry->value = 0;
+		if (skel)
+			skel->bss->has_siglock = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "rq_lock")) {
+		if (!(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
+		}
+		entry->part = PBF_LOCK_CLASS | mode;
+		entry->value = LOCK_CLASS_RQLOCK;
+		if (skel)
+			skel->bss->has_lock_class = 1;
+		return 0;
+	}
+
+	if (!strcmp(base, "zone_lock")) {
+		if (!(mode & PBF_LOCK_MODE_WRITE)) {
+			pr_err("Error: Lock '%s' is exclusive and does not support read/shared mode\n",
+			       name);
+			return -EINVAL;
+		}
+		entry->part = PBF_LOCK_CLASS | mode;
+		entry->value = LOCK_CLASS_ZONE_LOCK;
+		if (skel)
+			skel->bss->has_lock_class = 1;
+		return 0;
+	}
+
 	if (parse_lock_type_name(base, mode, skel, &encoded_pair, NULL)) {
 		entry->part = PBF_LOCK_TYPE | mode;
 		entry->value = encoded_pair;
@@ -1377,7 +1525,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
 	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
-	bool has_lock_filter = false;
+	bool has_lock_filter = false, needs_lock_syms = false, needs_zone_data = false;
 	unsigned int prog_groups = 0, required_groups = 0;
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
@@ -1385,7 +1533,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		return -1;
 
 	prescan_lock_filters(evsel, &btf, &has_lock_filter, &prog_groups,
-			     &required_groups);
+			     &required_groups, &needs_lock_syms, &needs_zone_data);
 
 	if ((has_lock_filter || is_tracepoint) && geteuid() != 0 &&
 	    !perf_cap__capable(CAP_BPF)) {
@@ -1449,12 +1597,19 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	if (has_lock_filter) {
 		bpf_map__set_max_entries(skel->maps.held_locks, MAX_ENTRIES);
 		bpf_map__set_max_entries(skel->maps.lock_addr_filter, MAX_FILTERS);
+		if (needs_lock_syms)
+			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
+		if (needs_zone_data) {
+			ret = init_numa_data(skel, btf);
+			if (ret < 0)
+				goto err;
+		}
 		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
-					   is_tracepoint);
+					   needs_lock_syms, is_tracepoint);
 		if (ret < 0)
 			goto err;
 	} else {
-		configure_lock_progs(skel, NULL, 0, 0, is_tracepoint);
+		configure_lock_progs(skel, NULL, 0, 0, false, is_tracepoint);
 	}
 
 	if (sample_filter_bpf__load(skel) < 0) {
@@ -1470,8 +1625,19 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	}
 
 	if (has_lock_filter) {
+		if (needs_lock_syms && skel->bss->has_lock_class) {
+			DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts);
+			int prog_fd = bpf_program__fd(skel->progs.collect_lock_syms);
+
+			ret = bpf_prog_test_run_opts(prog_fd, &opts);
+			if (ret < 0) {
+				pr_err("Failed to collect kernel lock symbols\n");
+				goto err;
+			}
+		}
 		bpf_program__set_autoattach(skel->progs.perf_sample_filter, false);
 		bpf_program__set_autoattach(skel->progs.perf_tp_sample_filter, false);
+		bpf_program__set_autoattach(skel->progs.collect_lock_syms, false);
 
 		ret = sample_filter_bpf__attach(skel);
 		if (ret < 0) {
@@ -1754,7 +1920,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	configure_lock_progs(skel, NULL, 0, 0, false);
+	configure_lock_progs(skel, NULL, 0, 0, false, false);
 
 	/* pinned program will use pid-hash */
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
@@ -1851,7 +2017,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	configure_lock_progs(skel, NULL, 0, 0, false);
+	configure_lock_progs(skel, NULL, 0, 0, false, false);
 	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index c240eee782f8..836b398dc62b 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -59,8 +59,8 @@ enum perf_bpf_filter_term {
 	 * The lock specification kind is stored in `entry.part`
 	 * (`enum perf_bpf_lock_target_kind`), `entry.op` is normalized to
 	 * `PBF_OP_EQ` (match when held) or `PBF_OP_NEQ` (match when not held),
-	 * and the resolved target address or type flag encoding is stored in
-	 * `entry.value`.
+	 * and the resolved target address, class ID, or type flag encoding is
+	 * stored in `entry.value`.
 	 */
 	PBF_TERM_LOCK_HELD,
 };
@@ -76,6 +76,20 @@ enum perf_bpf_lock_target_kind {
 	 * given as a hex address). `entry.value` holds the kernel address.
 	 */
 	PBF_LOCK_ADDR,
+	/*
+	 * Per-process `current->mm->mmap_lock` (or `mmap_sem`).
+	 */
+	PBF_LOCK_MMAP,
+	/*
+	 * Per-process `current->sighand->siglock`.
+	 */
+	PBF_LOCK_SIGHAND,
+	/*
+	 * Semi-global lock class (`rq_lock` or `zone_lock`).
+	 * `entry.value` holds `enum lock_class_sym` (LOCK_CLASS_RQLOCK or
+	 * LOCK_CLASS_ZONE_LOCK).
+	 */
+	PBF_LOCK_CLASS,
 	/*
 	 * Lock type filter (`mutex`, `spinlock`, `rwsem`, `rwsem:R`, etc.).
 	 * `entry.value` packs up to two `LCB_F_*` flag combinations in the
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index e527fbaf8a46..2087fb05e4c7 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -104,12 +104,27 @@ struct {
 	__uint(max_entries, 1);
 } lock_addr_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 1);
+} lock_syms SEC(".maps");
+
 volatile const int use_idx_hash;
 
+const volatile __u64 contig_page_data_addr;
+const volatile __u64 node_data_addr;
+const volatile int nr_nodes;
+const volatile int sizeof_zone;
+
 /* Control flags set by userspace when lock_held(...) filters are active. */
 int lock_enabled;
 int has_lock_addr;
+int has_lock_class;
 int has_lock_type;
+int has_mmap_lock;
+int has_siglock;
 int track_rwsem_read;
 __u8 lock_type_filter[LCB_F_TYPE_MAX];
 
@@ -226,6 +241,24 @@ static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
 			return true;
 		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id) != 0;
 
+	case PBF_LOCK_MMAP:
+		lock_addr = get_current_mmap_lock(curr);
+		if (!lock_addr)
+			return false;
+		if ((mode & PBF_LOCK_MODE_WRITE) &&
+		    is_rwsem_writer_owner(lock_addr, curr))
+			return true;
+		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id) != 0;
+
+	case PBF_LOCK_SIGHAND:
+		lock_addr = get_current_siglock(curr);
+		if (!lock_addr)
+			return false;
+		return is_lock_in_map(lock_addr, PBF_LOCK_ADDR, mode, pid, cpu_id) != 0;
+
+	case PBF_LOCK_CLASS:
+		return is_lock_in_map(entry->value, PBF_LOCK_CLASS, mode, pid, cpu_id) != 0;
+
 	case PBF_LOCK_TYPE:
 		return is_lock_type_in_map(entry->value, mode, pid, cpu_id) != 0;
 
@@ -663,6 +696,7 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 	struct held_lock_val *existing;
 	bool matched = false;
 	bool is_read = (flags & LCB_F_READ) != 0;
+	__u32 class_id = 0;
 	__u32 type_flag = flags & LCB_F_TYPE_MASK;
 	bool match_type = false;
 
@@ -672,6 +706,23 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 	if (has_lock_addr && bpf_map_lookup_elem(&lock_addr_filter, &lock_addr))
 		matched = true;
 
+	if (has_mmap_lock || has_siglock) {
+		__u32 ltype = check_lock_type(lock_addr, type_flag);
+
+		if ((has_mmap_lock && ltype == LCD_F_MMAP_LOCK) ||
+		    (has_siglock && ltype == LCD_F_SIGHAND_LOCK))
+			matched = true;
+	}
+
+	if (has_lock_class && type_flag == LCB_F_SPIN) {
+		__u32 *cid = bpf_map_lookup_elem(&lock_syms, &lock_addr);
+
+		if (cid) {
+			class_id = *cid;
+			matched = true;
+		}
+	}
+
 	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag]) {
 		match_type = true;
 		matched = true;
@@ -716,6 +767,8 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 			return 0;
 	}
 
+	if (class_id)
+		update_held_lock_count(class_id, owner_id, PBF_LOCK_CLASS, type_flag, true);
 	if (match_type)
 		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, type_flag, true);
 
@@ -764,6 +817,13 @@ static __always_inline int record_lock_released_addr(__u64 lock_addr, __u32 flag
 			existing->write_count = 0;
 	}
 
+	if (has_lock_class && flags == LCB_F_SPIN) {
+		__u32 *cid = bpf_map_lookup_elem(&lock_syms, &lock_addr);
+
+		if (cid)
+			update_held_lock_count(*cid, owner_id, PBF_LOCK_CLASS, flags, false);
+	}
+
 	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag])
 		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, flags, false);
 
@@ -1289,4 +1349,11 @@ int BPF_PROG(fentry_percpu_up_write, void *sem)
 	return record_lock_released(ctx, LCB_F_PERCPU | LCB_F_WRITE);
 }
 
+SEC("raw_tp/bpf_test_finish")
+int BPF_PROG(collect_lock_syms)
+{
+	return do_collect_lock_syms(&lock_syms, contig_page_data_addr,
+				    node_data_addr, nr_nodes, sizeof_zone);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.56.0.307.g5fe7bd680c-goog

