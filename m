Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037A2C1589
	for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968418; cv=none; b=gftwFgK8OM4F06S3qmm5fcMScTAxsmiPwW7eLJbPGw4SsFjqy5/MPo3hmcKbM76wYICb3XnLIH+jaE5yOc62WLGMLvT7EVXeUzY1Pvqlig4ygWV2XZGMM9srtmj1q/XCteoud8W0qLQYIdXQaWYR/IbhQ+ewVmMnPsq9+JpWEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968418; c=relaxed/simple;
	bh=DHxNzNVWUr+O5o8IyHJuN8fdD6GVaiWbG6x9JXShmp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AIxidifS/cqyrEPMlcjGc596Wt1kIHVeqjgV10XbdnnxZOPwB6wmcmynB1BgqA3PHBA4R11AIX5GZZbtnF70sd1CtNeb9XuKhcEedFXigTmeGoBRAfByXMyuG/yBSesON5YMhqnBdsDVgWzIrkS97YEYei2MtQSs5hailjhUtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EY5BPP2T; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EY5BPP2T"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4227d86246so713927a12.0
        for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968415; x=1754573215; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkP7Z4Cqqv/NC5+ok8KneBr4i3bJ/7NR+0dUzs2HMi8=;
        b=EY5BPP2T7uLDGS8T7JrCdxI6SpxCO3nSoXlqVls2F4J6o45YL5MbeaE7/+yIoTpErl
         X9JvPt4FPBt0jXyCDmf1Nd5pMf5Boz6Ef/K/qDSphgk9H9NhWhsi2wrgPy3Rdu47YXdV
         xrsd47wse6ZL5TwDgmphPQGtCburbHN12aM/U14x3SKn7gOa61JSHFdguC18GfsWC87j
         Sc7ELTWuBWzqmDTMcF0p9+AYKs0X+hjQhxroxwpZFnaIEPgHo3vAWORi06W7HqGlOr3S
         9GJm94wEsva/fW7RGkIhqCDayIsiRIUt4rjP4DmXG8dtS5p2f4FgyR1aR3PtScgctQH9
         4hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968415; x=1754573215;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkP7Z4Cqqv/NC5+ok8KneBr4i3bJ/7NR+0dUzs2HMi8=;
        b=C2JMS0PBoC+YrAQo6El8JBuMPepbThvLPkMgeXI/6+6mRh1AEARdwumclIYU7FJsLk
         S6u5sx4vQ+wOFTVeKVxY4DSC1AVPST3qWXkHMjlUYNUGrHhl8DVWR+adMYNWHgnZKFHy
         kPHk5t4UlXmF/o8w6pTVFQccDj9M/g0yeP4m+Gvciqqda2RQmoUvYquz3mykEDcIKckL
         U61rPGsnYBlWnRolCg7LnJOJ33RmRE0dcBeBrNAcsJ2JAdYPh5Kauv7Gx0KOu9bh3NFG
         Clo9144SB3jjWstkuvgZbFCY2PCBqjuGCTa1bXTNgx2vxJOFS1E3zCw95bHAPY68OICB
         t30g==
X-Forwarded-Encrypted: i=1; AJvYcCUgIPtzIgwT138a8sC5NtoyXR7lkmJITwlUzdEnDGz/q87NtOuVZdhQjBptP8APnCmC9Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6IeuSlTrXNEWeGbPrVPntEBRjfh0NQuhZyVgDL4F1NLaLDSql
	MGg307/o3NwvxP/u+KjjWCW5pM48imknVW4eVw9cFzwJ/RaOeq2vqgvBkfzjsRr3KQaX6QQ1dhT
	tvmUixw==
X-Google-Smtp-Source: AGHT+IEwduAehduBW9EWHJOWUGqQXIKJ02sza7Y6mu7qiMI5Yth6Qmr0VERdlGJ8n+sQiOAH1nTf9mvtt4k=
X-Received: from plnf7.prod.google.com ([2002:a17:903:1a67:b0:240:1bbf:686b])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94b:b0:240:150d:9147
 with SMTP id d9443c01a7336-24096a56357mr111905495ad.13.1753968415132; Thu, 31
 Jul 2025 06:26:55 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:11 -0700
