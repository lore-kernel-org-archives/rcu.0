Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529962;
	b=c7jdIbagPBtRWM5OenVfn3mk+grbaVtwPxo6Kv9fFrfLGuAsRIwMZLI6jcymIPzPEVdq
	 ICRl6NfkqRGwLEnYFzMmVD4qQAPjhBqqngq5vOFxvbouw93bH7J+B/5vRr6GLFGh6O494
	 DTloPjSJxcBAn9KjWRBs7JQxVZMd9h5U90u+gDiIuehsRSShTYp2j6gMXA6S7arBc3bNM
	 GFT/1eIYwwIaIpBUKSQFOyiO8u1/w4LKmtZXWmE5l85bbbVvCEnJqV7aEiZ0Q8KdLrs/8
	 kWBK1mn/igosSdb/4M+X71jmnuExF9WYaB4ZXEKq46DqIsdD6aMeT5Ho1doEc705viQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/4Kk6tpPjZyFjGLUOvBYhvjpAFW7THOZSkBUkMQ7rFs=;
	b=hNbFqYNRA7d0ee++5qNCKPR3zcGqfmHVaEkuKXgJ3Lq537sq1u3Me1Ip+hgMD3YClh1V
	 ccpn/cKo6WBovnledI1aYp4Edfzic+BG1n54JJp8werQqiuo/xssj6SouEGX2+nA/KuuY
	 Feca6LzIHPJ10n+1DVRHQfNS61hiH+X54J60pRpgbAWCAb5ZxwvNuWQq3TzSmgLtONOIT
	 ZxlpH1gDWk/WUXPkRSO4sJLBt9NgmosF8J9bX/jJhy1N+cFxg3l4STvB8kWHIVeepsvSd
	 nwp/uzbOq5dBSYmFRBv08XqxTwKVPGup6HwxcNK+JqHWqR86QayllzqJusMa6aS8FAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mPOqQV9L;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78F606A32E
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 20:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB78F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mPOqQV9L
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso6829781eec.0
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792529961; x=1793134761; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4Kk6tpPjZyFjGLUOvBYhvjpAFW7THOZSkBUkMQ7rFs=;
        b=mPOqQV9LbrpBDkYas7MuoMwemuMFRc7bveIfXwAZTkKy+vvLXsfOeG/gDGkUpcN7Ay
         R4lhpmQT7+fyoRLsNJbqWyopmKOwgnZcAC03SRXOmMDJWIilt0Dq0OoTWl44d43kUFc9
         J1zOg6UsBEu7Qxt1Kg4KTFUD4lan/5D8OKLnOGUWNBVuInyVMGyjP+ugtdkqxsh9PlXS
         +h2vqu3Ue+vsP+2nojFXV3h9HYRbr8i0HfuIADL7xhw+mjnBlQQGHa+IToLbYvs8WIqp
         dTgLviduN86oUJxd/8yyGmY0yCTmcVkKVQf111o/kkY2ft4O2/U5Jd+kfVvcyYhgBuVF
         0IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529961; x=1793134761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4Kk6tpPjZyFjGLUOvBYhvjpAFW7THOZSkBUkMQ7rFs=;
        b=YEuD2WBeg3SXo7c+GdA1SRfH1XBbdDkotI7iAQaXwiCFDnOx3LHgqdefd/OfttfINv
         SC2eLq3/plhtxW7FfycHP7In5VvLgvo2vxJGukWqz+yEq67ZkEQxNIaqiRJ3SAQlIKUI
         Y8x6CJydLSucbLRoyPPW8vyWf6eyeq+yPfaklvHYaHDxQ1RFb0pJLcWaUVbOsUKtSpGb
         v6NU2MZi+gJ5wqIaKp1CI5chspVTYUlzacISFqfA5ypAfwjXXLdFmp6esIbiHZ7KJoA6
         WmB3NYKdv0WlFF51EKdbi1bAKDP0F8snx9cxRommtFvamBB+zbkhiL0m6zl8mA3U9Hbp
         ZhBw==
X-Forwarded-Encrypted: i=1; AKwUvBxfTgvX01+pvbMXuQxh++ug12NpeJ9fVK1w+j3wu2uScm6HOCL38BMz+MJOV+B3B4ccEhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeLHUJeFaZuMQWnh7xfy/j/fpM9lDNGLdPCfdSj/r4RD2MVCmx
	Kcj1sIU1PJ/09q+jDOAwY4v+0TfS4fOCcxoZU5ct8h87AXop7+EzKeQADqIbV6tcbzXXOsblz7d
	pDGlXF+VUXA==
