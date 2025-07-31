Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD802D0C9A
	for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968424; cv=none; b=TUOujHZGRijmEpKW7L4gAmBaajjA1RkFS3DMxfXfADskSYSz8W0yYqDrB20qdXcqXFjyoZjp4LOuoB2cHzF5ARbHbB9Vu5Ska+btyOdTMoY00Jqkqh/UVGCuK29dD6VAubsAfQ/0gz1c43alVx383TShsYyPRhAWAxUOd+7ZoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968424; c=relaxed/simple;
	bh=IvE7wbOfiky5gP1/JdKf1HJsEXUXuz12TG0IoOAqx3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=P74hg9UeeG6cn/JE7XmRD/XK3UWqhWVxI1TdbervJJZQAPL4KXpot2uxXh8/q701FegUHbNvywMIGrZIfmGU70xsDDa9Nr/TJa+c+SWrD5oLoL8iumZ0OuJuAWnDJs4cXXcuQ4zpe8T11Iw6M9gnYYWYECLMF8F8YwU6DMcyijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMfqJ82Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMfqJ82Z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748fd21468cso969784b3a.1
        for <rcu@vger.kernel.org>; Thu, 31 Jul 2025 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968422; x=1754573222; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9D+1SkLUHFp3CL6p6s9XNodFOnizBfge5u1xSj5q/5M=;
        b=tMfqJ82Z05i8Mg0BYhuYG0kBYmCOeFUL9mvvU5abyEG1YqbgDAxn1ApFiy6E90mfDn
         EN/6DbGJmy1JLTksnZbnAIz3nDfHvP7/hjDEIKnxcQXuNERzy78jFsSlLXVs+2aVsDTS
         f2fnllV8pqwibDbRCkrTxVOJlMoyLheMZBDiPaPy7XledeP7RvT21t9DZlGXDiL1Wp4U
         gWQRbO8qs6IZ6K6cqCQKxiL0TQ7+ODh1GLTwyO+NnMNvPKLJKn4Fjn5iITzpP0XqL9kc
         qqIDt44Osc3ADUKRae4vJGb31ektm+jLmWTr0Eda/xROokUGvO1Jv/eYelG3R3uKi73q
         2InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968422; x=1754573222;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D+1SkLUHFp3CL6p6s9XNodFOnizBfge5u1xSj5q/5M=;
        b=mVP6iANFnGN8nyvNa2vlUXSwKzm76DyxkCqJ6uk0iOKxrQw1bo1rhI4i2ffvORgF6u
         SkPIKdeK4xRFZfCwDakzRE9MsiNw8vaYY4i4LuxtEjfhh6sJxaqtxcbsNRey/hQBk8IT
         EjxayvjzMN/hn3bvSKj5f+GWfEqeVA13B4vswjpIgm3X4DnBWXKffHLRPJivK68xfX52
         /+pA/Vjbxt9kDd0R45TgNS7yTHdai+2a/nMUDT4DCLhI+MS/HSaSzhtY//S+/+atLbiw
         mSP2HpDPb2LqmBfcxuHae2TurJcHwt7gIgjV5Nd0ilkFSwg0wp2HxPeNYR2TMm0R3xVm
         lC2g==
X-Forwarded-Encrypted: i=1; AJvYcCUS+aMKWHnH39N6JailS3cJOLdQ4uCv7Uhds3ngwKz0aRRA5tFWAukzaH2Hv9ftrk9PnYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6z3m3dKCoYIv9jNt//wpXelf7DLh8Os+XBQZU6j1+wM2aVy2w
	LZDMHG4uvvAJRJv249pwMxhg37OQ7nfnYR14gEp+3Scyllv6fw87hXdLHnjfVj9i2y6mJhrpnVM
	YIYKyHQ==
X-Google-Smtp-Source: AGHT+IHobDSGcus+S94g4r7tqFvwsqp38RnMHKYwOWfldZixh8KyWZx+bTZ3gtJnbMQKBH3kowT2EzQj/94=
X-Received: from pgar7.prod.google.com ([2002:a05:6a02:2e87:b0:b2c:4548:13d0])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258a:b0:232:ddc1:f22b
 with SMTP id adf61e73a8af0-23dc0d5f6bdmr10780967637.19.1753968422122; Thu, 31
 Jul 2025 06:27:02 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:15 -0700
In-Reply-To: <20250731132615.938435-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731132615.938435-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-6-yuzhuo@google.com>
Subject: [PATCH v1 5/5] perf bench: Add documentation for 'sync rcu' suite
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

Add documentation for 'perf bench sync rcu'.  This benchmark has three
modes or subcommands that takes positional arguments.  In addition,
*kernel* module parameters are directly specified in the form of
"name=value", without "--name".  Multiple subsections are thus added to
the 'sync' section for illustration.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/Documentation/perf-bench.txt | 131 ++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 8331bd28b10e..786c6e6880f5 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -49,6 +49,9 @@ SUBSYSTEM
 'sched'::
 	Scheduler and IPC mechanisms.
 
