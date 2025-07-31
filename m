Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877D2D0283
	for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968421; cv=none; b=AwRfTd/IIIxZTOGORANpIpK5K6kAxuoa4xHWGOZWp+O9e3CzqhHTd4Gs4WqZkZK2/UkBNzF/FrbljhN8fJJlTpXOMqclW4eq230ji+Vf9PlKXyHbqkn+V+KCqU8xA/OXAP5yMUZovAeifV5H86mLq9Nkzk4qqcJpxu641Um8hYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968421; c=relaxed/simple;
	bh=uAaOsx58SAIc0DaiyhmSbn/jax0B8hzvHf4y49AyUtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KuB6GUz/WrszbCMmBYprLxgZki8aphrPLzKOSQqS+GW3Hlk3pF8P20b0u+FaWHzS4Ez6IDNzEhoAz6lrqYqEcByQBnn5X7xiy9J8L83ezyQzPBS5uYkpkRmcwfImd5LtsKnWu8wXJ/qG2sP5fGxtSZOrFr46eRmiu3apqqj3S+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+v83ibV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+v83ibV"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso1046519a91.1
        for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968419; x=1754573219; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIx8Yrl2dRhsZZNWCwwoUy/r9MaHjZd4+Pz8DrLT0Nw=;
        b=A+v83ibVcZaLAOM4rrbMoRTKoada3CZhdpB1OzHfXKZgKR9N54nBlGbsVYHjV5fdCU
         J1eUyfUDcjRrfK7VU771emr4l9uWebjczgJbPFrdhacdQDKF3RWOx0rFdkomwSHeBGOt
         1Ge6qx+WgAeARn7QmpLxVfUVPrd4ahI/4RTAwzeZqdqrOBajpSKXEaWm0kRNXkFZfjmV
         WJnbILMVFIyvrLA/MfvDZWLdK5yB9I4zF4gL+u0+sdvjTWVWePFrjwmDH7Hgi1AkAC5o
         QGEkXx7+krk3+juZTwXPhBwOSJ5ewRiLeWFqwZ0Jh9ht9t4Ghm0tih2W6y+ZQ/HpwMlW
         xDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968419; x=1754573219;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIx8Yrl2dRhsZZNWCwwoUy/r9MaHjZd4+Pz8DrLT0Nw=;
        b=hUFpnG02uC0i0+GVlpXMRhgaJkvuF1CCv97gfilS+Pj7ABdqcR1MrLR3JNZ6+aAHum
         Ogxb2HqkLBShBrQjwJs+E201osLTfZs/bTr+bpRB9FDEqtdq/fdfVzysfIibc6ofuJOj
         dQBfr0giVdkBX3l4vJDfSteHobtnCSOiHfzcbi879nV3YVPKTbko/mbnmaoA5EEy9pAK
         32wTY9ltgBmR8P7gXBICMqS1UZNYZV5+CZ/diimbhpNUkPdTyxKkJWczJa2nb5Nwsmjl
         +l2ASwKsCSFcOCjQeJQA22fKFSfps7/QH8GlS3pMkvVV93f5q9MkkMccINNiiJR3XfB7
         K5AA==
X-Forwarded-Encrypted: i=1; AJvYcCXeRjrT68mTTj8ImZtlbhDq3NE3e/QYWGwZ0wbt813ImjFlQSpcKC0/WaGIV5GoOe2DBts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4PI+YXB7FQyrLdWru35XBNKaabsGLZ6hotKakQzIJp2L0ZqE
	yGekFJsQbhYMB1+ql8VQlx9axkzo3k+lJ4noyQ2JQ0WbN1RB5IfbRJUtOyJEz7kbO19SkP7A6sA
	vS5JvTw==
X-Google-Smtp-Source: AGHT+IEh/5sOTgA8qE5uzJr4lbFyhYU/sDirMMjY/1aldSGmBNHAtwFN7iym8avJdbqOTRFHWAEdbnNnqLE=
X-Received: from pjqx17.prod.google.com ([2002:a17:90a:b011:b0:314:29b4:453])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c48:b0:316:3972:b9d0
 with SMTP id 98e67ed59e1d1-31f5dc953d4mr9913423a91.0.1753968418498; Thu, 31
 Jul 2025 06:26:58 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:13 -0700
In-Reply-To: <20250731132615.938435-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731132615.938435-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-4-yuzhuo@google.com>
Subject: [PATCH v1 3/5] perf bench: Add 'range' mode to 'sync rcu'
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

