Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701016;
	b=HVI6wZS5lGnHSWFax8b7ni1ZxVlGepyOdbhlZ3we7CWNWZn2w1sIeFB9sbcMJgmJcKoz
	 z5MyMClPnNQriyMyTp61XyJxkUks5m71WtVv+PKKekKXbZymLxtzy9Fr4p1l6WQopZAIG
	 b+xX33puOVl3kNpw4YTtmaGijtPuAUT2SIyA+tNxqLPjMRhTh1iPTlu+yNVPPPEQ94x0/
	 cenIhjoKMnBPCFg5obNvOPjl3FNYUkorI72b1K+WztY0usVcoZzZZGi9zRUQYxE83biOb
	 gLact7n/bYhdp593U9H56VgZvnPNMx5GwdTZ1xV7TsnxjyaGOSdCbLCZs753MwJ8/4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hslE+EVvprKY4vSI1khoLdknSI9Qn35glfWRijBM1hI=;
	b=nIqL8BNAtca3pIe3NEv7r4347931oiGpcqhoXIotOt7aaEOumkk1yJEVLOjR9r8wgAKW
	 lh2RQstJQph1aPnfyIWqbcGwpz2Qs4Pba9qBRb7qjzcRp3O5Qbp3obsn7yxQgbIZOjEcV
	 d43Zfvr1cxbPFKL2I+uPxvqdAHqKmUhL75h2/CNwi0BxSOLKTrLe+A4hEEKYpGBMn8FKT
	 gieB5RT5g0eBOhEb8R+wgXoGWsZKGHxfYQNAPrCc3xwrvlIBF0HdnqKbfG4XBm16dcIFz
	 iju+S3OTLgwspx9OS/6KLuQ1EEy8oKoYssWcAipHhphZBGdRwEEBivNmHYvvpKwcbHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XB7hIQde;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9D606A31F
	for <rcu@vger.kernel.org>; Thu, 22 Oct 2026 20:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B9D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XB7hIQde
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so597256c88.1
        for <rcu@vger.kernel.org>; Thu, 22 Oct 2026 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792701015; x=1793305815; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hslE+EVvprKY4vSI1khoLdknSI9Qn35glfWRijBM1hI=;
        b=XB7hIQdeRQBiiMAaaF+LmKu3uLgWBy2u0Os81zntY4/YFMESmUzqsSnwn4iQharOXy
         vxUzfE8P6s8+r4MO7OKW7+f27Ndl2lPAVQuwdOFXu+BIcvQ443Tz4CYO0gIQ7AwiioOm
         MzMdpo70tG4Yyn0ACgsF2Vc+pWsq2QGbpWrscPnGBrHJSGQqfAQC6DTST+/WBiUqmeEM
         OVhqqzcoADBEZAN5wSphWDoMg+X4TRIsjV5TFIsmcVy7UBF4iDxkhDtG08VRrsHuZKKE
         QM2Xb3N1D+wXERASWLzO4MA97VRg98723FhVBXxysoVgEkQRogsAuD1P+amAzG7YC91q
         D7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701015; x=1793305815;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hslE+EVvprKY4vSI1khoLdknSI9Qn35glfWRijBM1hI=;
        b=VOFZJ24Tqc0PQ8r8HJtQeRVYOUyHpQrKCYdBZoCVHzKjBligN3oBsxqA1QOEU70BZX
         tduiwhT1LG9twArN7k0Fb16VjMRR0DkLm1LHJV7Fch7JXKmHyDzM25IzxgiuWQOWWtEB
         9kgcf7RE+KW2z6W9Z194DZbi2oGRqQyIhkcDsZnqorstAObc9fuf987yZglZ5LcoZTzH
         Eeh1CRuHTgQb3IZLEbgLWQt20LscVPUSXDh0yt7mLNFY5JZn/5HcPODusJEhbiSNgUwC
         KXo2fQaBjNPtEJUa18QzB040Xq5R/lfcW7XxlbrzOvrxMxhtJdJgpsqqLBYHt93FjmR7
         64Sw==
