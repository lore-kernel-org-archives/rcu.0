Return-Path: <SRS0=Rnls=6Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4546DC38A2A
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 00:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18671207FF
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 00:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589157887;
	bh=PSHaMs3sfDyRTDAP+dSIgTCmTUnUNjkBi5Xx6IGk4oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aKCoLk3mpIRMq4Fdd1Ox14sXV7e+F8IgwyOC6ctpGi4VsKeaAWo5oIiBQz4uEJEOd
	 OJ1weSqIJB1Z2+1Vvpk4tIgruIIfZk+unv8H2PGIGgIh1jfnTz26cuyUe4OvjsUT1k
	 1yw3BveSozwwpGpVla/GvmP4Jcmn9SyeDHgCV7ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgEKAoq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 May 2020 20:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgEKAoq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 May 2020 20:44:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4366206D6;
        Mon, 11 May 2020 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589157885;
        bh=PSHaMs3sfDyRTDAP+dSIgTCmTUnUNjkBi5Xx6IGk4oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KqWM+u5wY2Zuxx8oA8Kq8Z2N3svWc7sJMKsY11E7uT75vT0qyB+t+ZzOXWDMxFkz8
         F5uq/aPB3OiWey+uzn1LcV6h3f9bmegTCKstgNB/IbutlGTGiCZm2LTgzUkFDRQkV3
         lHYxvp0O3bnn1tSuNC2f7l+D3SuMBTPqj3FIl04U=
Date:   Mon, 11 May 2020 09:44:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-Id: <20200511094439.5361d4aa59eacad172ada3b5@kernel.org>
In-Reply-To: <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
        <20200312181702.8443-9-paulmck@kernel.org>
        <20200316194754.GA172196@google.com>
        <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
        <20200316203241.GB3199@paulmck-ThinkPad-P72>
        <20200316173219.1f8b7443@gandalf.local.home>
        <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
        <20200316180352.4816cb99@gandalf.local.home>
        <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 10 May 2020 17:59:27 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

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

Good idea, but the is_trampoline_page() will not be so easy since
those pages are scattered. !is_kernel_text() works but it doesn't
cover modules. I think we should make a new subsystem to allocate
trampoline pages instead of using module_alloc().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
