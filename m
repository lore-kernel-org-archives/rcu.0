Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782390;
	b=RQOuKnUy9SRlScnV3+DMlfpM8DUyotznqT6uZZHuFJ9zFGU+QSC6nRVfe8oQUPEnSybo
	 pfQbF+ui5OxZ7zcf5E3qM7+FUnTwWqdKQ/5Xc7rad6cyVI+OVnM/Wy4GjoyoG3DTifGkM
	 I1yV6rtTlHGPQqFIX5Fi3bQJArxpEU/KHPykklKJnQMTnJwLlUkcHzVd1sja1hNfhZaG2
	 oJ9aoYTh2UBsbcwlqPM53uz6liKz5H/kJqX8EFjdS1OlbUXf4vSVDzgWD/S9iZwYJj4om
	 JRQLkAfBC3lUHpfAdjQuqAkIqZet3KIXsMIeZq3lPRwkjH/8wRqNTXQF0kl4t4uj0Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=oLvIkwC2TcW0ua8f6McCb78YZLdm5GJNtqjRJHDe24s=;
	b=olX2T4xRnQSAJi7IpLUYsOH3YEo9SUk1WO9Vk03C4ZygiQLllvYLu6lBC/Uq3IynjqId
	 zu7lK57j3MAuE0hL9A7au3FITeWT+jWA7RXE9VfVunS6AF6Ocy9zPk6WFcD8RS7F+COdm
	 1aALpQF50EZvZQ69G4A0q2mrTZc1INWajpKE7ypDSQAhOerIzZIESmuUgOGLFqoFiLWeE
	 6+J/DYeu1r69nkB/rfwb3Nzfg3s6qe1py9HbJwtoKUgnU+N6MoCQOHWQR40xzcRh45cWh
	 KZFOpcVHnmVoRUfkZCHUmFdtAIqyQGqrjWDNCsumM9Rlny8rW1GxqriZwy5zHoFOudA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3760A260A
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F3760A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1665200f4c2so1625774c88.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782379; x=1793387179; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLvIkwC2TcW0ua8f6McCb78YZLdm5GJNtqjRJHDe24s=;
        b=NHqGmQamkOqgVBbZuy08hyywoeXE074BFPyLtt06CV6bylqim/ZKfI7Du+L067yn+p
         tXWTaOPNr2EV924dO0VMlSpIPPGrra7fEIB8RdxbG6aLR54rnspi5ArkqqkIDMqTG66v
         Mgwv7b7MxhQYAiCMxh+Ylv2PLL8Xy740J1UmGjdP7rmW6sOBppws/ju7tkLTCKi9vQzy
         xLdAOj8fkbVekWJROYoqp+SGzpXDEeR0VeI193ejPksmh4x2mtjYU4yw2OhL+oCvT3EN
         uDVZM8TXi7nYTYL3UaWRkkXnoiaZOXGXcyI8vqgLlyfSWPQ8nA1IMToQMj1ONZz1lA8E
         /NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782379; x=1793387179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLvIkwC2TcW0ua8f6McCb78YZLdm5GJNtqjRJHDe24s=;
        b=JzYeZCOlE6Roty1hsuH6Ssj6H5dNX6bnvuef8nrmQc1XIDAKYMLpqXjt88NDvwc/Q1
         EZPMJQBL5t2fr1VrpISkTSH/U6l47ngThI2oBVmblMtdxk2a7SRT6ufTWaE9ZD1ybRFf
         f1f8Hx6YPUGvXHBtCLqhQvQYqfx70Av2ogPHV/IwlZHePMLriBb9r3Nk+KthFl9DnRat
         4sPOy40GOI1vmv00w4BHChuwAzcB6XV0/ec7Y83bqwAoYrNMkzzurHzXuwOCf7ymAiWo
         HvyD/VVmx/AmlFxkKQAfKimBn3DRm6qylzAxY5w5AXmlzORlbn7ze6IAZu+7/ZiP9M+R
         wC7A==