X-Received: from dlbbz42.prod.google.com ([2002:a05:7022:23aa:b0:18c:1bcc:33e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2507:b0:14d:c53a:f6a0
 with SMTP id a92af1059eb24-190a4b2a37cmr39218c88.13.1792529960649; Tue, 20
 Oct 2026 13:59:20 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:53 -0700
In-Reply-To: <20261020205859.1080743-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019220915.3943592-1-irogers@google.com> <20261020205859.1080743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020205859.1080743-4-irogers@google.com>
Subject: [PATCH v5 3/8] perf bpf-filter: Support BPF sample filters on
 tracepoint events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
updated set_filter() to route non-tracepoint filter terms (such as uid
and gid) on PERF_TYPE_TRACEPOINT events to evsel->bpf_filters instead
of the ftrace tracepoint predicate filter.

However, in the kernel's __perf_event_set_bpf_prog()
(kernel/events/core.c), attaching a BPF program to a perf_event fd
branches on perf_event_is_tracing(event):
- Non-tracing events (hardware PMU, software events, breakpoints) call
  perf_event_set_bpf_handler(), which requires BPF_PROG_TYPE_PERF_EVENT
  (SEC("perf_event")).
- Tracepoint events (event->pmu == &perf_tracepoint) reject
  BPF_PROG_TYPE_PERF_EVENT with -EINVAL and instead require
  BPF_PROG_TYPE_TRACEPOINT (SEC("tracepoint")), which is attached to
  event->tp_event->prog_array and executed in
  perf_trace_run_bpf_submit() before perf_tp_event(), dropping the
  sample if the BPF program returns 0. Furthermore, the
  bpf_cast_to_kern_ctx() kfunc is only permitted in
  BPF_PROG_TYPE_PERF_EVENT programs.

Add SEC("tracepoint") int perf_tp_sample_filter(void *ctx) in
sample_filter.bpf.c to evaluate context-independent filter terms (uid,
gid, tid, cpu, time, cgroup) using BPF helpers without calling
bpf_cast_to_kern_ctx(). When preparing a BPF filter on a
PERF_TYPE_TRACEPOINT evsel, autoload perf_tp_sample_filter instead of
perf_sample_filter and attach it once to the shared trace_event_call.
Because returning 0 from a BPF_PROG_TYPE_TRACEPOINT program filters at
the shared trace_event_call->prog_array prior to perf_tp_event(),
tracepoint BPF filters are never pinned for unprivileged use and
require CAP_BPF or root privileges.

Because perf_bpf_filter__pin() and perf_bpf_filter__unpin() only load
perf_sample_filter and disable autoload on perf_tp_sample_filter,
libbpf's bpf_object__pin() and bpf_object__unpin() can no longer be used
directly (as bpf_object__pin_programs() and bpf_object__unpin_programs()
iterate over all programs in the object without checking autoload and
fail with -EINVAL when a program has not been loaded). Introduce
pin_filter_object() and unpin_filter_object() to pin/unpin the maps and
only the loaded perf_sample_filter program.

Before:
  # perf record -e kmem:mm_page_alloc --filter 'uid == 0' -- true
  libbpf: prog 'perf_sample_filter': failed to attach to perf_event FD 3: Invalid argument
  Failed to attach perf sample-filter program
  failed to set filter "BPF" on event kmem:mm_page_alloc with 22 (Invalid argument)

After:
  # perf record -e kmem:mm_page_alloc --filter 'uid == 0' -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data (42 samples) ]

Fixes: 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c                 | 132 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  95 +++++++++++++
 2 files changed, 208 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 1596b08fe4e6..ac0e7cf40f3a 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -123,15 +123,26 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 {
 	const struct perf_sample_info *info;
 
-	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
-	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
-		return 0;
-
 	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
 		/* Not dependent on the sample_type as computed from a BPF helper. */
 		return 0;
 	}
 
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+		if (expr->term == PBF_TERM_TID || expr->term == PBF_TERM_CPU ||
+		    expr->term == PBF_TERM_TIME || expr->term == PBF_TERM_CGROUP)
+			return 0;
+		if (expr->op != PBF_OP_GROUP_BEGIN) {
+			pr_err("Error: %s tracepoint event does not support BPF sample term %d\n",
+			       evsel__name(evsel), expr->term);
+			return -1;
+		}
+	}
+
+	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
+	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
+		return 0;
+
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
 
@@ -425,6 +436,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct sample_filter_bpf *skel = NULL;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
@@ -436,7 +448,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	if (needs_idx_hash && geteuid() != 0) {
+	if (is_tracepoint && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
+		pr_err("Error: Tracepoint BPF filter requires CAP_BPF capability\n");
+		ret = -EPERM;
+		goto err;
+	}
+
+	if (needs_idx_hash && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
 		int zero = 0;
 
 		/* The filters map is shared among other processes */
@@ -476,8 +494,17 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		return 0;
 	}
 
-	skel = sample_filter_bpf__open_and_load();
+	skel = sample_filter_bpf__open();
 	if (!skel) {
+		ret = -errno;
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
+	bpf_program__set_autoload(skel->progs.perf_sample_filter, !is_tracepoint);
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, is_tracepoint);
+
+	if (sample_filter_bpf__load(skel) < 0) {
 		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
 		goto err;
@@ -493,14 +520,32 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	fd = bpf_program__fd(skel->progs.perf_sample_filter);
-	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
-			if (ret < 0) {
-				ret = -errno;
-				pr_err("Failed to attach perf sample-filter program\n");
-				goto err;
+	if (is_tracepoint) {
+		/*
+		 * For PERF_TYPE_TRACEPOINT, PERF_EVENT_IOC_SET_BPF attaches the
+		 * BPF program to event->tp_event->prog_array on the shared
+		 * trace_event_call, which perf_trace_run_bpf_submit() executes
+		 * for all CPUs and tasks before iterating the per-CPU perf
+		 * events. Attach once on the first FD so tp_event->prog_array
+		 * does not get duplicate copies for each per-CPU FD.
+		 */
+		fd = bpf_program__fd(skel->progs.perf_tp_sample_filter);
+		ret = ioctl(FD(evsel, 0, 0), PERF_EVENT_IOC_SET_BPF, fd);
+		if (ret < 0) {
+			ret = -errno;
+			pr_err("Failed to attach perf tracepoint sample-filter program\n");
+			goto err;
+		}
+	} else {
+		fd = bpf_program__fd(skel->progs.perf_sample_filter);
+		for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+			for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+				ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
+				if (ret < 0) {
+					ret = -errno;
+					pr_err("Failed to attach perf sample-filter program\n");
+					goto err;
+				}
 			}
 		}
 	}
@@ -632,6 +677,45 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 	return ret;
 }
 
+static int pin_filter_object(struct sample_filter_bpf *skel, const char *path)
+{
+	char *prog_path = NULL;
+	int ret;
+
+	ret = bpf_object__pin_maps(skel->obj, path);
+	if (ret < 0)
+		return ret;
+
+	if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
+		bpf_object__unpin_maps(skel->obj, path);
+		return -ENOMEM;
+	}
+
+	ret = bpf_program__pin(skel->progs.perf_sample_filter, prog_path);
+	if (ret < 0)
+		bpf_object__unpin_maps(skel->obj, path);
+
+	free(prog_path);
+	return ret;
+}
+
+static int unpin_filter_object(struct sample_filter_bpf *skel, const char *path)
+{
+	char *prog_path = NULL;
+	int ret, map_ret;
+
+	if (asprintf(&prog_path, "%s/perf_sample_filter", path) < 0) {
+		bpf_object__unpin_maps(skel->obj, path);
+		return -ENOMEM;
+	}
+
+	ret = bpf_program__unpin(skel->progs.perf_sample_filter, prog_path);
+	free(prog_path);
+
+	map_ret = bpf_object__unpin_maps(skel->obj, path);
+	return ret < 0 ? ret : map_ret;
+}
+
 int perf_bpf_filter__pin(void)
 {
 	struct sample_filter_bpf *skel;
@@ -646,6 +730,7 @@ int perf_bpf_filter__pin(void)
 	}
 
 	/* pinned program will use pid-hash */
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
 	bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
