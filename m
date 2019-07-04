Return-Path: <SRS0=COUN=VB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F3C5B578
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 00:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F80218A0
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 00:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="h4b0MC9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGDAVe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:21:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36508 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfGDAVe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Jul 2019 20:21:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so2099182plt.3
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q+K8PY4h8OkSoghXFhc1nUHWGVNYjooM7Nq8U/SgXQ8=;
        b=h4b0MC9wWMgQ7J6bKTs6sw3yQCTR/JEAZiKlmb7HbB9YTeeGZTU1etAfF8MNzujzV4
         SMu2kNg2uCsaP670TMu984iOh2GpCACkagjcCTZl1Zd9U6HkrmLOQT9WV6BFQMnLHIsi
         3sTltmzGS7WBHdCExUIcxWiocM7f1Wy9du22s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+K8PY4h8OkSoghXFhc1nUHWGVNYjooM7Nq8U/SgXQ8=;
        b=KJNLIaFn5kYMuPYSojOYIFc7VbDMA5VU4OAbT4z6Ncj4T7b+d8Dtj4Me/eShmDYRDw
         A8U0Iw+AL6q8egfrJEfucpGheIXfSUj0m9kr4nf/4rXRogV1sAAHqIdtBYwZaC1hPk5b
         rCVIaPci2JowwwaEDishV14a6h5gREggej1Yi6WlyoUkdbuF0Ds9DI0ZGvMGc36LkKMS
         nQ9tHtZXwHs3XaDTrgIVK6+aLYPrx8Za+mzC9jpmHvEOP7F3/vgfcwtm12uTrm8+iPaT
         MUsYhv7DFSU/SdewXYIWjZlWwvp8W3pES7eHzPOV7oQ81MG3L0NaOjs9wwr31CTmsao+
         4XpA==
X-Gm-Message-State: APjAAAVlsAc38YYQHCeJduphy7ikJcYw3SReWj0unDwVQfYHmErXTmNS
        btH5S3Ttw/KhnJnBG0EBl5EXpJOuYwM=
X-Google-Smtp-Source: APXvYqzwvejO5RaW5+1hCoSbjH1d1lyzvbhB2HwdpD70qDwRDps2Fjkwrl0MRQ49ssBPFlItyL90+Q==
X-Received: by 2002:a17:902:112a:: with SMTP id d39mr35548153pla.254.1562199692909;
        Wed, 03 Jul 2019 17:21:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y12sm4725373pfn.187.2019.07.03.17.21.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 17:21:32 -0700 (PDT)
Date:   Wed, 3 Jul 2019 20:21:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190704002130.GA68801@google.com>
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
 <20190703113036.04f6169d@gandalf.local.home>
 <20190703164134.GA125833@google.com>
 <20190703173935.GU26519@linux.ibm.com>
 <20190703212426.GC146386@google.com>
 <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703230103.GX26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 04:01:03PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2019 at 06:24:06PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 03, 2019 at 02:57:14PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 03, 2019 at 05:24:26PM -0400, Joel Fernandes wrote:
> > > > On Wed, Jul 03, 2019 at 10:39:35AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Jul 03, 2019 at 12:41:34PM -0400, Joel Fernandes wrote:
> > > > > > On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > > > > > > On Wed, 3 Jul 2019 11:25:20 -0400
> > > > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > > I am sorry if this is not a realistic real-life problem, but more a
> > > > > > > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > > > > > > > 
> > > > > > > > I'll keep poking ;-)
> > > > > > > 
> > > > > > > Hi Joel,
> > > > > > > 
> > > > > > > Can you also share the tests you are performing as well as any
> > > > > > > module/code changes you made so that we can duplicate the results?
> > > > > > 
> > > > > > Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> > > > > > believe Linus's tree should have same results.
> > > > > > 
> > > > > > After applying the diff below, I run it like this:
> > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
> > > > > > 
> > > > > > Some new options I added:
> > > > > > pd_test=1 runs the preempt disable loop test
> > > > > > pd_busy_wait is the busy wait time each pass through the loop in microseconds
> > > > > > pd_resched is whether the loop should set the need-resched flag periodically.
> > > > > > 
> > > > > > If your qemu is a bit old or from debian, then you may also need to pass: --qemu-args "-net nic,model=e1000"
> > > > > > 
> > > > > > With pd_resched = 0, I get quite high average grace-period latencies. The
> > > > > > preempt-disable loop thread is running on its own CPU. Enabling the rcu:*
> > > > > > tracepoints, I see that for long periods of time, the FQS rcu loop can be
> > > > > > running while the scheduler tick learns from rcu_preempt_deferred_qs() that
> > > > > > there's nothing to worry about (at least this is what I remember tracing).
> > > > > > 
> > > > > > With pd_resched = 0, the output of the command above:
> > > > > > Average grace-period duration: 195629 microseconds
> > > > > > Minimum grace-period duration: 30111.7
> > > > > > 50th percentile grace-period duration: 211000
> > > > > > 90th percentile grace-period duration: 218000
> > > > > > 99th percentile grace-period duration: 222999
> > > > > > Maximum grace-period duration: 236351
> > > > > > 
> > > > > > With pd_resched = 1, you get more like twice (10ms) the busy-wait time (5ms).
> > > > > > I wonder why its twice, but that's still Ok. It is as follows:
> > > > > > Average grace-period duration: 12302.2 microseconds
> > > > > > Minimum grace-period duration: 5998.35
> > > > > > 50th percentile grace-period duration: 12000.4
> > > > > > 90th percentile grace-period duration: 15996.4
> > > > > > 99th percentile grace-period duration: 18000.6
> > > > > > Maximum grace-period duration: 20998.6
> > > > > 
> > > > > Both of these results are within the design range for normal
> > > > > RCU grace-period durations on busy systems.  See the code in
> > > > > adjust_jiffies_till_sched_qs(), which is setting one of the "panic
> > > > > durations" at which RCU starts taking more aggressive actions to end
> > > > > the current grace period.  See especially:
> > > > > 
> > > > > 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> > > > > 		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> > > > > 	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > > > > 	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > > > 
> > > > > This usually gets you about 100 milliseconds, and if you are starting
> > > > > grace periods in quick succession from a single thread while other threads
> > > > > are doing likewise, each grace-period wait gets to wait about two grace
> > > > > periods worth due to the end of the previous grace period having started
> > > > > a new grace period before the thread is awakened.
> > > > > 
> > > > > Of course, if this is causing trouble for some use case, it would not
> > > > > be hard to create a tunable to override this panic duration.  But that
> > > > > would of course require a real use case in real use, given that RCU isn't
> > > > > exactly short on tunables at the moment.  Significantly shortening this
> > > > > panic duration caused 0day to complain about slowness last I tried it,
> > > > > just so you know.
> > > > 
> > > > Thanks a lot for the explanation.
> > > > Indeed this code in the tick is doing a good job and I just had to drop
> > > > jiffies_till_first_fqs to bring down the latencies. With a
> > > > jiffies_till_first_fqs of 50 instead of the default of 100, the latencies
> > > > drop by 4 fold.
> > > 
> > > You lost me on this one.  The normal value of jiffies_till_first_fqs
> > > is but three, for systems with 255 or fewer CPUs and HZ=1000.  So I
> > > have to ask...  What did you do to get jiffies_till_first_fqs=100?
> > > The normal default automatic settings would need something like 8,000
> > > CPUs to get it up to that level.
> > > 
> > > Or did you instead mean replacing the "HZ / 10" in the code snippet
> > > above with "HZ / 20" or similar?
> > > 
> > 
> > I meant jiffies_to_sched_qs.
> 
> Whew!!!  ;-)
> 
> >                              Without any changes, it is 100 jiffies on my
> > system. Setting rcutree.jiffies_till_sched_qs sets the jiffies_to_sched_qs. I
> > had set it to 50 and observed dramatic improvements.
> > 
> >         /* If jiffies_till_sched_qs was specified, respect the request. */
> >         if (jiffies_till_sched_qs != ULONG_MAX) {
> >                 WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> >                 return;
> >         }
> > 
> > > Or did you mean jiffies_to_sched_qs instead of jiffies_till_first_fqs?
> > > -That- does default to 100, and you could set it using the
> > > rcutree.jiffies_to_sched_qs kernel boot parameter.  But even then, I
> > > must admit that I would naively expect halving jiffies_till_first_fqs to
> > > halve the latencies.  But I have not looked at it closely, and there are
> > > lots of moving parts in RCU's grace-period encouragement code, so maybe
> > > that is the effect.
> > 
> > It could also be my sloppy testing. Now I tried again with 50 and it cuts the
> > latencies by around half as you said. However my histogram does have several
> > really nasty outliers..
> 
> OK, that is more what I would expect.
> 
> > (rcu-kvm is my wrapper where I pass the -net qemu args I need)
> > 
> > rcu-kvm --rcuperf --boot-args "rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000
> > rcuperf.holdout=5 rcuperf.pd_resched=0 rcutree.jiffies_till_sched_qs=50"
> > --kvm-args "--duration 1
> > 
> > Log says:
> > 0.087440] rcu:     Boot-time adjustment of scheduler-enlistment delay to 50 jiffies.
> > 
> > Output:
> > Histogram bucket size: 1000
> > 57000 4                     
> > 58000 1                           
> > 59000 1                   
> > 60000 2
> > 103000 1
> > 104000 2
> > 105000 8                       
> > 106000 44                
> > 107000 60                                          
> > 108000 131           
> > 109000 164
> > 110000 143     <---------- most of the time its ~100ms.
> > 111000 136            
> > 112000 51                 
> > 113000 45                             
> > 114000 11             
> > 115000 4                  
> > 12464000 1                            
> > 12466000 2   <--- But what are these :(
> > 12467000 2                
> > 12468000 1                                                        
> > 12470000 1                                  
> 
> Well, those are a bit over one second, which is when .b.need_qs is set
> in CONFIG_PREEMPT=y systems.  Are you possibly seeing vCPU preeemption?
> (Not that .b.need_qs does anything about vCPU preemption just yet.)

Actually, I just realized, there is an extra 0 on those outliers. So it is
really 12 seconds, for example: 12,466,000 microseconds is ~12.4 seconds. So
these outliers are really odd since I don't see any RCU stalls, possible theories:

Looking closer into the logs, it is always the last iteration of a writer:

Third last iteration..
[   62.157951] rcu-perf:    0 writer-duration:    99 109999933
[   62.258131] rcu-perf:    1 writer-duration:    99 110999466
[   62.353607] rcu-perf:    2 writer-duration:    99 112000830
[   62.433249] rcu-perf:    3 writer-duration:    99 114000321
[   62.510405] rcu-perf:    4 writer-duration:    99 109000240
[   62.603643] rcu-perf:    5 writer-duration:    99 108999164
[   62.702109] rcu-perf:    6 writer-duration:    99 111000721
[   62.799970] rcu-perf:    7 writer-duration:    99 109000536

Second last iteration..
[   62.158920] rcu-perf:    0 writer-duration:   100 109998415
[   62.259061] rcu-perf:    1 writer-duration:   100 104024906
[   62.354395] rcu-perf:    2 writer-duration:   100 105019175
[   62.434072] rcu-perf:    3 writer-duration:   100 108019926
[   62.511154] rcu-perf:    4 writer-duration:   100 109998839
[   62.604572] rcu-perf:    5 writer-duration:   100 109000969
[   62.703005] rcu-perf:    6 writer-duration:   100 107015416
[   62.800894] rcu-perf:    7 writer-duration:   100 111018680

And last one which is over blown over..
[   62.161123] rcu-perf:    0 writer-duration:   101 42665751175
[   62.261115] rcu-perf:    1 writer-duration:   101 42693148470
[   62.357093] rcu-perf:    2 writer-duration:   101 42692066685
[   62.436059] rcu-perf:    3 writer-duration:   101 42692831737
[   62.513063] rcu-perf:    4 writer-duration:   101 42693195036
[   62.705105] rcu-perf:    6 writer-duration:   101 42692114079
[   62.803104] rcu-perf:    7 writer-duration:   101 42693153435

I am wondering if this because the torture_stop() is having a hard time
stopping my preempt disable thread, which is odd because I am checking for
torture_must_stop() to break out of the loop as are other threads.

Anyway this is clearly more of a test issue than an RCU one ;-)

> > Average grace-period duration: 215642 microseconds <-- avg ended up skewed
> > Minimum grace-period duration: 57979.7
> > 50th percentile grace-period duration: 110000
> > 90th percentile grace-period duration: 112999  <-- but this reduced.
> > 99th percentile grace-period duration: 115000
> 
> Indeed, medians and percentiles are often more stable than are averages.
> (But yes, you can cook up distributions that work the other way around.)
> 
> > (And just did another test and the outliers are pretty consistent).
> > 
> > Also, I do occassionally see that preempt disable test not getting its Need
> > resched bit set yet. Even though we have multiple ticks. I am trying to trace
> > this out and understand it as well.
> 
> That might also be a sign that the RCU grace-period kthread is being
> starved for short time periods.  One way to check this is to use the
> rcutree.kthread_prio kernel boot parameter to set RCU's kthreads to
> some real-time priority.  This is not something you usually want to
> do because it can greatly increase the context-switch rate, but as an
> experiment it might provide useful clues.

Tried and did not change the result of outliers but that's just because it is
likely not an RCU issue.

thanks,

 - Joel