X-Forwarded-Encrypted: i=1; AKwUvBwUjee9Roart/uGn54p/6+ssAdFdHBatx14cz7X4HPfhPOfUnYO2z9sf1/YI5MVIKmWQ/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJneAe6QcjN0Us6vYamJiqOxBjyIE/cQCrOMdoFBP1hhO4OdW6Q
	pFopoDAxMZexljj++/f8GkoFTjDL86STHDZCqYvGFBhGjf/Cz2pd2QPlpM2iSa5+ug5nDwRuX71
	c8W5fTOVsbA==
X-Received: from dldyr13-n1.prod.google.com ([2002:a05:701b:450d:10b0:197:f679:f62d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3a07:b0:14c:1f57:3e86
 with SMTP id a92af1059eb24-195c823b222mr4209148c88.47.1792782378230; Fri, 23
 Oct 2026 12:06:18 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:55 -0700
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
Message-ID: <20261023190558.3050796-9-irogers@google.com>
Subject: [PATCH v7 08/11] perf bpf-filter: Support slab cache locks (&<name>)
 in lock_held()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the lock_held() BPF sample filter to support dynamically
allocated kernel locks inside slab caches prefixed with '&' (e.g.
lock_held(&dentry), lock_held_read(&dentry), lock_held_write(&dentry)).

Reuse do_slab_cache_iter() from lock_data.h via a SEC("iter/kmem_cache")
program to resolve the requested slab cache name to its kernel
struct kmem_cache * address, and use the bpf_get_kmem_cache() kfunc in
record_lock_acquired_owner() and record_lock_released_addr() to match
held locks allocated from that slab cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     |  25 ++--
 tools/perf/util/bpf-filter.c                 | 124 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample-filter.h     |   5 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  48 +++++++
 4 files changed, 175 insertions(+), 27 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 1c65f90dfb6b..8a160317304a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -227,13 +227,15 @@ OPTIONS
 	(alias 'lock_held_exclusive(<lock>)'), or append ':R' or ':W' to
 	<lock> (e.g. 'lock_held(mmap_lock:R)' or 'lock_held(mmap_lock:W)').
 	<lock> can be a kernel lock symbol name (e.g.
-	'lock_held(cgroup_mutex)'), a hexadecimal lock address, a well-known
-	lock name ('mmap_lock', 'siglock', 'rq_lock', 'zone_lock'), or a lock
-	type ('mutex', 'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock',
-	'rwlock:R', 'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W',
-	'semaphore').  Both read/shared and write/exclusive tracking are
-	supported for 'rwsem' (including 'mmap_lock') and 'rwlock'; 'mutex',
-	'spinlock' (including 'siglock', 'rq_lock', 'zone_lock'), 'rt-mutex',
+	'lock_held(cgroup_mutex)'), a hexadecimal lock address, a slab cache
+	name prefixed with '&' (e.g. 'lock_held(&dentry)',
+	'lock_held_read(&dentry)'), a well-known lock name ('mmap_lock',
+	'siglock', 'rq_lock', 'zone_lock'), or a lock type ('mutex',
+	'spinlock', 'rwsem', 'rwsem:R', 'rwsem:W', 'rwlock', 'rwlock:R',
+	'rwlock:W', 'rt-mutex', 'percpu-rwsem', 'pcpu-sem:W', 'semaphore').
+	Both read/shared and write/exclusive tracking are supported for
+	'rwsem' (including 'mmap_lock') and 'rwlock'; 'mutex', 'spinlock'
+	(including 'siglock', 'rq_lock', 'zone_lock'), 'rt-mutex',
 	'semaphore', and 'percpu-rwsem' ('percpu_down_write()') support
 	write/exclusive tracking only.  Note that 'semaphore' tracking
 	('down*()' / 'up()') assumes binary mutex-like usage where the
@@ -259,16 +261,17 @@ OPTIONS
 	'owner' field directly in kernel memory on each sample without attaching
 	any BPF fentry/fexit hooks.  For locks that do not maintain an
 	authoritative per-task owner pointer (such as spinlocks, rwlocks,
-	semaphores, reader-locked rwsems, and lock type filters), it attaches
+	semaphores, reader-locked rwsems, and slab/type filters), it attaches
 	BPF fentry/fexit programs to kernel lock acquire and release functions
 	to track held locks in a BPF map.  These BPF hooks run on every kernel
 	lock acquisition and release for the attached lock family, even when no
 	perf sample is being taken.  To minimize this overhead, only the hooks
 	for the relevant lock family and mode are attached when known (for
 	example, 'lock_held_read(mmap_lock)' only hooks rwsem read functions
-	and 'rq_lock' only hooks spinlock functions), whereas raw hex addresses
-	or symbols without a recognizable lock-type suffix attach hooks across
-	all lock families (including high-frequency spinlocks).
+	and 'rq_lock' only hooks spinlock functions), whereas slab filters
+	('&<slab>'), raw hex addresses, or symbols without a recognizable
+	lock-type suffix attach hooks across all lock families (including
+	high-frequency spinlocks).
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 7b92cd1bf8a8..97296b65709f 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -693,10 +693,14 @@ static unsigned int supported_lock_prog_groups(struct btf *btf)
 static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
 				unsigned int needed_groups,
 				unsigned int required_groups,
