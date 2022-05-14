Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C25C433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiENO0Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiENO0C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:26:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9211451
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:25:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id jt15so8968314qvb.8
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lnQQ0ak7spVz4xHOdNe+pLim2dzHP9iOqyjPzF6M+7w=;
        b=x2oNBwLc3VhYBUYOUuvL56lxpgAHTlSMs8TuOYPUNowxrrMdCw/Kci47TQ73uhybDo
         svU9syPMpaejvXJzaZyyvUpEUjXoB4lDhT6RJJybJTDcE3vxgj28e48lg2GSz7hp6cde
         yaLIRyp+wrxbamCpvNrjOPfuwGFwD8LzmTY8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnQQ0ak7spVz4xHOdNe+pLim2dzHP9iOqyjPzF6M+7w=;
        b=n8AXBpmj8ymRjHNiCh7a6YdzjGw11wVMx+Ill/hayuauW5Ybb1FRkft4rB/gbelbMK
         7qRPPt4IX+cbosDduiq0IeVFHE6QIVjDZkB4iu7VHq4ijJ7zku4Cugdi6enkYjH65gbF
         2Td4/sAf+vgUjCIgsGwiwgN9b2gUJm+YV4SAtrJXaVYlmryL27cNPEZ7dWSO/1Ir3bB7
         m2SIc/iRXnyr8Iiih+wSWj5ZP17o7U3dDRrIWuu+3qgZt2TKbVcS5jDn8G2Jyv1NRuVB
         EgPLbKYE0XFgJvbKtC6ISE1RfAXo07UmAFVrHhuYESsI/NPtfChK200jb9AIjDSJfpx3
         qx+w==
X-Gm-Message-State: AOAM532aMkTlwY8waZq69+8NLYotnZjP/BYk0fUlcCRLW0yJysRwtBUb
        /y+8TyyY8fZq2/fIbyrQNfCIiw==
X-Google-Smtp-Source: ABdhPJxnjWKCFYCCxN3xg5BupTi97UBd0rTVaFIKwZYGvPJh2fHQ0/nuSsm4xWBF+BO9iUrUlKwHVA==
X-Received: by 2002:a05:6214:e4a:b0:45a:dfa5:404a with SMTP id o10-20020a0562140e4a00b0045adfa5404amr8508779qvc.126.1652538359007;
        Sat, 14 May 2022 07:25:59 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id p62-20020a374241000000b0069fc13ce224sm2804216qka.85.2022.05.14.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:25:58 -0700 (PDT)
Date:   Sat, 14 May 2022 14:25:58 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <Yn+79v4q+1c9lXdc@google.com>
References: <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
 <Yn0TuehXj6VoWG0A@google.com>
 <Yn0bwhkdfPvbjIwK@pc638.lan>
 <CAEXW_YQNPDJ8aaxKzG2NN9gVR_QPbarJthiXYRd9Erw7p5V=FA@mail.gmail.com>
 <Yn02uhvov7CDoKX7@pc638.lan>
 <Yn5e7w8NWzThUARb@pc638.lan>
 <CAEXW_YQSLSAOAYDhztreYu=t2v8HPCdjRwJ=5Bx6N3LT8frtkQ@mail.gmail.com>
 <Yn58t2UWtj9YfJPR@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn58t2UWtj9YfJPR@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 13, 2022 at 05:43:51PM +0200, Uladzislau Rezki wrote:
