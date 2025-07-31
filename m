Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D02D0C7B
	for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968423; cv=none; b=Qdx2wklL+AQnmCXo1WZLVaa+tOsPcME7BGejTIriJdG8USZNCCOEmJawCgTbaWHzp++8ZU/7yjY8XDaKkE58QX9iR1wpIaBJRHoKdmufZVA4D3yzAX79V2K/+RVokEKOtLRFLRuTTVtGQAXtvnS6KGxSqv2Gxm41C+wyzbC/4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968423; c=relaxed/simple;
	bh=U2Q/nA8/fs3IaxhsmxtBPWhflIIPydiW0Xcing3X6TQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Qy6u1mx2ip2fuQ4A9czTIsZ89wxjQf8hee58NrzssB3aUYTBUOUJBJKy3vCcZwxTogerbtb9vpf0LuuAe5gdlQZo+jYE3Jch6w69Ad8YNoTPzWjb2botToq9aoeEHLA7UACLwZAGa/+zyv3XOtAFeRFSNYuGS1ghovhV25FuxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg4T17Fu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg4T17Fu"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115fb801bcso1360973a12.3
        for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968420; x=1754573220; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cS0kX7TvRYgQTsqu0GMqG/8vvD7pFz5fsy9ObfHAWm4=;
        b=Jg4T17FugmVHZwRiwS3QLHVhMZkjjr/LQTLtSfLnY8fYp6RWCCP1q1G9cAWNeV9PoO
         19/Ez/k0IFszuunhz30CmIKDUmIWeVX4IZAkxtxUHe4Ic685tzJCD0Zfb22HggSuhvCL
         3XsKBZ1CxoldgPPe3YrDWDairLV94zT5dPcLMSqxo2xiRUtPoYshTI0hdovKfw/s58gf
         YbYx3ivr9YD0gu+Rp9eDB+q4JDv1UmgsnxC7BgtZRhX0vMcBjCUiwYIJORK+108xXmpl
         anpDjuGEfxWc49HoVZv/4KoM+pTk79di7/msXig6WlK/5lDpDUW4UradQd4mHjPho+md
         7Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968420; x=1754573220;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS0kX7TvRYgQTsqu0GMqG/8vvD7pFz5fsy9ObfHAWm4=;
        b=eMbkRiYAXyb1ftasaRHgjp+yRbXGLu82gXTy4ABH2by/PkEhw19ld/QEkbjPwQWwip
         +AmfROdYY1zqQm6QI7PnHlKBgPT1NfJcVaxdH0XhdLtWoBQsnR7Ouj21qXlHA6LIJcDF
         LkOoIUB/R2LL+IMmGClqzCeXvv2MqkjohqskYvMuDKHGJN9DqU7ZffV4girYPzI4w5Or
         BnhNMSxTxSt+pcRMdYpGkTs3BMccAR0eBGpwJVlVrBZyOJqpmrLl7loymCtBpozecK6c
         MKnlAmnKcAFJTMuDiAiDYY3rS3seUBgqb3bJdUxS6U7+TpfeEDgq6wlA5rLKVN5Tb3b8
         ocKw==
X-Forwarded-Encrypted: i=1; AJvYcCVAU1nMRGojDtew58r6H3PglRHOOWkhDmfa87VQuhiNF6siCftzESMrN0MUjsQV70iRD+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51IKUD8RI29og4bftUoYK/4WIO7Sq7b9Nr5Eo4IEegXfkk5Sj
	7RKWmkIZG2DHDBuYSr3bS4tuCwxJ2+fB+txefO2LxQfNWp/CRIbB/QYS9jO5fTNxbV99KaVjA0g
	btUATQw==
X-Google-Smtp-Source: AGHT+IEwFWYPRxHNlmybj0gexk68rMr7gVOb927INT9mYj/fa8gmdq1czl+fytYCMaogstSXj8WleWU/75s=
X-Received: from plrj13.prod.google.com ([2002:a17:903:28d:b0:23f:cd94:8c5e])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b43:b0:240:8ec:fe2
 with SMTP id d9443c01a7336-24096a4fa57mr127525435ad.4.1753968420421; Thu, 31
 Jul 2025 06:27:00 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:14 -0700
In-Reply-To: <20250731132615.938435-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731132615.938435-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-5-yuzhuo@google.com>
Subject: [PATCH v1 4/5] perf bench: Add 'ratio' mode to 'sync rcu'
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

Add a 'ratio' mode to RCU benchmark.  This mode helps investigate
performance effects on the ratio between selected two parameters.
The command is defined as:

  ratio <gp_type> <total> <param1_range> <param1_name> <param2_name>

<total> is the sum of <param1> and <param2>.
<param1_range> specifies the range of param1's values, and thus param2's
  values can be calculated as 'total-param1'.

Example usage:

$ ./perf bench sync rcu ratio sync 10 0:10:3 nreaders nwriters
\# Running 'sync/rcu' benchmark:
Running experiment with options: nreaders=0 nwriters=10
Experiment finished.
Average grace-period duration: 16494.413 microseconds
Minimum grace-period duration: 7994.842
50th percentile grace-period duration: 17999.439
90th percentile grace-period duration: 18001.923
99th percentile grace-period duration: 23999.068
Maximum grace-period duration: 24000.441
Cooling down (3s)..

Running experiment with options: nreaders=3 nwriters=7
Experiment finished.
Average grace-period duration: 140018.793 microseconds
Minimum grace-period duration: 11987.02
50th percentile grace-period duration: 120999.879
90th percentile grace-period duration: 218000.011
99th percentile grace-period duration: 218006.372
Maximum grace-period duration: 219002.024
Cooling down (3s)..