@@ -665,7 +750,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	ret = bpf_object__pin(skel->obj, path);
+	ret = pin_filter_object(skel, path);
 	if (ret < 0) {
 		pr_err("Failed to pin BPF filter objects\n");
 		goto err;
@@ -674,8 +759,8 @@ int perf_bpf_filter__pin(void)
 	/* setup access permissions for the pinned objects */
 	dir_fd = open(path, O_PATH);
 	if (dir_fd < 0) {
-		bpf_object__unpin(skel->obj, path);
-		ret = dir_fd;
+		ret = -errno;
+		unpin_filter_object(skel, path);
 		goto err;
 	}
 
@@ -718,6 +803,8 @@ int perf_bpf_filter__pin(void)
 
 err_close:
 	close(dir_fd);
+	if (ret < 0)
+		unpin_filter_object(skel, path);
 
 err:
 	free(path);
@@ -731,13 +818,20 @@ int perf_bpf_filter__unpin(void)
 	char *path = NULL;
 	int ret = -1;
 
-	skel = sample_filter_bpf__open_and_load();
+	skel = sample_filter_bpf__open();
 	if (!skel) {
 		ret = -errno;
 		pr_err("Failed to open perf sample-filter BPF skeleton\n");
 		goto err;
 	}
 
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
+	if (sample_filter_bpf__load(skel) < 0) {
+		ret = -errno;
+		pr_err("Failed to load perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
 	if (asprintf(&path, "%s/fs/bpf/%s", sysfs__mountpoint(),
 		     PERF_BPF_FILTER_PIN_PATH) < 0) {
 		ret = -errno;
@@ -745,7 +839,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	ret = bpf_object__unpin(skel->obj, path);
+	ret = unpin_filter_object(skel, path);
 
 err:
 	free(path);
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index e5666d4c1722..a190374ed87a 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -192,6 +192,28 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	return 0;
 }
 
+static __always_inline __u64 perf_get_common_sample(struct perf_bpf_filter_entry *entry)
+{
+	switch (entry->term) {
+	case PBF_TERM_TID:
+		if (entry->part)
+			return bpf_get_current_pid_tgid() >> 32;
+		return (__u32)bpf_get_current_pid_tgid();
+	case PBF_TERM_CPU:
+		return bpf_get_smp_processor_id();
+	case PBF_TERM_TIME:
+		return bpf_ktime_get_ns();
+	case PBF_TERM_CGROUP:
+		return bpf_get_current_cgroup_id();
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
+	default:
+		return 0;
+	}
+}
+
 #define CHECK_RESULT(data, op, val)			\
 	if (!(data op val)) {				\
 		if (!in_group)				\
@@ -295,4 +317,77 @@ int perf_sample_filter(void *ctx)
 	return 0;
 }
 
+/*
+ * BPF program to be called for tracepoint perf events.
+ *
+ * For PERF_TYPE_TRACEPOINT events, the kernel's __perf_event_set_bpf_prog()
+ * rejects BPF_PROG_TYPE_PERF_EVENT and only accepts BPF_PROG_TYPE_TRACEPOINT,
+ * attaching the program to the shared trace_event_call->prog_array executed
+ * by perf_trace_run_bpf_submit() prior to perf_tp_event(). Because returning 0
+ * filters the event at trace_event_call->prog_array (affecting the
+ * trace_event_call globally while attached), tracepoint BPF filters are never
+ * pinned for unprivileged use and require CAP_BPF / root privileges.
+ */
+SEC("tracepoint")
+int perf_tp_sample_filter(void *ctx)
+{
+	struct perf_bpf_filter_entry *entry;
+	__u64 sample_data;
+	int in_group = 0;
+	int group_result = 0;
+	int i, k = 0;
+	int *losts;
+
+	entry = bpf_map_lookup_elem(&filters, &k);
+	if (entry == NULL)
+		goto drop;
+
+	for (i = 0; i < MAX_FILTERS; i++) {
+		sample_data = perf_get_common_sample(&entry[i]);
+
+		switch (entry[i].op) {
+		case PBF_OP_EQ:
+			CHECK_RESULT(sample_data, ==, entry[i].value)
+			break;
+		case PBF_OP_NEQ:
+			CHECK_RESULT(sample_data, !=, entry[i].value)
+			break;
+		case PBF_OP_GT:
+			CHECK_RESULT(sample_data, >, entry[i].value)
+			break;
+		case PBF_OP_GE:
+			CHECK_RESULT(sample_data, >=, entry[i].value)
+			break;
+		case PBF_OP_LT:
+			CHECK_RESULT(sample_data, <, entry[i].value)
+			break;
+		case PBF_OP_LE:
+			CHECK_RESULT(sample_data, <=, entry[i].value)
+			break;
+		case PBF_OP_AND:
+			CHECK_RESULT(sample_data, &, entry[i].value)
+			break;
+		case PBF_OP_GROUP_BEGIN:
+			in_group = 1;
+			group_result = 0;
+			break;
+		case PBF_OP_GROUP_END:
+			if (group_result == 0)
+				goto drop;
+			in_group = 0;
+			break;
+		case PBF_OP_DONE:
+			return 1;
+		}
+	}
+	return 1;
+
+drop:
+	losts = bpf_map_lookup_elem(&dropped, &k);
+	if (losts != NULL)
+		__sync_fetch_and_add(losts, 1);
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.56.0.212.g129ede20d9-goog

