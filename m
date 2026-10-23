Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782380;
	b=SFFntVlk/+lRJL63JXkVLRh87yegCqmaZixWOp3k4NDUxheZtpyssAYuxRinv0LEKbo0
	 Q58GhAuoig7x2cx6cAf7w7YdrWpTrnPcjxDuXR2Ye7qIIDw53uiWqlSCZqfXc8WF3wAN1
	 jHs3DVs0EO4kQj/Sjr4Zd6BBQKW1q2m/OGJ+yTtUsA0qDSXtdA84B/OB5v00nCbbAFDss
	 ln/lWavE2xcAnByVt0IsHzXqupfZg+oaegQvIeh3MA8AHheE9dNr+826nGTBo0XohXQiN
	 KwmigaZQNGA5jhhPyzIXYwoGX/MBDhkNVsfJaiI2z6m2bcRRZsZkT9Weu8ebSUps65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=q5Mn3uOOu02gjGRn2P0AkvTaplXZ1AXxqGgkk9FIuOo=;
	b=ulFMe8A9iJRuxqsy/XKlOSDFF13TPu3fkGq7A6E5XQRgjLAVgva+RhZVVKX7qYjMHR/g
	 HLSP0Wikly5ocXJX/7Yp3mYUa5RGmjPEP90AFwJN5M1Os4WdC6NVisi/pmCGMCQFTvhET
	 rkGyZKhfp7WxEZXSxWq+5TqL9STwhEcMrDFYB3VjtwJnIiYrc6Yg+eCGhvQsRQ54OwP/g
	 WbRerce9I1fwX9X1E1CA6BGVEJMYYTCXW7AcFLrYuSjywOv83LcM+wCwg8iMfW/vXBidy
	 2vkJkKD/7glqe/nnHkxOWmyTGVS7C/IAatGrLdXFLb0bChQnIRgq3djMz5gm/grVnLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K99fyJEl;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63FB606A32A
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K99fyJEl
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1730954eec.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782366; x=1793387166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5Mn3uOOu02gjGRn2P0AkvTaplXZ1AXxqGgkk9FIuOo=;
        b=K99fyJElPGlJlCXuqzShsvUFUMJ1Ve3smzepsvhZemCWKKs+3BlEYE9lAAj9XJKPHC
         jHOxy33Le5npm4/qmWwWocT4oj2JIqWqSZ8fX3cs0FQxYjD/CV4lIsyvYLHr+ytzF9no
         ckatJtjASirBs741g3DBrgeAsc62CxduB5n43EKhSZubsGefGuX2Ry+cwqEpycWkYYQz
         R+gDRzSg5hoMehvat/60pX+ZiXKL119I2dKsA15w6pF/j7xGbin2Bnyqmll7Smy/Brnv
         f8kRyfrz5oKiLL0/mYmeBPdJGT5rPceOdqBLLrqLGYrGJRLg1p/A2t8q0TwEc8hbAWXJ
         cKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782366; x=1793387166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5Mn3uOOu02gjGRn2P0AkvTaplXZ1AXxqGgkk9FIuOo=;
        b=qPc7iBj3NwJaxB2/f46OGHoy/sX0QdQXkfRXPPHwLL9327MljOaUWN12HBs9kqu0Fk
         BbXQVxearfN+SWGAyMJVMUW7znhVACGvIOouUTrlbNzwNj3mLyf4hq8TaN9y7rRQmsMR
         xA/fUk4k1+PX7TkXiPaQ88PhuyUD1fFToFVKl1OZNJpu+8TsC+BEkfo00EeI5rUCj4Vh
         I5LVPfypkpzOtmKD7qA2chM8Gaq2K3wfVOGi3Obrw9fr2H2cq3jJWV1aAJn8fPNwOKxr
         9iZe4shf4MIBeK6aSIdjsltFqH+Mek16s8S+2DL8glgnSnWPoXo8BiZ9mZvV/V2u91PX
         KNpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwk7IVdalutC9vK5uuRgzWblbpSUymZRJylKzJAhTFZvli2ddRar0MNnngV8d3qHM6YM84=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr0QhVZ06ktpKPssRcj6c9n2LVOUS/VlzWxOToUSyjbXo8g8jZ
	m1O132r1Zb5WGSzxWoYkUJtS+l+aQe8fjgVJsyX/2FJZ7DbJ+ZCuIgqCoiMu5pJySc3EL68trm0
	WCbyxvR7i3Q==