Running experiment with options: nreaders=6 nwriters=4
Experiment finished.
Average grace-period duration: 210481.539 microseconds
Minimum grace-period duration: 5999.579
50th percentile grace-period duration: 217999.902
90th percentile grace-period duration: 218000.529
99th percentile grace-period duration: 218998.809
Maximum grace-period duration: 219000.652
Cooling down (3s)..

Running experiment with options: nreaders=9 nwriters=1
Experiment finished.
Average grace-period duration: 210782.119 microseconds
Minimum grace-period duration: 89997.154
50th percentile grace-period duration: 217999.829
90th percentile grace-period duration: 218001.299
99th percentile grace-period duration: 219003.072
Maximum grace-period duration: 324116.763

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/sync-rcu.c | 74 +++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/perf/bench/sync-rcu.c b/tools/perf/bench/sync-rcu.c
index 921520a645ae..73142fd5be21 100644
--- a/tools/perf/bench/sync-rcu.c
+++ b/tools/perf/bench/sync-rcu.c
@@ -55,6 +55,7 @@ static const char *const bench_rcu_usage[] = {
 	"perf bench sync rcu [options..] [-- <command>..]",
 	"perf bench sync rcu [options..] once  <gp_type> [<param=value>..] [-- <command>..]",
 	"perf bench sync rcu [options..] range <gp_type> [<param=range>..] [-- <command>..]",
+	"perf bench sync rcu [options..] ratio <gp_type> <total> <param1_range> <param1_name> <param2_name> [<param=value>..] [-- <command>..]",
 	"",
 	"  <gp_type>: The type of grace period to use: sync, async, exp (expedited)",
 	"             This sets the gp_exp or gp_async kernel module parameters.",
@@ -83,12 +84,17 @@ static const char *const bench_rcu_usage[] = {
 	"         If a parameter does not specify end, or start=end, it behaves",
 	"         the same as 'once' mode.  The range parameter types are validated",
 	"         agains `modinfo rcuscale` to ensure they are integer.",
+	"  ratio: Run benchmark that changes the ratio between two parameters.",
+	"         <total> specifies the sum of param1 and param2, and <param1_range>",
+	"         is the range of param1 values.  param2 is calculated by total-param1.",
+	"         Additional non-range parameters may also be specified.",
 	"",
 	"Examples:",
 	"  perf bench sync rcu --hist once exp nreaders=1 nwriters=1 writer_cpu_offset=1",
 	"  perf bench sync rcu once",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1",
 	"  perf bench sync rcu range exp  nreaders=1:2 nwriters=1 writer_cpu_offset=0:2",
+	"  perf bench sync rcu ratio sync 10 0:10:3 nreaders nwriters",
 	"",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1 -- \\",
 	"      perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period \\",
@@ -1194,6 +1200,72 @@ static void test_range(int argc, const char *argv[])
 	test_range_recursive(0, &modprobe_cmd);
 }
 
+/*
+ * Test ratio.  Use loop on two range options.
+ *
+ * Does not allow ranges for other options.
+ *
+ * Example:
+ *   perf bench rcu ratio sync 10 1:10:2 nreaders nwriters
+ *   will run the following experiments:
+ *     nreaders=1, nwriters=9
+ *     nreaders=2, nwriters=8
+ *     nreaders=3, nwriters=7
+ *     ...
+ *     nreaders=9, nwriters=1
+ */
+static void test_ratio(int argc, const char *argv[])
+{
+	MODPROBE_CMD_INIT;
+
+	int total;
+	struct range option1_range;
+	const char *option1_name;
+	const char *option2_name;
+
+	if (argc < 4)
+		usage_with_options(bench_rcu_usage, bench_rcu_options);
+
+	total = parse_int(argv[0]);
+	parse_range(&option1_range, argv[1]);
+	option1_name = argv[2];
+	option2_name = argv[3];
+
+	check_param_name(option1_name);
+	check_param_name(option2_name);
+
+	if (total < option1_range.start || total < option1_range.end)
+		fail("Total must be greater than or equal to the range bounary");
+
+	parse_module_params(argc - 4, argv + 4, false);
+
+	modprobe_collect_simple_options(&modprobe_cmd);
+
+	for (int i = option1_range.start; i <= option1_range.end; i += option1_range.step) {
+		int j = total - i;
+
+		struct modprobe_param param1, param2;
+
+		param_print_key_value(&param1, "%s=%d", option1_name, i);
+		param_print_key_value(&param2, "%s=%d", option2_name, j);
+
+		modprobe_cmd_add(&modprobe_cmd, param1.value);
+		modprobe_cmd_add(&modprobe_cmd, param2.value);
+
+		runonce(&modprobe_cmd);
+
+		modprobe_cmd_pop(&modprobe_cmd);
+		modprobe_cmd_pop(&modprobe_cmd);
+
+		if (i + option1_range.step <= option1_range.end) {
+			printf("Cooling down (%ds)..\n", cooldown);
+			if (!dryrun)
+				sleep(cooldown);
+			puts("");
+		}
+	}
+}
+
 /* ============================= Entry Point ============================== */
 
 int bench_sync_rcu(int argc, const char **argv)
@@ -1228,6 +1300,8 @@ int bench_sync_rcu(int argc, const char **argv)
 		cmd = test_once;
 	else if (strcmp(runmode, "range") == 0)
 		cmd = test_range;
+	else if (strcmp(runmode, "ratio") == 0)
+		cmd = test_ratio;
 	else
 		usage_with_options(bench_rcu_usage, bench_rcu_options);
 
-- 
2.50.1.565.gc32cd1483b-goog

