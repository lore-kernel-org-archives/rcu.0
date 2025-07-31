Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD62C3745
	for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968419; cv=none; b=b3eUiSBUalPBeJVHHsQAy4/XpDLMTO0RGdKqGik7nRRUAliRaOFynbaHaFJylERDQQHnmbKdEnPNBT0GzbJJN7c7NUcJWgzk+Q6sVYs6RzQCQ6I2mLgg9DUaNStWYRl7arBAuRry2ClKfe1BofNFS23FpDVvZxfX5LkJvIC6Ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968419; c=relaxed/simple;
	bh=SDLv3vRUm4a7IfRMbe5z27kgDuKQZrYHeqcv2Xeh6+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FS21dYYY9rFwQxldEPXGnRK6Nw+98z15ZKt3v3ulcKzrSL1+06VytTQpFd4BQKtgPiUyyl3UifWihLW7uSn0CMbgeVe+uDwo99EIS3gV54XoGvduTkZXRnzTyRxtZlq/UuJ16sljXyp1Ot50Uwrr9SblMquWg8dqx4BAcmK9RKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbBCNywm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbBCNywm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so1065000b3a.2
        for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968417; x=1754573217; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wx1jGBaHmAOK84M8vVvUKtj0B4hkxXN2QqsHHZy6RfE=;
        b=wbBCNywmmpqQQ81W3dFaBcU308v0MLBz+V0Y//o5I/jCfTJs7kmdqLIXQxvMVmdcBJ
         +lDjAg14SAVnG1yoq7uGDltRvaKfORXU59Y+j1bHFcpWM2yKu0Ptjx/Kx2gd273THlWc
         BocD6kagQixb95YOooZ+yYrH+ZKw6VUqkMS6jvO0cvIEj515vEH7yt4ZakofnOWKtaaM
         CrJWX4hbcBnF5tpby+IK7nQa/Yfsv1lWZlAsiATWMr+kLG+QqxkEURvTiwpngaVRam0+
         5aVJ/XbIz2NGSxuXP78oYVsiAdECyAa+GAqLOWipacyYCNTRksCDcfxBiRJQwCGTj4t3
         DkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968417; x=1754573217;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx1jGBaHmAOK84M8vVvUKtj0B4hkxXN2QqsHHZy6RfE=;
        b=fajvSO9fK1PL6eKmfIlCzw2JE1+4VtFUyVSd3FTQzttr83pgb1XoeQWpfFPCxA7dGo
         yB2Dz5vLCYZnIvlwMzVfj7wQ04qXBlO37ZNIwjrvTVuwxzxFXjRucwR8shQDGiuFsj24
         6o1H9WX61OSD7nAAs/FCQbm8BPYb36ZrNdhnJEnxVBAOgWO77sA7ydFbTRmo5NxfE3P/
         HflADSuYwCP3OSvSfcmEK3Cj1sBNxl/2b+cpgP/yVEaiX2oevSxar5VQGRuJln7xvJvG
         LJdc1FHjwAglrzjh3ZTyqdyWQwQcxl5LbCz4YvZcgPrdIKj/hz3uMr9D6muU2oQETLso
         sYcw==
X-Forwarded-Encrypted: i=1; AJvYcCXMWxhhvm9HmyoBQiXhQX9Lx72r2fQnkpODumjuAg3gFQQ9YAJsDPJ5cCAp3MxU275aAbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGJUm9YU8y/+7wCDm+EXEY/BaKbHZF9JvL0hY0ONdLl9DtsZS
	gowF82nYkA7ZJpFjlLXxbQvPev+UywkaXeqTMbljnAAKsH2fbQFi4oi080jxXQYcmeDC347Ighz
	SytlOXA==
X-Google-Smtp-Source: AGHT+IHy977OGKGUfQxfPzzgX/dUwkN3T5owF6V3wWPLDAGGgMWB1YafYG5tVw6JssVvWq6hdTG9MJzAQrY=
X-Received: from pfll8.prod.google.com ([2002:a05:6a00:1588:b0:747:9faf:ed39])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:339d:b0:218:96ad:720d
 with SMTP id adf61e73a8af0-23dc0cf784dmr9622346637.1.1753968416873; Thu, 31
 Jul 2025 06:26:56 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:12 -0700
In-Reply-To: <20250731132615.938435-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731132615.938435-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-3-yuzhuo@google.com>
Subject: [PATCH v1 2/5] perf bench: Implement subprocess execution for 'sync rcu'
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

Monitor system state is useful for understanding performance impact.
This patch enables running external tool during the benchmark.  It
provides a similar semantic to 'perf record -- perf bench mem', except
that the order is reversed.

Because the benchmark threads are kernel module created kthreads, perf
cannot directly attach to them.  This patch propose a method to execute
the attach command from a child process, using command line
substitution.

