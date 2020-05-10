Return-Path: <SRS0=u9Eq=6Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB1C54E8C
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 09:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F9420735
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 09:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0cyYyAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEJJ7m (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 May 2020 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEJJ7l (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 10 May 2020 05:59:41 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB6C061A0C;
        Sun, 10 May 2020 02:59:40 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v10so2339584ilq.8;
        Sun, 10 May 2020 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXMmR0HwqHNbEsLpy+7cSVZwaeXm6Y04lj/FCV8faIM=;
        b=O0cyYyAcHAK8PjEsnJulARtI4/dSZp+Nky+NQdBrm/L7C6ucoQ/0e+2DlNSzwzbi/A
         97UncCnoBHDs3oWDTbSHaYV8meV3PJccoQKbJUz785TJVjTQHBepijsKm0VYalaFBDaT
         e/ffAl2rEfdE9GVUZUbiGSrRFEIgS5JkGFC91luhf0UD2FW+h+ArCJMCc3m9Oni1iPig
         troS1xrI3qWzxOGMaBpNPX8746PZRYoeWAGLstH82ZOY51AsTBZ56lKqIbpkNikSfaLY
         EypzJy8YOgaKYaJmnPJs7FGJxnBfv2Qx4fEjHL9SoN18BKYvzNFwa7XdaX3AKUoUziWg
         SaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXMmR0HwqHNbEsLpy+7cSVZwaeXm6Y04lj/FCV8faIM=;
        b=L6CN0GLPOJHME+ll1KC+8rlDi8O2+0FbpBVVY73OkakCzCtGUOhbUFIWPmGfiLyFKW
         rPRPhnNB4HlBZCgqhyyk4ChpXpnZcMvh5nxTXVcWDiG6BVQjgBL4v80Sh7oTY7lTkUnZ
         FieKJlYluclW0RQknf8EK8QGyxFud7TAvGMp02ULKZD5YPvDGHJUnXA8vap6ZlvtntVf
         JcpwtvY2yLyrHeoZFMHgu3QYhrA09bFggAzm7sIUvQ+2akrvP/5iqNutnX0oINDz7x5B
         FBe+rwzqLZpW4lhT+2eF0trvXM0vYEi+11+P2PltqYtPZ6ikecHsR6GosR3w8TMR3vkz
         tGZQ==
X-Gm-Message-State: AGi0PuYyEU7pYhz/E3gbdI2Q8Q8YXhJJP6mKsgxCXZ5nm6xat2Og8FD9
        UvVgnw+C5r9MFjsX5FPYcg4nKyfMD30dV85ryeE=
X-Google-Smtp-Source: APiQypLhjkmhY0ncGaKs+MYZ6vOwmt79m1YQyMTMifQpjkh0/Q5relXkXLAOaDHaRrxznxIlZRQvH9GkCIMH49vRhTs=
X-Received: by 2002:a92:d801:: with SMTP id y1mr10931507ilm.308.1589104779649;
 Sun, 10 May 2020 02:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200312181618.GA21271@paulmck-ThinkPad-P72> <20200312181702.8443-9-paulmck@kernel.org>
 <20200316194754.GA172196@google.com> <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
 <20200316203241.GB3199@paulmck-ThinkPad-P72> <20200316173219.1f8b7443@gandalf.local.home>
 <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com> <20200316180352.4816cb99@gandalf.local.home>
In-Reply-To: <20200316180352.4816cb99@gandalf.local.home>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 10 May 2020 17:59:27 +0800
Message-ID: <CAJhGHyAaktwgv63XcUaLduKyYSwA+OuTLU_h7XAgyD6CKZp5Mg@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude variant
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 17, 2020 at 6:03 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 16 Mar 2020 17:45:40 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > >
> > > Same for the function side (if not even more so). This would require adding
> > > a srcu_read_lock() to all functions that can be traced! That would be a huge
> > > kill in performance. Probably to the point no one would bother even using
> > > function tracer.
> >
> > Point well taken! Thanks,
>
> Actually, it's worse than that. (We talked about this on IRC but I wanted
> it documented here too).
>
> You can't use any type of locking, unless you insert it around all the
> callers of the nops (which is unreasonable).
>
> That is, we have gcc -pg -mfentry that creates at the start of all traced
> functions:
>
>  <some_func>:
>     call __fentry__
>     [code for function here]
>
> At boot up (or even by the compiler itself) we convert that to:
>
>  <some_func>:
>     nop
>     [code for function here]
>
>
> When we want to trace this function we use text_poke (with current kernels)
> and convert it to this:
>
>  <some_func>:
>     call trace_trampoline
>     [code for function here]
>
>
> That trace_trampoline can be allocated, which means when its no longer
> needed, it must be freed. But when do we know it's safe to free it? Here's
> the issue.
>
>
>  <some_func>:
>     call trace_trampoline  <- interrupt happens just after the jump
>     [code for function here]
>
> Now the task has just executed the call to the trace_trampoline. Which
> means the instruction pointer is set to the start of the trampoline. But it
> has yet executed that trampoline.
>
> Now if the task is preempted, and a real time hog is keeping it from
> running for minutes at a time (which is possible!). And in the mean time,
> we are done with that trampoline and free it. What happens when that task
> is scheduled back? There's no more trampoline to execute even though its
> instruction pointer is to execute the first operand on the trampoline!
>
> I used the analogy of jumping off the cliff expecting a magic carpet to be
> there to catch you, and just before you land, it disappears. That would be
> a very bad day indeed!
>
> We have no way to add a grace period between the start of a function (can
> be *any* function) and the start of the trampoline.

Hello

I think adding a small number of instructions to preempt_schedule_irq()
is sufficient to create the needed protected region between the start
of a function and the trampoline body.

preempt_schedule_irq() {
+  if (unlikely(is_trampoline_page(page_of(interrupted_ip)))) {
+      return; // don't do preempt schedule
+
+  }
  preempt_schedule_irq() original body
}

// generated on trampoline pages
trace_trampoline() {
   preempt_disable();
   trace_trampoline body
   jmp preempt_enable_traced(clobbers)
}

asm(kernel text):
preempt_enable_traced:
   preempt_enable_notrace();
   restore cobblers
   return(the return ip on the stack is traced_function_start_code)


If the number of instructions added in preempt_schedule_irq() and
the complexity to make trampoline ip detectable(is_trampoline_page(),
or is_trampoline_range()) are small, and tasks_rcu is rendered useless,
I think it will be win-win.

Thanks

Lai

> Since the problem is
> that the task was non-voluntarily preempted before it could execute the
> trampoline, and that trampolines are not allowed (suppose) to call
> schedule, then we have our quiescent state to track (voluntary scheduling).
> When all tasks have either voluntarily scheduled, or entered user space
> after disconnecting a trampoline from a function, we know that it is safe to
> free the trampoline.
>
> -- Steve
