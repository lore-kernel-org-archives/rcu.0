Return-Path: <SRS0=Rnls=6Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9291DC38A2A
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 00:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553BE208E4
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 00:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQYejcvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgEKAGo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 May 2020 20:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728972AbgEKAGn (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 10 May 2020 20:06:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D773C061A0C;
        Sun, 10 May 2020 17:06:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i19so7695776ioh.12;
        Sun, 10 May 2020 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oK+p54C8j8NRcdreMfDlETggKTIQejsEGJM7mKa73g0=;
        b=hQYejcvQ5GyTPwOc76aMdws477bfLiahDh6qvUZRGVmXidsI+BWmh5rfjwIH5cPjyl
         zJzgcPTekQN9NamqFYrqtQjpmbJW6jlmT7RM1HB0hsNk5ZgvB27diUSxgoKfxwGx5/Jv
         cCV3n2eLG5nFZQRJDoTS7e5QCTM5gX7RIY0rAf5TWCcKb56pgWVzQnVLYH6wYnEm9Ptv
         JqjrktTuEoCL+Vn0FpfDbrNgRMGZuQh3oz/CbI0PrO+NHg7oiuHnEjTI2fSh+0K+6cW1
         h2vJpu5jgrR8IOL1H9UPwnpxxYDC8KEkEaUINp82u30cnkMsTOhmJjpvzKuJ9cgscMwi
         CoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oK+p54C8j8NRcdreMfDlETggKTIQejsEGJM7mKa73g0=;
        b=J5fm6m+teDTPn+icyRTG3q0HGL9oW6yrDYHCU6fdamXlI35BDdmAEQw7SasLgtMn4R
         pqPcLRZzPEj+b2id1pBcvlDhCu8U7L8UZsf+QH6VDEY9DWkRnacG0s9Im9BBWthuEKsF
         jlOIkYol4oSLaRJibeOKSq65JVYMeVHo2oAKPjKxWDiurFeob/Gv6so8hNi5HFEEsWMh
         bzOb6pHY/20CNGF/J1IckB0B+eWazO7bLC6e1zUlWUuFL2DOT+6kCwprsmi2PhLeqtjl
         AHr9jO4eClwjVVgz1svrCUsB0OgTKLqZtC/5nQXfwP5rPslHbaTiKY3cEjlbgvOG9vXb
         hOvQ==
X-Gm-Message-State: AGi0PubdiE/eqxWFIRC7wZiHiGrpfAg/54ihDcBGD2mHbnuaz4SyQ4Fd
        gdg+UvKyZta2tLpntrm4i2UdtPRMEO2potiQ15w=
X-Google-Smtp-Source: APiQypLCfRYthSUmIHEOiKu04YTalHU8IdMWAaOc2MV0vE4tTq0cxBCbsllMoMyz+CxplH+lQ57nYxbfQwe1xHCLj6g=
X-Received: by 2002:a05:6638:158:: with SMTP id y24mr11783477jao.43.1589155601375;
 Sun, 10 May 2020 17:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200312181618.GA21271@paulmck-ThinkPad-P72> <20200312181702.8443-9-paulmck@kernel.org>
 <20200316194754.GA172196@google.com> <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
 <20200316203241.GB3199@paulmck-ThinkPad-P72> <20200316173219.1f8b7443@gandalf.local.home>
 <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
 <20200316180352.4816cb99@gandalf.local.home> <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
 <20200510154908.GR2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200510154908.GR2869@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 11 May 2020 08:06:29 +0800
Message-ID: <CAJhGHyB4xQqKpYwOZdznVTzGjLaJuDPy4upDny9mdnUb1oAKCg@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude variant
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 10, 2020 at 11:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, May 10, 2020 at 05:59:27PM +0800, Lai Jiangshan wrote:
> > On Tue, Mar 17, 2020 at 6:03 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Mon, 16 Mar 2020 17:45:40 -0400
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > > >
> > > > > Same for the function side (if not even more so). This would require adding
> > > > > a srcu_read_lock() to all functions that can be traced! That would be a huge
> > > > > kill in performance. Probably to the point no one would bother even using
> > > > > function tracer.
> > > >
> > > > Point well taken! Thanks,
> > >
> > > Actually, it's worse than that. (We talked about this on IRC but I wanted
> > > it documented here too).
> > >
> > > You can't use any type of locking, unless you insert it around all the
> > > callers of the nops (which is unreasonable).
> > >
> > > That is, we have gcc -pg -mfentry that creates at the start of all traced
> > > functions:
> > >
> > >  <some_func>:
> > >     call __fentry__
> > >     [code for function here]
> > >
> > > At boot up (or even by the compiler itself) we convert that to:
> > >
> > >  <some_func>:
> > >     nop
> > >     [code for function here]
> > >
> > >
> > > When we want to trace this function we use text_poke (with current kernels)
> > > and convert it to this:
> > >
> > >  <some_func>:
> > >     call trace_trampoline
> > >     [code for function here]
> > >
> > >
> > > That trace_trampoline can be allocated, which means when its no longer
> > > needed, it must be freed. But when do we know it's safe to free it? Here's
> > > the issue.
> > >
> > >
> > >  <some_func>:
> > >     call trace_trampoline  <- interrupt happens just after the jump
> > >     [code for function here]
> > >
> > > Now the task has just executed the call to the trace_trampoline. Which
> > > means the instruction pointer is set to the start of the trampoline. But it
> > > has yet executed that trampoline.
> > >
> > > Now if the task is preempted, and a real time hog is keeping it from
> > > running for minutes at a time (which is possible!). And in the mean time,
> > > we are done with that trampoline and free it. What happens when that task
> > > is scheduled back? There's no more trampoline to execute even though its
> > > instruction pointer is to execute the first operand on the trampoline!
> > >
> > > I used the analogy of jumping off the cliff expecting a magic carpet to be
> > > there to catch you, and just before you land, it disappears. That would be
> > > a very bad day indeed!
> > >
> > > We have no way to add a grace period between the start of a function (can
> > > be *any* function) and the start of the trampoline.
> >
> > Hello
> >
> > I think adding a small number of instructions to preempt_schedule_irq()
> > is sufficient to create the needed protected region between the start
> > of a function and the trampoline body.
> >
> > preempt_schedule_irq() {
> > +  if (unlikely(is_trampoline_page(page_of(interrupted_ip)))) {
> > +      return; // don't do preempt schedule
> > +
> > +  }
> >   preempt_schedule_irq() original body
> > }
> >
> > // generated on trampoline pages
> > trace_trampoline() {
> >    preempt_disable();
> >    trace_trampoline body
> >    jmp preempt_enable_traced(clobbers)
> > }
> >
> > asm(kernel text):
> > preempt_enable_traced:
> >    preempt_enable_notrace();
> >    restore cobblers
> >    return(the return ip on the stack is traced_function_start_code)
> >
> >
> > If the number of instructions added in preempt_schedule_irq() and
> > the complexity to make trampoline ip detectable(is_trampoline_page(),
> > or is_trampoline_range()) are small, and tasks_rcu is rendered useless,
> > I think it will be win-win.
>
> It certainly would provide a nice reduction in code size!
>
> This would provide a zero-instructions preempt_disable() at the beginning
> of the trampoline and a zero-instructions preempt_enable_no_resched() at
> the end, correct?  If so, wouldn't this create a potentially long (though
> "weak") preempt-disable region extending to the next preempt_enable(),
> local_bh_enable(), schedule(), interrupt, transition to userspace,
> or similar?  This could be quite some time.  Note that cond_resched()
> wouldn't help, given that this is only in PREEMPT=y kernels.
>
> The "weak" refers to the fact that if a second resched IPI arrived in the
> meantime, preemption would then happen.  But without that second IPI,
> the request for preemption could be ignored for quite some time.
>
> Or am I missing something here?

