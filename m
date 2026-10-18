Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CC3F39FA
	for <rcu@vger.kernel.org>; Sun, 18 Oct 2026 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301843; cv=none; b=LfEuyPl1018R+HtUvk5udTDH3EIgr/TH4cO1leF8md8Q0pGZpaZKHtzyAjH23g3Xy351j6hXwnGZ1Ye35/71EqXqTjpDSsW4JNdoxzLXCkcVeuXhw2RDsd22FGs1xMMRiWSOZa0iBBAMY111bCfXvFTQAUgK+wXIimVRAZqFI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301843; c=relaxed/simple;
	bh=Tda0Ij1c7QQIZ+bi2pZfSZmbq5pAlX7peaiknbUkAAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cgr4syZn7UIaUAWG9hI31I+CMNdGV4iD+0qo0KhKncjHT7fYVHQGxUDZg8tfxLMjEKjK2YoVTXXmbIrs8E2hErRbwvkVF4ovFpSjh2TaSdfoaBSCtaxVZ5FXSaP2znn4yJhlsDP3SsPSYMsa6LFNZeJ8HifcO7xnp38tbaAwt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6JfVPxm; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6JfVPxm"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c5aef2a74so2740540eec.0
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 22:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792301840; x=1792906640; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBD0q56IaJAp2LEswZuUMnNpQnj5wb0tRC9PUrpa7m0=;
        b=T6JfVPxmlf7v8R6DGtxVi2JtzRWvyoPETm0yaGHWpLzENnPW7VJs/1HU43ZMBqZG4p
         aep9LDOXPguTFCrUl+n1H5euOiJdjETCQcY/F8G6hBkdttPpZTeeHQ9lFny5fLfxMcdN
         n1cFmfNzf2KOig3BCpWyPbleSE2xWeL1hqV4uzi9jPcx2aJOdojXcpghAnZJkEHoRayf
         HaF5k28TWQnDwP6wKy+n3nEySLqFiij8KbiSBLXniquy2KLhDSiZ0ZhJG/s36LFo9p7R
         wlYGnmHMN+p+12rjoz8OTe9wyjEV3qJBJ4Eahq2KvTr44Vq9K42mFROgrUoCqz23sFXY
         /DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792301840; x=1792906640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBD0q56IaJAp2LEswZuUMnNpQnj5wb0tRC9PUrpa7m0=;
        b=zFxfZz2YmtVrtdobHUpbZayL5iw6oINwJOqmddn80qYJK6TqtjByxyb/T/5lqZahtj
         UL6ABNX6Bas4ywKdZ4VOUijgjv+194lm+946/Zz4m8vOeNN7Qle+/Lh63Kwo8leSeNtN
         x5JK+Q4XJ8fS8CwqTYrzkhJg8Xy7CKFcj4IsyoHe/7z8Qcxf/5qwY01FFG0mc93N3eHC
         46/jE6rTPEwev1Ecq9hz65dHuedFsM0b5UADsuvzYcqgBAX/ozuYTw6f3wSgtCjCWrKr
         HyzD5elY/H9XFESR+TT/jG+wHmO+X/Sqr0ESRlPZBGexsjoGGQcYk+R0DOF039MnVQSI
         s67Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcHS3JqSOn+uWLcyuWrs3j86YDML2UtCaag/JF2OVLCVLZMY7RPdZVeKAEfBcQPyIVrQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqSKRooENyeicF4cBI3SBs5wo02jomh0z11YMUB6F1n3NE3zp0
	jKsp2tILAZb5AB3e0q9yoSyiT5juueKINHh+v2tkNvRneu90ZyvxxvWWJZTlMtEVIjcrExYke6o
	s0NRM3vfUDg==
