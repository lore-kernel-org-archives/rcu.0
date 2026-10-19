Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447768;
	b=vIVjQ5uwGAX4TWHLeGE3q/ruV27Yg3D8jRSR8vuTU/wkpB27w5JhiTlJ6j+AFN+Rvoqw
	 LbhY/adRnRhAl18SV0m3CrwkHPcQL7WaNgo1efdMbdTNN3GfKXCqe9K2uhd8P877WHbiq
	 erfJr2jQr6OHO0C7e2+DG1H64vSahPcLZcgM3BJL+D+M8D5AsX9ljQrwoui1ovfukwvVY
	 hZRRWexmM4ziroNslhRIxhSrqKE6RhgIRQ4svhKCn0XmIw7Tu96mpLjfBQ/PS11+EFSeL
	 Jt96HyZ184IxIRKx6GGT7gWmUizbDBPzEpbijztuuP85RMJKWtRScLdpIAe0aofIulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vpqW14SBLlXSFndNo7YEydnKjfEoAkCIlORdfmADx2Y=;
	b=GqelO2DOXoNwsWNpzErtfMTTszc31wz5Fv8OCoejxLeZ3V7SgTw5tRL1OkIdnIVb0+d7
	 VlxRN1CFNanffjYVR9oEpya91W3XV9h0lGmYwxUelst5m3kFXMOW8mEpaKiNsn33OjnFS
	 MIQVj6cF3vsdzj7j11IzC1FrCCElW8pbwcUWarA4qUqypkTMvInlY1GaVoJ44rjLUn4Bi
	 dE7yQqH2hoaDQ9CcaQwWp1cdVJwPp03tOPtZjPFodORPm22HDYJ41OBl+uNC7EIifWLvg
	 oKFhnadh8wOWmTC5E6705E+KoiEXcBkI1+291bl4ZCg96V8h4zjjQPrJd1Io6MGcuaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=POHyuPF0;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C770606A329
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 22:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C770606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=POHyuPF0
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so7113865eec.1
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792447768; x=1793052568; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpqW14SBLlXSFndNo7YEydnKjfEoAkCIlORdfmADx2Y=;
        b=POHyuPF0pSEwp/isnKXzYcFn480lxL+OgrqQdJ8RedGEXtkseZR93RVqQCuvq42WSL
         4Gr1bPL5TNYJRw0tj+Xu8fO3d02QOI5SFZGnQGJ53G4KA4Zu5ScU2ji3B289BWPfrHNi
         MXSYt2rKggGIntmrVI5McEYEVzLLx1kS+wdiQNRQLDWoZX0rsK55ORYqoEHJtba/i0cd
         QU1OMHXyUx938FRIKzAHfaV7D7tb7SyNqoEvCgeXozaWSaXXriND1587hKen7IgqH3Db
         dmwW9lG6xYnRaPpbwYvofKASazSJ+7ac7/9XG7lGG7h6/8ly8MaANK4OUbFUYqqPJEIG
         uysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447768; x=1793052568;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpqW14SBLlXSFndNo7YEydnKjfEoAkCIlORdfmADx2Y=;
        b=JcoxCW42jZPOxL6WAM+HfeHd4ldIBlc7UzYIiONJm1H6u42zrRD1pc22NtyVRs6zN6
         4czTpcCWRjuH25ahkIS8BD4V98Dkp/ROBFGj8RF84ngUztBu0nyvx7s7g6MCumebev4X
         DWzjWVcZ2aGDaR8qooRJfXKHHBxrsfNv7ZX3GnGj6iD+LjV6j5qZNlbDYguvy2dxLIpV
         p1yJunUG9JuQF+ZD3RcjwuV0Ru2da/6avuWhulXgea1ejhq9YdqLqlzfSjDXxHsYp+cJ
         I9k/gNTbF+tBcTpAODVp4zKfpf6Egdw6NYsi0/4Rpfju1RMtIj5JpGl+G/DD8Sun6Jc6
         PKUg==
X-Forwarded-Encrypted: i=1; AKwUvBwUAt3b72VeVdP54sQnBu0dRyxbdOrqrSp3KcJPk+ZAOZzlwwnrLy9mfAzDszD8iT/9hpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdNG1TSISlC82xjv3Bn2ASKk5sCy0mF+4OiCrngarr+DjFmSQE
	CakryKd7ElVfcpVb+BgxF/NJmBKDFzMY/ADlajhX1Zy/Zznu/tddawktiOWWHln+2uzPWxWqVwJ
	FY186H8tYJA==