In-Reply-To: <20250731132615.938435-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731132615.938435-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-2-yuzhuo@google.com>
Subject: [PATCH v1 1/5] perf bench: Add RCU benchmark using rcuscale kernel module
From: Yuzhuo Jing <yuzhuo@google.com>
To: Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add 'rcu' to the 'perf bench sync' collection.  This benchmark depends
on the rcuscale kernel module, and also depends on new features
in the rcuscale module that exposes control and internal state through
debugfs.

This patch adds the basic 'once' mode that runs one combination of
rcuscale parameters.  Command usage is defined as:

  perf bench sync rcu [options..] [once <gp_type> [<param=value>..]]

* gp_type is one of "sync", "async", "exp"
* Valid params can be found from `modinfo rcuscale`.  Except that
  gp_exp, gp_async, and block_start are managed by the benchmark and
  cannot be set by user.

This benchmark parses the modinfo to validate the existence of user
provided parameters.  It then executes modprobe to load rcuscale.
Experiment start/finish is controlled through
/sys/kernel/debug/rcuscale/{should_start,test_complete}.
After the experiment finishes, it reads
/sys/kernel/debug/rcuscale/writer_durations and outputs statistics.
The statistic code (print_writer_duration_stats function) is derived
from tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh.

Example output:

./perf bench sync rcu --hist once exp nreaders=1 nwriters=1
\# Running 'sync/rcu' benchmark:
Running experiment with options: gp_exp=1 nreaders=1 nwriters=1
Experiment finished.
Histogram bucket size: 0.1 microseconds
8.8 11
8.9 25
9 27
9.1 13
9.2 6
9.3 3
9.4 2
9.5 2
9.6 3
9.7 1
9.8 1
9.9 1
10 2
10.4 1
10.5 1
11.1 1
6025.6 1
Average grace-period duration: 68.734 microseconds
Minimum grace-period duration: 8.813
50th percentile grace-period duration: 9.044
90th percentile grace-period duration: 9.625
99th percentile grace-period duration: 10.516
Maximum grace-period duration: 6025.679

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/Build      |   1 +
 tools/perf/bench/bench.h    |   1 +
 tools/perf/bench/sync-rcu.c | 816 ++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c  |   1 +
 4 files changed, 819 insertions(+)
 create mode 100644 tools/perf/bench/sync-rcu.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 13558279fa0e..f694f8715cfc 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -20,6 +20,7 @@ perf-bench-y += breakpoint.o
 perf-bench-y += pmu-scan.o
 perf-bench-y += uprobe.o
 perf-bench-y += sync.o
+perf-bench-y += sync-rcu.o
 perf-bench-y += qspinlock.o
 
 perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 42c0696b05fb..09c5b3af347f 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -24,6 +24,7 @@ int bench_sched_pipe(int argc, const char **argv);
 int bench_sched_seccomp_notify(int argc, const char **argv);
 int bench_sync_qspinlock(int argc, const char **argv);
 int bench_sync_ticket(int argc, const char **argv);
