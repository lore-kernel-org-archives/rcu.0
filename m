Return-Path: <SRS0=COUN=VB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99513C0651F
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 18:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BF92189E
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 18:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XsPDatcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGDSu7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:50:59 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:35419 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDSu6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Jul 2019 14:50:58 -0400
Received: by mail-pf1-f182.google.com with SMTP id u14so2075507pfn.2
        for <rcu@vger.kernel.org>; Thu, 04 Jul 2019 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGLU+acHWsb9J2RgHb+Q6p2v+II40Ti5aVimx/7z1pI=;
        b=XsPDatcT4l3WHqea0mltT03pcdCEtAW9gd+Mk1Jpoa1Y86mklZrDmldJHWLFgA9Al3
         1SnptqQQy7T6X9WmJyOnCxk5q9Ibwti4+F2VV2eHINbs4oNQV+ie5WBP2g5xDIBXPUVw
         V9Yz4GgZyoh0Ds/plJ6QYNRDr5C/2qnQdvcQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGLU+acHWsb9J2RgHb+Q6p2v+II40Ti5aVimx/7z1pI=;
        b=bLMljxiFlqvD8ZcLg1s9iUWPaszNWKLMTgtqPHMD0lgAceJ1/BK/lE251vMxVymqgl
         YWAWTK64O+KcGkaYdmEAgB3m60POAsQGvLiOmKaJpNBN4hFuwaN2zRsIR3PXIYI7A8Ir
         vj7Amgp3LmDbEsV1UIvrm7XaiHHXXDWbQ8f1CTmi6HsZ2VXtLuo3Uaaw0NP6KDnQHOH+
         UP0lX6sUfjhOVIA3RQBbFiUXlNLsA8ods0r0DI2c/qLqh1SYGxcKLu1Z5CYMErAxs/vI
         jQ+eYe/mj/6gK2TowVaUljB+NtpBLq1euk1V7V1ACx6RILbmk+Uooe8s3F8I2zO1WVDG
         FAaQ==
X-Gm-Message-State: APjAAAWgphbOKApy8gK70f+xsCtyqlp9PFS5NcbaNoRMlOjw7WIVHOZC
        S7/qHlEtzmlUgxD9b7e+5Q6e6Tz/8Cw=
X-Google-Smtp-Source: APXvYqwfsxujEw5WJgZq/eGs9oYReXEBNtw75vHS/xubWUu3mhezGDY0fZuwfSilOZFtz7xqGub6WQ==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr1020035pjb.51.1562266257666;
        Thu, 04 Jul 2019 11:50:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m101sm5377657pjb.7.2019.07.04.11.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 11:50:56 -0700 (PDT)
Date:   Thu, 4 Jul 2019 14:50:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190704185055.GA12919@google.com>
References: <20190703173935.GU26519@linux.ibm.com>
 <20190703212426.GC146386@google.com>
 <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704171315.GG26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 04, 2019 at 10:13:15AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2019 at 11:24:54PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:
> 
> [ . . . ]
> 
> > > > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > > > 
> > > > Still can't explain that :)
> > > > 
> > > > 	do {
> > > > 		...
> > > > 		...
> > > > +               rcu_perf_wait_shutdown();
> > > >         } while (!torture_must_stop());
> > > 
> > > Might it be the cond_resched_tasks_rcu_qs() invoked from within
> > > rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> > > use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> > > rcu_perf_wait_shutdown()?
> > 
> > I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
> > help. Only calling rcu_perf_wait_shutdown() cures it.
> 
> My eyes seem to be working better today.
> 
> Here is rcu_perf_wait_shutdown():
> 
> 	static void rcu_perf_wait_shutdown(void)
> 	{
> 		cond_resched_tasks_rcu_qs();
> 		if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
> 			return;
> 		while (!torture_must_stop())
> 			schedule_timeout_uninterruptible(1);
> 	}
> 
> Take a close look at the "while" loop.  It is effectively ending your
> test prematurely and thus rendering the code no longer CPU-bound.  ;-)

That makes a lot of sense. I also found that I can drop
'rcu_perf_wait_shutdown' in my preempt-disable loop as long as I don't do an
ftrace trace. I suspect the trace dump happening at the end is messing with
the last iteration of the writer loops. My preempt disable loop probably
disables preemption for a long time without rescheduling during this ftrace
dump.

Anyway, having the rcu_perf_wait_shutdown without doing the ftrace dump seems
to solve it.

So actually the point of all my testing was (other than learning) was to
compare how RCU pre-consolidated vs post-consolidated does. As predicted,
with post-consolidated RCU, the preempt-disable / enable does manage to slow
down the grace periods. This is not an issue per-se as you said that even
100s of ms of grace period delay is within acceptable RCU latencies. The
results are as below:

I am happy to try out any other test scenarios as well if you would like me
to. I am open to any other suggestions you may have to improve the rcuperf
tests in this (deferred/consolidated RCU) or other regards.

I did have a request, could you help me understand why is the grace period
duration double that of my busy wait time? You mentioned this has something
to do with the thread not waking up before another GP is started. But I did
not follow this. Thanks a lot!!

Performance changes in consolidated vs regular
-------------------------------------------
I ran a thread on a reserved CPU doing preempt disable + busy wait + preempt enable
in a loop and measured the difference in rcuperf between conslidated and regular.
nreaders = nwriters = 10.

		(preempt disable duration)
		5ms	10ms	20ms	50ms
v4.19
median (usecs)	12000.3	12001	11000	12000

v5.1 (deferred)
median (usecs)	13000	19999   40000   100000

All of this is still within spec of RCU.

Note as discussed:
These results are independent of the value of jiffies_to_sched_qs. However,
in my preempt-disable + enable loop, if I don't do a
set_preempt_need_resched() in my loop, then I need to lower
jiffies_to_sched_qs to bring down the grace period durations. This is
understandable because the tick may not know sooner that it needs to resched
the preempt disable busy loop.

thanks,

 J.