> > On Fri, May 13, 2022 at 9:36 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > > > On Thu, May 12, 2022 at 10:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > > On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> > > > > > > > Never mind. I port it into 5.10
> > > > > > >
> > > > > > > Oh, this is on mainline. Sorry about that. If you want I have a tree here for
> > > > > > > 5.10 , although that does not have the kfree changes, everything else is
> > > > > > > ditto.
> > > > > > > https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4
> > > > > > >
> > > > > > No problem. kfree_rcu two patches are not so important in this series.
> > > > > > So i have backported them into my 5.10 kernel because the latest kernel
> > > > > > is not so easy to up and run on my device :)
> > > > >
> > > > > Actually I was going to write here, apparently some tests are showing
> > > > > kfree_rcu()->call_rcu_lazy() causing possible regression. So it is
> > > > > good to drop those for your initial testing!
> > > > >
> > > > Yep, i dropped both. The one that make use of call_rcu_lazy() seems not
> > > > so important for kfree_rcu() because we do batch requests there anyway.
> > > > One thing that i would like to improve in kfree_rcu() is a better utilization
> > > > of page slots.
> > > >
> > > > I will share my results either tomorrow or on Monday. I hope that is fine.
> > > >
> > >
> > > Here we go with some data on our Android handset that runs 5.10 kernel. The test
> > > case i have checked was a "static image" use case. Condition is: screen ON with
> > > disabled all connectivity.
> > >
> > > 1.
> > > First data i took is how many wakeups cause an RCU subsystem during this test case
> > > when everything is pretty idling. Duration is 360 seconds:
> > >
> > > <snip>
> > > serezkiul@seldlx26095:~/data/call_rcu_lazy$ ./psp ./perf_360_sec_rcu_lazy_off.script | sort -nk 6 | grep rcu
> > 
> > Nice! Do you mind sharing this script? I was just talking to Rushikesh
> > that we want something like this during testing. Appreciate it. Also,
> > if we dump timer wakeup reasons/callbacks that would also be awesome.
> > 
> Please find in attachment. I wrote it once upon a time and make use of
> to parse "perf script" output, i.e. raw data. The file name is: perf_script_parser.c
> so just compile it.
> 
> How to use it:
> 1. run perf: './perf sched record -a -- sleep "how much in sec you want to collect data"'
> 2. ./perf script -i ./perf.data > foo.script
> 3. ./perf_script_parser ./foo.script

Thanks a lot for sharing this. I think it will be quite useful. FWIW, I also
use "perf sched record" and "perf sched report --sort latency" to get wakeup
latencies.

> > FWIW, I wrote a BPF tool that periodically dumps callbacks and can
> > share that with you on request as well. That is probably not in a
> > shape for mainline though (Makefile missing and such).
> > 
> Yep, please share!

Sure, check out my bcc repo from here:
https://github.com/joelagnel/bcc

Build this project, then cd libbpf-tools and run make. This should produce a
static binary 'rcutop' which you can push to Android. You have to build for
ARM which bcc should have instructions for. I have also included the rcuptop
diff at the end of this file for reference.

> > > 2.
> > > Please find in attachment two power plots. The same test case. One is related to a
> > > regular use of call_rcu() and second one is "lazy" usage. There is light a difference
> > > in power, it is ~2mA. Event though it is rather small but it is detectable and solid
> > > what is also important, thus it proofs the concept. Please note it might be more power
> > > efficient for other arches and platforms. Because of different HW design that is related
> > > to C-states of CPU and energy that is needed to in/out of those deep power states.
> > 
> > Nice! I wonder if you still have other frequent callbacks on your
> > system that are getting queued during the tests. Could you dump the
> > rcu_callbacks trace event and see if you have any CBs frequently
> > called that the series did not address?
> >
> I have pretty much like this:
> <snip>
>     rcuop/2-33      [002] d..1  6172.420541: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/1-26      [001] d..1  6173.131965: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/0-15      [001] d..1  6173.696540: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/3-40      [003] d..1  6173.703695: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/0-15      [001] d..1  6173.711607: rcu_batch_start: rcu_preempt CBs=1667 bl=13
>     rcuop/1-26      [000] d..1  6175.619722: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/2-33      [001] d..1  6176.135844: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/3-40      [002] d..1  6176.303723: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/0-15      [002] d..1  6176.519894: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/0-15      [003] d..1  6176.527895: rcu_batch_start: rcu_preempt CBs=273 bl=10
>     rcuop/1-26      [003] d..1  6178.543729: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/1-26      [003] d..1  6178.551707: rcu_batch_start: rcu_preempt CBs=1317 bl=10
>     rcuop/0-15      [003] d..1  6178.819698: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/0-15      [003] d..1  6178.827734: rcu_batch_start: rcu_preempt CBs=949 bl=10
>     rcuop/3-40      [001] d..1  6179.203645: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/2-33      [001] d..1  6179.455747: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/2-33      [002] d..1  6179.471725: rcu_batch_start: rcu_preempt CBs=1983 bl=15
>     rcuop/1-26      [003] d..1  6181.287646: rcu_batch_start: rcu_preempt CBs=2048 bl=16
>     rcuop/1-26      [003] d..1  6181.295607: rcu_batch_start: rcu_preempt CBs=55 bl=10
> <snip>
> 
> so almost everything is batched.

