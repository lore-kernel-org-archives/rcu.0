Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F1C433E2
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59E620767
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 02:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599187349;
	bh=RZp2z2lZ4ZEa5XCcqc63rPN5V8YW2idBP8wQngWLmmQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AhWJ/RMD8PtvsCOmW/QOeo6yahyDAKar5tX3etoxh/+2dmWJ/jPCQRCkT87wyxdJQ
	 dM8v0CAwg7YDyzzR3ROHqC2NrVR6pgFNnTTk5ajjeKLtVj5Z2HwjyuIBMogqjCB8Eh
	 +ajN1pH1JkJVpnFrL7tvuH0E6xwJjdetXZ3sDkto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgIDCm3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgIDCm3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Sep 2020 22:42:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535F82075D;
        Fri,  4 Sep 2020 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599187348;
        bh=RZp2z2lZ4ZEa5XCcqc63rPN5V8YW2idBP8wQngWLmmQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tXKNVi9V3hfKEMuoSuYwyRWW7ZIGntoNqZ3Lo3DB+WPn7rlyZ/Mui9HDfcdrBIV/B
         +qS8DYEv62qXSSsD9P2GgY47YHZytU+h2lgtRzFZeRUuemykJ8Kh4IqtdApQSmuYZW
         Vvw8x2AGyUq5hbGAeKk8k2rS1u9t0edIHX3rUJqc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3006D3522636; Thu,  3 Sep 2020 19:42:28 -0700 (PDT)
Date:   Thu, 3 Sep 2020 19:42:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH tip/core/rcu 2/4] smp: Add source and destination CPUs to
 __call_single_data
Message-ID: <20200904024228.GY29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
 <20200831181417.1378-2-paulmck@kernel.org>
 <20200904021610.GA7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904021610.GA7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 04, 2020 at 10:16:10AM +0800, Boqun Feng wrote:
> Hi Paul,
> 
> On Mon, Aug 31, 2020 at 11:14:15AM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds a destination CPU to __call_single_data, and is inspired
> > by an earlier commit by Peter Zijlstra.  This version adds #ifdef to
> > permit use by 32-bit systems and supplying the destination CPU for all
> > smp_call_function*() requests, not just smp_call_function_single().
> > 
> > If need be, 32-bit systems could be accommodated by shrinking the flags
> > field to 16 bits (the atomic_t variant is currently unused) and by
> > providing only eight bits for CPU on such systems.
> > 
> > It is not clear that the addition of the fields to __call_single_node
> > are really needed.
> > 
> > Link: https://lore.kernel.org/lkml/20200615164048.GC2531@hirez.programming.kicks-ass.net/
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/smp.h       | 3 +++
> >  include/linux/smp_types.h | 3 +++
> >  kernel/smp.c              | 2 ++
> >  3 files changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > index 80d557e..9f13966 100644
> > --- a/include/linux/smp.h
> > +++ b/include/linux/smp.h
> > @@ -26,6 +26,9 @@ struct __call_single_data {
> >  		struct {
> >  			struct llist_node llist;
> >  			unsigned int flags;
> > +#ifdef CONFIG_64BIT
> > +			u16 src, dst;
> > +#endif
> >  		};
> >  	};
> >  	smp_call_func_t func;
> > diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
> > index 364b3ae..2e8461a 100644
> > --- a/include/linux/smp_types.h
> > +++ b/include/linux/smp_types.h
> > @@ -61,6 +61,9 @@ struct __call_single_node {
> >  		unsigned int	u_flags;
> >  		atomic_t	a_flags;
> >  	};
> > +#ifdef CONFIG_64BIT
> > +	u16 src, dst;
> > +#endif
> >  };
> >  
> >  #endif /* __LINUX_SMP_TYPES_H */
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index d0ae8eb..a47382d 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -375,6 +375,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
> >  
> >  	csd->func = func;
> >  	csd->info = info;
> > +	csd->dst = cpu;
> 
> Would this and the next modification cause compile errors with
> CONFIG_64BIT = n? I saw you add #ifdef guard in the next patch, so maybe
> move those two into next patch (of course, if they trigger compile
> errors)

Good point, will fix, thank you!

							Thanx, Paul

> Regards,
> Boqun
> 
> >  
> >  	err = generic_exec_single(cpu, csd);
> >  
> > @@ -540,6 +541,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
> >  			csd->flags |= CSD_TYPE_SYNC;
> >  		csd->func = func;
> >  		csd->info = info;
> > +		csd->dst = cpu;
> >  		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
> >  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> >  	}
> > -- 
> > 2.9.5
> > 
