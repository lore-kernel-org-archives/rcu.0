Return-Path: <SRS0=COUN=VB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D4C0650E
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 03:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D420F2187F
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 03:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BSq/yIVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGDDY6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 23:24:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41441 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGDDY6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Jul 2019 23:24:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so2289918pls.8
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxks+645z73qWPgUjhHGaNP6RKudedF88GQ/N2L8SAY=;
        b=BSq/yIViW/RPhIqYW+oaSs03URYqkThocOq4TdPkiwtxlac0ndubxwUaNMKTjhbrp8
         tsCRK6zkrGB5KBU65cW9/nRstIZZZL1LAynpQG+lEi9GYvrSEGiMvEY6nAhfIAK83DGB
         KN48zjdAQ6tTtxKUK5Qfu/jxPqO15Ilcdg0Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxks+645z73qWPgUjhHGaNP6RKudedF88GQ/N2L8SAY=;
        b=TMC82//aezMgQ+jApWv8WUw7UK/blKy4rKqwejjeuooR5MUa4Nu/vgK/B+sMiXDtvN
         3jiNdlOr2Uy5PQnawCuk7ljBxAhIw5TerZaJL8DsbSTOxMorNzzjGvrM+j6WWBHo515J
         05UdfyV2VQarF6Jy92jV3UuRg/2ynUR9SVmpIMDuEh5AWq5JQDg/J29MNobOazf/NKmG
         vUOCkUBEkjOFuBUYLFg8UwjDA9S/NpWuIJ9TNTRsVfV2nwr7/s1Ia7FStbZvcpkkMH4P
         tcO25blTuBEjhxRXDTTbtW0jQi+OvXKEDQiRBbhGtWhEnMP3+X3Zxi9KZkL74ELP2NYZ
         FhRg==
X-Gm-Message-State: APjAAAWFpNncVM5DZlXeRqGzKXLaEeSYQPi9+phb85rIrcnkMRH42LWZ
        RFzstURnVlfAr+mAs5MEpvChMSVonTU=
X-Google-Smtp-Source: APXvYqz4lQNdPNO/z78QtqyDzbK6FYYETxHrDPzHsl15gVG6zvCmLSsNy9izeijLYDK/ETASdVL4Rw==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr47093284pln.279.1562210696905;
        Wed, 03 Jul 2019 20:24:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j13sm3736127pfh.13.2019.07.03.20.24.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 20:24:55 -0700 (PDT)
Date:   Wed, 3 Jul 2019 23:24:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190704032454.GA259593@google.com>
References: <20190703113036.04f6169d@gandalf.local.home>
 <20190703164134.GA125833@google.com>
 <20190703173935.GU26519@linux.ibm.com>
 <20190703212426.GC146386@google.com>
 <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704005009.GZ26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 03, 2019 at 08:21:30PM -0400, Joel Fernandes wrote:
