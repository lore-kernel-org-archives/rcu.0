Return-Path: <SRS0=u9Eq=6Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FADC38A2A
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3A120820
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589125750;
	bh=WUqz8SCxJRtX45w2ld++azi9BEtGeIHYbgoRCAw21rI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=p9zPrCTDF3Mzrb5GrsW4tRRXiGsipWdpjUvHTrZfoUZxAkc7vSpJSzWwzlNlCs3as
	 GfENRoQWI7icniVgYcYAH7wcf1lOIE4VN2cOcdKsskESYiA5gP/AguQQyLFnhN9qnJ
	 HRTqwxHa1Kppc6xatK8r3bQRHP62QKbo2U5fNXNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgEJPtK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 May 2020 11:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgEJPtK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 May 2020 11:49:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F7920735;
        Sun, 10 May 2020 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589125749;
        bh=WUqz8SCxJRtX45w2ld++azi9BEtGeIHYbgoRCAw21rI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=exZesUuZmVlROGKES3hDHZVxuDXJMkyhaNdMJIZPWMeWHhOg5LfOwaSwC8cqBrRqR
         Xr02om3heQemK1shc2YQ+LqSezuTAI5NidEQifCUoRRsxnc3DAG56htnAWvgMw13+5
         ZFqu6m7YhNtoRlW8cWkJEiUYkxb5QMg0ZiUWr1JU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C6E5D35227BD; Sun, 10 May 2020 08:49:08 -0700 (PDT)
Date:   Sun, 10 May 2020 08:49:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>, dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200510154908.GR2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200312181702.8443-9-paulmck@kernel.org>
 <20200316194754.GA172196@google.com>
 <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
 <20200316203241.GB3199@paulmck-ThinkPad-P72>
 <20200316173219.1f8b7443@gandalf.local.home>
 <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
 <20200316180352.4816cb99@gandalf.local.home>
 <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 10, 2020 at 05:59:27PM +0800, Lai Jiangshan wrote:
> On Tue, Mar 17, 2020 at 6:03 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 16 Mar 2020 17:45:40 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > >
> > > > Same for the function side (if not even more so). This would require adding
> > > > a srcu_read_lock() to all functions that can be traced! That would be a huge
> > > > kill in performance. Probably to the point no one would bother even using
> > > > function tracer.
> > >
> > > Point well taken! Thanks,
> >
> > Actually, it's worse than that. (We talked about this on IRC but I wanted
> > it documented here too).
> >
> > You can't use any type of locking, unless you insert it around all the
> > callers of the nops (which is unreasonable).
> >
> > That is, we have gcc -pg -mfentry that creates at the start of all traced
> > functions:
> >
> >  <some_func>:
> >     call __fentry__
> >     [code for function here]
> >
> > At boot up (or even by the compiler itself) we convert that to:
> >
> >  <some_func>:
> >     nop
> >     [code for function here]
> >
> >
> > When we want to trace this function we use text_poke (with current kernels)
> > and convert it to this:
> >
> >  <some_func>:
> >     call trace_trampoline
> >     [code for function here]
> >
> >
> > That trace_trampoline can be allocated, which means when its no longer
> > needed, it must be freed. But when do we know it's safe to free it? Here's
> > the issue.
> >
> >
> >  <some_func>:
> >     call trace_trampoline  <- interrupt happens just after the jump
> >     [code for function here]
> >
> > Now the task has just executed the call to the trace_trampoline. Which
> > means the instruction pointer is set to the start of the trampoline. But it
> > has yet executed that trampoline.
> >
> > Now if the task is preempted, and a real time hog is keeping it from
> > running for minutes at a time (which is possible!). And in the mean time,
> > we are done with that trampoline and free it. What happens when that task
> > is scheduled back? There's no more trampoline to execute even though its
> > instruction pointer is to execute the first operand on the trampoline!
> >
> > I used the analogy of jumping off the cliff expecting a magic carpet to be
> > there to catch you, and just before you land, it disappears. That would be
> > a very bad day indeed!
> >
> > We have no way to add a grace period between the start of a function (can
> > be *any* function) and the start of the trampoline.
> 
> Hello
> 
> I think adding a small number of instructions to preempt_schedule_irq()
> is sufficient to create the needed protected region between the start
> of a function and the trampoline body.
> 
> preempt_schedule_irq() {
> +  if (unlikely(is_trampoline_page(page_of(interrupted_ip)))) {
> +      return; // don't do preempt schedule
> +
> +  }
>   preempt_schedule_irq() original body
> }
> 
> // generated on trampoline pages
> trace_trampoline() {
>    preempt_disable();
>    trace_trampoline body
>    jmp preempt_enable_traced(clobbers)
> }
> 
> asm(kernel text):
> preempt_enable_traced:
>    preempt_enable_notrace();
>    restore cobblers
>    return(the return ip on the stack is traced_function_start_code)
> 
> 
> If the number of instructions added in preempt_schedule_irq() and
> the complexity to make trampoline ip detectable(is_trampoline_page(),
> or is_trampoline_range()) are small, and tasks_rcu is rendered useless,
> I think it will be win-win.

It certainly would provide a nice reduction in code size!

This would provide a zero-instructions preempt_disable() at the beginning
of the trampoline and a zero-instructions preempt_enable_no_resched() at
the end, correct?  If so, wouldn't this create a potentially long (though
"weak") preempt-disable region extending to the next preempt_enable(),
local_bh_enable(), schedule(), interrupt, transition to userspace,
or similar?  This could be quite some time.  Note that cond_resched()
wouldn't help, given that this is only in PREEMPT=y kernels.

The "weak" refers to the fact that if a second resched IPI arrived in the
meantime, preemption would then happen.  But without that second IPI,
the request for preemption could be ignored for quite some time.

Or am I missing something here?

							Thanx, Paul

> Thanks
> 
> Lai
> 
> > Since the problem is
> > that the task was non-voluntarily preempted before it could execute the
> > trampoline, and that trampolines are not allowed (suppose) to call
> > schedule, then we have our quiescent state to track (voluntary scheduling).
> > When all tasks have either voluntarily scheduled, or entered user space
> > after disconnecting a trampoline from a function, we know that it is safe to
> > free the trampoline.
> >
> > -- Steve