If any of the command string contains "{READER,WRITER,KFREE}_TASKS"
placeholder, they are replaced with the real value upon startup.  The
thread ID information comes from
/sys/kernel/debug/rcuscale/{reader,writer,kfree}_tasks.

Example usage of running 'perf stat' to attach kernel threads:

$ ./perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1 -- \
          perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period \
          -t READER_TASKS,WRITER_TASKS
\# Running 'sync/rcu' benchmark:
Running experiment with options: nreaders=1 nwriters=1 writer_cpu_offset=1
Running child command: perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period -t 1682932,1682933

 Performance counter stats for thread id '1682932,1682933':

             20105      ipi:ipi_send_cpu
               702      rcu:rcu_grace_period

      25.023871111 seconds time elapsed

Experiment finished.
Waiting for child process to exit.
Average grace-period duration: 188128.652 microseconds
Minimum grace-period duration: 9000.221
50th percentile grace-period duration: 217996.932
90th percentile grace-period duration: 218001.019
99th percentile grace-period duration: 218153.558
Maximum grace-period duration: 326999.705

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/sync-rcu.c | 252 +++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/sync-rcu.c b/tools/perf/bench/sync-rcu.c
index ac85841f0b68..934d2416c216 100644
--- a/tools/perf/bench/sync-rcu.c
+++ b/tools/perf/bench/sync-rcu.c
@@ -5,6 +5,7 @@
  * 2025  Yuzhuo Jing <yuzhuo@google.com>
  */
 #include <dirent.h>
+#include <ctype.h>
 #include <err.h>
 #include <errno.h>
 #include <inttypes.h>
@@ -32,6 +33,7 @@
 static bool dryrun;
 static unsigned int cooldown = 3;
 static bool show_hist;