> > > On Wed, Jul 03, 2019 at 04:01:03PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jul 03, 2019 at 06:24:06PM -0400, Joel Fernandes wrote:
> > > > > On Wed, Jul 03, 2019 at 02:57:14PM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Jul 03, 2019 at 05:24:26PM -0400, Joel Fernandes wrote:
> > > > > > > On Wed, Jul 03, 2019 at 10:39:35AM -0700, Paul E. McKenney wrote:
> > > > > > > > On Wed, Jul 03, 2019 at 12:41:34PM -0400, Joel Fernandes wrote:
> > > > > > > > > On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > > > > > > > > > On Wed, 3 Jul 2019 11:25:20 -0400
> > > > > > > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > I am sorry if this is not a realistic real-life problem, but more a
> > > > > > > > > > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > > > > > > > > > > 
> > > > > > > > > > > I'll keep poking ;-)
> > > > > > > > > > 
> > > > > > > > > > Hi Joel,
> > > > > > > > > > 
> > > > > > > > > > Can you also share the tests you are performing as well as any
> > > > > > > > > > module/code changes you made so that we can duplicate the results?
> > > > > > > > > 
> > > > > > > > > Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> > > > > > > > > believe Linus's tree should have same results.
> > > > > > > > > 
> > > > > > > > > After applying the diff below, I run it like this:
> > > > > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
> > > > > > > > > 
> > > > > > > > > Some new options I added:
> > > > > > > > > pd_test=1 runs the preempt disable loop test
> > > > > > > > > pd_busy_wait is the busy wait time each pass through the loop in microseconds
> > > > > > > > > pd_resched is whether the loop should set the need-resched flag periodically.
> > > > > > > > > 
> > > > > > > > > If your qemu is a bit old or from debian, then you may also need to pass: --qemu-args "-net nic,model=e1000"
> > > > > > > > > 
> > > > > > > > > With pd_resched = 0, I get quite high average grace-period latencies. The
> > > > > > > > > preempt-disable loop thread is running on its own CPU. Enabling the rcu:*
> > > > > > > > > tracepoints, I see that for long periods of time, the FQS rcu loop can be
> > > > > > > > > running while the scheduler tick learns from rcu_preempt_deferred_qs() that
> > > > > > > > > there's nothing to worry about (at least this is what I remember tracing).
> > > > > > > > > 
> > > > > > > > > With pd_resched = 0, the output of the command above:
> > > > > > > > > Average grace-period duration: 195629 microseconds
> > > > > > > > > Minimum grace-period duration: 30111.7
> > > > > > > > > 50th percentile grace-period duration: 211000
> > > > > > > > > 90th percentile grace-period duration: 218000
> > > > > > > > > 99th percentile grace-period duration: 222999
> > > > > > > > > Maximum grace-period duration: 236351
> > > > > > > > > 
> > > > > > > > > With pd_resched = 1, you get more like twice (10ms) the busy-wait time (5ms).
> > > > > > > > > I wonder why its twice, but that's still Ok. It is as follows:
> > > > > > > > > Average grace-period duration: 12302.2 microseconds
> > > > > > > > > Minimum grace-period duration: 5998.35
> > > > > > > > > 50th percentile grace-period duration: 12000.4
> > > > > > > > > 90th percentile grace-period duration: 15996.4
> > > > > > > > > 99th percentile grace-period duration: 18000.6
> > > > > > > > > Maximum grace-period duration: 20998.6
> > > > > > > > 
> > > > > > > > Both of these results are within the design range for normal
> > > > > > > > RCU grace-period durations on busy systems.  See the code in
> > > > > > > > adjust_jiffies_till_sched_qs(), which is setting one of the "panic
> > > > > > > > durations" at which RCU starts taking more aggressive actions to end
> > > > > > > > the current grace period.  See especially:
> > > > > > > > 
> > > > > > > > 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> > > > > > > > 		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> > > > > > > > 	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > > > > > > > 	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > > > > > > 
> > > > > > > > This usually gets you about 100 milliseconds, and if you are starting
> > > > > > > > grace periods in quick succession from a single thread while other threads
> > > > > > > > are doing likewise, each grace-period wait gets to wait about two grace
> > > > > > > > periods worth due to the end of the previous grace period having started
> > > > > > > > a new grace period before the thread is awakened.
> > > > > > > > 
> > > > > > > > Of course, if this is causing trouble for some use case, it would not
> > > > > > > > be hard to create a tunable to override this panic duration.  But that
> > > > > > > > would of course require a real use case in real use, given that RCU isn't
> > > > > > > > exactly short on tunables at the moment.  Significantly shortening this
> > > > > > > > panic duration caused 0day to complain about slowness last I tried it,
> > > > > > > > just so you know.
> > > > > > > 
> > > > > > > Thanks a lot for the explanation.
> > > > > > > Indeed this code in the tick is doing a good job and I just had to drop
> > > > > > > jiffies_till_first_fqs to bring down the latencies. With a
> > > > > > > jiffies_till_first_fqs of 50 instead of the default of 100, the latencies
> > > > > > > drop by 4 fold.
> > > > > > 
> > > > > > You lost me on this one.  The normal value of jiffies_till_first_fqs
> > > > > > is but three, for systems with 255 or fewer CPUs and HZ=1000.  So I
> > > > > > have to ask...  What did you do to get jiffies_till_first_fqs=100?
> > > > > > The normal default automatic settings would need something like 8,000
> > > > > > CPUs to get it up to that level.
> > > > > > 
> > > > > > Or did you instead mean replacing the "HZ / 10" in the code snippet
> > > > > > above with "HZ / 20" or similar?
> > > > > > 
> > > > > 
> > > > > I meant jiffies_to_sched_qs.
> > > > 
> > > > Whew!!!  ;-)
> > > > 
> > > > >                              Without any changes, it is 100 jiffies on my
> > > > > system. Setting rcutree.jiffies_till_sched_qs sets the jiffies_to_sched_qs. I
> > > > > had set it to 50 and observed dramatic improvements.
> > > > > 
> > > > >         /* If jiffies_till_sched_qs was specified, respect the request. */
> > > > >         if (jiffies_till_sched_qs != ULONG_MAX) {
> > > > >                 WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> > > > >                 return;
> > > > >         }
> > > > > 
> > > > > > Or did you mean jiffies_to_sched_qs instead of jiffies_till_first_fqs?
> > > > > > -That- does default to 100, and you could set it using the
> > > > > > rcutree.jiffies_to_sched_qs kernel boot parameter.  But even then, I
> > > > > > must admit that I would naively expect halving jiffies_till_first_fqs to
> > > > > > halve the latencies.  But I have not looked at it closely, and there are
> > > > > > lots of moving parts in RCU's grace-period encouragement code, so maybe
> > > > > > that is the effect.
> > > > > 
> > > > > It could also be my sloppy testing. Now I tried again with 50 and it cuts the
> > > > > latencies by around half as you said. However my histogram does have several
> > > > > really nasty outliers..
> > > > 
> > > > OK, that is more what I would expect.
> > > > 
> > > > > (rcu-kvm is my wrapper where I pass the -net qemu args I need)
> > > > > 
> > > > > rcu-kvm --rcuperf --boot-args "rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000
> > > > > rcuperf.holdout=5 rcuperf.pd_resched=0 rcutree.jiffies_till_sched_qs=50"
> > > > > --kvm-args "--duration 1
> > > > > 
> > > > > Log says:
> > > > > 0.087440] rcu:     Boot-time adjustment of scheduler-enlistment delay to 50 jiffies.
> > > > > 
> > > > > Output:
> > > > > Histogram bucket size: 1000
> > > > > 57000 4                     
> > > > > 58000 1                           
> > > > > 59000 1                   
> > > > > 60000 2
> > > > > 103000 1
> > > > > 104000 2
> > > > > 105000 8                       
> > > > > 106000 44                
> > > > > 107000 60                                          
> > > > > 108000 131           
> > > > > 109000 164
> > > > > 110000 143     <---------- most of the time its ~100ms.
> > > > > 111000 136            
> > > > > 112000 51                 
> > > > > 113000 45                             
> > > > > 114000 11             
> > > > > 115000 4                  
> > > > > 12464000 1                            
> > > > > 12466000 2   <--- But what are these :(
> > > > > 12467000 2                
> > > > > 12468000 1                                                        
> > > > > 12470000 1                                  
> > > > 
> > > > Well, those are a bit over one second, which is when .b.need_qs is set
> > > > in CONFIG_PREEMPT=y systems.  Are you possibly seeing vCPU preeemption?
> > > > (Not that .b.need_qs does anything about vCPU preemption just yet.)
> > > 
> > > Actually, I just realized, there is an extra 0 on those outliers. So it is
> > > really 12 seconds, for example: 12,466,000 microseconds is ~12.4 seconds. So
> > > these outliers are really odd since I don't see any RCU stalls, possible theories:
> > > 
> > > Looking closer into the logs, it is always the last iteration of a writer:
> > > 
> > > Third last iteration..
> > > [   62.157951] rcu-perf:    0 writer-duration:    99 109999933
> > > [   62.258131] rcu-perf:    1 writer-duration:    99 110999466
> > > [   62.353607] rcu-perf:    2 writer-duration:    99 112000830
> > > [   62.433249] rcu-perf:    3 writer-duration:    99 114000321
> > > [   62.510405] rcu-perf:    4 writer-duration:    99 109000240
> > > [   62.603643] rcu-perf:    5 writer-duration:    99 108999164
> > > [   62.702109] rcu-perf:    6 writer-duration:    99 111000721
> > > [   62.799970] rcu-perf:    7 writer-duration:    99 109000536
> > > 
> > > Second last iteration..
> > > [   62.158920] rcu-perf:    0 writer-duration:   100 109998415
> > > [   62.259061] rcu-perf:    1 writer-duration:   100 104024906
> > > [   62.354395] rcu-perf:    2 writer-duration:   100 105019175
> > > [   62.434072] rcu-perf:    3 writer-duration:   100 108019926
> > > [   62.511154] rcu-perf:    4 writer-duration:   100 109998839
> > > [   62.604572] rcu-perf:    5 writer-duration:   100 109000969
> > > [   62.703005] rcu-perf:    6 writer-duration:   100 107015416
> > > [   62.800894] rcu-perf:    7 writer-duration:   100 111018680
> > > 
> > > And last one which is over blown over..
> > > [   62.161123] rcu-perf:    0 writer-duration:   101 42665751175
> > > [   62.261115] rcu-perf:    1 writer-duration:   101 42693148470
> > > [   62.357093] rcu-perf:    2 writer-duration:   101 42692066685
> > > [   62.436059] rcu-perf:    3 writer-duration:   101 42692831737
> > > [   62.513063] rcu-perf:    4 writer-duration:   101 42693195036
> > > [   62.705105] rcu-perf:    6 writer-duration:   101 42692114079
> > > [   62.803104] rcu-perf:    7 writer-duration:   101 42693153435
> > > 
> > > I am wondering if this because the torture_stop() is having a hard time
> > > stopping my preempt disable thread, which is odd because I am checking for
> > > torture_must_stop() to break out of the loop as are other threads.
> > > 
> > > Anyway this is clearly more of a test issue than an RCU one ;-)
> > > 
> > > > > Average grace-period duration: 215642 microseconds <-- avg ended up skewed
> > > > > Minimum grace-period duration: 57979.7
> > > > > 50th percentile grace-period duration: 110000
> > > > > 90th percentile grace-period duration: 112999  <-- but this reduced.
> > > > > 99th percentile grace-period duration: 115000
> > > > 
> > > > Indeed, medians and percentiles are often more stable than are averages.
> > > > (But yes, you can cook up distributions that work the other way around.)
> > 
> > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > 
> > Still can't explain that :)
> > 
> > 	do {
> > 		...
> > 		...
> > +               rcu_perf_wait_shutdown();
> >         } while (!torture_must_stop());
> 
> Might it be the cond_resched_tasks_rcu_qs() invoked from within
> rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> rcu_perf_wait_shutdown()?