+int bench_sync_rcu(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_getpgid(int argc, const char **argv);
 int bench_syscall_fork(int argc, const char **argv);
diff --git a/tools/perf/bench/sync-rcu.c b/tools/perf/bench/sync-rcu.c
new file mode 100644
index 000000000000..ac85841f0b68
--- /dev/null
+++ b/tools/perf/bench/sync-rcu.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RCU scale benchmark using rcuscale kernel module.
+ *
+ * 2025  Yuzhuo Jing <yuzhuo@google.com>
+ */
+#include <dirent.h>
+#include <err.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <math.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <subcmd/parse-options.h>
+#include <sys/cdefs.h>
+#include <sys/wait.h>
+
+#include "bench.h"
+
+#define MAX_OPTS 64
+#define MAX_OPTNAME 64
+#define MAX_OPTTYPE 16
+#define MAX_OPTVALUE 128
+
+#define INIT_CAPACITY 1024UL
+
+/* ============================ Global Options ============================ */
+
+static bool dryrun;
+static unsigned int cooldown = 3;
+static bool show_hist;
+static const char *debugfs = "/sys/kernel/debug";
+
+static const struct option bench_rcu_options[] = {
+	OPT_BOOLEAN('n',	"dryrun",	&dryrun,	"Dry run mode"),
+	OPT_UINTEGER('c',	"cooldown",	&cooldown,
+		"Sleep time between each run (default: 3 seconds)"),
+	OPT_BOOLEAN(0,		"hist",		&show_hist,
+		"Show histogram of writer durations"),
+	OPT_STRING(0,		"debugfs",	&debugfs,	"path",
+		"Debugfs mount point (default: /sys/kernel/debug)"),
+	OPT_END()
+};
+
+static const char *const bench_rcu_usage[] = {
+	"RCU benchmark using rcuscale kernel module.",
+	"",
+	"perf bench sync rcu [options..]",
+	"perf bench sync rcu [options..] once  <gp_type> [<param=value>..]",
+	"",
+	"  <gp_type>: The type of grace period to use: sync, async, exp (expedited)",
+	"             This sets the gp_exp or gp_async kernel module parameters.",
+	"  <param>:   Any parameter of the rcuscale kernel module, e.g. holdoff=5.",
+	"             Valid options can be found from running `modinfo rcuscale`.",
+	"",
+	"Notes on param:",
+	"  This benchmark manages gp_exp and gp_async, and sets block_start=1.",
+	"  User cannot override those parameters.  This benchmark also sets default",
+	"  values writer_no_print=1 and holdoff=3, but users may override those.",
+	"  Note that if nwriters=0, the rcuscale kernel module will not exit,",
+	"  and the benchmark will sleep indefinitely.",
+	"",
+	"Modes:",
+	"  default: Run 'once sync'.",
+	"  once:  Run benchmark once, with all parameters passed through to the",
+	"         kernel rcuscale module.",
+	"",
+	"Examples:",
+	"  perf bench sync rcu --hist once exp nreaders=1 nwriters=1 writer_cpu_offset=1",
+	"  perf bench sync rcu once",
+	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1",
+	"",
+	"In case perf exited abnormally, user need to unload rcuscale by running:",
+	"  modprobe -r rcuscale torture",
+	"",
+	"Global options:",  // continues to show bench_rcu_options
+	NULL
+};
+
+/* ============================ Runtime Options ============================ */
+
+#define MODPROBE_BASE_COUNT 3
+#define MODPROBE_CMD_MAX (2 * MAX_OPTS + MODPROBE_BASE_COUNT + 1)
+/*
+ * The command line builder for modprobe.  The cmd array will be directly
+ * passed to execvp.
+ *
+ * Note: the cmd array does not own the pointers in it.  Those argument
+ * pointers could come from:
+ *   - string literals (e.g. the "modprobe" and "rcuscale" command name)
+ *   - simple_params
+ */
+struct modprobe_cmd {
+	const char *cmd[MODPROBE_CMD_MAX];
+	size_t count;
+};
+
+#define MODPROBE_CMD_INIT						\
+	struct modprobe_cmd modprobe_cmd = {				\
+		{ "modprobe", "rcuscale", "block_start=1", NULL, },	\
+		MODPROBE_BASE_COUNT,					\
+	}
+#define MODPROBE_REMOVE_CMD "modprobe -r rcuscale torture"
+
+/*
+ * Generic modprobe parameter definition.  This is the storage for an
+ * instantiated module parameter.  This may come from parameters directly
+ * given by user, or generated.
+ *
+ * Format must be "key=value".
+ */
+struct modprobe_param {
+	char value[MAX_OPTVALUE];
+};
+
+/*
+ * The storage for simple (i.e. non-range) module parameter strings.
+ */
+static struct modprobe_param simple_params[MAX_OPTS];
+static int simple_params_count;
+
+static bool in_child;
+
+struct durations {
+	u64 *values;
+	size_t count;
+	size_t capacity;
+	u64 sum;
+};
+
+/* ========================== Override parameters ======================= */
+
+/* Non-override module parameter.  This may be updated by "ratio" command. */
+struct non_override_param {
+	char name[MAX_OPTNAME];
+};
+static int non_override_params_count = 3;
+static struct non_override_param non_override_params[MAX_OPTS] = {
+	{ "block_start" },
+	{ "gp_exp" },
+	{ "gp_async" },
+};
+
+struct overridable_param {
+	char name[MAX_OPTNAME];
+	bool user_overridden;
+};
+static struct overridable_param overridable_params[] = {
+	{ "writer_no_print", false },
+	{ "holdoff", false },
+};
+static const int overridable_params_count = ARRAY_SIZE(overridable_params);
+
+/* Valid module parameters parsed from modinfo. */
+struct modinfo_parm {
+	char name[MAX_OPTNAME];
+	char type[MAX_OPTTYPE];
+};
+static struct modinfo_parm modinfo_parms[MAX_OPTS];
+static int modinfo_parms_count;
+
+/* ========================== Cleanup functions ========================== */
+
+static void unload_module(void)
+{
+	if (system(MODPROBE_REMOVE_CMD) != 0)
+		fprintf(stderr, "Failed to unload rcuscale kernel module.\n"
+			"Please manually remove it using `"MODPROBE_REMOVE_CMD"`.\n");
+}
+
+static void cleanup(void)
+{
+	if (in_child)
+		return;
+
+	unload_module();
+}
+
+static void signal_handler(int sig)
+{
+	if (sig)
+		fprintf(stderr, "perf: Signal %d received\n", sig);
+	/* cleanup is registered in atexit */
+	fprintf(stderr, "Cleaning up...\n");
+	exit(1);
+}
+
+static void setup_cleanup(void)
+{
+	atexit(cleanup);
+	signal(SIGINT, signal_handler);
+	signal(SIGTERM, signal_handler);
+	signal(SIGSEGV, signal_handler);
+}
+
+/*
+ * Failure handling.  Use this for logical checks, and use "err" for those with
+ * external interactions.
+ */
+#define fail(fmt, ...)						\
+do {								\
+	fprintf(stderr, "perf: "fmt"\n", ##__VA_ARGS__);	\
+	exit(1);						\
+} while (0)
+
+/* ============================ Modprobe info ============================ */
+
+/*
+ * Parse modinfo and store the results in modinfo_parms.  Used to determine
+ * whether an option is valid as a range parameter.
+ *
+ * The expected format is:
+ *   nreaders:Number of RCU reader threads (int)
+ *   nwriters:Number of RCU updater threads (int)
+ */
+static void parse_modinfo(void)
+{
+	char *line = NULL;
+	size_t len = 0;
+	FILE *fp;
+
+	fp = popen("modinfo rcuscale -0 -F parm", "r");
+	if (!fp)
+		err(EXIT_FAILURE, "Failed to run modinfo");
+
+	while (getdelim(&line, &len, '\0', fp) != -1) {
+		char *type;
+		char *remaining = NULL;
+		char *name = strtok_r(line, ":", &remaining);
+
+		if (!name)
+			fail("Failed to parse modinfo parameter name");
+
+		type = strrchr(remaining, '(');
+		if (!type)
+			fail("Failed to parse modinfo parameter type");
+		remaining = NULL;
+		type = strtok_r(type + 1, ")", &remaining);
+		if (!type)
+			fail("Failed to parse modinfo parameter type");
+
+		strlcpy(modinfo_parms[modinfo_parms_count].name, name, MAX_OPTNAME);
+		strlcpy(modinfo_parms[modinfo_parms_count].type, type, MAX_OPTTYPE);
+		modinfo_parms_count++;
+	}
+	if (!modinfo_parms_count)
+		fail("Failed to read modinfo");
+
+	free(line);
+	pclose(fp);
+}
+
+/*
+ * Check if the module parameter is an integer.
+ */
+static bool modparm_is_int(const char *name)
+{
+	for (int i = 0; i < modinfo_parms_count; i++) {
+		if (strcmp(modinfo_parms[i].name, name) == 0)
+			return strcmp(modinfo_parms[i].type, "int") == 0;
+	}
+	return false;
+}
+
+/* ============================ Argument parsing ============================ */
+
+/*
+ * Reserve memory for a pointer.
+ *
+ * If current capacity is 0, the minimum capacity is at least INIT_CAPACITY or
+ * min_capacity.
+ *
+ * The current capacity is doubled if it is less than the minimum capacity.
+ */
+static void raw_reserve_size(void **ptr, size_t elemsize,
+		size_t *current_capacity, size_t min_capacity)
+{
+	size_t new_capacity;
+
+	if (min_capacity == 0)
+		min_capacity = INIT_CAPACITY;
+
+	if (*current_capacity >= min_capacity)
+		return;
+
+	new_capacity = *current_capacity ?: min_capacity;
+	while (new_capacity < min_capacity)
+		new_capacity *= 2;
+
+	*ptr = realloc(*ptr, new_capacity * elemsize);
+	if (!*ptr)
+		fail("Failed to allocate memory");
+	*current_capacity = new_capacity;
+}
+#define reserve_size(ptr, current_capacity, min_capacity) \
+	raw_reserve_size((void **)(ptr), sizeof(**(ptr)), (current_capacity), (min_capacity))
+
+static int parse_int(const char *val)
+{
+	char *endptr;
+	long num = strtol(val, &endptr, 10);
+
+	if (*endptr != '\0')
+		fail("Invalid integer format: %s", val);
+
+	return (int)num;
+}
+
+static void simple_params_add(const char *full)
+{
+	if (simple_params_count >= MAX_OPTS)
+		fail("Too many module parameters");
+	strlcpy(simple_params[simple_params_count++].value, full, MAX_OPTVALUE);
+}
+
+static void parse_gp_type(const char *gp_type)
+{
+	if (strcmp(gp_type, "sync") == 0) {
+		// no new option is added
+	} else if (strcmp(gp_type, "async") == 0)
+		simple_params_add("gp_async=1");
+	else if (strcmp(gp_type, "exp") == 0)
+		simple_params_add("gp_exp=1");
+	else
+		fail("Invalid grace period type: %s", gp_type);
+}
+
+/*
+ * Check if the option is already set.
+ */
+static bool param_has_conflict(const char *key)
+{
+	for (int i = 0; i < non_override_params_count; ++i) {
+		if (strcmp(key, non_override_params[i].name) == 0)
+			return true;
+	}
+	for (int i = 0; i < simple_params_count; ++i) {
+		if (strncmp(key, simple_params[i].value, strlen(key)) == 0
+			&& simple_params[i].value[strlen(key)] == '=')
+			return true;
+	}
+	/* overridable_params are considered non conflict */
+
+	return false;
+}
+
+static struct overridable_param *overridable_param_get(const char *key)
+{
+	for (int i = 0; i < overridable_params_count; ++i)
+		if (strcmp(overridable_params[i].name, key) == 0)
+			return overridable_params + i;
+	return NULL;
+}
+
+/*
+ * For overridable_params, if user specifies it, set overridden so that it will
+ * not be appended to modprobe cmd.
+ */
+static inline void param_try_set_user_override(const char *key)
+{
+	struct overridable_param *param = overridable_param_get(key);
+
+	if (param)
+		param->user_overridden = true;
+}
+
+/*
+ * Validate basics about the parameter name.
+ *
+ * Note: This is supposed to only be used during parsing user provided
+ * arguments.  This will also update the "user_overridden" flag for overridable
+ * parameters.
+ */
+static void check_param_name(const char *name)
+{
+	if (strlen(name) + 1 > MAX_OPTNAME)
+		fail("Module parameter name too long: %s", name);
+	if (param_has_conflict(name))
+		fail("Module parameter \"%s\" has conflict", name);
+	/* Set user overridden if possible */
+	param_try_set_user_override(name);
+
+	for (int i = 0; i < modinfo_parms_count; ++i) {
+		if (strcmp(modinfo_parms[i].name, name) == 0)
+			return;
+	}
+	fail("Module parameter \"%s\" does not exist in modinfo", name);
+}
+
+/*
+ * Parse module parameter.  Results are stored in params and range_params.
+ *
+ * If allow_range is false, all params are stored in params, and checks
+ * the format cannot be range.
+ *
+ * If allow_range is true, params that only has one value will be stored in
+ * params, and range ones will be stored in range_params.
+ */
+static void parse_module_params(int argc, const char *argv[])
+{
+	while (argc) {
+		char *saved_ptr = NULL;
+		char *key;
+		char *value;
+		char buf[MAX_OPTVALUE] = "";
+
+		if (strnlen(argv[0], MAX_OPTVALUE) >= MAX_OPTVALUE - 1)
+			fail("Module parameter too long: \"%s\"", argv[0]);
+		strlcpy(buf, argv[0], MAX_OPTVALUE);
+
+		/* Parse keys and values. */
+		key = strtok_r(buf, "=", &saved_ptr);
+		if (!key)
+			fail("Failed to parse module option \"%s\"", argv[0]);
+		check_param_name(key);
+
+		value = strtok_r(NULL, "=", &saved_ptr);
+		if (!value || strlen(value) == 0)
+			fail("Cannot find value for module option \"%s\"", key);
+		if (strlen(value) + 1 > MAX_OPTVALUE)
+			fail("Module parameter value too long: \"%s\"", value);
+
+		/* Ensure integer type value are integers, but don't need the value. */
+		if (modparm_is_int(key))
+			parse_int(value);
+
+		simple_params_add(argv[0]);
+
+		argc--;
+		argv++;
+	}
+}
+
+/* ====================== Experiment Result Handling ====================== */
+
+static void durations_add(struct durations *durations, u64 duration)
+{
+	reserve_size(&durations->values, &durations->capacity, durations->count + 1);
+	durations->values[durations->count++] = duration;
+	durations->sum += duration;
+}
+
+/*
+ * Parse writer durations from debugfs and push them to durations array.
+ *
+ * The expected format is writer_id,duration.
+ *
+ * Durations are converted to microseconds and stored in durations array.
+ */
+static struct durations *parse_durations(void)
+{
+	char durations_path[PATH_MAX];
+	FILE *fp = NULL;
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t read;
+	u64 duration;
+	struct durations *durations = calloc(1, sizeof(*durations));
+
+	if (!durations)
+		fail("Failed to allocate memory for durations");
+
+	snprintf(durations_path, sizeof(durations_path), "%s/rcuscale/writer_durations", debugfs);
+
+	fp = fopen(durations_path, "r");
+	if (!fp)
+		err(EXIT_FAILURE, "Failed to open writer_durations");
+
+	while ((read = getline(&line, &len, fp)) != -1) {
+		if (sscanf(line, "%*d,%lu", &duration) != 1)
+			fail("Failed to parse writer duration. Line: %s", line);
+		durations_add(durations, duration);
+	}
+
+	free(line);
+	fclose(fp);
+
+	return durations;
+}
+
+static void free_durations(struct durations *durations)
+{
+	free(durations->values);
+	free(durations);
+}
+
+/*
+ * Helper function for sorting.
+ */
+static int compare_duration(const void *a, const void *b)
+{
+	u64 aa = *(u64 *)a, bb = *(u64 *)b;
+
+	return aa < bb ? -1 : !!(aa > bb);
+}
+
+/*
+ * Print a trimmed zero converted ns to us, without automatic scientific
+ * notation like %g.
+ * e.g.  10000 ns -> 10 us
+ * e.g.  10001 ns -> 10.001 us
+ * e.g.  10100 ns -> 10.1 us
+ */
+static char *print_us(char *buf, u64 ns)
+{
+	int len;
+
+	sprintf(buf, "%"PRIu64, ns / 1000);
+	if (ns % 1000 == 0)
+		return buf;
+
+	sprintf(buf + strlen(buf), ".%03"PRIu64, ns % 1000);
+	len = strlen(buf);
+	while (len && buf[len - 1] == '0')
+		buf[--len] = '\0';
+
+	return buf;
+}
+
+/*
+ * Print statistics of writer durations.
+ *
+ * This function is derived from
+ * tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
+ * Note that the durations array are in nanoseconds, and are integers.
+ */
+static void print_writer_duration_stats(const struct durations *d)
+{
+	size_t pct50, pct90, pct99;
+	size_t count;
+	u64 div, last;
+	char ms_us_buf[30];
+	u64 *durations = d->values;
+	size_t durations_count = d->count;
+
+	if (durations_count == 0) {
+		printf("No rcuscale records found.\n");
+		return;
+	}
+
+	qsort(durations, durations_count, sizeof(*durations), compare_duration);
+
+	// Calculate percentiles
+	pct50 = max(durations_count * 50 / 100, 1UL);
+	pct90 = max(durations_count * 90 / 100, 1UL);
+	pct99 = max(durations_count * 99 / 100, 1UL);
+
+#define US_NS 1000
+#define us(ns) print_us(ms_us_buf, (ns))
+
+	if (show_hist) {
+		// Calculate histogram bucket size based on 90th percentile
+		div = pow(10, floor(log10((double)durations[pct90 - 1]) + 0.5)) / 100;
+		if (div <= 0)
+			div = 1;
+		printf("Histogram bucket size: %s microseconds\n", us(div));
+
+		last = durations[0] - 10 * US_NS;
+		count = 0;
+		for (size_t i = 0; i < durations_count; ++i) {
+			u64 current = durations[i] / div * div;
+
+			if (last == current) {
+				count++;
+			} else {
+				if (count > 0)
+					printf("%s %lu\n", us(last), count);
+				count = 1;
+				last = current;
+			}
+		}
+		if (count > 0)
+			printf("%s %lu\n", us(last), count);
+	}
+
+	// Print statistics
+	printf("Average grace-period duration: %s microseconds\n", us(d->sum / durations_count));
+	printf("Minimum grace-period duration: %s\n", us(durations[0]));
+	printf("50th percentile grace-period duration: %s\n", us(durations[pct50 - 1]));
+	printf("90th percentile grace-period duration: %s\n", us(durations[pct90 - 1]));
+	printf("99th percentile grace-period duration: %s\n", us(durations[pct99 - 1]));
+	printf("Maximum grace-period duration: %s\n", us(durations[durations_count - 1]));
+
+#undef US_NS
+#undef us
+}
+
+/* ============================ Experiment Functions ============================ */
+
+/*
+ * Trigger the experiment by writing 1 to should_start.
+ */
+static void start_experiment(void)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "%s/rcuscale/should_start", debugfs);
+
+	fp = fopen(path, "w");
+	if (!fp)
+		err(EXIT_FAILURE, "Failed to open %s", path);
+
+	if (fprintf(fp, "1\n") < 0)
+		err(EXIT_FAILURE, "Failed to write %s", path);
+
+	fclose(fp);
+}
+
+/*
+ * Wait for the experiment to complete by reading test_complete once every
+ * second, until it is not 0.
+ */
+static void wait_experiment(void)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/rcuscale/test_complete", debugfs);
+
+	while (true) {
+		int finished;
+		FILE *fp = fopen(path, "r");
+
+		if (!fp)
+			err(EXIT_FAILURE, "Failed to open %s", path);
+
+		if (fscanf(fp, "%d", &finished) != 1) {
+			fclose(fp);
+			err(EXIT_FAILURE, "Failed to read %s", path);
+		}
+
+		fclose(fp);
+
+		if (finished)
+			break;
+
+		sleep(1);
+	}
+}
+
+/*
+ * Run the constructed modprobe command.
+ */
+static void run_modprobe(const struct modprobe_cmd *cmd)
+{
+	int retval;
+	pid_t pid;
+
+	if (dryrun)
+		return;
+
+	pid = fork();
+	if (pid < 0)
+		err(EXIT_FAILURE, "Failed to fork child process");
+
+	if (pid == 0) {
+		execvp(cmd->cmd[0], (char *const *)cmd->cmd);
+		in_child = true;
+		err(EXIT_FAILURE, "Failed to execute modprobe command");
+	}
+	waitpid(pid, &retval, 0);
+	if (retval)
+		fail("modprobe failed, exiting.");
+}
+
+/*
+ * Print modprobe parameters, but skip the base command line, and also skip
+ * those overridable params not overridden by user.
+ */
+static void print_params(const struct modprobe_cmd *cmd)
+{
+	bool printed = false;
+	char keybuf[MAX_OPTNAME];
+	struct overridable_param *param;
+
+	printf("Running experiment with options:");
+	for (int i = MODPROBE_BASE_COUNT; cmd->cmd[i] != NULL; ++i) {
+		if (sscanf(cmd->cmd[i], "%[^=]=", keybuf) != 1)
+			fail("Invalid generated modprobe parameter: %s", cmd->cmd[i]);
+		param = overridable_param_get(keybuf);
+		if (param == NULL || param->user_overridden) {
+			printed = true;
+			printf(" %s", cmd->cmd[i]);
+		}
+	}
+	if (!printed)
+		printf(" (default)\n");
+	else
+		printf("\n");
+}
+
+/*
+ * Core Experiment function
+ */
+static void runonce(const struct modprobe_cmd *modprobe_cmd)
+{
+	struct durations *durations;
+
+	print_params(modprobe_cmd);
+	run_modprobe(modprobe_cmd);
+
+	if (dryrun)
+		return;
+
+	/* Start and wait for experiment */
+	start_experiment();
+	wait_experiment();
+
+	/* Parse writer durations */
+	/* Wait until all kernel threads enter final wait */
+	sleep(1);
+	durations = parse_durations();
+	unload_module();
+
+	printf("Experiment finished.\n");
+
+	/* Print statistics */
+	print_writer_duration_stats(durations);
+	free_durations(durations);
+}
+
+static void modprobe_cmd_add(struct modprobe_cmd *cmd, const char *v)
+{
+	// 2 for NULL and v
+	if (cmd->count + 2 >= MODPROBE_CMD_MAX)
+		fail("Too many module parameters");
+	cmd->cmd[cmd->count] = v;
+	cmd->cmd[++cmd->count] = NULL;
+}
+
+/*
+ * Append parameters that are overridable by users.
+ */
+static void modprobe_cmd_add_overridable(struct modprobe_cmd *cmd)
+{
+	if (!param_has_conflict("writer_no_print"))
+		modprobe_cmd_add(cmd, "writer_no_print=1");
+	if (!param_has_conflict("holdoff"))
+		modprobe_cmd_add(cmd, "holdoff=3");
+}
+
+/*
+ * Collect simple options into modprobe_cmd.
+ */
+static void modprobe_collect_simple_options(struct modprobe_cmd *cmd)
+{
+	for (int i = 0; i < simple_params_count; ++i)
+		modprobe_cmd_add(cmd, simple_params[i].value);
+
+	modprobe_cmd_add_overridable(cmd);
+}
+
+/*
+ * Test once.  Does not allow ranges.
+ */
+static void test_once(int argc, const char *argv[])
+{
+	MODPROBE_CMD_INIT;
+
+	parse_module_params(argc, argv);
+
+	modprobe_collect_simple_options(&modprobe_cmd);
+
+	runonce(&modprobe_cmd);
+}
+
+/* ============================= Entry Point ============================== */
+
+int bench_sync_rcu(int argc, const char **argv)
+{
+	void (*cmd)(int argc, const char *argv[]);
+	const char *runmode, *gp_type;
+
+	/* Reset errno to avoid printing irrelavent error string */
+	errno = 0;
+
+	/* Parse global options first. */
+	argc = parse_options(argc, argv, bench_rcu_options, bench_rcu_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/* The empty case is equivalent to 'once sync'.
+	 * Otherwise, at least two positional options are required:
+	 * once/range/ratio and sync/async/exp
+	 */
+	if (argc == 0) {
+		runmode = "once";
+		gp_type = "sync";
+	} else if (argc < 2) {
+		usage_with_options(bench_rcu_usage, bench_rcu_options);
+	} else {
+		runmode = argv[0];
+		gp_type = argv[1];
+		argc -= 2;
+		argv += 2;
+	}
+
+	if (strcmp(runmode, "once") == 0)
+		cmd = test_once;
+	else
+		usage_with_options(bench_rcu_usage, bench_rcu_options);
+
+	parse_gp_type(gp_type);
+
+	parse_modinfo();
+	if (system(MODPROBE_REMOVE_CMD) != 0)
+		err(EXIT_FAILURE, "Unloading existing rcuscale module failed");
+
+	setup_cleanup();
+
+	cmd(argc, argv);
+
+	return 0;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 8d945b846321..9d2e765c7e16 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -55,6 +55,7 @@ static struct bench sched_benchmarks[] = {
 static struct bench sync_benchmarks[] = {
 	{ "qspinlock",	"Benchmark for queued spinlock",		bench_sync_qspinlock	},
 	{ "ticket",	"Benchmark for ticket spinlock",		bench_sync_ticket	},
+	{ "rcu",	"Benchmark using rcuscale kernel module",	bench_sync_rcu		},
 	{ "all",	"Run all synchronization benchmarks",		NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.50.1.565.gc32cd1483b-goog