-				bool needs_lock_syms, bool is_tracepoint)
+				bool needs_lock_syms, bool needs_slab_iter,
+				bool is_tracepoint)
 {
 	unsigned int supported_groups = supported_lock_prog_groups(btf);
 	unsigned int enabled_progs = 0;
+	bool has_slab_iter = needs_slab_iter && btf &&
+			     btf__find_by_name_kind(btf, "bpf_iter__kmem_cache",
+						    BTF_KIND_STRUCT) > 0;
 
 	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
 	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
@@ -729,6 +733,7 @@ static int configure_lock_progs(struct sample_filter_bpf *skel, struct btf *btf,
 	}
 
 	bpf_program__set_autoload(skel->progs.collect_lock_syms, needs_lock_syms);
+	bpf_program__set_autoload(skel->progs.slab_cache_iter, has_slab_iter);
 
 	if (needed_groups && !enabled_progs) {
 		pr_err("Error: Kernel BTF lacks required lock tracing entry points\n");
@@ -871,7 +876,8 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 				  unsigned int *prog_groups,
 				  unsigned int *required_groups,
 				  bool *needs_lock_syms,
-				  bool *needs_zone_data)
+				  bool *needs_zone_data,
+				  bool *needs_slab_iter)
 {
 	char base[128];
 	bool has_amp;
@@ -889,9 +895,16 @@ static void prescan_one_lock_expr(struct perf_bpf_filter_expr *expr,
 			*btf = NULL;
 	}
 	if (split_lock_name_mode(expr->lock_name, expr->part, base,
-				 sizeof(base), &has_amp, &mode) < 0 || has_amp)
+				 sizeof(base), &has_amp, &mode) < 0)
 		return;
 
