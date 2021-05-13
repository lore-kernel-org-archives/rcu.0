Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3702C433B4
	for <rcu@archiver.kernel.org>; Thu, 13 May 2021 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3CF611AC
	for <rcu@archiver.kernel.org>; Thu, 13 May 2021 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhEMOXD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 May 2021 10:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234421AbhEMOWV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 May 2021 10:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5CB9610A0;
        Thu, 13 May 2021 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620915671;
        bh=6gxmTjd9VZ/ZgASdqIhtkGQj9eTx0nRfnVBXcwAaqOs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SIqd6nSkEswbRIKqx34D/mktxOmQUfdOCQ3OcqvuCCLjGpqMP9RqfPvTq4kSIRJ8r
         OBMicROqiIzuALz9JNkDESL7Siu1XDSXq8cuXPm7tOivxwCuxA1GNzdUGCX7vJVyAw
         18TvN5MiFmZfVEj51DxZ1IXjR2bMB24UldOvL5BId/kN39uUnxoIR4J9TztPDCZdTs
         wjLeB2VwMssVNo4hGXcHYBm9wM0LD2wFdCVI42sMq4oYqfhnApHEuHBfVvyOyNLZpy
         DdfwTNaGiZxo9+9twnS0MMiTamdYb+LwxULo5uaHcX1m5BBoHUNSSSIuO85RI3gjhU
         3QoKIeT2ghVrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69E925C014E; Thu, 13 May 2021 07:21:10 -0700 (PDT)
Date:   Thu, 13 May 2021 07:21:10 -0700
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
Message-ID: <20210513142110.GY975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210512182747.3445812-4-paulmck@kernel.org>
 <20210513155417.93ab2299139ba35025ec8ef7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513155417.93ab2299139ba35025ec8ef7@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 13, 2021 at 03:54:17PM +0900, Masami Hiramatsu wrote:
> Hi Paul,
> 
> On Wed, 12 May 2021 11:27:46 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Heavy networking load can cause a CPU to execute continuously and
> > indefinitely within ksoftirqd, in which case there will be no voluntary
> > task switches and thus no RCU-tasks quiescent states.  This commit
> > therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
> > quiescent state.
> > 
> > This of course means that __do_softirq() and its callers cannot be
> > invoked from within a tracing trampoline.
> 
> I would like to confirm that you mean "tracing trampoline" here is
> the code on the trampoline buffer, not the handler code which is
> invoked from the trampoline buffer but it is protected by preempt_disable(),
> am I understand correctly?

Maybe?  ;-)

If the handler code is invoked from the trampoline buffer, but
returns somewhere else, then it is OK for the handler code to invoke
__do_softirq() or its callers.

In addition, if the handler code is invoked from the trampoline buffer is
guaranteed never to be running in the context of the ksoftirqd kthread,
then it is also OK for the handler code to invoke __do_softirq() or
its callers.

Otherwise, if the handler code might return back into the trampoline
buffer and if that code might be running in the context of the ksoftirqd
kthread, invoking __do_softirq() or one of its callers could result in
the trampoline buffer no longer being there when it was returned to.

							Thanx, Paul

> Thank you,
> 
> > 
> > Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8e78b2430c16..f4daa4e60b14 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -242,6 +242,7 @@ void rcu_softirq_qs(void)
> >  {
> >  	rcu_qs();
> >  	rcu_preempt_deferred_qs(current);
> > +	rcu_tasks_qs(current, false);
> >  }
> >  
> >  /*
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
