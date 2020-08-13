Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39911C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 03:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105D220774
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597289399;
	bh=7IjTk2DY46eXNf6sb5o7KFN9VINS9QIkpmlTDWFxFEY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AItQdBEabwUEXpW/t2c9Y/5XXdyc8ukDvuEOBzBJmwu1IS+K2H4ZGmURRzhnNNrCj
	 OMrn86Pbykgyc7aLdFXzM7BsVd43nw9lew/nLpoRVVFeo6oy9ScwiWODB9CXTG0sZc
	 GrBjtszQbnbknc2x4kxMp92xPQH5LQ8Izkaz9Zp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMD36 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMD36 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 23:29:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187DA206A4;
        Thu, 13 Aug 2020 03:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597289398;
        bh=7IjTk2DY46eXNf6sb5o7KFN9VINS9QIkpmlTDWFxFEY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=x7WwxEjsaZ4qWutWElZaeWHdML0w/R3OzvZyXCG1iaItGaE89XSexloSg1lwB2kSw
         ZfHu8UWvAxBv9hm8iiocl3VEkjo1o56lzjlp1Jx8GSXPdSoEvtUK1zjnUN57DYZqQT
         1oKvYSLI9HHNziscc5MLa5feMQRpbOxEQVV0fJak=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E51FB3522615; Wed, 12 Aug 2020 20:29:57 -0700 (PDT)
Date:   Wed, 12 Aug 2020 20:29:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     rcu@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH tip/core/rcu 06/12] rcu: Do full report for .need_qs for
 strict GPs
Message-ID: <20200813032957.GN4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
 <20200812225732.20068-6-paulmck@kernel.org>
 <CAG48ez3WyDBLPs8cBt3-3HGJ_xvAg0-JPZRDP1mf1eLmPjSvPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3WyDBLPs8cBt3-3HGJ_xvAg0-JPZRDP1mf1eLmPjSvPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 02:50:27AM +0200, Jann Horn wrote:
> On Thu, Aug 13, 2020 at 12:57 AM <paulmck@kernel.org> wrote:
> > The rcu_preempt_deferred_qs_irqrestore() function is invoked at
> > the end of an RCU read-side critical section (for example, directly
> > from rcu_read_unlock()) and, if .need_qs is set, invokes rcu_qs() to
> > report the new quiescent state.  This works, except that rcu_qs() only
> > updates per-CPU state, leaving reporting of the actual quiescent state
> > to a later call to rcu_report_qs_rdp(), for example from within a later
> > RCU_SOFTIRQ instance.  Although this approach is exactly what you want if
> > you are more concerned about efficiency than about short grace periods,
> > in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, short grace periods are
> > the name of the game.
> >
> > This commit therefore makes rcu_preempt_deferred_qs_irqrestore() directly
> > invoke rcu_report_qs_rdp() in CONFIG_RCU_STRICT_GRACE_PERIOD=y, thus
> > shortening grace periods.
> 
> Ooh, I'm very happy about this series! :)

Glad you like it!  And I hope that it helps!

One usability concern is whether rcutree.rcu_unlock_delay needs to be
applied only some small fraction of the time in order to allow the delay
to be large (a couple hundred microseconds?)  while still avoiding doing
too much more damage to timing and performance than absolutely necessary.

> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 7ed55c5..1761ff4 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -459,8 +459,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >                 return;
> >         }
> >         t->rcu_read_unlock_special.s = 0;
> > -       if (special.b.need_qs)
> > -               rcu_qs();
> > +       if (special.b.need_qs) {
> > +               if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> > +                       rcu_report_qs_rdp(rdp->cpu, rdp);
> 
> Not an issue with this patch specifically, but: I'm looking at
> rcu_report_qs_rdp(), and some of the parts that I do vaguely
> understand look a bit off to me.
> 
> rcu_report_qs_rdp() is given a CPU number as first argument, but never
> actually uses that argument. (And the only existing caller also passes
> in rdp->cpu, just like this patch.) I guess that argument can go away?
> 
> The comment above rcu_report_qs_rdp() claims that it "must be called
> from the specified CPU", but there is a branch in there that
> specifically checks whether that is true ("if (rdp->cpu ==
> smp_processor_id())"). As far as I can tell, rcu_report_qs_rdp() is,
> as the comment says, indeed never invoked with another CPU's rcu_data
> (only invoked via rcu_core() -> rcu_check_quiescent_state() ->
> rcu_report_qs_rdp(), and rcu_core() looks up "rdp =
> raw_cpu_ptr(&rcu_data)"). So perhaps if there is a check for whether
> rdp belongs to the current CPU, that check should have a WARN_ON(), or
> something like that, since it indicates that the API contract
> specified in the comment was violated?

It looks like you are correct, and that the first parameter can be
dropped, the "if" you mention replaced by a WARN_ON_ONCE(), and
the body of that "if" be unconditional.  I have it on my list, and
if it still looks correct in the cold hard light of dawn, I will
apply it with your Reported-by.

And thank you very much for looking it over!

						Thanx, Paul