Add 'range' mode to test multiple combinations of parameters in
rcuscale.  The command format is similar to 'once', but allows
parameters to be specified as 'name=start[:end:[:step]]', inclusive
integer ranges.  The default step is 1.

This 'range' mode allows multiple parameters to be ranges, and in that
scenario, the benchmark will enumerate all combinations of all ranges.

Example usage below running 6 scenarios of
  [nreaders = 1 or 2] x [writer_cpu_offset = 0 or 1 or 2]:

From the result, we can see that overlapping or non-overlapping reader
and writer CPU affinity will affect performance characteristics.

$ ./perf bench sync rcu range exp  nreaders=1:2 nwriters=1 writer_cpu_offset=0:2
\# Running 'sync/rcu' benchmark:
Running experiment with options: gp_exp=1 nwriters=1 nreaders=1 writer_cpu_offset=0
Experiment finished.
Average grace-period duration: 297.535 microseconds
Minimum grace-period duration: 8.853
50th percentile grace-period duration: 9.044
90th percentile grace-period duration: 9.905
99th percentile grace-period duration: 5724.727
Maximum grace-period duration: 12029.204
Cooling down (3s)..

Running experiment with options: gp_exp=1 nwriters=1 nreaders=1 writer_cpu_offset=1
Experiment finished.
Average grace-period duration: 15.491 microseconds
Minimum grace-period duration: 8.863
50th percentile grace-period duration: 9.354
90th percentile grace-period duration: 21.142
99th percentile grace-period duration: 50.195
Maximum grace-period duration: 319.359
Cooling down (3s)..

Running experiment with options: gp_exp=1 nwriters=1 nreaders=1 writer_cpu_offset=2
Experiment finished.
Average grace-period duration: 21.439 microseconds
Minimum grace-period duration: 11.046
50th percentile grace-period duration: 16.134
90th percentile grace-period duration: 32.819
99th percentile grace-period duration: 53.59
Maximum grace-period duration: 186.71
Cooling down (3s)..

Running experiment with options: gp_exp=1 nwriters=1 nreaders=2 writer_cpu_offset=0
Experiment finished.
Average grace-period duration: 122.448 microseconds
Minimum grace-period duration: 8.934
50th percentile grace-period duration: 9.234
90th percentile grace-period duration: 9.895
99th percentile grace-period duration: 13.31
Maximum grace-period duration: 6024.476
Cooling down (3s)..

Running experiment with options: gp_exp=1 nwriters=1 nreaders=2 writer_cpu_offset=1
Experiment finished.
Average grace-period duration: 68.765 microseconds
Minimum grace-period duration: 8.913
50th percentile grace-period duration: 9.144
90th percentile grace-period duration: 9.384
99th percentile grace-period duration: 10.505
Maximum grace-period duration: 6023.405
Cooling down (3s)..

Running experiment with options: gp_exp=1 nwriters=1 nreaders=2 writer_cpu_offset=2
Experiment finished.
Average grace-period duration: 12.079 microseconds
Minimum grace-period duration: 9.204
50th percentile grace-period duration: 9.344
90th percentile grace-period duration: 11.538
99th percentile grace-period duration: 41.152
Maximum grace-period duration: 78.478

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/sync-rcu.c | 199 ++++++++++++++++++++++++++++++++++--
 1 file changed, 193 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/sync-rcu.c b/tools/perf/bench/sync-rcu.c
