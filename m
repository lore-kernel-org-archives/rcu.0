Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932EC4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0111260EFD
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhG1S65 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhG1S64 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 14:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 131606024A;
        Wed, 28 Jul 2021 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627498735;
        bh=ylRo91fIufsJiBQ/p1hWoYSghsQ4i01+g9DxsEqtZg8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hdwzcvPua3c9lnDYn0c7kJ6RQTjy+0LbW2hEHEiDQo06U6Iz98ox/JeLt5da6kgj0
         0qxbK7ALuTSZCd5gY3JEZrVZLgtEAhU6EpkGq8qU3GnVubnBXasWrf2PZ9fxLMVVnd
         IjPt8TdkK0hgaPPqsU13GG4LUSRkB7tEIvhc4mTFPzjCoa3+mEjEEXBd9MelZgcmVN
         0dXHq7qcx+OdeBvZBgOVxC+zRRnpebhds8utvM3mwp7SBJOfIn39x08S+3+wKa0/jY
         q98zWq9etbqNvZHKj3raULYCrWGbUqxkWDTlephxJadU9UXYN54VKo0KDAYvlbD9Hq
         X75n6cTO19Ddw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D13315C048D; Wed, 28 Jul 2021 11:58:54 -0700 (PDT)
Date:   Wed, 28 Jul 2021 11:58:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728185854.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <2135064974.9081.1627496585724.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2135064974.9081.1627496585724.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 02:23:05PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 28, 2021, at 1:37 PM, paulmck paulmck@kernel.org wrote:
> [...]
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 42a0032dd99f7..c87b3a271d65b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -251,6 +251,15 @@ void rcu_softirq_qs(void)
> > 	rcu_tasks_qs(current, false);
> > }
> > 
> > +/*
> > + * Increment the current CPU's rcu_data structure's ->dynticks field
> > + * with ordering.  Return the new value.
> > + */
> > +static noinstr unsigned long rcu_dynticks_inc(int incby)
> > +{
> > +	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> > +}
> > +
> 
> [...]
> 
> > @@ -308,7 +317,7 @@ static void rcu_dynticks_eqs_online(void)
> > 
> > 	if (atomic_read(&rdp->dynticks) & 0x1)
> > 		return;
> 
> Can the thread be migrated at this point ? If yes, then
> the check and the increment may happen on different cpu's rdps. Is
> that OK ?

Good point!  Actually, it can be migrated, but it does not matter.
In fact, it so completely fails to matter that is is totally useless.  :-/

The incoming CPU is still offline, so this is run from some other
completely-online CPU.  Because this CPU is executing in non-idle
kernel context, that "if" condition must evaluate to true, so that the
rcu_dynticks_inc() below is dead code.

Maybe I should move the call to rcu_dynticks_eqs_online() to
rcu_cpu_starting(), which is pinned to the incoming CPU.  Yes, I
could remove it completely, but then small changes in the offline
process could cause great mischief.

Good catch, thank you!

							Thanx, Paul

> > -	atomic_inc(&rdp->dynticks);
> > +	rcu_dynticks_inc(1);
> > }
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