Nice, glad to know this is happening even without the kfree_rcu() changes.

> > Also, one more thing I was curious about is - do you see savings when
> > you pin the rcu threads to the LITTLE CPUs of the system? The theory
> > being, not disturbing the BIG CPUs which are more power hungry may let
> > them go into a deeper idle state and save power (due to leakage
> > current and so forth).
> > 
> I did some experimenting to pin nocbs to a little cluster. For idle use
> cases i did not see any power gain. For heavy one i see that "big" CPUs
> are also invoking and busy with it quite often. Probably i should think
> of some use case where i can detect the power difference. If you have
> something please let me know.

Yeah, probably screen off + audio playback might be a good one, because it
lightly loads the CPUs.

> > > So a front-lazy-batching is something worth to have, IMHO :)
> > 
> > Exciting! Being lazy pays off some times ;-) ;-). If you are Ok with
> > it, we can add your data to the LPC slides as well about your
> > investigation (with attribution to you).
> > 
> No problem, since we will give a talk on LPC, more data we have more
> convincing we are :)

I forget, you did mention you are Ok with presenting with us right? It would
be great if you present your data when we come to Android, if you are OK with
it. I'll start a common slide deck soon and share so you, Rushikesh and me
can add slides to it and present together.

thanks,

 - Joel

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] rcutop

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 libbpf-tools/Makefile     |   1 +
 libbpf-tools/rcutop.bpf.c |  56 ++++++++
 libbpf-tools/rcutop.c     | 288 ++++++++++++++++++++++++++++++++++++++
 libbpf-tools/rcutop.h     |   8 ++
 4 files changed, 353 insertions(+)
 create mode 100644 libbpf-tools/rcutop.bpf.c
 create mode 100644 libbpf-tools/rcutop.c
 create mode 100644 libbpf-tools/rcutop.h

diff --git a/libbpf-tools/Makefile b/libbpf-tools/Makefile
index e60ec409..0d4cdff2 100644
--- a/libbpf-tools/Makefile
+++ b/libbpf-tools/Makefile
@@ -42,6 +42,7 @@ APPS = \
 	klockstat \
 	ksnoop \
 	llcstat \
+	rcutop \
 	mountsnoop \
 	numamove \
 	offcputime \
