Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA5C33CAF
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 19:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A683520661
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 19:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OtMlLwEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgAPTZz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:25:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46037 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgAPTZz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jan 2020 14:25:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so10691726pfg.12
        for <rcu@vger.kernel.org>; Thu, 16 Jan 2020 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UoXmscIHF47pWtJ9KUeHYTru5gMXzffDC9Q60+M0m2Y=;
        b=OtMlLwEYchm4DsDaowqkEg2KpPgr///vim8wAsAQtKLZUHYmg3/WZbhtLXWrTCRHNc
         oV6d67f/g2WNja98sELhneBRWYkY87SvgdAoz7dVKasTKcxTSIbJPa2TeCUegYv6xP/h
         gbciql2ySsJYr6qXrn5rgklIFACmuW4YcQ2F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UoXmscIHF47pWtJ9KUeHYTru5gMXzffDC9Q60+M0m2Y=;
        b=uJ948rGTxuRwzu36Cj+LtyUIxV9RYiYu1z7P5mfguWHEH8jyMmyfCxUFPJAYcPb9qp
         vENN7MCZdJ9S3QpOgpGHcMjedPTDJGWh5fcj6qofUKK92SMUSJk9SE2G/+Fj2Rz+KaZr
         x6i0kwKthMggGBVrXRcbixJN+PXa+pzq9wx8tnVajhUZGTJj4uV79REN0URWyFRVEBGc
         LFY7wemQjsdf6WFcjjVgo9XTIQgVDRfqxoDIkk/Ya+cnAFArQyV17KK+yCIkOKGRa0cx
         MO0HbmBfLTnd6+PafISKDBO8nfwUjI/imLhyqtcB6Z4+11c3aGaxcQY4PK3HXeh77Atd
         nppg==
X-Gm-Message-State: APjAAAU0lT3tHYwiNzUij6TtcQfE+smVC3S1TrzjxhMdZ/oF775bEArQ
        lG2JTH15bKPt5foQCC58mbd+Tw==
X-Google-Smtp-Source: APXvYqxgiyPG9gPfp4SRfJKGLTVLondeWrkSrTpE7KWY0xNsjHCtBzjBo8zsbFkHBCcT6fsWiTuisg==
X-Received: by 2002:a65:68c8:: with SMTP id k8mr41247676pgt.216.1579202754122;
        Thu, 16 Jan 2020 11:25:54 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o134sm27433549pfg.137.2020.01.16.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 11:25:53 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:25:52 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200116192552.GE246464@google.com>
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
 <20200115220300.GA94036@google.com>
 <20200115224251.GK2935@paulmck-ThinkPad-P72>
 <20200115224542.GB94036@google.com>
 <20200116000104.GO2935@paulmck-ThinkPad-P72>
 <20200116040558.GD246464@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116040558.GD246464@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 15, 2020 at 11:05:58PM -0500, Joel Fernandes wrote:
> On Wed, Jan 15, 2020 at 04:01:04PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 15, 2020 at 05:45:42PM -0500, Joel Fernandes wrote:
> > > On Wed, Jan 15, 2020 at 02:42:51PM -0800, Paul E. McKenney wrote:
> > > > > [snip]
> > > > > > > We can certainly refine it further but at this time I am thinking of spending
> > > > > > > my time reviewing Lai's patches and learning some other RCU things I need to
> > > > > > > catch up on. If you hate this patch too much, we can also defer this patch
> > > > > > > review for a bit and I can carry it in my tree for now as it is only a patch
> > > > > > > to test code. But honestly, in its current form I am sort of happy with it.
> > > > > > 
> > > > > > OK, I will keep it as is for now and let's look again later on.  It is not
> > > > > > in the bucket for the upcoming merge window in any case, so we do have
> > > > > > quite a bit of time.
> > > > > > 
> > > > > > It is not that I hate it, but rather that I want to be able to give
> > > > > > good answers to questions that might come up.  And given that I have
> > > > > > occasionally given certain people a hard time about their statistics,
> > > > > > it is only reasonable to expect them to return the favor.  I wouldn't
> > > > > > want you to be caught in the crossfire.  ;-)
> > > > > 
> > > > > Since the weights were concerning, I was thinking of just using a weight of
> > > > > (1 / N) where N is the number of samples. Essentially taking the average.
> > > > > That could be simple enough and does not cause your concerns with weight
> > > > > tuning. I tested it and looks good, I'll post it shortly.
> > > > 
> > > > YES!!!  ;-)
> > > > 
> > > > Snapshot mem_begin before entering the loop.  For the mean value to
> > > > be solid, you need at least 20-30 samples, which might mean upping the
> > > > default for kfree_loops.  Have an "unsigned long long" to accumulate the
> > > > sum, which should avoid any possibility of overflow for current systems
> > > > and for all systems for kfree_loops less than PAGE_SIZE.  At which point,
> > > > forget the "%" stuff and just sum up the si_mem_available() on each pass
> > > > through the loop.
> > > > 
> > > > Do the division on exit from the loop, preferably checking for divide
> > > > by zero.
> > > > 
> > > > Straightforward, fast, reasonably reliable, and easy to defend.
> > > 
> > > I mostly did it along these lines. Hopefully the latest posting is reasonable
> > > enough ;-) I sent it twice because I messed up the authorship (sorry).
> > 
> > No problem with the authorship-fix resend!
> > 
> > But let's get this patch consistent with basic statistics!
> > 
> > You really do need 20-30 samples for an average to mean much.
> > 
> > Of course, right now you default kfree_loops to 10.  You are doing
> > 8000 kmalloc()/kfree_rcu() loops on each pass.  This is large enough
> > that just dropping the "% 4" should be just fine from the viewpoint of
> > si_mem_available() overhead.  But 8000 allocations and frees should get
> > done in way less than one second, so kicking the default kfree_loops up
> > to 30 should be a non-problem.
> > 
> > Then the patch would be both simpler and statistically valid.
> > 
> > So could you please stop using me as the middleman in your fight with
> > the laws of mathematics and get this patch to a defensible state?  ;-)
> 
> The thing is the signal doesn't vary much. I could very well just take one
> out of the 4 samples and report that. But I still took the average since
> there are 4 samples. I don't see much point in taking more samples here since
> I am not concerned that the signal will fluctuate much (and if it really
> does, then I can easily catch that kind of variation with multiple rcuperf
> runs).
> 
> But if you really want though, I can increase the sampling to 20 samples or a
> number like that and resend it.

