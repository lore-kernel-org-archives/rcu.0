Return-Path: <SRS0=Rnls=6Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50013C47255
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3329B20752
	for <rcu@archiver.kernel.org>; Mon, 11 May 2020 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgEKTs3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 May 2020 15:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTs2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 May 2020 15:48:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7899A206F5;
        Mon, 11 May 2020 19:48:26 +0000 (UTC)
Date:   Mon, 11 May 2020 15:48:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
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
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200511154824.09a18c46@gandalf.local.home>
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
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 10 May 2020 17:59:27 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

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

To make this even more complex, with ftrace direct callers (used by bpf to
define their own non ftrace trampoline), if a direct call is on the same
location as a ftrace caller, we have something like this:

ftrace_caller:
	save_regs
	call ftrace_ops_list_func
	cmp ORIG_RAX
	jnz do_direct
	restore_regs
	ret

do_direct:
	mov ORIG_RAX to return
	restore_regs
	ret

What the above is basically doing, is that the ftrace_ops_list_func() will
call the ftrace callbacks, but also a special callback to handle the direct
that is also registered to that same location. The direct callback will
place the address of the direct trampoline into ORIG_RAX. Then on return
from ftrace_ops_list_func(), it will jump directly to the direct caller.

To implement what you are proposing, you have to have a way to keep
preemption off between the setting of ORIG_RAX and the jump to the direct
caller (which would require its own preempt_disable() section). But if we
preempt between the two, the direct trampoline may disappear and then this
code will jump to it.

-- Steve