Hello,

I'm sorry to note that preempt_enable_traced() is in *kernel text*, it
is *not* in trace_trampoline_protected region. So preempt_enable_traced()
can be preempted. And preempt_enable_notrace() in it checks any previous
resched requested during the trampoline. So no resched request is lost.

The idea is that "semi-automatically preempt-disable-protecting"
the trampoline. "semi" means the trampoline still needs
preempt_disable() and the beginning, and preempt_enable() at
the end after leaving trace_trampoline_preempt_protected region.
"automatically" means the region between the start ip of
trampoline and the first preempt_disable() is also protected.
This automatically protected region is IP based, which means the
code should be put in "trace_trampoline_preempt_protected".

In my previous email, "trace_trampoline_preempt_protected" is detected
by information in the "struct page". But the trampolines are often
created in module_alloc() region, if so, 13-page bitmap is sufficient
to store "is this virtual-page-frame-number in trace_trampoline?" info
for all vpfn in 1520 MB module_alloc() region. If the bitmap
is too big for some cases, we might need to use bloom filter
for the fast path. I still don't know what is the best way to control
the ip of trace_trampoline or attach info to it and to fast detect it.

Thanks,
Lai

>
>                                                         Thanx, Paul
>
> > Thanks
> >
> > Lai
> >
> > > Since the problem is
> > > that the task was non-voluntarily preempted before it could execute the
> > > trampoline, and that trampolines are not allowed (suppose) to call
> > > schedule, then we have our quiescent state to track (voluntary scheduling).
> > > When all tasks have either voluntarily scheduled, or entered user space
> > > after disconnecting a trampoline from a function, we know that it is safe to
> > > free the trampoline.
> > >
> > > -- Steve
