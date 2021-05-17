Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE046C433B4
	for <rcu@archiver.kernel.org>; Mon, 17 May 2021 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1BF611EE
	for <rcu@archiver.kernel.org>; Mon, 17 May 2021 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhEQS0H (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 May 2021 14:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhEQS0H (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 May 2021 14:26:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3EDF61241;
        Mon, 17 May 2021 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621275890;
        bh=agtqME+MKmOmL3aHSZ0CiwFpj5LnjrmqdL388mt/8PI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cNIzKIMnVD7el6yhUFHTVuSo/cF8AFYjDx/7JWn9swaI2SV07JxBLMHPY1pMY1a6E
         N2Y0AagWNaWu8W90Fw6R45oFm5hiCyx/46EzqHrpLlQUlBSg3R2EseybSk6rLmfUlh
         LSx/HYqxJvwLDIWOxuzF9NhVGRktueq+1i95AyH5tto4RDmaEbRPwwAwr2F+TgIDbB
         Gkfl3y4z/+UGKrlsf+D4QrRVogKM14kpytdWPlqsmgOvfcHW5QdH1jX/ZemrPdA0vv
         tWwnUdVTvQbWVHVeI7HO8tEyTFGig8fVww3Du+ahYAc5hWKd3+1Xp10IzIqsIgl8TQ
         EnhI8X2oxO5wA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C019B5C00C6; Mon, 17 May 2021 11:24:50 -0700 (PDT)
Date:   Mon, 17 May 2021 11:24:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH tip/core/rcu 3/4] rcu-tasks: Make ksoftirqd provide RCU
 Tasks quiescent states
Message-ID: <20210517182450.GL4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210512182747.3445812-4-paulmck@kernel.org>
 <20210513155417.93ab2299139ba35025ec8ef7@kernel.org>
 <20210513142110.GY975577@paulmck-ThinkPad-P17-Gen-1>
 <20210514024912.a38f755add13a0f1dc73395a@kernel.org>
 <20210513191539.GF975577@paulmck-ThinkPad-P17-Gen-1>
 <20210514150431.d89b0ad0a5ce1ac3971a66e5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514150431.d89b0ad0a5ce1ac3971a66e5@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 14, 2021 at 03:04:31PM +0900, Masami Hiramatsu wrote:
> Hi Paul,
> 
> On Thu, 13 May 2021 12:15:39 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Fri, May 14, 2021 at 02:49:12AM +0900, Masami Hiramatsu wrote:
> > > On Thu, 13 May 2021 07:21:10 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > On Thu, May 13, 2021 at 03:54:17PM +0900, Masami Hiramatsu wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On Wed, 12 May 2021 11:27:46 -0700
> > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > 
> > > > > > Heavy networking load can cause a CPU to execute continuously and
> > > > > > indefinitely within ksoftirqd, in which case there will be no voluntary
> > > > > > task switches and thus no RCU-tasks quiescent states.  This commit
> > > > > > therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
> > > > > > quiescent state.
> > > > > > 
> > > > > > This of course means that __do_softirq() and its callers cannot be
> > > > > > invoked from within a tracing trampoline.
> > > > > 
> > > > > I would like to confirm that you mean "tracing trampoline" here is
> > > > > the code on the trampoline buffer, not the handler code which is
> > > > > invoked from the trampoline buffer but it is protected by preempt_disable(),
> > > > > am I understand correctly?
> > > > 
> > > > Maybe?  ;-)
> > > > 
> > > > If the handler code is invoked from the trampoline buffer, but
> > > > returns somewhere else, then it is OK for the handler code to invoke
> > > > __do_softirq() or its callers.
> > > > 
> > > > In addition, if the handler code is invoked from the trampoline buffer is
> > > > guaranteed never to be running in the context of the ksoftirqd kthread,
> > > > then it is also OK for the handler code to invoke __do_softirq() or
> > > > its callers.
> > > > 
> > > > Otherwise, if the handler code might return back into the trampoline
> > > > buffer and if that code might be running in the context of the ksoftirqd
> > > > kthread, invoking __do_softirq() or one of its callers could result in
> > > > the trampoline buffer no longer being there when it was returned to.
> > > 
> > > Hmm, the optprobe may be involved in this case. It always return to
> > > the trampoline and handler does not disable irqs (only disable preempt).
> > > BTW, what will call the __do_softirq()? Is hardirq safe?
> > 
> > As long as your code does not explicitly call __do_softirq() or one of
> > its callers, you should be OK.
> > 
> > Let's suppose that your code takes a hardirq from ksoftirqd context.
> > In that case, the return-from-irq path will notice the ksoftirqd
> > context and refrain from calling __do_softirqd().  Life is good.
> > (See the invoke_softirq() function for more detail.)
> > 
> > On the other hand, if your code takes a hardirq from some non-ksoftirqd
> > context, and if this hardirq decides to handle softirqs on exit
> > from the hardirq, the "__this_cpu_read(ksoftirqd) == current" within
> > __do_softirq() will fail, so that rcu_softirq_qs() will not be called.
> > Life is still good.
> 
> Ah, OK. This is good.
> 
> > 
> > Either way, as long as your handler does not explicitly invoke
> > __do_softirq(), life is good.
> 
> There should be no such code, I hope. 
> 
> > 
> > The bad case is when you instrument a function that is invoked in the
> > context of a ksoftirqd kthread, and the corresponding handler (or
> > some function that the handler explicitly calls) directly invokes
> > __do_softirq() or one of its caller.
> > 
> > Is that more helpful?
> 
> OK, I got it. So it would be better to be commented later.
> But anyway I can't imagine that there is any reason to call
> __do_softirq() inside kprobe handler :)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

I will apply on the next rebase, thank you!

							Thanx, Paul