+'sync'::
+	Synchronization primitives.
+
 'syscall'::
 	System call performance (throughput).
 
@@ -162,6 +165,134 @@ Example of *pipe*
 
 ---------------------
 
+SUITES FOR 'sync'
+~~~~~~~~~~~~~~~~~
+*rcu*::
+Suite for RCU performance.  Depends on rcuscale kernel module.
+This benchmark has three modes: once, range, ratio.  Usage is defined as below.
+
+'perf bench sync rcu' [options..] [-- <command>..]
+'perf bench sync rcu' [options..] once  <gp_type> [<param=value>..] [-- <command>..]
+'perf bench sync rcu' [options..] range <gp_type> [<param=range>..] [-- <command>..]
+'perf bench sync rcu' [options..] ratio <gp_type> <total> <param1_range> <param1_name> <param2_name> [<param=value>..] [-- <command>..]
+
+Modes for *rcu*
+^^^^^^^^^^^^^^^
+
+default::
+Run 'once sync'.",
+
+once::
+Run benchmark once, with all parameters passed through to the kernel rcuscale
+module.
+
+range::
+Run benchmark multiple times, with parameters as ranges.  Range format is
+defined as start[:end[:step]], inclusive, non-negative.  The benchmark
+instantiates all combinations of all ranges.
+
+ratio::
+Run benchmark that changes the ratio between two parameters. 'total' specifies
+the sum of 'param1' and 'param2', and 'param1_range' is the range of 'param1'
+values.  'param2' is calculated by 'total-param1'.  Additional non-range
+parameters may also be specified.
+
+Positional arguments for *rcu*
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+gp_type::
+The type of grace period to use: sync, async, exp (expedited)
+
+param::
+Any parameter of the rcuscale kernel module, except for "gp_exp",
+"gp_async" and "block_start" that are managed by this benchmark.
+Valid options can be found from "modinfo rcuscale".
+
+command::
+A child command to run during the experiment.  If the command line
+string contains {READER,WRITER,KFREE}_TASKS placeholders, they will be
+substituted with the tasks PIDs, separated by comma.
+
+Options for *rcu*
+^^^^^^^^^^^^^^^^^
+-c::
+--cooldown::
+Sleep time between each experiment (default: 3 seconds).
+
+-n::
+--dryrun::
+Dry run mode.  Do not run experiments, but instead print what parameter
+combination will run.
+
+--child-delay=::
+Wait for child startup before starting experiment (default: 1 second).
+
+--debugfs=::
+Debugfs mount point used to interact with the rcuscale kernel module. (default:
+/sys/kernel/debug).
+
+--hist::
+Show the histogram of writer durations.
+
+Example of *rcu*
+^^^^^^^^^^^^^^^^
+
+---------------------
+% perf bench sync rcu once exp nreaders=1 nwriters=1
+# Running 'sync/rcu' benchmark:
+Running experiment with options: gp_exp=1 nreaders=1 nwriters=1
+Experiment finished.
+Average grace-period duration: 124.236 microseconds
+Minimum grace-period duration: 8.783
+50th percentile grace-period duration: 9.033
+90th percentile grace-period duration: 9.665
+99th percentile grace-period duration: 20.911
+Maximum grace-period duration: 6025.167
+
+% perf bench sync rcu range exp nreaders=1 nwriters=1 writer_cpu_offset=0:1 -- \
+          perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period \
+          -t READER_TASKS,WRITER_TASKS
+# Running 'sync/rcu' benchmark:
+Running experiment with options: gp_exp=1 nreaders=1 nwriters=1 writer_cpu_offset=0
+Running child command: perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period -t 2061441,2061442
+
+ Performance counter stats for thread id '2061441,2061442':
+
+              2400      ipi:ipi_send_cpu
+               100      rcu:rcu_grace_period
+
+       6.006040148 seconds time elapsed
+
+Experiment finished.
+Waiting for child process to exit.
+Average grace-period duration: 301.177 microseconds
+Minimum grace-period duration: 9.064
+50th percentile grace-period duration: 9.394
+90th percentile grace-period duration: 10.977
+99th percentile grace-period duration: 5926.781
+Maximum grace-period duration: 6011.067
+Cooling down (3s)..
+
+Running experiment with options: gp_exp=1 nreaders=1 nwriters=1 writer_cpu_offset=1
+Running child command: perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period -t 2061461,2061462
+
+ Performance counter stats for thread id '2061461,2061462':
+
+              2144      ipi:ipi_send_cpu
+               201      rcu:rcu_grace_period
+
+       6.006110747 seconds time elapsed
+
+Experiment finished.
+Waiting for child process to exit.
+Average grace-period duration: 12.23 microseconds
+Minimum grace-period duration: 9.134
+50th percentile grace-period duration: 9.475
+90th percentile grace-period duration: 11.897
+99th percentile grace-period duration: 38.057
+Maximum grace-period duration: 67.19
+---------------------
+
 SUITES FOR 'syscall'
 ~~~~~~~~~~~~~~~~~~
 *basic*::
-- 
2.50.1.565.gc32cd1483b-goog

