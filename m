Return-Path: <SRS0=COUN=VB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127FFC0651F
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB94E21721
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Mvhmulan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGDQt1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:49:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33381 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDQt1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Jul 2019 12:49:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so3148476pgk.0
        for <rcu@vger.kernel.org>; Thu, 04 Jul 2019 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/lWh/+X9vOwXw46cbYFVIyvrFwirn+jzcxwLd8bZ3A=;
        b=Mvhmulansem5gHqXq5T2sGV8bjrRNCRq6YKsGH8rYrOszCntGSX3qzKYjbhTRrVxJI
         6dtGvhHA4RpUETa8vttuBygKcjLiGD1tfmG2F0r6/jJ1UEPSEMfLd/UKUDpoGS9yldHT
         /OtpLcIpuP7OIIJFAm+rU9zKiLhb+gv0z1tyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/lWh/+X9vOwXw46cbYFVIyvrFwirn+jzcxwLd8bZ3A=;
        b=cQrfLNBDiPIa6e/VTWUD3D8ISz/cEcoBNaOv39BQPGjge62mkDT5zAI93kjaEL+y2e
         a3ypw/GMFBAMY0lg/dHwH1nTXbZ1NZ8pBXtiO2LF44aO9VRkUYpYUC/QFCXi2NP5FkD/
         cLAtckY89KFt+JoK7oTl4Ly08pvc8+xKBvZb/fErB3vnRwk/E/enbX0waCVF0NN7sU5Y
         hOdtXtS3BJfF/ZOXsadvpvjM46I7G8e/tLhy2hYeUhvOoMeaiq1QBVlMdb3MtB8T7q9N
         /RRAgmQFB2TAaZd6qVWURu9yAyU+zrofno031eaVIoP7QpzC3vHGUTpnmUbM9aQEoPnh
         hA2A==
X-Gm-Message-State: APjAAAVp8hwxZWvkh7Kp4Dkg8QURxj/PUMg3NEXhU3cENyPd8I5VRCiq
        42gC66HhzgSw+ER0huN9mwXYLXdv/jo=
X-Google-Smtp-Source: APXvYqwESwFfH4an/mLYVzfIpoAVwUqimXAwf0CCdyrOyP853+jZhU9QCEcCDTeS1nkFQg4coDilrw==
X-Received: by 2002:a65:43cd:: with SMTP id n13mr45834642pgp.208.1562258965721;
        Thu, 04 Jul 2019 09:49:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x7sm6845473pfa.125.2019.07.04.09.49.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 09:49:24 -0700 (PDT)
Date:   Thu, 4 Jul 2019 12:49:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190704164923.GA117502@google.com>
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
 <20190703113036.04f6169d@gandalf.local.home>
 <20190703164134.GA125833@google.com>
 <20190703173935.GU26519@linux.ibm.com>
 <20190703212426.GC146386@google.com>
 <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704004757.GY26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704004757.GY26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 05:47:57PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2019 at 08:21:30PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 03, 2019 at 04:01:03PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 03, 2019 at 06:24:06PM -0400, Joel Fernandes wrote:
> > > > On Wed, Jul 03, 2019 at 02:57:14PM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Jul 03, 2019 at 05:24:26PM -0400, Joel Fernandes wrote:
> > > > > > On Wed, Jul 03, 2019 at 10:39:35AM -0700, Paul E. McKenney wrote:
> > > > > > > On Wed, Jul 03, 2019 at 12:41:34PM -0400, Joel Fernandes wrote:
> > > > > > > > On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > > > > > > > > On Wed, 3 Jul 2019 11:25:20 -0400
> > > > > > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > I am sorry if this is not a realistic real-life problem, but more a
> > > > > > > > > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > > > > > > > > > 
> > > > > > > > > > I'll keep poking ;-)
> > > > > > > > > 
> > > > > > > > > Hi Joel,
> > > > > > > > > 
> > > > > > > > > Can you also share the tests you are performing as well as any
> > > > > > > > > module/code changes you made so that we can duplicate the results?
> > > > > > > > 
> > > > > > > > Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> > > > > > > > believe Linus's tree should have same results.
> > > > > > > > 
> > > > > > > > After applying the diff below, I run it like this:
> > > > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
> > > > > > > > 
> > > > > > > > Some new options I added:
> > > > > > > > pd_test=1 runs the preempt disable loop test
> > > > > > > > pd_busy_wait is the busy wait time each pass through the loop in microseconds
> > > > > > > > pd_resched is whether the loop should set the need-resched flag periodically.
> > > > > > > > 
> > > > > > > > If your qemu is a bit old or from debian, then you may also need to pass: --qemu-args "-net nic,model=e1000"
> > > > > > > > 
> > > > > > > > With pd_resched = 0, I get quite high average grace-period latencies. The
> > > > > > > > preempt-disable loop thread is running on its own CPU. Enabling the rcu:*
> > > > > > > > tracepoints, I see that for long periods of time, the FQS rcu loop can be
> > > > > > > > running while the scheduler tick learns from rcu_preempt_deferred_qs() that
> > > > > > > > there's nothing to worry about (at least this is what I remember tracing).
> > > > > > > > 
> > > > > > > > With pd_resched = 0, the output of the command above:
> > > > > > > > Average grace-period duration: 195629 microseconds
> > > > > > > > Minimum grace-period duration: 30111.7
> > > > > > > > 50th percentile grace-period duration: 211000
> > > > > > > > 90th percentile grace-period duration: 218000
> > > > > > > > 99th percentile grace-period duration: 222999
> > > > > > > > Maximum grace-period duration: 236351
> > > > > > > > 
> > > > > > > > With pd_resched = 1, you get more like twice (10ms) the busy-wait time (5ms).
> > > > > > > > I wonder why its twice, but that's still Ok. It is as follows:
> > > > > > > > Average grace-period duration: 12302.2 microseconds
> > > > > > > > Minimum grace-period duration: 5998.35
> > > > > > > > 50th percentile grace-period duration: 12000.4
> > > > > > > > 90th percentile grace-period duration: 15996.4
> > > > > > > > 99th percentile grace-period duration: 18000.6
> > > > > > > > Maximum grace-period duration: 20998.6
> > > > > > > 
> > > > > > > Both of these results are within the design range for normal
> > > > > > > RCU grace-period durations on busy systems.  See the code in
> > > > > > > adjust_jiffies_till_sched_qs(), which is setting one of the "panic
> > > > > > > durations" at which RCU starts taking more aggressive actions to end
> > > > > > > the current grace period.  See especially:
> > > > > > > 
> > > > > > > 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> > > > > > > 		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> > > > > > > 	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > > > > > > 	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > > > > > 
> > > > > > > This usually gets you about 100 milliseconds, and if you are starting
> > > > > > > grace periods in quick succession from a single thread while other threads
> > > > > > > are doing likewise, each grace-period wait gets to wait about two grace
> > > > > > > periods worth due to the end of the previous grace period having started
> > > > > > > a new grace period before the thread is awakened.
> > > > > > > 
> > > > > > > Of course, if this is causing trouble for some use case, it would not
> > > > > > > be hard to create a tunable to override this panic duration.  But that
> > > > > > > would of course require a real use case in real use, given that RCU isn't
> > > > > > > exactly short on tunables at the moment.  Significantly shortening this
> > > > > > > panic duration caused 0day to complain about slowness last I tried it,
> > > > > > > just so you know.
> > > > > > 
> > > > > > Thanks a lot for the explanation.
> > > > > > Indeed this code in the tick is doing a good job and I just had to drop
> > > > > > jiffies_till_first_fqs to bring down the latencies. With a
> > > > > > jiffies_till_first_fqs of 50 instead of the default of 100, the latencies
> > > > > > drop by 4 fold.
> > > > > 
> > > > > You lost me on this one.  The normal value of jiffies_till_first_fqs
> > > > > is but three, for systems with 255 or fewer CPUs and HZ=1000.  So I
> > > > > have to ask...  What did you do to get jiffies_till_first_fqs=100?
> > > > > The normal default automatic settings would need something like 8,000
> > > > > CPUs to get it up to that level.
> > > > > 
> > > > > Or did you instead mean replacing the "HZ / 10" in the code snippet
> > > > > above with "HZ / 20" or similar?
> > > > > 
> > > > 
> > > > I meant jiffies_to_sched_qs.
> > > 
> > > Whew!!!  ;-)
> > > 
> > > >                              Without any changes, it is 100 jiffies on my
> > > > system. Setting rcutree.jiffies_till_sched_qs sets the jiffies_to_sched_qs. I
> > > > had set it to 50 and observed dramatic improvements.
> > > > 
> > > >         /* If jiffies_till_sched_qs was specified, respect the request. */
> > > >         if (jiffies_till_sched_qs != ULONG_MAX) {
> > > >                 WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> > > >                 return;
> > > >         }
> > > > 
> > > > > Or did you mean jiffies_to_sched_qs instead of jiffies_till_first_fqs?
> > > > > -That- does default to 100, and you could set it using the
> > > > > rcutree.jiffies_to_sched_qs kernel boot parameter.  But even then, I
> > > > > must admit that I would naively expect halving jiffies_till_first_fqs to
> > > > > halve the latencies.  But I have not looked at it closely, and there are
> > > > > lots of moving parts in RCU's grace-period encouragement code, so maybe
> > > > > that is the effect.
> > > > 
> > > > It could also be my sloppy testing. Now I tried again with 50 and it cuts the
> > > > latencies by around half as you said. However my histogram does have several
> > > > really nasty outliers..
> > > 
> > > OK, that is more what I would expect.
> > > 
> > > > (rcu-kvm is my wrapper where I pass the -net qemu args I need)
> > > > 
> > > > rcu-kvm --rcuperf --boot-args "rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000
> > > > rcuperf.holdout=5 rcuperf.pd_resched=0 rcutree.jiffies_till_sched_qs=50"
> > > > --kvm-args "--duration 1
> > > > 
> > > > Log says:
> > > > 0.087440] rcu:     Boot-time adjustment of scheduler-enlistment delay to 50 jiffies.
> > > > 
> > > > Output:
> > > > Histogram bucket size: 1000
> > > > 57000 4                     
> > > > 58000 1                           
> > > > 59000 1                   
> > > > 60000 2
> > > > 103000 1
> > > > 104000 2
> > > > 105000 8                       
> > > > 106000 44                
> > > > 107000 60                                          
> > > > 108000 131           
> > > > 109000 164
> > > > 110000 143     <---------- most of the time its ~100ms.
> > > > 111000 136            
> > > > 112000 51                 
> > > > 113000 45                             
> > > > 114000 11             
> > > > 115000 4                  
> > > > 12464000 1                            
> > > > 12466000 2   <--- But what are these :(
> > > > 12467000 2                
> > > > 12468000 1                                                        
> > > > 12470000 1                                  
> > > 
> > > Well, those are a bit over one second, which is when .b.need_qs is set
> > > in CONFIG_PREEMPT=y systems.  Are you possibly seeing vCPU preeemption?
> > > (Not that .b.need_qs does anything about vCPU preemption just yet.)
> > 
> > Actually, I just realized, there is an extra 0 on those outliers. So it is
> > really 12 seconds, for example: 12,466,000 microseconds is ~12.4 seconds.
> 
> This is not too far off of another RCU panic point at half of the RCU CPU
> stall warning time.  But that is at roughly 10.5 seconds rather than 12.4.
> At this point, RCU asks the scheduler to force a reschedule.

Shouldn't the tick path take care of any such reschedules already at the
jiffies_to_sched_qs mark? Just curious how can the reschedule help at the
"half way to stall" mark. May be for nohz full CPUs?

By the way, the outliers also happen with rcu_perf_wait_shutdown() in the
loop, but just not as often without it :(

thanks,

 - Joel
