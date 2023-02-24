Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE881C64ED6
	for <rcu@archiver.kernel.org>; Fri, 24 Feb 2023 03:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBXDMA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 22:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjBXDL7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 22:11:59 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94686011A
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 19:11:55 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f16so12808891ljq.10
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 19:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=svtOjujOsN51ibhhpkpUlPmq6lAkJ479j4PaitrGJKA=;
        b=Qcb34A+tamA551FyUom0I5FyPjaPIiVmN1V++TnV6APLV9IX0gpjZJRKVgLjJyXwNk
         4858PPz7RRgCE6HRK8k7r/J7adDyKSlB3ATD6pB/j0vbalsiqdvuNqW4HIzZ6UnXBU3z
         blOoy+rLxhPsGyoJdf2UJP3AfMtNQAcj4mL9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svtOjujOsN51ibhhpkpUlPmq6lAkJ479j4PaitrGJKA=;
        b=VpdMpsGFnYjNaCVxQZkjdyIZYf4mPQMgKte23KeO8OWL4gkuwvbkpwYEsSuNEwmiGm
         gspuc0I22oT/la1Lr3nW3e0HcRB7E/Oy2YOlW7NkWNeEn5QaMKXzciDTzRKZs6MiDCrE
         IKEPw7Pn5f4VHCFD08xPG/8WCIlfG9KlP+Gbrr48JTcODpwUtObzhKKaL7BUev+KnngF
         wbY3cb+kFijbOCT/A9hmekZMyxCWn9VpKl12alKYB2lQLlRJ0ZLF7Vt6HhSMlTWiZfH+
         REI9U55fDOJCGP6gppk5LC2sbuxga+5WZM2ZVJ6DIwvli3hgSEpdcTQj4Vh3UwrpsUYZ
         qC6g==
X-Gm-Message-State: AO0yUKUTPG2cXkQn1nohY6df8oEAjyx3yrm2G9UMl/q7lKJY0qniJUAD
        PuTiAsL2/HRXXVhEO9VtfY2SkKoIGps/8aSwHrf0qjriy9Qqlw==
X-Google-Smtp-Source: AK7set8P5JlnjCX8r9CV//dtRO/nQPcyOdiYse+3EiMEBJL74XrFB5DT9w5Mb2x+urJnHrd+AYVloi0t5x6WjVD858k=
X-Received: by 2002:a2e:a275:0:b0:294:6de5:e642 with SMTP id
 k21-20020a2ea275000000b002946de5e642mr4369240ljm.3.1677208314049; Thu, 23 Feb
 2023 19:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/eP4h/chB8J0rAj@google.com> <PH0PR11MB58801B94B0374865394E9F8FDAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Y/ggCdoMEhMO8vs+@google.com> <CAEXW_YRTOYu5ZR6aX7AaTGyCQJwjB2aEmuPMYExYD4A2csRP1w@mail.gmail.com>
 <CAEXW_YRH2amT0K3f9c4tEzXZ46GsKHwGkjaznPrH5EOL4ay+dg@mail.gmail.com> <PH0PR11MB588021890119CA76AA5BB848DAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB588021890119CA76AA5BB848DAA89@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Feb 2023 22:11:42 -0500
Message-ID: <CAEXW_YSbUzqBCQXHPF0zF67B8+mwTNojC38K6rx3=0+Jzurjzg@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in call_rcu_tasks_generic()
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 23, 2023 at 10:05 PM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
> On Thu, Feb 23, 2023 at 9:35 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Feb 23, 2023 at 9:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Fri, Feb 24, 2023 at 12:36:05AM +0000, Zhang, Qiang1 wrote:
> > > > On Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
> > > > > > From: Zqiang <qiang1.zhang@intel.com>
> > > > > > Sent: Thursday, February 23, 2023 2:30 PM
> > > > > > To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> > > > > > joel@joelfernandes.org
> > > > > > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > > Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> > > > > > call_rcu_tasks_generic()
> > > > > >
> > > > > > According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> > > > > > call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeup
> > > > > > using irq_work_queue() is because if the caller of
> > > > > > call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built with
> > > > > > CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will be hold in
> > > > > > wake_up(), so the lockdep splats will happen. but now using
> > > > > > rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> > > > > > rcuwait_wake_up() no spinlock will be acquired, so this commit remove using
> > > > > >
> > > > > >There are still spinlock-acquisition and spinlock-release invocations within the call path from rcuwait_wake_up().
> > > > > >
> > > > > >rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> > > > > >
> > > > > >    raw_spin_lock_irqsave()
> > > > > >    ...
> > > > > >    raw_spin_unlock_irqrestore
> > > > >
> > > > > Yes, but this is raw_spinlock acquisition and release(note: spinlock will convert to
> > > > > sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
> > > > >
> > > > > acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
> > > > >
> > > > >Is this really safe in the long run though? I seem to remember there are
> > > > >weird locking dependencies if RCU is used from within the scheduler [1].
> > > > >
> > > >
> > > >
> > > > I have  been running rcutorture with rcutorture.type = tasks-tracing,
> > > > so far no problems have been found.
> > > >
> > > >
> > > > >I prefer to keep it as irq_work_queue() unless you are seeing some benefit.
> > > > >Generally, there has to be a 'win' or other justification for adding more
> > > > >risk.
> > > > >
> > > > >thanks,
> > > > >
> > > > >- Joel
> > > > >[1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-schedlocks.html
> > > >
> > > >
> > > > The problem in this link,  in an earlier RCU version, rcu_read_unlock_special()
> > > > Invoke wakeup and enter scheduler can lead to deadlock, but my modification is for
> > > > call_rcu_tasks_generic(), even if there is a lock dependency problem, we should pay
> > > > more attention to rcu_read_unlock_trace_special()
> > >
> > > Consider ABBA deadlocks as well, not just self-deadlocks (which IIRC is what
> > > the straight-RCU rcu_read_unlock() issues were about).
> > >
> > > What prevents the following scenario?
> > >
> > > In the scheduler you have code like this:
> > >                 rq = task_rq_lock(p, &rf);
> > >                 trace_sched_wait_task(p);
> > >
> > > Someone can hook up a BPF program to that tracepoint that then calls
> > > rcu_read_unlock_trace() -> rcu_read_unlock_trace_special(). All of
> > > this while holding the rq and pi scheduler locks.
> > >
> > > That's A (rq lock) -> B (rtpcp lock).
>
> In rcu_read_unlock_trace_special(), the premise of acquiring the rtpcp lock is that
> before that, we have task switch in the rcu_read_lock_trace/unlock_trace critical section.
> but after we already hold the rq lock, no task switch is generated in the
> rcu_read_lock_trace/unlock_trace  critical section.
>
> Please correct me if my understanding is wrong.

Yes, but in the next reply I corrected myself and I am still concerned
about ABBA. There is obviously *some lock* that is held by the callers
of call_rcu_tasks*(). So there is a dependency that gets created
between _that_ lock and the rq lock, if you do a wakeup here.  And I
am not sure whether that lock is also acquired when the BPF program
runs. If it is, then the BPF programs may hang. It is probably worth
checking with the BPF guys.

More importantly, do you see a benefit with this change in terms of
anything more than deleting a few lines of code? Paul typically favors
robustness and guard rails (as do I), unless there is significant
benefit in performance, power or both.

Thanks,

 - Joel