X-Received: from dybmx14.prod.google.com ([2002:a05:7300:d40e:b0:368:7730:99e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8291:b0:34c:d1f2:b552
 with SMTP id 5a478bee46e88-369e8362b32mr320006eec.4.1792782365485; Fri, 23
 Oct 2026 12:06:05 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:49 -0700
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
Message-ID: <20261023190558.3050796-3-irogers@google.com>
Subject: [PATCH v7 02/11] perf bpf-filter: Support BPF sample filters on
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

Route a tracepoint --filter to the BPF filter only when it uses one of
these terms that isn't a field of the tracepoint, looking up fields with
evsel__field() or, without libtraceevent, the tracefs format file, and
ignoring words in quoted string literals. "cpu" stays an ftrace filter
as ftrace provides a generic "cpu" field for all tracepoints. Reject
filters mixing BPF terms with tracepoint fields named like a BPF term
(such as "pid" on sched:sched_wakeup) as the BPF filter would evaluate
such fields against the current task.

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
 tools/perf/Documentation/perf-record.txt     |  13 +-
 tools/perf/util/bpf-filter.c                 | 144 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  95 ++++++++++++
 tools/perf/util/parse-events.c               | 109 +++++++++++++-
 tools/perf/util/tp_pmu.c                     |  54 +++++++
 tools/perf/util/tp_pmu.h                     |   1 +
 6 files changed, 392 insertions(+), 24 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2351f7b4f5fc..6646e16633ef 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -173,7 +173,18 @@ OPTIONS
 
 	A BPF filter can access the sample data and make a decision based on the
 	data.  Users need to set an appropriate sample type to use the BPF
-	filter.  BPF filters need root privilege.
+	filter.  BPF filters need root privilege (or CAP_BPF, or a pinned BPF
+	filter for non-tracepoint events).  On tracepoint events, BPF filters
+	support context-independent terms ('uid', 'gid', 'tid', 'pid', 'cpu',
+	'time', 'cgroup') by attaching a 'BPF_PROG_TYPE_TRACEPOINT' program to
+	the tracepoint's shared 'trace_event_call->prog_array', which filters
+	the tracepoint before 'perf_tp_event()' runs across concurrent
+	perf_event listeners on that tracepoint.  A tracepoint filter is only
+	treated as a BPF filter when it uses one of these terms that is not a
+	field of the tracepoint (a filter only using 'cpu' remains an ftrace
+	filter on the generic 'cpu' field).  Filters mixing such BPF terms with
+	tracepoint fields of the same name (e.g. 'pid' on sched:sched_wakeup)
+	are rejected; use separate --filter options instead.
 
 	The sample data field can be specified in lower case letter.  Multiple
 	filters can be separated with comma.  For example,
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 506414e5c407..0d3c700d3dcd 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -41,8 +41,10 @@
  * it will be reported as lost samples.
  */
 #include <errno.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 
@@ -124,15 +126,26 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
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
 
@@ -426,6 +439,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct sample_filter_bpf *skel = NULL;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+	bool is_tracepoint = (evsel->core.attr.type == PERF_TYPE_TRACEPOINT);
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
@@ -437,7 +451,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
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
@@ -477,8 +497,17 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
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
@@ -494,14 +523,32 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
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
@@ -633,6 +680,55 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 	return ret;
 }
 
+/*
+ * perf_bpf_filter__pin() and perf_bpf_filter__unpin() only load
+ * perf_sample_filter and disable autoload on other programs in the skeleton
+ * (such as perf_tp_sample_filter). While libbpf's bpf_object__pin_maps() skips
+ * maps that were not created, bpf_object__pin_programs() and
+ * bpf_object__unpin_programs() iterate over every program in skel->obj without
+ * checking whether autoload was enabled and fail with -EINVAL when a program
+ * was not loaded. Pin and unpin the maps and the loaded perf_sample_filter
+ * program explicitly instead of calling bpf_object__pin() / bpf_object__unpin().
+ */
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
@@ -647,6 +743,7 @@ int perf_bpf_filter__pin(void)
 	}
 
 	/* pinned program will use pid-hash */
+	bpf_program__set_autoload(skel->progs.perf_tp_sample_filter, false);
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
 	bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