index 934d2416c216..921520a645ae 100644
--- a/tools/perf/bench/sync-rcu.c
+++ b/tools/perf/bench/sync-rcu.c
@@ -54,6 +54,7 @@ static const char *const bench_rcu_usage[] = {
 	"",
 	"perf bench sync rcu [options..] [-- <command>..]",
 	"perf bench sync rcu [options..] once  <gp_type> [<param=value>..] [-- <command>..]",
+	"perf bench sync rcu [options..] range <gp_type> [<param=range>..] [-- <command>..]",
 	"",
 	"  <gp_type>: The type of grace period to use: sync, async, exp (expedited)",
 	"             This sets the gp_exp or gp_async kernel module parameters.",
@@ -76,11 +77,18 @@ static const char *const bench_rcu_usage[] = {
 	"  default: Run 'once sync'.",
 	"  once:  Run benchmark once, with all parameters passed through to the",
 	"         kernel rcuscale module.",
+	"  range: Run benchmark multiple times, with parameters as ranges.",
+	"         Range format is defined as start[:end[:step]], inclusive, non-negative.",
+	"         The benchmark instantiates all combinations of all ranges.",
+	"         If a parameter does not specify end, or start=end, it behaves",
+	"         the same as 'once' mode.  The range parameter types are validated",
+	"         agains `modinfo rcuscale` to ensure they are integer.",
 	"",
 	"Examples:",
 	"  perf bench sync rcu --hist once exp nreaders=1 nwriters=1 writer_cpu_offset=1",
 	"  perf bench sync rcu once",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1",
+	"  perf bench sync rcu range exp  nreaders=1:2 nwriters=1 writer_cpu_offset=0:2",
 	"",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1 -- \\",
 	"      perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period \\",
@@ -105,6 +113,7 @@ static const char *const bench_rcu_usage[] = {
  * pointers could come from:
  *   - string literals (e.g. the "modprobe" and "rcuscale" command name)
  *   - simple_params
+ *   - generated param from ranges
  */
 struct modprobe_cmd {
 	const char *cmd[MODPROBE_CMD_MAX];
@@ -146,6 +155,30 @@ struct modprobe_param {
 	char value[MAX_OPTVALUE];
 };
 
+/*
+ * Parsed range module parameter.  The collected range_params will be
+ * instantiated to actual values, and then collected into modprobe_cmd.
+ *
+ * The range is inclusive.
+ *
+ * Example range: start=1 end=9 step=2 will instantiate values 1, 3 5 7 9.
+ */
+struct range {
+	int start;
+	int end;
+	int step;
+};
+struct range_option {
+	char name[MAX_OPTNAME];
+	struct range range;
+};
+
+/*
+ * The storage of range parameters.
+ */
+static struct range_option range_params[MAX_OPTS];
+static int range_params_count;
+
 /*
  * The storage for simple (i.e. non-range) module parameter strings.
  */
@@ -346,6 +379,75 @@ static int parse_int(const char *val)
 	return (int)num;
 }
 
+/*
+ * Parse a range string into a range struct.  The range is inclusive.
+ *
+ * The range string is in the format of "start[:end[:step]]".
+ * The default step is 1.
+ *
+ * Example:
+ *   "1:10:2" -> start=1, end=10, step=2
+ *   "1:10"   -> start=1, end=10, step=1
+ *   "1"      -> start=1, end=1, step=1
+ */
+static int parse_range(struct range *range, const char *str)
+{
+#define MAX_RANGE 5
+
+	char *token;
+	char *saveptr = NULL;
+	int count = 0;
+	int values[MAX_RANGE];
+
+	char *str_copy = strdup(str);
+
+	if (!str_copy)
+		fail("Memory allocation failed");
+
+	// Split by : or -
+	token = strtok_r(str_copy, ":", &saveptr);
+	while (token != NULL && count < MAX_RANGE) {
+		values[count++] = parse_int(token);
+		token = strtok_r(NULL, ":", &saveptr);
+	}
+
+	switch (count) {
+	case 1:
+		range->start = values[0];
+		range->end = values[0];
+		range->step = 1;
+		break;
+	case 2:
+		range->start = values[0];
+		range->end = values[1];
+		range->step = 1;
+		break;
+	case 3:
+		range->start = values[0];
+		range->end = values[1];
+		range->step = values[2];
+		break;
+	default:
+		free(str_copy);
+		fail("Invalid range format: \"%s\"", str);
+	}
+
+	if (range->start < 0 || range->end < 0)
+		fail("Range must be non negative");
+	if (range->start > range->end)
+		fail("Range start must be smaller or equal to end");
+	if (range->step <= 0)
+		fail("Range step must be positive");
+
+	free(str_copy);
+	return 0;
+
+#undef MAX_RANGE
+}
+
+#define param_print_key_value(param, fmt, ...) \
+	snprintf((param)->value, MAX_OPTVALUE, fmt, ##__VA_ARGS__)
+
 static void simple_params_add(const char *full)
 {
 	if (simple_params_count >= MAX_OPTS)
@@ -353,6 +455,14 @@ static void simple_params_add(const char *full)
 	strlcpy(simple_params[simple_params_count++].value, full, MAX_OPTVALUE);
 }
 
+static void range_params_add(const char *name, const struct range *range)
+{
+	if (range_params_count >= MAX_OPTS)
+		fail("Too many module parameters");
+	strlcpy(range_params[range_params_count].name, name, MAX_OPTNAME);
+	range_params[range_params_count++].range = *range;
+}
+
 static void parse_gp_type(const char *gp_type)
 {
 	if (strcmp(gp_type, "sync") == 0) {
@@ -379,6 +489,10 @@ static bool param_has_conflict(const char *key)
 			&& simple_params[i].value[strlen(key)] == '=')
 			return true;
 	}
+	for (int i = 0; i < range_params_count; ++i) {
+		if (strcmp(key, range_params[i].name) == 0)
+			return true;
+	}
 	/* overridable_params are considered non conflict */
 
 	return false;
@@ -436,10 +550,12 @@ static void check_param_name(const char *name)
  * If allow_range is true, params that only has one value will be stored in
  * params, and range ones will be stored in range_params.
  */
-static void parse_module_params(int argc, const char *argv[])
+static void parse_module_params(int argc, const char *argv[], bool allow_range)
 {
 	while (argc) {
 		char *saved_ptr = NULL;
+		struct range range;
+		bool is_range = false;
 		char *key;
 		char *value;
 		char buf[MAX_OPTVALUE] = "";
@@ -467,11 +583,26 @@ static void parse_module_params(int argc, const char *argv[])
 		if (strlen(value) + 1 > MAX_OPTVALUE)
 			fail("Module parameter value too long: \"%s\"", value);
 
-		/* Ensure integer type value are integers, but don't need the value. */
-		if (modparm_is_int(key))
-			parse_int(value);
+		if (modparm_is_int(key)) {
+			/* Detect range options. */
+			if (allow_range) {
+				parse_range(&range, value);
+				is_range = !(range.start == range.end
+					|| range.start + range.step > range.end);
+			} else {
+				/* Ensure integer type value are integers,
+				 * but don't need the value.
+				 */
+				if (modparm_is_int(key))
+					parse_int(value);
+			}
+		}
 
-		simple_params_add(argv[0]);
+		/* Store the option. */
+		if (is_range)
+			range_params_add(key, &range);
+		else
+			simple_params_add(argv[0]);
 
 		argc--;
 		argv++;
@@ -973,6 +1104,11 @@ static void modprobe_cmd_add(struct modprobe_cmd *cmd, const char *v)
 	cmd->cmd[++cmd->count] = NULL;
 }
 
+static void modprobe_cmd_pop(struct modprobe_cmd *cmd)
+{
+	cmd->cmd[--cmd->count] = NULL;
+}
+
 /*
  * Append parameters that are overridable by users.
  */
@@ -1002,13 +1138,62 @@ static void test_once(int argc, const char *argv[])
 {
 	MODPROBE_CMD_INIT;
 
-	parse_module_params(argc, argv);
+	parse_module_params(argc, argv, false);
 
 	modprobe_collect_simple_options(&modprobe_cmd);
 
 	runonce(&modprobe_cmd);
 }
 
+/*
+ * Recursively generate modprobe options from the range command.
+ *
+ * This will modify the global params storage and
+ * params_count, and also collect new options into modprobe_cmd.
+ */
+static void test_range_recursive(int range_index, struct modprobe_cmd *cmd)
+{
+	struct range range;
+
+	if (range_index >= range_params_count)
+		return runonce(cmd);
+
+	range = range_params[range_index].range;
+
+	for (int i = range.start; i <= range.end; i += range.step) {
+		struct modprobe_param param;
+
+		param_print_key_value(&param, "%s=%d",
+				range_params[range_index].name, i);
+		modprobe_cmd_add(cmd, param.value);
+
+		test_range_recursive(range_index + 1, cmd);
+
+		modprobe_cmd_pop(cmd);
+
+		if (i + range.step <= range.end) {
+			printf("Cooling down (%ds)..\n", cooldown);
+			if (!dryrun)
+				sleep(cooldown);
+			puts("");
+		}
+	}
+}
+
+/*
+ * Test range.  Use recursion on all range commands.
+ */
+static void test_range(int argc, const char *argv[])
+{
+	MODPROBE_CMD_INIT;
+
+	parse_module_params(argc, argv, true);
+
+	modprobe_collect_simple_options(&modprobe_cmd);
+
+	test_range_recursive(0, &modprobe_cmd);
+}
+
 /* ============================= Entry Point ============================== */
 
 int bench_sync_rcu(int argc, const char **argv)
@@ -1041,6 +1226,8 @@ int bench_sync_rcu(int argc, const char **argv)
 
 	if (strcmp(runmode, "once") == 0)
 		cmd = test_once;
+	else if (strcmp(runmode, "range") == 0)
+		cmd = test_range;
 	else
 		usage_with_options(bench_rcu_usage, bench_rcu_options);
 
-- 
2.50.1.565.gc32cd1483b-goog