+	/* Leading '&' is reserved for slab cache locks (e.g. '&dentry'). */
+	if (has_amp) {
+		*needs_slab_iter = true;
+		*prog_groups |= LOCK_PROG_ALL;
+		return;
+	}
+
 	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
 		/*
 		 * Write ownership of mm->mmap_lock is inspected directly via
@@ -988,7 +1001,8 @@ static void prescan_lock_filters(struct evsel *evsel, struct btf **btf,
 				 unsigned int *prog_groups,
 				 unsigned int *required_groups,
 				 bool *needs_lock_syms,
-				 bool *needs_zone_data)
+				 bool *needs_zone_data,
+				 bool *needs_slab_iter)
 {
 	struct perf_bpf_filter_expr *expr, *group;
 
@@ -998,21 +1012,73 @@ static void prescan_lock_filters(struct evsel *evsel, struct btf **btf,
 	*required_groups = 0;
 	*needs_lock_syms = false;
 	*needs_zone_data = false;
+	*needs_slab_iter = false;
 
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
 		prescan_one_lock_expr(expr, btf, has_lock_filter, prog_groups,
 				      required_groups, needs_lock_syms,
-				      needs_zone_data);
+				      needs_zone_data, needs_slab_iter);
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
 			list_for_each_entry(group, &expr->groups, list) {
 				prescan_one_lock_expr(group, btf, has_lock_filter,
 						      prog_groups, required_groups,
-						      needs_lock_syms, needs_zone_data);
+						      needs_lock_syms, needs_zone_data,
+						      needs_slab_iter);
 			}
 		}
 	}
 }
 
+static void run_slab_cache_iter(struct sample_filter_bpf *skel)
+{
+	struct bpf_link *link;
+	int fd;
+	char buf[256];
+
+	if (!bpf_program__autoload(skel->progs.slab_cache_iter))
+		return;
+
+	link = bpf_program__attach_iter(skel->progs.slab_cache_iter, NULL);
+	if (!link || IS_ERR(link)) {
+		pr_debug("cannot attach slab cache iter\n");
+		return;
+	}
+
+	fd = bpf_iter_create(bpf_link__fd(link));
+	if (fd >= 0) {
+		while (read(fd, buf, sizeof(buf)) > 0)
+			continue;
+		close(fd);
+	}
+
+	bpf_link__destroy(link);
+}
+
+static bool find_slab_cache(struct sample_filter_bpf *skel, const char *name,
+			    u64 *kmem_cache_addr)
+{
+	int cache_fd;
+	u64 key, *prev_key = NULL;
+
+	if (!skel || !bpf_program__autoload(skel->progs.slab_cache_iter))
+		return false;
+
+	cache_fd = bpf_map__fd(skel->maps.slab_caches);
+	while (!bpf_map_get_next_key(cache_fd, prev_key, &key)) {
+		struct slab_cache_data data;
+
+		if (bpf_map_lookup_elem(cache_fd, &key, &data) < 0)
+			break;
+
+		if (!strcmp(data.name, name)) {
+			*kmem_cache_addr = key;
+			return true;
+		}
+		prev_key = &key;
+	}
+	return false;
+}
+
 static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
 				  enum perf_bpf_filter_op *op_out)
 {
@@ -1084,12 +1150,13 @@ static int normalize_lock_expr_op(const struct perf_bpf_filter_expr *expr,
  * and populate the corresponding BPF filter maps and BSS control flags.
  *
  * Resolution order:
- * 1. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
+ * 1. Slab cache name (when prefixed with '&', e.g. `&dentry`).
+ * 2. Well-known per-process / semi-global locks: `mmap_lock`, `siglock`,
  *    `rq_lock`, `zone_lock`.
- * 2. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
+ * 3. Lock types / flags: `mutex`, `spinlock`, `rwsem`, `rwsem:R`, `rwsem:W`,
  *    `rwlock`, `percpu-rwsem`, `semaphore`, etc.
- * 3. Hexadecimal lock address.
- * 4. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
+ * 4. Hexadecimal lock address.
+ * 5. Global/static kernel lock symbol in kallsyms (e.g. `cgroup_mutex`).
  */
 static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 			     struct perf_bpf_filter_expr *expr,
@@ -1108,11 +1175,25 @@ static int resolve_lock_expr(struct sample_filter_bpf *skel, struct btf *btf,
 		return ret;
 
 	if (split_lock_name_mode(name, expr->part, base, sizeof(base),
-				 &has_amp, &mode) < 0 || has_amp) {
+				 &has_amp, &mode) < 0) {
 		pr_err("Error: Invalid kernel lock filter '%s'\n", name ?: "");
 		return -EINVAL;
 	}
 