@@ -666,7 +763,7 @@ int perf_bpf_filter__pin(void)
 		goto err;
 	}
 
-	ret = bpf_object__pin(skel->obj, path);
+	ret = pin_filter_object(skel, path);
 	if (ret < 0) {
 		pr_err("Failed to pin BPF filter objects\n");
 		goto err;
@@ -675,8 +772,8 @@ int perf_bpf_filter__pin(void)
 	/* setup access permissions for the pinned objects */
 	dir_fd = open(path, O_PATH);
 	if (dir_fd < 0) {
-		bpf_object__unpin(skel->obj, path);
-		ret = dir_fd;
+		ret = -errno;
+		unpin_filter_object(skel, path);
 		goto err;
 	}
 
@@ -719,6 +816,8 @@ int perf_bpf_filter__pin(void)
 
 err_close:
 	close(dir_fd);
+	if (ret < 0)
+		unpin_filter_object(skel, path);
 
 err:
 	free(path);
@@ -732,13 +831,20 @@ int perf_bpf_filter__unpin(void)
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
@@ -746,7 +852,7 @@ int perf_bpf_filter__unpin(void)
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
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2f3317ce17f0..7110c9ca928e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -3,8 +3,10 @@
 #include <linux/err.h>
 #include <linux/list_sort.h>
 #include <linux/zalloc.h>
+#include <ctype.h>
 #include <dirent.h>
 #include <errno.h>
+#include <string.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
 #include "cpumap.h"
@@ -2593,10 +2595,103 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 	return 0;
 }
 