X-Forwarded-Encrypted: i=1; AKwUvBwTdqb6lErK5ub4F0a8db6cF4wqlcwWNepbg5GY69B8Bs+D4IdI85xE0HWOzt3eaBFS69A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKb0MLeFsiikStroV8sAMUJzV7avYARvleXeyFvdBUj91jq2Xe
	h+4RWGqLImerX1acuQAH/q/bs4pjJnZ5A8KzftgVB6qvk1z2/dt0PUnLaB3oSVQeyOkD+YaFhSQ
	KtIHY2f1pXw==
X-Received: from dled17-n1.prod.google.com ([2002:a05:701b:42d1:10b0:195:cde8:ab41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:ca0b:b0:18d:96e8:b913
 with SMTP id a92af1059eb24-195c75bb98cmr458400c88.47.1792701014280; Thu, 22
 Oct 2026 13:30:14 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:29:54 -0700
In-Reply-To: <20261022203003.1779152-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022203003.1779152-3-irogers@google.com>
Subject: [PATCH v6 02/11] perf bpf-filter: Support BPF sample filters on
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
 tools/perf/Documentation/perf-record.txt     |   8 +-
 tools/perf/util/bpf-filter.c                 | 144 ++++++++++++++++---
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  95 ++++++++++++
 tools/perf/util/parse-events.c               |  38 ++++-
 4 files changed, 262 insertions(+), 23 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 2351f7b4f5fc..fcf1ea62bf1c 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -173,7 +173,13 @@ OPTIONS
 
 	A BPF filter can access the sample data and make a decision based on the
 	data.  Users need to set an appropriate sample type to use the BPF
-	filter.  BPF filters need root privilege.
+	filter.  BPF filters need root privilege (or CAP_BPF, or a pinned BPF
+	filter for non-tracepoint events).  On tracepoint events, BPF filters
+	support context-independent terms ('uid', 'gid', 'tid', 'pid', 'cpu',
+	'time', 'cgroup') by attaching a 'BPF_PROG_TYPE_TRACEPOINT' program to
+	the tracepoint's shared 'trace_event_call->prog_array', which filters
+	the tracepoint before 'perf_tp_event()' runs across concurrent
+	perf_event listeners on that tracepoint.
 
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
index 2f3317ce17f0..d6bab89ade5d 100644
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
@@ -2593,10 +2595,40 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 	return 0;
 }
 
+static bool is_filter_word_char(char c)
+{
+	return isalnum((unsigned char)c) || c == '_' || c == '/' || c == '.';
+}
+
+static bool has_filter_word(const char *str, const char *word)
+{
+	size_t len = strlen(word);
+	const char *p = str;
+
+	while ((p = strstr(p, word)) != NULL) {
+		bool start_ok = (p == str) || !is_filter_word_char(p[-1]);
+		bool end_ok = !is_filter_word_char(p[len]);
+
+		if (start_ok && end_ok)
+			return true;
+		p += len;
+	}
+	return false;
+}
+
 /* Will a tracepoint filter work for str or should a BPF filter be used? */
-static bool is_possible_tp_filter(const char *str)
+static bool is_possible_tp_filter(struct evsel *evsel, const char *str)
 {
-	return strstr(str, "uid") == NULL;
+	static const char *const bpf_tp_terms[] = {
+		"uid", "gid", "tid", "pid", "cpu", "time", "cgroup",
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(bpf_tp_terms); i++) {
+		if (has_filter_word(str, bpf_tp_terms[i]) &&
+		    !evsel__field(evsel, bpf_tp_terms[i]))
+			return false;
+	}
+	return true;
 }
 
 static int set_filter(struct evsel *evsel, const void *arg)
@@ -2611,7 +2643,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(str)) {
+	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT && is_possible_tp_filter(evsel, str)) {
 		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
-- 
2.56.0.307.g5fe7bd680c-goog