+	if (has_amp) {
+		if (find_slab_cache(skel, base, &addr)) {
+			int fd = bpf_map__fd(skel->maps.slab_filter);
+
+			entry->part = PBF_LOCK_SLAB | mode;
+			entry->value = addr;
+			bpf_map_update_elem(fd, &addr, &one, BPF_ANY);
+			skel->bss->has_lock_slab = 1;
+			return 0;
+		}
+		pr_err("Error: Cannot resolve slab cache '%s'\n", name);
+		return -EINVAL;
+	}
+
 	if (!strcmp(base, "mmap_lock") || !strcmp(base, "mmap_sem")) {
 		entry->part = PBF_LOCK_MMAP | mode;
 		entry->value = 0;
@@ -1526,6 +1607,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	bool needs_idx_hash = !target__has_cpu(target);
 	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
 	bool has_lock_filter = false, needs_lock_syms = false, needs_zone_data = false;
+	bool needs_slab_iter = false;
 	unsigned int prog_groups = 0, required_groups = 0;
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
@@ -1533,7 +1615,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		return -1;
 
 	prescan_lock_filters(evsel, &btf, &has_lock_filter, &prog_groups,
-			     &required_groups, &needs_lock_syms, &needs_zone_data);
+			     &required_groups, &needs_lock_syms, &needs_zone_data,
+			     &needs_slab_iter);
 
 	if ((has_lock_filter || is_tracepoint) && geteuid() != 0 &&
 	    !perf_cap__capable(CAP_BPF)) {
@@ -1597,6 +1680,10 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	if (has_lock_filter) {
 		bpf_map__set_max_entries(skel->maps.held_locks, MAX_ENTRIES);
 		bpf_map__set_max_entries(skel->maps.lock_addr_filter, MAX_FILTERS);
+		if (needs_slab_iter) {
+			bpf_map__set_max_entries(skel->maps.slab_filter, MAX_FILTERS);
+			bpf_map__set_max_entries(skel->maps.slab_caches, MAX_ENTRIES);
+		}
 		if (needs_lock_syms)
 			bpf_map__set_max_entries(skel->maps.lock_syms, MAX_ENTRIES);
 		if (needs_zone_data) {
@@ -1605,11 +1692,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 				goto err;
 		}
 		ret = configure_lock_progs(skel, btf, prog_groups, required_groups,
-					   needs_lock_syms, is_tracepoint);
+					   needs_lock_syms, needs_slab_iter,
+					   is_tracepoint);
 		if (ret < 0)
 			goto err;
 	} else {
-		configure_lock_progs(skel, NULL, 0, 0, false, is_tracepoint);
+		configure_lock_progs(skel, NULL, 0, 0, false, false, is_tracepoint);
 	}
 
 	if (sample_filter_bpf__load(skel) < 0) {
@@ -1618,6 +1706,9 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
+	if (has_lock_filter && needs_slab_iter)
+		run_slab_cache_iter(skel);
+
 	ret = get_filter_entries(evsel, skel, btf, entry);
 	if (ret < 0) {
 		pr_err("Failed to process filter entries\n");
@@ -1638,6 +1729,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		bpf_program__set_autoattach(skel->progs.perf_sample_filter, false);
 		bpf_program__set_autoattach(skel->progs.perf_tp_sample_filter, false);
 		bpf_program__set_autoattach(skel->progs.collect_lock_syms, false);
+		bpf_program__set_autoattach(skel->progs.slab_cache_iter, false);
 
 		ret = sample_filter_bpf__attach(skel);
 		if (ret < 0) {
@@ -1920,7 +2012,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	configure_lock_progs(skel, NULL, 0, 0, false, false);
+	configure_lock_progs(skel, NULL, 0, 0, false, false, false);
 
 	/* pinned program will use pid-hash */
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
@@ -2017,7 +2109,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	configure_lock_progs(skel, NULL, 0, 0, false, false);
+	configure_lock_progs(skel, NULL, 0, 0, false, false, false);
 	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 836b398dc62b..a65ee780d64d 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -76,6 +76,11 @@ enum perf_bpf_lock_target_kind {
 	 * given as a hex address). `entry.value` holds the kernel address.
 	 */
 	PBF_LOCK_ADDR,
+	/*
+	 * Dynamic lock allocated inside a slab cache (`&slab_name`).
+	 * `entry.value` holds the kernel `struct kmem_cache *` address.
+	 */
+	PBF_LOCK_SLAB,
 	/*
 	 * Per-process `current->mm->mmap_lock` (or `mmap_sem`).
 	 */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 2087fb05e4c7..d1192a93179e 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -111,6 +111,20 @@ struct {
 	__uint(max_entries, 1);
 } lock_syms SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} slab_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(struct slab_cache_data));
+	__uint(max_entries, 1);
+} slab_caches SEC(".maps");
+
 volatile const int use_idx_hash;
 
 const volatile __u64 contig_page_data_addr;