-/* Will a tracepoint filter work for str or should a BPF filter be used? */
-static bool is_possible_tp_filter(const char *str)
+static bool is_filter_word_char(char c)
 {
-	return strstr(str, "uid") == NULL;
+	/* '/' and '.' are part of words so cgroup paths aren't split. */
+	return isalnum((unsigned char)c) || c == '_' || c == '/' || c == '.';
+}
+
+/*
+ * Does str contain the identifier word, ignoring occurrences inside quoted
+ * string literals (e.g. prev_comm == "cpu")?
+ */
+static bool has_filter_word(const char *str, const char *word)
+{
+	size_t len = strlen(word);
+	const char *p = str;
+
+	while (*p) {
+		const char *start;
+
+		if (*p == '"' || *p == '\'') {
+			char quote = *p++;
+
+			while (*p && *p != quote) {
+				if (*p == '\\' && p[1])
+					p++;
+				p++;
+			}
+			if (*p)
+				p++;
+			continue;
+		}
+		if (!is_filter_word_char(*p)) {
+			p++;
+			continue;
+		}
+		start = p;
+		while (is_filter_word_char(*p))
+			p++;
+		if ((size_t)(p - start) == len && !strncmp(start, word, len))
+			return true;
+	}
+	return false;
+}
+
+/* Is field a field in the tracefs format of the tracepoint evsel? */
+static bool tp_evsel_has_field(struct evsel *evsel, const char *field)
+{
+#ifdef HAVE_LIBTRACEEVENT
+	return evsel__field(evsel, field) != NULL;
+#else
+	const char *name = evsel__name(evsel);
+	const char *colon = name ? strchr(name, ':') : NULL;
+	char sys[256];
+
+	if (!colon || (size_t)(colon - name) >= sizeof(sys))
+		return false;
+	memcpy(sys, name, colon - name);
+	sys[colon - name] = '\0';
+	return tp_pmu__has_field(sys, colon + 1, field);
+#endif
+}
+
+/*
+ * Will a tracepoint filter work for str or should a BPF filter be used?
+ * Returns 1 for a tracepoint (ftrace) filter, 0 for a BPF filter, or a
+ * negative error when str mixes BPF-only terms with tracepoint fields that
+ * share a BPF term name (such as "pid" on sched:sched_wakeup), which a BPF
+ * filter would otherwise silently evaluate against the current task.
+ */
+static int is_possible_tp_filter(struct evsel *evsel, const char *str)
+{
+	/*
+	 * BPF terms evaluated by perf_tp_sample_filter. "cpu" is omitted as
+	 * ftrace provides a generic "cpu" field for all tracepoints (see
+	 * trace_define_generic_fields()).
+	 */
+	static const char *const bpf_tp_terms[] = {
+		"uid", "gid", "tid", "pid", "time", "cgroup",
+	};
+	const char *bpf_term = NULL, *tp_field = NULL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(bpf_tp_terms); i++) {
+		if (!has_filter_word(str, bpf_tp_terms[i]))
+			continue;
+		if (tp_evsel_has_field(evsel, bpf_tp_terms[i]))
+			tp_field = bpf_tp_terms[i];
+		else if (!bpf_term)
+			bpf_term = bpf_tp_terms[i];
+	}
+	if (!bpf_term)
+		return 1;
+	if (tp_field) {
+		pr_err("Error: filter '%s' on %s mixes BPF term '%s' with tracepoint field '%s'.\n"
+		       "Hint: use separate --filter options for tracepoint fields and BPF terms.\n",
+		       str, evsel__name(evsel), bpf_term, tp_field);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static int set_filter(struct evsel *evsel, const void *arg)
@@ -2604,6 +2699,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 	const char *str = arg;
 	int nr_addr_filters = 0;
 	struct perf_pmu *pmu;
+	int tp_filter = 0;
 
 	if (evsel == NULL) {
 		fprintf(stderr,
@@ -2611,7 +2707,12 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+		tp_filter = is_possible_tp_filter(evsel, str);
+		if (tp_filter < 0)
+			return -1;
+	}
+	if (tp_filter) {
 		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index 5ac732e06841..bb703c466840 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -6,6 +6,7 @@
 #include <api/io_dir.h>
 #include <linux/kernel.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <string.h>
 
 int tp_pmu__id(const char *sys, const char *name)
@@ -26,6 +27,59 @@ int tp_pmu__id(const char *sys, const char *name)
 	return id;
 }
 
+/*
+ * Does the tracefs format file of tracepoint sys:name declare a field called
+ * field? Format lines are of the form "\tfield:<type> <name>[<len>];\t...".
+ * Works without libtraceevent.
+ */
+bool tp_pmu__has_field(const char *sys, const char *name, const char *field)
+{
+	char *tp_dir = get_events_file(sys);
+	char path[PATH_MAX];
+	char *format = NULL, *line, *saveptr = NULL;
+	size_t format_size, field_len = strlen(field);
+	bool found = false;
+
+	if (!tp_dir)
+		return false;
+
+	scnprintf(path, sizeof(path), "%s/%s/format", tp_dir, name);
+	put_events_file(tp_dir);
+	if (filename__read_str(path, &format, &format_size))
+		return false;
+
+	for (line = strtok_r(format, "\n", &saveptr); line && !found;
+	     line = strtok_r(NULL, "\n", &saveptr)) {
+		char *decl = strstr(line, "field:"), *end;
+
+		if (!decl)
+			continue;
+		decl += strlen("field:");
+		end = strchr(decl, ';');
+		if (!end)
+			continue;
+		/*
+		 * Drop a trailing array suffix, e.g. "char prev_comm[16]", but
+		 * not the "[]" in the type of "__data_loc char[] name".
+		 */
+		while (end > decl && end[-1] == ' ')
+			end--;
+		if (end > decl && end[-1] == ']') {
+			while (end > decl && *end != '[')
+				end--;
+		}
+		/* The field name is the last token of the declaration. */
+		while (end > decl && end[-1] == ' ')
+			end--;
+		if ((size_t)(end - decl) >= field_len &&
+		    !strncmp(end - field_len, field, field_len) &&
+		    (end - field_len == decl || end[-field_len - 1] == ' ' ||
+		     end[-field_len - 1] == '*'))
+			found = true;
+	}
+	free(format);
+	return found;
+}
 
 int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb)
 {
diff --git a/tools/perf/util/tp_pmu.h b/tools/perf/util/tp_pmu.h
index 30456bd6943d..a60ec0e8a176 100644
--- a/tools/perf/util/tp_pmu.h
+++ b/tools/perf/util/tp_pmu.h
@@ -8,6 +8,7 @@ typedef int (*tp_sys_callback)(void *state, const char *sys_name);
 typedef int (*tp_event_callback)(void *state, const char *sys_name, const char *evt_name);
 
 int tp_pmu__id(const char *sys, const char *name);
+bool tp_pmu__has_field(const char *sys, const char *name, const char *field);
 int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb);
 int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb);
 
-- 
2.56.0.307.g5fe7bd680c-goog

