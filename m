Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529971;
	b=M9ZSu4t6ZunSfQKOiOrWNrCxsU7BOKPPZaUxAZ6f8Lbh4/24DBQGy5ioysTdoR2LZtTB
	 R9djKEIEPRbT3o9z0w6qNZu0hCSrrW0S08U7vg7ivqp9kk2YdAx+G8OQDrSlYemY+DiwW
	 36U6qjm/IokN7XJ1kHEPyxmcBZW5Rlm+4xuwHO9KObPKxSklcnKhAyhyEb3iC/rmVimWl
	 OBxdUGsNQu7nCqvTuA0QJPzVHwxZzUEz/IugZgOwW9wgcG/tWmhax+THJnaP4Dh2svsXa
	 7fvhLC68XYNAWaz9JF8lInNvah4WIQSJC+9QUajfYaBQKt/WWtlKd7DTFZFExAAc8Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ez0sBtW/aXAY60CLvQQn9ZSDvDfeSletdmhwTWVxkOI=;
	b=E1eQfULoRum0YpE5EBgK+2miOMIKckAasuPt8dyzBwK6uQxtpjXNvRJCiA6CTgISI4KE
	 V6GKrXhVaFTwNz9Ors80qF/MqejaX2M7WkPmqBHKjMwpP2krFj3yynNnrN3T6QtMZitsU
	 YlYrHcl+KiabHzvw+N820Q3CYkmvcYsjViCYotb01nA4RJyKuPKHPLYVkTf6lOJyBIEg5
	 r03jDxyGnA9fgIZhEUuJ9fpoTRYHfeRoxCeW3cA2OG760UpZ+B+XMLZ+nB+Ljv/wI4yHE
	 lpEgb/CoPb7G5DRpESMkDWmcWjuy6kC97mFe+rfQsqaDHLcC7ltU0gN10TvKydW63CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WqGge4BW;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D38606A322
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 20:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D38606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WqGge4BW
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-155a75f91e1so682890c88.1
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 13:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792529970; x=1793134770; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ez0sBtW/aXAY60CLvQQn9ZSDvDfeSletdmhwTWVxkOI=;
        b=WqGge4BWPyL0VqEE5Ob51Epn6rohwVjkxjqISdiDtMSuXZ5T3RrkPeJPK2C/7Iqzdl
         Dsq+0mwJPBM58dQed9M1qtfSUnzzIUEIh2APsr4RYHh7Dc+x7a+/9iU7H6JWGZ3v94sv
         1hoGW8qFn/cikQi5aAAn3UfwutlnuIQfkT8VxS8Z3xIEFiQzhRYoicZNYEr+QfJ56LUT
         rbAm3wkubngPOUhUtB6Ex/qlX7i63KQ7x2KeulXG/+/R8pbc+vi5AWEVzYAlau3K8Axw
         VFsDI31bjn92Opj2WF381Ca9Nzv5Hmt4iPFf1qE01hWGSvdVWP72FAVX/EWdjQ+tLPiM
         Ly2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529970; x=1793134770;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ez0sBtW/aXAY60CLvQQn9ZSDvDfeSletdmhwTWVxkOI=;
        b=JgUvJ4r1UoE0ozKe1sgmGkQg0H7DF7SX3MJUb7XLlIqYMwQwWsG/RrD+G/KlMbLnhN
         Hl1pX1dbM0pkSj3Q1CXXGjy4mKv1dwFpz1sZAoRSrhvqV+HkJVMW1RQeXk6gExHQo0Rl
         2aaNKKs0mFJeLOle69VHwy85mHdP09EzcM/esbVRWyiU5oxGtHiuTWNtvMgf0/9TKwk5
         mseBLff5dgofVGDJVEfUWv5JGL5RBJfWiWj2mgHNc95/BG+pLkHdVJ1QVdk3IItaOwUT
         iMztOZXeDx8yF/eGRwikKjNSl0u7pD7IjL8dsIBYKBUAFcCjyvC4he7Rfp+FIvM1dF4N
         jHHw==
X-Forwarded-Encrypted: i=1; AKwUvByznFO4R1QBkuPCNF0Q4om4WXWQ6AELuffiesCvx1PNiM8Nbua3R9u2tlpebDZs7YDP668=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9k8MMxk4z3ZiyVUBUKgIcWdKALsZ7Dpaoth3vrRwa7+paNnd5
	qNwFv8NUJrLLkc7sANYnOazXiWBfZd3DFSRN/Aevy2DYnN6EPeAmJlUNHzLd2te46Hw+624zXlb
	Q82ivsAQVQA==
X-Received: from dlbpu6.prod.google.com ([2002:a05:7022:e886:b0:161:df69:3983])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4210:20b0:159:f192:5290
 with SMTP id a92af1059eb24-18dbf218391mr3929480c88.13.1792529969966; Tue, 20
 Oct 2026 13:59:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:56 -0700
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
Message-ID: <20261020205859.1080743-7-irogers@google.com>
Subject: [PATCH v5 6/8] perf test: Add tests for lock_held() BPF sample filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
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
 tools/perf/tests/parse-events.c             | 108 +++++++++++++++++
 tools/perf/tests/shell/record_bpf_filter.sh | 122 ++++++++++++++++++++
 2 files changed, 230 insertions(+)

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
index 383574cb3bd3..ebaf8ee41622 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -176,6 +176,124 @@ test_bpf_filter_cgroup() {
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
+  if ! perf record -e task-clock --filter "lock_held(${lock_sym})" \
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
+    echo "Lock-held bpf-filter test [Failed ${lock_sym}]"
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
+  if ! perf record -e task-clock --filter 'lock_held(&dentry)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed &dentry]"
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
+       --filter 'lock_held_read(mmap_lock) || lock_held_write(mmap_lock)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed lock_held_read/write(mmap_lock)]"
+    err=1
+    return
+  fi
+
+  if ! perf record -e task-clock --filter 'lock_held(mmap_lock:R) || lock_held(mmap_lock:W)' \
+       -o "${perfdata}" true 2> /dev/null
+  then
+    echo "Lock-held bpf-filter test [Failed mmap_lock:R/:W]"
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
@@ -198,5 +316,9 @@ if [ $err = 0 ]; then
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