@@ -118,9 +132,12 @@ const volatile __u64 node_data_addr;
 const volatile int nr_nodes;
 const volatile int sizeof_zone;
 
+__u32 slab_cache_id;
+
 /* Control flags set by userspace when lock_held(...) filters are active. */
 int lock_enabled;
 int has_lock_addr;
+int has_lock_slab;
 int has_lock_class;
 int has_lock_type;
 int has_mmap_lock;
@@ -259,6 +276,9 @@ static __always_inline bool is_lock_held(struct perf_bpf_filter_entry *entry)
 	case PBF_LOCK_CLASS:
 		return is_lock_in_map(entry->value, PBF_LOCK_CLASS, mode, pid, cpu_id) != 0;
 
+	case PBF_LOCK_SLAB:
+		return is_lock_in_map(entry->value, PBF_LOCK_SLAB, mode, pid, cpu_id) != 0;
+
 	case PBF_LOCK_TYPE:
 		return is_lock_type_in_map(entry->value, mode, pid, cpu_id) != 0;
 
@@ -697,6 +717,7 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 	bool matched = false;
 	bool is_read = (flags & LCB_F_READ) != 0;
 	__u32 class_id = 0;
+	__u64 kmem_cache_addr = 0;
 	__u32 type_flag = flags & LCB_F_TYPE_MASK;
 	bool match_type = false;
 
@@ -723,6 +744,14 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 		}
 	}
 
+	if (has_lock_slab && bpf_get_kmem_cache) {
+		kmem_cache_addr = (__u64)bpf_get_kmem_cache(lock_addr);
+		if (kmem_cache_addr && bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr))
+			matched = true;
+		else
+			kmem_cache_addr = 0;
+	}
+
 	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag]) {
 		match_type = true;
 		matched = true;
@@ -769,6 +798,10 @@ static __always_inline int record_lock_acquired_owner(__u64 lock_addr, __u32 fla
 
 	if (class_id)
 		update_held_lock_count(class_id, owner_id, PBF_LOCK_CLASS, type_flag, true);
+	if (kmem_cache_addr) {
+		update_held_lock_count((__u64)kmem_cache_addr, owner_id,
+				       PBF_LOCK_SLAB, type_flag, true);
+	}
 	if (match_type)
 		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, type_flag, true);
 
@@ -824,6 +857,15 @@ static __always_inline int record_lock_released_addr(__u64 lock_addr, __u32 flag
 			update_held_lock_count(*cid, owner_id, PBF_LOCK_CLASS, flags, false);
 	}
 
+	if (has_lock_slab && bpf_get_kmem_cache) {
+		__u64 kmem_cache_addr = (__u64)bpf_get_kmem_cache(lock_addr);
+
+		if (kmem_cache_addr && bpf_map_lookup_elem(&slab_filter, &kmem_cache_addr)) {
+			update_held_lock_count(kmem_cache_addr, owner_id,
+					       PBF_LOCK_SLAB, flags, false);
+		}
+	}
+
 	if (has_lock_type && type_flag < LCB_F_TYPE_MAX && lock_type_filter[type_flag])
 		update_held_lock_count(type_flag, owner_id, PBF_LOCK_TYPE, flags, false);
 
@@ -1356,4 +1398,10 @@ int BPF_PROG(collect_lock_syms)
 				    node_data_addr, nr_nodes, sizeof_zone);
 }
 
+SEC("iter/kmem_cache")
+int slab_cache_iter(void *ctx)
+{
+	return do_slab_cache_iter(ctx, &slab_caches, &slab_cache_id);
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.56.0.307.g5fe7bd680c-goog