+static unsigned int child_delay = 1;
 static const char *debugfs = "/sys/kernel/debug";
 
 static const struct option bench_rcu_options[] = {
@@ -40,6 +42,8 @@ static const struct option bench_rcu_options[] = {
 		"Sleep time between each run (default: 3 seconds)"),
 	OPT_BOOLEAN(0,		"hist",		&show_hist,
 		"Show histogram of writer durations"),
+	OPT_UINTEGER(0,		"child-delay",	&child_delay,
+		"Wait for child startup before starting experiment (default: 1 second)"),
 	OPT_STRING(0,		"debugfs",	&debugfs,	"path",
 		"Debugfs mount point (default: /sys/kernel/debug)"),
 	OPT_END()
@@ -48,13 +52,18 @@ static const struct option bench_rcu_options[] = {
 static const char *const bench_rcu_usage[] = {
 	"RCU benchmark using rcuscale kernel module.",
 	"",
-	"perf bench sync rcu [options..]",
-	"perf bench sync rcu [options..] once  <gp_type> [<param=value>..]",
+	"perf bench sync rcu [options..] [-- <command>..]",
+	"perf bench sync rcu [options..] once  <gp_type> [<param=value>..] [-- <command>..]",
 	"",
 	"  <gp_type>: The type of grace period to use: sync, async, exp (expedited)",
 	"             This sets the gp_exp or gp_async kernel module parameters.",
 	"  <param>:   Any parameter of the rcuscale kernel module, e.g. holdoff=5.",
 	"             Valid options can be found from running `modinfo rcuscale`.",
+	"  <command>: A child command to run during the experiment.  This is useful",
+	"             for running tools that monitor system metrics during the",
+	"             experiment. If the command line string contains",
+	"             {READER,WRITER,KFREE}_TASKS placeholders, they will be substituted",
+	"             with the tasks PIDs, separated by comma.",
 	"",
 	"Notes on param:",
 	"  This benchmark manages gp_exp and gp_async, and sets block_start=1.",
@@ -73,6 +82,10 @@ static const char *const bench_rcu_usage[] = {
 	"  perf bench sync rcu once",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1",
 	"",
+	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1 -- \\",
+	"      perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period \\",
+	"      -t READER_TASKS,WRITER_TASKS",
+	"",
 	"In case perf exited abnormally, user need to unload rcuscale by running:",
 	"  modprobe -r rcuscale torture",
 	"",
@@ -105,6 +118,23 @@ struct modprobe_cmd {
 	}
 #define MODPROBE_REMOVE_CMD "modprobe -r rcuscale torture"
 
+/*
+ * Generated subprocess command.
+ *
+ * Different from modprobe_cmd, this struct is owns the argv array and all
+ * strings in the array.  The only exception is child_cmd_template, which
+ * contains the remainder of argv parsing.
+ *
+ * Upon each runonce(), generate_child_command will make a copy of the strings
+ * in child_cmd_template and also substitute placeholders to actual value.
+ */
+struct child_cmd {
+	int argc;
+	char **argv;
+};
+
+static struct child_cmd child_cmd_template;
+
 /*
  * Generic modprobe parameter definition.  This is the storage for an
  * instantiated module parameter.  This may come from parameters directly
@@ -122,6 +152,7 @@ struct modprobe_param {
 static struct modprobe_param simple_params[MAX_OPTS];
 static int simple_params_count;
 
+static pid_t child_pid;
 static bool in_child;
 
 struct durations {
@@ -177,6 +208,12 @@ static void cleanup(void)
 		return;
 
 	unload_module();
+
+	if (child_pid) {
+		kill(child_pid, SIGTERM);
+		waitpid(child_pid, NULL, 0);
+		child_pid = 0;
+	}
 }
 
 static void signal_handler(int sig)
@@ -407,6 +444,13 @@ static void parse_module_params(int argc, const char *argv[])
 		char *value;
 		char buf[MAX_OPTVALUE] = "";
 
+		/* Handle child command. */
+		if (strcmp(argv[0], "--") == 0) {
+			child_cmd_template.argc = argc - 1;
+			child_cmd_template.argv = (char **)argv + 1;
+			break;
+		}
+
 		if (strnlen(argv[0], MAX_OPTVALUE) >= MAX_OPTVALUE - 1)
 			fail("Module parameter too long: \"%s\"", argv[0]);
 		strlcpy(buf, argv[0], MAX_OPTVALUE);
@@ -434,6 +478,162 @@ static void parse_module_params(int argc, const char *argv[])
 	}
 }
 
+/* ======================== Child Command Handling ========================= */
+
+/*
+ * Read reader, writer, or kfree tasks from debugfs, and return a comma
+ * separated string.
+ */
+static char *get_tids(const char *debugfs_filename)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+
+	char *tids = calloc(INIT_CAPACITY, sizeof(char));
+	size_t tids_len = 0;
+	size_t tids_capacity = INIT_CAPACITY;
+
+	char *line = NULL;
+	size_t line_buf_size = 0;
+
+	if (!tids)
+		fail("Failed to allocate memory for substitute string");
+
+	snprintf(path, sizeof(path), "%s/rcuscale/%s", debugfs, debugfs_filename);
+
+	fp = fopen(path, "r");
+	if (!fp)
+		err(EXIT_FAILURE, "Failed to open %s", path);
+
+	while (getline(&line, &line_buf_size, fp) != -1) {
+		size_t line_len = strlen(line);
+		bool is_first = (tids_len == 0);
+
+		// trim white space and new line characters
+		while (line_len && isspace(line[line_len - 1]))
+			line[--line_len] = '\0';
+
+		// 2 for NUL-terminator and ","
+		reserve_size(&tids, &tids_capacity, tids_len + line_len + 2);
+		// skip "," for the first value
+		if (!is_first)
+			strlcpy(tids + tids_len, ",", 2);
+		strcat(tids + tids_len, line);
+		tids_len += line_len + !is_first;
+	}
+
+	free(line);
+	fclose(fp);
+
+	return tids;
+}
+
+/*
+ * Replace the placeholder with the actual value.  Modifies the given new string.
+ */
+static void replace_child_arg(char **arg, const char *placeholder,
+				const char *debugfs_filename, char **replacement)
+{
+	size_t str_capacity = strlen(*arg) + 1;
+	size_t placeholder_len = strlen(placeholder);
+
+	while (true) {
+		size_t replacement_len;
+		const char *found = strstr(*arg, placeholder);
+		size_t placeholder_off, suffix_off;
+
+		if (found == NULL)
+			return;
+
+		placeholder_off = found - *arg;
+		found = NULL;
+
+		/* Replacement is calculated lazily upon encountering placeholder */
+		if (*replacement == NULL)
+			*replacement = get_tids(debugfs_filename);
+
+		replacement_len = strlen(*replacement);
+
+		reserve_size(arg, &str_capacity,
+			str_capacity - placeholder_len + replacement_len + 1);
+
+		suffix_off = placeholder_off + placeholder_len;
+
+		/* Move:                   v suffix_off
+		 *       PREFIX PLACEHOLDER SUFFIX
+		 *             ^ placeholder_off
+		 * To:   PREFIX _______ SUFFIX
+		 * Or:   PREFIX _______________ SUFFIX
+		 *                             ^ placeholder_off+replacement_len
+		 */
+		memmove(*arg + placeholder_off + replacement_len,
+			*arg + suffix_off, strlen(*arg + suffix_off) + 1);
+		/* Fill in the replacement */
+		memcpy(*arg + placeholder_off, *replacement, replacement_len);
+	}
+}
+
+/*
+ * Generate child command by replacing {READER,WRITER,KFREE}_TASKS with the actual
+ * values, comma separated.  Caller must call free_child_command().
+ */
+static struct child_cmd *generate_child_command(void)
+{
+	char *reader_tasks_string = NULL;
+	char *writer_tasks_string = NULL;
+	char *kfree_tasks_string = NULL;
+	struct child_cmd *cmd = calloc(1, sizeof(*cmd));
+
+	if (!cmd)
+		fail("Failed to allocate memory for child command");
+
+	cmd->argc = child_cmd_template.argc;
+	if (cmd->argc == 0) {
+		cmd->argv = NULL;
+		return cmd;
+	}
+
+	cmd->argv = malloc((cmd->argc + 1) * sizeof(char *));
+	if (!cmd->argv)
+		fail("Failed to allocate memory for child command");
+
+	for (int i = 0; i < cmd->argc; ++i) {
+		char *arg = strdup(child_cmd_template.argv[i]);
+
+		if (!arg)
+			fail("Failed to allocate memory for child command");
+
+		if (dryrun) {
+			cmd->argv[i] = arg;
+			continue;
+		}
+
+		replace_child_arg(&arg, "READER_TASKS", "reader_tasks", &reader_tasks_string);
+		replace_child_arg(&arg, "WRITER_TASKS", "writer_tasks", &writer_tasks_string);
+		replace_child_arg(&arg, "KFREE_TASKS", "kfree_tasks", &kfree_tasks_string);
+
+		cmd->argv[i] = arg;
+	}
+
+	cmd->argv[cmd->argc] = NULL;
+
+	free(reader_tasks_string);
+	free(writer_tasks_string);
+	free(kfree_tasks_string);
+
+	return cmd;
+}
+
+/*
+ * Free the child command.
+ */
+static void free_child_command(struct child_cmd *cmd)
+{
+	for (int i = 0; i < cmd->argc; i++)
+		free(cmd->argv[i]);
+	free(cmd->argv);
+}
+
 /* ====================== Experiment Result Handling ====================== */
 
 static void durations_add(struct durations *durations, u64 duration)
@@ -692,18 +892,53 @@ static void print_params(const struct modprobe_cmd *cmd)
 		printf("\n");
 }
 
