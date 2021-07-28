Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43827C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AAC60F5E
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 20:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhG1UDF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:03:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:45560 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhG1UDF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 16:03:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C649235B4A9;
        Wed, 28 Jul 2021 16:03:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1neallEIlD3z; Wed, 28 Jul 2021 16:03:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3570635B4A6;
        Wed, 28 Jul 2021 16:03:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3570635B4A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627502582;
        bh=b//lJLcPByuvZRIn7/xeEND5gAZOf4XdRcGyQEVeavU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZYOrhnNqKYJK7ZSr8cZjqOBTtE8PKtnP9KuIAzfUe5Rzqg+lLL5NCJbb433RuP1Pp
         RCkSUZ62764URo+zbIUzJgRthtunezURj1eO4Ww7tIJGGebAUNlnaDcCNjLthDGN6A
         A+pg9aVUqlYAqYl+E46qhMz7Zo94Xo/B+6pQ49oPyJ3GRJMD4VA4p9VRGHRY5oEJ8x
         Ie/sBmTh2VzppVfuPba1QPzLJOZLxSrgLrEyVLPOFwGr5tCnElnKkkLLUef6xr7NxP
         5WMEjsJN6ZGgJA8gh8b7QGD+w3JE/YJ0I/K2L2YhgfwbVxRst5Ne9BVh3Vwr9t9bxI
         lX3O+6wIQAfuw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X339T_vesXcS; Wed, 28 Jul 2021 16:03:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1EEDE35B435;
        Wed, 28 Jul 2021 16:03:02 -0400 (EDT)
Date:   Wed, 28 Jul 2021 16:03:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <874308613.9545.1627502582005.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210728194505.GA1500024@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1> <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1> <2135064974.9081.1627496585724.JavaMail.zimbra@efficios.com> <20210728185854.GK4397@paulmck-ThinkPad-P17-Gen-1> <20210728194505.GA1500024@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: Weaken ->dynticks accesses and updates
Thread-Index: 568K9ZSxkflip1GHOVAM8nm+9R9/hw==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Jul 28, 2021, at 3:45 PM, paulmck paulmck@kernel.org wrote:
[...]
> 
> And how about like this?
> 
>						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit cb8914dcc6443cca15ce48d937a93c0dfdb114d3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Jul 28 12:38:42 2021 -0700
> 
>    rcu: Move rcu_dynticks_eqs_online() to rcu_cpu_starting()
>    
>    The purpose of rcu_dynticks_eqs_online() is to adjust the ->dynticks
>    counter of an incoming CPU if required.  It is currently is invoked

"is currently is" -> "is currently"

>    from rcutree_prepare_cpu(), which runs before the incoming CPU is
>    running, and thus on some other CPU.  This makes the per-CPU accesses in
>    rcu_dynticks_eqs_online() iffy at best, and it all "works" only because
>    the running CPU cannot possibly be in dyntick-idle mode, which means
>    that rcu_dynticks_eqs_online() never has any effect.  One could argue
>    that this means that rcu_dynticks_eqs_online() is unnecessary, however,
>    removing it makes the CPU-online process vulnerable to slight changes
>    in the CPU-offline process.

Why favor moving this from the prepare_cpu to the cpu_starting hotplug step,
rather than using the target cpu's rdp from rcutree_prepare_cpu ? Maybe there
was a good reason for having this very early in the prepare_cpu step ?

Also, the commit message refers to this bug as having no effect because the
running CPU cannot possibly be in dyntick-idle mode. I understand that calling
this function was indeed effect-less, but then why is it OK for the CPU coming
online to skip this call in the first place ? This commit message hints at
"slight changes in the CPU-offline process" which could break it, but therer is
no explanation of what makes this not an actual bug fix.

Thanks,

Mathieu

>    
>    This commit therefore moves the call to rcu_dynticks_eqs_online() from
>    rcutree_prepare_cpu() to rcu_cpu_starting(), this latter being guaranteed
>    to be running on the incoming CPU.  The call to this function must of
>    course be placed before this rcu_cpu_starting() announces this CPU's
>    presence to RCU.
>    
>    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0172a5fd6d8de..aa00babdaf544 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4129,7 +4129,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> 	rdp->blimit = blimit;
> 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
> -	rcu_dynticks_eqs_online();
> 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
> 
> 	/*
> @@ -4249,6 +4248,7 @@ void rcu_cpu_starting(unsigned int cpu)
> 	mask = rdp->grpmask;
> 	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
> 	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
> +	rcu_dynticks_eqs_online();
> 	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
> 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