I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
help. Only calling rcu_perf_wait_shutdown() cures it. If you would like try
it out, below is the diff and the command is:

tools/testing/selftests/rcutorture/bin/kvm.sh --qemu-args -net nic,model=e1000
--bootargs "rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5
   rcuperf.pd_resched=0 rcutree.jiffies_till_sched_qs=50 rcutree.kthread_prio=10
   ftrace_dump_on_oops trace_event=rcu:rcu_grace_period"

(The diff is just for debugging and not meant for upstreaming, atleast not yet)
------8<-------
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 8fd4f82c9b3d..5d30dbc7000b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -429,12 +429,14 @@ static inline void srcu_init(void) { }
 static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline void rcu_expedite_gp(void) { }
+static inline bool rcu_expedite_gp_called(void) { }
 static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
+bool rcu_expedite_gp_called(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
 void rcu_request_urgent_qs_task(struct task_struct *t);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 4513807cd4c4..08ff48ffa065 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -34,6 +34,7 @@
 #include <linux/stat.h>
 #include <linux/srcu.h>
 #include <linux/slab.h>
+#include <linux/trace_clock.h>
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
@@ -79,13 +80,16 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
 torture_param(int, gp_async_max, 1000, "Max # outstanding waits per reader");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
-torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
-torture_param(int, nreaders, -1, "Number of RCU reader threads");
-torture_param(int, nwriters, -1, "Number of RCU updater threads");
+torture_param(int, holdoff, 5, "Holdoff time before test start (s)");
+torture_param(int, nreaders, 10, "Number of RCU reader threads");
+torture_param(int, nwriters, 10, "Number of RCU updater threads");
 torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 	      "Shutdown at end of performance tests.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
+torture_param(int, pd_test, 0, "Do the preempt disable loop test");
+torture_param(int, pd_busy_wait, 5000, "Preempt-disable per-loop wait in usecs");
+torture_param(int, pd_resched, 1, "Preempt-disable per-loop wait in usecs");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
@@ -96,6 +100,7 @@ static int nrealwriters;
 static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
 static struct task_struct *shutdown_task;
+static struct task_struct *pd_task;
 
 static u64 **writer_durations;
 static int *writer_n_durations;
@@ -375,6 +380,11 @@ rcu_perf_writer(void *arg)
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
 
+	// Wait for rcu_unexpedite_gp() to be called from init to avoid
+	// doing expedited GPs if we are not supposed to
+	while (!gp_exp && rcu_expedite_gp_called())
+		schedule_timeout_uninterruptible(1);
+
 	t = ktime_get_mono_fast_ns();
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
@@ -413,6 +423,9 @@ rcu_perf_writer(void *arg)
 		} else {
 			rcu_perf_writer_state = RTWS_SYNC;
 			cur_ops->sync();
+			if (i % 20 == 0) {
+				//pr_err("writer %ld loop=%d gpseq=%lu\n", me, i, cur_ops->get_gp_seq());
+			}
 		}
 		rcu_perf_writer_state = RTWS_IDLE;
 		t = ktime_get_mono_fast_ns();