+static void print_child_command(const struct child_cmd *cmd)
+{
+	if (cmd->argc == 0)
+		return;
+	printf("Running child command:");
+	for (int i = 0; i < cmd->argc; ++i)
+		printf(" %s", cmd->argv[i]);
+	printf("\n");
+}
+
 /*
  * Core Experiment function
  */
 static void runonce(const struct modprobe_cmd *modprobe_cmd)
 {
+	struct child_cmd *child_cmd;
 	struct durations *durations;
 
 	print_params(modprobe_cmd);
 	run_modprobe(modprobe_cmd);
 
-	if (dryrun)
+	child_cmd = generate_child_command();
+	print_child_command(child_cmd);
+
+	if (dryrun) {
+		free_child_command(child_cmd);
 		return;
+	}
+
+	if (child_cmd->argc != 0) {
+		// Start command in background
+		child_pid = fork();
+		if (child_pid < 0)
+			err(EXIT_FAILURE, "Failed to fork child process");
+
+		if (child_pid == 0) {
+			execvp(child_cmd->argv[0], child_cmd->argv);
+			in_child = true;
+			err(EXIT_FAILURE, "Failed to execute child command");
+		}
+		// otherwise, parent process
+	}
+	free_child_command(child_cmd);
+	child_cmd = NULL;
+
+	/* Wait for child process to initialize */
+	sleep(child_delay);
 
 	/* Start and wait for experiment */
 	start_experiment();
@@ -717,6 +952,13 @@ static void runonce(const struct modprobe_cmd *modprobe_cmd)
 
 	printf("Experiment finished.\n");
 
+	/* Wait for child to finish */
+	if (child_pid != 0) {
+		printf("Waiting for child process to exit.\n");
+		waitpid(child_pid, NULL, 0);
+		child_pid = 0;
+	}
+
 	/* Print statistics */
 	print_writer_duration_stats(durations);
 	free_durations(durations);
@@ -779,13 +1021,13 @@ int bench_sync_rcu(int argc, const char **argv)
 
 	/* Parse global options first. */
 	argc = parse_options(argc, argv, bench_rcu_options, bench_rcu_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
 
 	/* The empty case is equivalent to 'once sync'.
 	 * Otherwise, at least two positional options are required:
 	 * once/range/ratio and sync/async/exp
 	 */
-	if (argc == 0) {
+	if (argc == 0 || strcmp(argv[0], "--") == 0) {
 		runmode = "once";
 		gp_type = "sync";
 	} else if (argc < 2) {
-- 
2.50.1.565.gc32cd1483b-goog