X-Received: from dyru33.prod.google.com ([2002:a05:7300:4fa1:b0:35b:4bd1:e0fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:710d:b0:361:7ab9:479d
 with SMTP id 5a478bee46e88-361a1f51896mr12313573eec.27.1792447767193; Mon, 19
 Oct 2026 15:09:27 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:09:10 -0700
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
Message-ID: <20261019220915.3943592-3-irogers@google.com>
Subject: [PATCH v4 2/7] perf bpf-filter: Support BPF sample filters on
 tracepoint events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, eranian@google.com, 
	ddhariwal@google.com, rcu@vger.kernel.org
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
 tools/perf/util/bpf-filter.c                 | 136 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  85 ++++++++++++
 2 files changed, 201 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 72e83ac1d6a4..4e99af4764f1 100644
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
 
@@ -427,6 +438,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
 #if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
 			    .dont_enable = true);
@@ -444,9 +456,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	if (needs_idx_hash && geteuid() != 0) {
+	if (needs_idx_hash && geteuid() != 0 && !perf_cap__capable(CAP_BPF)) {
 		int zero = 0;
 
+		if (is_tracepoint) {
+			pr_err("Error: Tracepoint BPF filter requires CAP_BPF capability\n");
+			ret = -EPERM;
+			goto err;
+		}
+
 		/* The filters map is shared among other processes */
 		ret = create_idx_hash(evsel, entry);
 		if (ret < 0)
@@ -484,8 +502,17 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
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
@@ -501,15 +528,35 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	prog = skel->progs.perf_sample_filter;
-	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
-		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
-								   &pe_opts);
-			if (IS_ERR(link)) {
-				pr_err("Failed to attach perf sample-filter program\n");
-				ret = PTR_ERR(link);
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
+		prog = skel->progs.perf_tp_sample_filter;
+		link = bpf_program__attach_perf_event_opts(prog, FD(evsel, 0, 0),
+							   &pe_opts);
+		ret = libbpf_get_error(link);
+		if (ret) {
+			pr_err("Failed to attach perf tracepoint sample-filter program\n");
+			goto err;
+		}
+		skel->links.perf_tp_sample_filter = link;
+	} else {
+		prog = skel->progs.perf_sample_filter;
+		for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+			for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+				link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
+									   &pe_opts);
+				ret = libbpf_get_error(link);
+				if (ret) {
+					pr_err("Failed to attach perf sample-filter program\n");
+					goto err;
+				}
 			}
 		}
 	}
@@ -641,6 +688,45 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
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
@@ -655,6 +741,7 @@ int perf_bpf_filter__pin(void)
 	}
 
 	/* pinned program will use pid-hash */
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
 	bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
@@ -674,7 +761,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	ret = bpf_object__pin(skel->obj, path);
+	ret = pin_filter_object(skel, path);
 	if (ret < 0) {
 		pr_err("Failed to pin BPF filter objects\n");
 		goto err;
@@ -683,8 +770,8 @@ int perf_bpf_filter__pin(void)
 	/* setup access permissions for the pinned objects */
 	dir_fd = open(path, O_PATH);
 	if (dir_fd < 0) {
-		bpf_object__unpin(skel->obj, path);
-		ret = dir_fd;
+		ret = -errno;
+		unpin_filter_object(skel, path);
 		goto err;
 	}
 
@@ -727,6 +814,8 @@ int perf_bpf_filter__pin(void)
 
 err_close:
 	close(dir_fd);
+	if (ret < 0)
+		unpin_filter_object(skel, path);
 
 err:
 	free(path);
@@ -740,13 +829,20 @@ int perf_bpf_filter__unpin(void)
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
@@ -754,7 +850,7 @@ int perf_bpf_filter__unpin(void)
 		goto err;
 	}
 
-	ret = bpf_object__unpin(skel->obj, path);
+	ret = unpin_filter_object(skel, path);
 
 err:
 	free(path);
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index e5666d4c1722..576fbed270e5 100644
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
@@ -295,4 +317,67 @@ int perf_sample_filter(void *ctx)
 	return 0;
 }
 
+/* BPF program to be called for tracepoint perf events */
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