X-Received: from dlbds20.prod.google.com ([2002:a05:7022:2514:b0:170:e346:472d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:170d:b0:145:4ef:e8de
 with SMTP id a92af1059eb24-1850c9cf21fmr6092819c88.6.1792301839549; Sat, 17
 Oct 2026 22:37:19 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:37:07 -0700
In-Reply-To: <20261018053710.2572636-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017171437.2066343-1-irogers@google.com> <20261018053710.2572636-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261018053710.2572636-4-irogers@google.com>
Subject: [PATCH v3 3/6] perf test: Add tests for lock_held() BPF sample filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add unit tests in parse-events.c for parsing lock_held(),
lock_held_read(), and lock_held_exclusive() BPF filter expressions
(standalone predicates, negated predicates, and compound group
expressions) and extend record_bpf_filter.sh with lock_held(),
lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.

Example output:

  # perf test -v 'Parsing of BPF sample filters'
    5: Parse event definition strings               :
    5.7: Parsing of BPF sample filters              : Ok

  # perf test -v 'perf record sample filtering (by BPF) tests'
  112: perf record sample filtering (by BPF) tests  :
  Checking BPF-filter privilege
  Basic bpf-filter test
  Basic bpf-filter test [Success]
  Failing bpf-filter test
  Failing bpf-filter test [Success]
  Group bpf-filter test
  Group bpf-filter test [Success]
  Multiple bpf-filter test
  Multiple bpf-filter test [Success]
  Cgroup bpf-filter test
  Cgroup bpf-filter test [Success]
  Lock-held bpf-filter test
  Lock-held bpf-filter test [Success]
  112: perf record sample filtering (by BPF) tests  : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c             | 108 +++++++++++++++++++
 tools/perf/tests/shell/record_bpf_filter.sh | 114 ++++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5f6f95c8a5b4..4cf9192762f2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -8,9 +8,11 @@
 #include "debug.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "bpf-filter.h"
 #include "strbuf.h"
 #include <dirent.h>
 #include <errno.h>
+#include <string.h>
 #include "fncache.h"
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -2938,6 +2940,111 @@ static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+#ifdef HAVE_BPF_SKEL
+static void clear_bpf_filter_exprs(struct list_head *expr_head)
+{
+	struct perf_bpf_filter_expr *expr, *tmp;
+
+	list_for_each_entry_safe(expr, tmp, expr_head, list) {
+		list_del(&expr->list);
+		perf_bpf_filter_expr__delete(expr);
+	}
+}
+
+static int do_test_bpf_filters(struct list_head *expr_head)
+{
+	struct perf_bpf_filter_expr *expr, *group;
+	const char *compound = "lock_held(rwsem:R) == 1 || lock_held(&dentry) != 0, period > 100";
+
+	/* Simple lock_held(&cgroup_mutex) */
+	TEST_ASSERT_VAL("parse lock_held(&cgroup_mutex)",
+			__perf_bpf_filter__parse(expr_head, "lock_held(&cgroup_mutex)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 1", expr->val == 1);
+	TEST_ASSERT_VAL("lock_name is &cgroup_mutex",
+			expr->lock_name && !strcmp(expr->lock_name, "&cgroup_mutex"));
+	clear_bpf_filter_exprs(expr_head);
+
+	/* Negated !lock_held(cgroup_mutex) */
+	TEST_ASSERT_VAL("parse !lock_held(cgroup_mutex)",
+			__perf_bpf_filter__parse(expr_head, "!lock_held(cgroup_mutex)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 0", expr->val == 0);
+	TEST_ASSERT_VAL("lock_name is cgroup_mutex",
+			expr->lock_name && !strcmp(expr->lock_name, "cgroup_mutex"));
+	clear_bpf_filter_exprs(expr_head);
+
+	/* Read/shared and write/exclusive predicates */
+	TEST_ASSERT_VAL("parse lock_held_read(&mmap_lock)",
+			__perf_bpf_filter__parse(expr_head, "lock_held_read(&mmap_lock)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("part is PBF_LOCK_MODE_READ", expr->part == PBF_LOCK_MODE_READ);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 1", expr->val == 1);
+	TEST_ASSERT_VAL("lock_name is &mmap_lock",
+			expr->lock_name && !strcmp(expr->lock_name, "&mmap_lock"));
+	clear_bpf_filter_exprs(expr_head);
+
+	TEST_ASSERT_VAL("parse !lock_held_exclusive(mmap_lock)",
+			__perf_bpf_filter__parse(expr_head,
+						 "!lock_held_exclusive(mmap_lock)") == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("term is PBF_TERM_LOCK_HELD", expr->term == PBF_TERM_LOCK_HELD);
+	TEST_ASSERT_VAL("part is PBF_LOCK_MODE_WRITE", expr->part == PBF_LOCK_MODE_WRITE);
+	TEST_ASSERT_VAL("op is PBF_OP_EQ", expr->op == PBF_OP_EQ);
+	TEST_ASSERT_VAL("val is 0", expr->val == 0);
+	TEST_ASSERT_VAL("lock_name is mmap_lock",
+			expr->lock_name && !strcmp(expr->lock_name, "mmap_lock"));
+	clear_bpf_filter_exprs(expr_head);
+
+	/*
+	 * Comparison and compound group:
+	 * lock_held(rwsem:R) == 1 || lock_held(&dentry) != 0, period > 100
+	 */
+	TEST_ASSERT_VAL("parse compound lock_held filter",
+			__perf_bpf_filter__parse(expr_head, compound) == 0);
+	TEST_ASSERT_VAL("not empty", !list_empty(expr_head));
+	expr = list_first_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("group op", expr->op == PBF_OP_GROUP_BEGIN);
+	TEST_ASSERT_VAL("groups not empty", !list_empty(&expr->groups));
+	group = list_first_entry(&expr->groups, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("first group member lock_name",
+			group->lock_name && !strcmp(group->lock_name, "rwsem:R"));
+	TEST_ASSERT_VAL("first group member op", group->op == PBF_OP_EQ && group->val == 1);
+	group = list_last_entry(&expr->groups, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("second group member lock_name",
+			group->lock_name && !strcmp(group->lock_name, "&dentry"));
+	TEST_ASSERT_VAL("second group member op", group->op == PBF_OP_NEQ && group->val == 0);
+	expr = list_last_entry(expr_head, struct perf_bpf_filter_expr, list);
+	TEST_ASSERT_VAL("second term is period", expr->term == PBF_TERM_PERIOD && expr->val == 100);
+
+	return TEST_OK;
+}
+#endif
+
+static int test__bpf_filters(struct test_suite *test __maybe_unused,
+			     int subtest __maybe_unused)
+{
+#ifdef HAVE_BPF_SKEL
+	struct list_head expr_head = LIST_HEAD_INIT(expr_head);
+	int ret = do_test_bpf_filters(&expr_head);
+
+	clear_bpf_filter_exprs(&expr_head);
+	return ret;
+#else
+	return TEST_SKIP;
+#endif
+}
+
 static struct test_case tests__parse_events[] = {
 	TEST_CASE_REASON("Test event parsing",
 			 events2,
@@ -2952,6 +3059,7 @@ static struct test_case tests__parse_events[] = {
 			 "no aliases in sysfs"),
 	TEST_CASE("Parsing of aliased events", pmu_events_alias2),
 	TEST_CASE("Parsing of terms (event modifiers)", terms2),
+	TEST_CASE("Parsing of BPF sample filters", bpf_filters),
 	{	.name = NULL, }
 };
 
diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 383574cb3bd3..9334b8b9b1c2 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -176,6 +176,116 @@ test_bpf_filter_cgroup() {
   echo "Cgroup bpf-filter test [Success]"
 }
 
+test_bpf_filter_lock_held() {
+  echo "Lock-held bpf-filter test"
+  lock_sym="cgroup_mutex"
+
+  if [ -r /proc/kallsyms ] && ! grep -qw "${lock_sym}" /proc/kallsyms
+  then
+    lock_sym="slab_mutex"
+  fi
+
+  if ! perf record -e task-clock --filter "lock_held(&${lock_sym})" \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    if [ "$(id -u)" != 0 ]
+    then
+      echo "Lock-held bpf-filter test [Skipped permission]"
+      return
+    fi
+    if [ -r /proc/kallsyms ] && ! grep -qw "${lock_sym}" /proc/kallsyms
+    then
+      echo "Lock-held bpf-filter test [Skipped missing ${lock_sym}]"
+      return
+    fi
+    echo "Lock-held bpf-filter test [Failed &${lock_sym}]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter "!lock_held(${lock_sym})" \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed !lock_held(${lock_sym})]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(mmap_lock)' \
+       -o "${perfdata}" perf bench mem mmap -t 2 -l 10 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed mmap_lock]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(rq_lock) || lock_held(spinlock)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    if ! perf record -e task-clock --filter 'lock_held(rq_lock) || lock_held(spinlock)' \
+         -o /dev/null true 2>&1 | grep -q "Kernel BTF lacks required"
+    then
+      echo "Lock-held bpf-filter test [Failed rq_lock/spinlock]"
+      err=1
+      return
+    fi
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(mutex) || lock_held(rwsem)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock type]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock \
+       --filter 'lock_held_read(&mmap_lock) || lock_held_write(&mmap_lock)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock_held_read/write(&mmap_lock)]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(&mmap_lock:R) || lock_held(&mmap_lock:W)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed &mmap_lock:R/:W]"
+    err=1
+    return
+  fi
+
+  if perf list tracepoint 2> /dev/null | grep -q kmem:mm_page_alloc
+  then
+    if ! perf record -e kmem:mm_page_alloc --filter 'lock_held(mutex) || lock_held(rwsem)' \
+         -o "${perfdata}" true 2> /dev/null
+    then
+      echo "Lock-held bpf-filter test [Failed tracepoint kmem:mm_page_alloc]"
+      err=1
+      return
+    fi
+  fi
+
+  if perf record -e task-clock --filter 'lock_held_read(rq_lock)' \
+       -o /dev/null true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock_held_read(rq_lock) should fail]"
+    err=1
+    return
+  fi
+
+  if perf record -e task-clock --filter 'lock_held(nonexistent_lock_xyz)' \
+       -o /dev/null true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed nonexistent lock should fail]"
+    err=1
+    return
+  fi
+
+  echo "Lock-held bpf-filter test [Success]"
+}
+
 test_bpf_filter_priv
 
 if [ $err = 0 ]; then
@@ -198,5 +308,9 @@ if [ $err = 0 ]; then
   test_bpf_filter_cgroup
 fi
 
+if [ $err = 0 ]; then
+  test_bpf_filter_lock_held
+fi
+
 cleanup
 exit $err
-- 
2.56.0.212.g129ede20d9-goog