Changed it to around 20 samples and the tests look fine. Updated patch below (v5) :

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcuperf: Measure memory footprint during kfree_rcu() test (v5)

During changes to kfree_rcu() code, we often check the amount of free
memory.  As an alternative to checking this manually, this commit adds a
measurement in the test itself.  It measures four times during the test
for available memory, digitally filters these measurements to produce a
running average with a weight of 0.5, and compares this digitally
filtered value with the amount of available memory at the beginning of
the test.

We apply the digital filter only once we are more than 25% into the
test. At the 25% mark, we just read available memory and don't apply any
filtering. This prevents the first sample from skewing the results
as we would not consider memory readings that were before memory was
allocated.

A sample run shows something like:

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
v1->v2: Minor corrections
v1->v3: Use long long to prevent 32-bit system's overflow
	Handle case where some threads start later than others.
	Start measuring only once 25% into the test. Slightly more accurate.
v3->v4: Simplified test more. Using simple average.
v4->v5: Collect more memory samples than previous revision (4 to 5, vs, 20 to 21).

 kernel/rcu/rcuperf.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 1fd0cc72022e..284625af4c79 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/err.h>
@@ -593,7 +594,7 @@ rcu_perf_shutdown(void *arg)
 
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
-torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(int, kfree_loops, 20, "Number of loops doing kfree_alloc_num allocations and frees.");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -616,14 +617,17 @@ DEFINE_KFREE_OBJ(32); // goes on kmalloc-64 slab
 DEFINE_KFREE_OBJ(64); // goes on kmalloc-96 slab
 DEFINE_KFREE_OBJ(96); // goes on kmalloc-128 slab
 
+long long mem_begin;
+
 static int
 kfree_perf_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
 	void *alloc_ptr;
-
 	u64 start_time, end_time;
+	long mem_samples = 0;
+	long long mem_during = 0;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
@@ -638,7 +642,17 @@ kfree_perf_thread(void *arg)
 			b_rcu_gp_test_started = cur_ops->get_gp_seq();
 	}
 
+	// Prevent "% 0" error below.
+	if (kfree_loops < 20)
+		kfree_loops = 20;
+
 	do {
+		// Start measuring only from when we are a little into the test.
+		if ((loop != 0) && (loop % (kfree_loops / 20) == 0)) {
+			mem_during = mem_during + si_mem_available();
+			mem_samples++;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
 			int kfree_type = i % 4;
 
@@ -671,6 +685,8 @@ kfree_perf_thread(void *arg)
 		cond_resched();
 	} while (!torture_must_stop() && ++loop < kfree_loops);
 
+	mem_during = (mem_during / mem_samples);
+
 	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
 		end_time = ktime_get_mono_fast_ns();
 
@@ -679,9 +695,13 @@ kfree_perf_thread(void *arg)
 		else
 			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
 
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		// The "memory footprint" field represents how much in-flight
+		// memory is allocated during the test and waiting to be freed.
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
 			wake_up(&shutdown_wq);
@@ -753,6 +773,8 @@ kfree_perf_init(void)
 		goto unwind;
 	}
 
+	mem_begin = si_mem_available();
+
 	for (i = 0; i < kfree_nrealthreads; i++) {
 		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
 						  kfree_reader_tasks[i]);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

