Return-Path: <SRS0=tj9r=VA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF2C5B578
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EC721882
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 21:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BSr+u+mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGCVY3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:24:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42523 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCVY3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Jul 2019 17:24:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so1831029pgb.9
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lNXJPNfRmCFCRzbPSL7jIAJVn/zqlIiSI064aDWpEG4=;
        b=BSr+u+mVAmIKz0mKf+jSCiMZAiAYg43aw1xRMe+r49LfcRVLpqnDpH7MzkwuQxvo07
         kH8OS7oZGjdeZq+GOe7Fj6B7QI7Vj48y9SRVvaxFf0jlq9Iai/2OPXZtI3cyOh2WV3Mi
         BpICOHeIo+JYchGJaGPgB8E/QvFvljDRrxK3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lNXJPNfRmCFCRzbPSL7jIAJVn/zqlIiSI064aDWpEG4=;
        b=azSKQ/Xuvg+SEr6w2Dm8qCo7wuLV3VUR6vw3R4UvZC1u/3hGLhc9A9Ar+nWPAotFJs
         efHjLkYyk8frGq5C4xU8z08CsHaif42mS56PUXxlih51KufjVxjQewLFB3qJJWegu2BS
         c3j+/owJeu90C3NGgHaLPqOZxlMFnWinL4gxsN79arGZ8xP+PU73WAVmw4+G2Ma9sMI7
         3e8V6FeRh+BHGJl4u+UxMWD2vOnQsM9EcNUWlBw7HJEpUZfPttyDJnKZ6Ff4tJTJ4Xh8
         Tha+fLL0bCfkybplg/h1dalrknocLfH49LipEa778UVnwfep5JO8A1uXv/VCKZK8OIMJ
         CRKA==
X-Gm-Message-State: APjAAAUeRtoUx7ld7hQ5Nrx8XYT8N+cijHwf1P5YywSG8yNZxvQOaoiz
        DW7ohk82Jb/dotjSHvreJizk6A==
X-Google-Smtp-Source: APXvYqx42AG3wQgJUiet5y21GasrQ442TwNo6aBAB0kRBfRwf66oOLEfnRPdnKo3iZhLk/47GJONDg==
X-Received: by 2002:a63:30c6:: with SMTP id w189mr10627133pgw.398.1562189068256;
        Wed, 03 Jul 2019 14:24:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z20sm5890195pfk.72.2019.07.03.14.24.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 14:24:27 -0700 (PDT)
Date:   Wed, 3 Jul 2019 17:24:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190703212426.GC146386@google.com>
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
 <20190703113036.04f6169d@gandalf.local.home>
 <20190703164134.GA125833@google.com>
 <20190703173935.GU26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703173935.GU26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 10:39:35AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2019 at 12:41:34PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > > On Wed, 3 Jul 2019 11:25:20 -0400
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > 
> > > > I am sorry if this is not a realistic real-life problem, but more a
> > > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > > > 
> > > > I'll keep poking ;-)
> > > 
> > > Hi Joel,
> > > 
> > > Can you also share the tests you are performing as well as any
> > > module/code changes you made so that we can duplicate the results?
> > 
> > Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> > believe Linus's tree should have same results.
> > 
> > After applying the diff below, I run it like this:
> > tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
> > 
> > Some new options I added:
> > pd_test=1 runs the preempt disable loop test
> > pd_busy_wait is the busy wait time each pass through the loop in microseconds
> > pd_resched is whether the loop should set the need-resched flag periodically.
> > 
> > If your qemu is a bit old or from debian, then you may also need to pass: --qemu-args "-net nic,model=e1000"
> > 
> > With pd_resched = 0, I get quite high average grace-period latencies. The
> > preempt-disable loop thread is running on its own CPU. Enabling the rcu:*
> > tracepoints, I see that for long periods of time, the FQS rcu loop can be
> > running while the scheduler tick learns from rcu_preempt_deferred_qs() that
> > there's nothing to worry about (at least this is what I remember tracing).
> > 
> > With pd_resched = 0, the output of the command above:
> > Average grace-period duration: 195629 microseconds
> > Minimum grace-period duration: 30111.7
> > 50th percentile grace-period duration: 211000
> > 90th percentile grace-period duration: 218000
> > 99th percentile grace-period duration: 222999
> > Maximum grace-period duration: 236351
> > 
> > With pd_resched = 1, you get more like twice (10ms) the busy-wait time (5ms).
> > I wonder why its twice, but that's still Ok. It is as follows:
> > Average grace-period duration: 12302.2 microseconds
> > Minimum grace-period duration: 5998.35
> > 50th percentile grace-period duration: 12000.4
> > 90th percentile grace-period duration: 15996.4
> > 99th percentile grace-period duration: 18000.6
> > Maximum grace-period duration: 20998.6
> 
> Both of these results are within the design range for normal
> RCU grace-period durations on busy systems.  See the code in
> adjust_jiffies_till_sched_qs(), which is setting one of the "panic
> durations" at which RCU starts taking more aggressive actions to end
> the current grace period.  See especially:
> 
> 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> 		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> 	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> 	WRITE_ONCE(jiffies_to_sched_qs, j);
> 
> This usually gets you about 100 milliseconds, and if you are starting
> grace periods in quick succession from a single thread while other threads
> are doing likewise, each grace-period wait gets to wait about two grace
> periods worth due to the end of the previous grace period having started
> a new grace period before the thread is awakened.
> 
> Of course, if this is causing trouble for some use case, it would not
> be hard to create a tunable to override this panic duration.  But that
> would of course require a real use case in real use, given that RCU isn't
> exactly short on tunables at the moment.  Significantly shortening this
> panic duration caused 0day to complain about slowness last I tried it,
> just so you know.

Thanks a lot for the explanation.
Indeed this code in the tick is doing a good job and I just had to drop
jiffies_till_first_fqs to bring down the latencies. With a
jiffies_till_first_fqs of 50 instead of the default of 100, the latencies
drop by 4 fold.

In the tick:
        if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
                /* Idle and userspace execution already are quiescent states. */
                if (!rcu_is_cpu_rrupt_from_idle() && !user) {
                        set_preempt_need_resched();     <--------\
                        set_tsk_need_resched(current);  <------- the preempt
								count test loop
								stands no chance!
                }
                __this_cpu_write(rcu_data.rcu_urgent_qs, false);
        }

Appreciate it! thanks,

 - Joel