diff --git a/libbpf-tools/rcutop.bpf.c b/libbpf-tools/rcutop.bpf.c
new file mode 100644
index 00000000..8287bbe2
--- /dev/null
+++ b/libbpf-tools/rcutop.bpf.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2021 Hengqi Chen */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+#include "rcutop.h"
+#include "maps.bpf.h"
+
+#define MAX_ENTRIES	10240
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, void *);
+	__type(value, int);
+} cbs_queued SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, void *);
+	__type(value, int);
+} cbs_executed SEC(".maps");
+
+SEC("tracepoint/rcu/rcu_callback")
+int tracepoint_rcu_callback(struct trace_event_raw_rcu_callback* ctx)
+{
+	void *key = ctx->func;
+	int *val = NULL;
+	static const int zero;
+
+	val = bpf_map_lookup_or_try_init(&cbs_queued, &key, &zero);
+	if (val) {
+		__sync_fetch_and_add(val, 1);
+	}
+
+	return 0;
+}
+
+SEC("tracepoint/rcu/rcu_invoke_callback")
+int tracepoint_rcu_invoke_callback(struct trace_event_raw_rcu_invoke_callback* ctx)
+{
+	void *key = ctx->func;
+	int *val;
+	int zero = 0;
+
+	val = bpf_map_lookup_or_try_init(&cbs_executed, (void *)&key, (void *)&zero);
+	if (val) {
+		__sync_fetch_and_add(val, 1);
+	}
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/libbpf-tools/rcutop.c b/libbpf-tools/rcutop.c
new file mode 100644
index 00000000..35795875
--- /dev/null
+++ b/libbpf-tools/rcutop.c
@@ -0,0 +1,288 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+/*
+ * rcutop
+ * Copyright (c) 2022 Joel Fernandes
+ *
+ * 05-May-2022   Joel Fernandes   Created this.
+ */
+#include <argp.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include "rcutop.h"
+#include "rcutop.skel.h"
+#include "btf_helpers.h"
+#include "trace_helpers.h"
+
+#define warn(...) fprintf(stderr, __VA_ARGS__)
+#define OUTPUT_ROWS_LIMIT 10240
+
+static volatile sig_atomic_t exiting = 0;
+
+static bool clear_screen = true;
+static int output_rows = 20;
+static int interval = 1;
+static int count = 99999999;
+static bool verbose = false;
+
+const char *argp_program_version = "rcutop 0.1";
+const char *argp_program_bug_address =
+"https://github.com/iovisor/bcc/tree/master/libbpf-tools";
+const char argp_program_doc[] =
+"Show RCU callback queuing and execution stats.\n"
+"\n"
+"USAGE: rcutop [-h] [interval] [count]\n"
+"\n"
+"EXAMPLES:\n"
+"    rcutop            # rcu activity top, refresh every 1s\n"
+"    rcutop 5 10       # 5s summaries, 10 times\n";
+
+static const struct argp_option opts[] = {
+	{ "noclear", 'C', NULL, 0, "Don't clear the screen" },
+	{ "rows", 'r', "ROWS", 0, "Maximum rows to print, default 20" },
+	{ "verbose", 'v', NULL, 0, "Verbose debug output" },
+	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	long rows;
+	static int pos_args;
+
+	switch (key) {
+		case 'C':
+			clear_screen = false;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'h':
+			argp_state_help(state, stderr, ARGP_HELP_STD_HELP);
+			break;
+		case 'r':
+			errno = 0;
+			rows = strtol(arg, NULL, 10);
+			if (errno || rows <= 0) {
+				warn("invalid rows: %s\n", arg);
+				argp_usage(state);
+			}
+			output_rows = rows;
+			if (output_rows > OUTPUT_ROWS_LIMIT)
+				output_rows = OUTPUT_ROWS_LIMIT;
+			break;
+		case ARGP_KEY_ARG:
+			errno = 0;
+			if (pos_args == 0) {
+				interval = strtol(arg, NULL, 10);
+				if (errno || interval <= 0) {
+					warn("invalid interval\n");
+					argp_usage(state);
+				}
+			} else if (pos_args == 1) {
+				count = strtol(arg, NULL, 10);
+				if (errno || count <= 0) {
+					warn("invalid count\n");
+					argp_usage(state);
+				}
+			} else {
+				warn("unrecognized positional argument: %s\n", arg);
+				argp_usage(state);
+			}
+			pos_args++;
+			break;
+		default:
+			return ARGP_ERR_UNKNOWN;
+	}
+	return 0;
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sig_int(int signo)
+{
+	exiting = 1;
+}
+
+static int print_stat(struct ksyms *ksyms, struct syms_cache *syms_cache,
+		struct rcutop_bpf *obj)
+{
+	void *key, **prev_key = NULL;
+	int n, err = 0;
+	int qfd = bpf_map__fd(obj->maps.cbs_queued);
+	int efd = bpf_map__fd(obj->maps.cbs_executed);
+	const struct ksym *ksym;
+	FILE *f;
+	time_t t;
+	struct tm *tm;
+	char ts[16], buf[256];
+
+	f = fopen("/proc/loadavg", "r");
+	if (f) {
+		time(&t);
+		tm = localtime(&t);
+		strftime(ts, sizeof(ts), "%H:%M:%S", tm);
+		memset(buf, 0, sizeof(buf));
+		n = fread(buf, 1, sizeof(buf), f);
+		if (n)
+			printf("%8s loadavg: %s\n", ts, buf);
+		fclose(f);
+	}
+
+	printf("%-32s %-6s %-6s\n", "Callback", "Queued", "Executed");
+
+	while (1) {
+		int qcount = 0, ecount = 0;
+
+		err = bpf_map_get_next_key(qfd, prev_key, &key);
+		if (err) {
+			if (errno == ENOENT) {
+				err = 0;
+				break;
+			}
+			warn("bpf_map_get_next_key failed: %s\n", strerror(errno));
+			return err;
+		}
+
+		err = bpf_map_lookup_elem(qfd, &key, &qcount);
+		if (err) {
+			warn("bpf_map_lookup_elem failed: %s\n", strerror(errno));
+			return err;
+		}
+		prev_key = &key;
+
+		bpf_map_lookup_elem(efd, &key, &ecount);
+
+		ksym = ksyms__map_addr(ksyms, (unsigned long)key);
+		printf("%-32s %-6d %-6d\n",
+				ksym ? ksym->name : "Unknown",
+				qcount, ecount);
+	}
+	printf("\n");
+	prev_key = NULL;
+	while (1) {
+		err = bpf_map_get_next_key(qfd, prev_key, &key);
+		if (err) {
+			if (errno == ENOENT) {
+				err = 0;
+				break;
+			}
+			warn("bpf_map_get_next_key failed: %s\n", strerror(errno));
+			return err;
+		}
+		err = bpf_map_delete_elem(qfd, &key);
+		if (err) {
+			if (errno == ENOENT) {
+				err = 0;
+				continue;
+			}
+			warn("bpf_map_delete_elem failed: %s\n", strerror(errno));
+			return err;
+		}
+
+		bpf_map_delete_elem(efd, &key);
+		prev_key = &key;
+	}
+
+	return err;
+}
+
+int main(int argc, char **argv)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
+	static const struct argp argp = {
+		.options = opts,
+		.parser = parse_arg,
+		.doc = argp_program_doc,
+	};
+	struct rcutop_bpf *obj;
+	int err;
+	struct syms_cache *syms_cache = NULL;
+	struct ksyms *ksyms = NULL;
+
+	err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
+	if (err)
+		return err;
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+	libbpf_set_print(libbpf_print_fn);
+
+	err = ensure_core_btf(&open_opts);
+	if (err) {
+		fprintf(stderr, "failed to fetch necessary BTF for CO-RE: %s\n", strerror(-err));
+		return 1;
+	}
+
+	obj = rcutop_bpf__open_opts(&open_opts);
+	if (!obj) {
+		warn("failed to open BPF object\n");
+		return 1;
+	}
+
+	err = rcutop_bpf__load(obj);
+	if (err) {
+		warn("failed to load BPF object: %d\n", err);
+		goto cleanup;
+	}
+
+	err = rcutop_bpf__attach(obj);
+	if (err) {
+		warn("failed to attach BPF programs: %d\n", err);
+		goto cleanup;
+	}
+
+	ksyms = ksyms__load();
+	if (!ksyms) {
+		fprintf(stderr, "failed to load kallsyms\n");
+		goto cleanup;
+	}
+
+	syms_cache = syms_cache__new(0);
+	if (!syms_cache) {
+		fprintf(stderr, "failed to create syms_cache\n");
+		goto cleanup;
+	}
+
+	if (signal(SIGINT, sig_int) == SIG_ERR) {
+		warn("can't set signal handler: %s\n", strerror(errno));
+		err = 1;
+		goto cleanup;
+	}
+
+	while (1) {
+		sleep(interval);
+
+		if (clear_screen) {
+			err = system("clear");
+			if (err)
+				goto cleanup;
+		}
+
+		err = print_stat(ksyms, syms_cache, obj);
+		if (err)
+			goto cleanup;
+
+		count--;
+		if (exiting || !count)
+			goto cleanup;
+	}
+
+cleanup:
+	rcutop_bpf__destroy(obj);
+	cleanup_core_btf(&open_opts);
+
+	return err != 0;
+}
diff --git a/libbpf-tools/rcutop.h b/libbpf-tools/rcutop.h
new file mode 100644
index 00000000..cb2a3557
--- /dev/null
+++ b/libbpf-tools/rcutop.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __RCUTOP_H
+#define __RCUTOP_H
+
+#define PATH_MAX	4096
+#define TASK_COMM_LEN	16
+
+#endif /* __RCUTOP_H */
-- 
2.36.0.550.gb090851708-goog