@@ -452,6 +465,7 @@ rcu_perf_writer(void *arg)
 			alldone = true;
 		if (started && !alldone && i < MAX_MEAS - 1)
 			i++;
+		//pr_err("writer %d i now %d\n", me, i);
 		rcu_perf_wait_shutdown();
 	} while (!torture_must_stop());
 	if (gp_async) {
@@ -464,6 +478,68 @@ rcu_perf_writer(void *arg)
 	return 0;
 }
 
+static void busy_wait(int time_us)
+{
+	u64 start, end;
+	start = trace_clock_local();
+	do {
+		end = trace_clock_local();
+		if (kthread_should_stop())
+			break;
+	} while ((end - start) < (time_us * 1000));
+}
+
+static int
+rcu_perf_preempt_disable(void *arg)
+{
+	struct sched_param sp;
+
+	VERBOSE_PERFOUT_STRING("rcu_perf_preempt_disable task thread enter");
+
+	// Create pd thread on last CPU
+	set_cpus_allowed_ptr(current, cpumask_of(nr_cpu_ids - 1));
+	sp.sched_priority = 1;
+	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
+
+	// Wait for holdoff
+	if (holdoff)
+		schedule_timeout_uninterruptible(holdoff * HZ);
+
+	// Wait for rcu_unexpedite_gp() to be called from init to avoid
+	// doing expedited GPs if we are not supposed to
+	while (!gp_exp && rcu_expedite_gp_called())
+		schedule_timeout_uninterruptible(1);
+
+	pr_err("PD test started on cpu %d\n", smp_processor_id());
+
+	do {
+		preempt_disable();
+		busy_wait(pd_busy_wait);
+
+		/* Prevent stalls and unnecessary extension of grace period */
+		if (pd_resched) {
+			set_tsk_need_resched(current);
+			set_preempt_need_resched();
+		}
+
+		preempt_enable();
+
+		/* Just in case preempt_enable didn't resched ;-) */
+		if (pd_resched)
+			cond_resched();
+#if 0
+		if (i++ % 1000 == 0){
+			pr_err("pd: looped once in 1000, i = %d\n", i);
+			trace_printk("pd: looped once in 1000, i = %d\n", i);
+		}
+#endif
+		rcu_perf_wait_shutdown();
+	} while (!torture_must_stop());
+
+	torture_kthread_stopping("rcu_perf_preempt_disable");
+	return 0;
+}
+
 static void
 rcu_perf_print_module_parms(struct rcu_perf_ops *cur_ops, const char *tag)
 {
@@ -548,6 +624,11 @@ rcu_perf_cleanup(void)
 		kfree(writer_n_durations);
 	}
 
+	if (pd_task) {
+		torture_stop_kthread(rcu_perf_preempt_disable, pd_task);
+		kfree(pd_task);
+	}
+
 	/* Do torture-type-specific cleanup operations.  */
 	if (cur_ops->cleanup != NULL)
 		cur_ops->cleanup();
@@ -571,7 +652,9 @@ static int compute_real(int n)
 		if (nr <= 0)
 			nr = 1;
 	}
-	return nr;
+
+	// Reserve 2 cpus for testing
+	return nr - 2;
 }
 
 /*
@@ -681,6 +764,20 @@ rcu_perf_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+
+	if (pd_test) {
+		pd_task = kzalloc(sizeof(*pd_task), GFP_KERNEL);
+		if (!pd_task) {
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
+
+		firsterr = torture_create_kthread(rcu_perf_preempt_disable,
+				NULL, pd_task);
+		if (firsterr)
+			goto unwind;
+	}
+
 	torture_init_end();
 	return 0;
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 249517058b13..840f62805d62 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -154,6 +154,15 @@ void rcu_expedite_gp(void)
 }
 EXPORT_SYMBOL_GPL(rcu_expedite_gp);
 
+/**
+ * rcu_expedite_gp_called - Was there a prior call to rcu_expedite_gp()?
+ */
+bool rcu_expedite_gp_called(void)
+{
+	return (atomic_read(&rcu_expedited_nesting) != 0);
+}
+EXPORT_SYMBOL_GPL(rcu_expedite_gp_called);
+
 /**
  * rcu_unexpedite_gp - Cancel prior rcu_expedite_gp() invocation
  *
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
index db0375a57f28..c8fd6bb6d8cb 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+set -x
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Analyze a given results directory for rcuperf performance measurements.
@@ -78,6 +79,7 @@ END {
 	print "90th percentile grace-period duration: " gptimes[pct90];
 	print "99th percentile grace-period duration: " gptimes[pct99];
 	print "Maximum grace-period duration: " gptimes[newNR];
+	print "Batches " nbatches " done";
 	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches;
 	print "Computed from rcuperf printk output.";
 }'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 33c669619736..f6ec8de276b7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+set -x
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Run a kvm-based test of the specified tree on the specified configs.
