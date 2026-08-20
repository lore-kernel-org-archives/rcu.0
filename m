Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F925B08E;
	Thu, 20 Aug 2026 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787266776; cv=none; b=RVP/HfCgkVrPkASFb090xx33JCMTeKe6vte+ruG12hAynvNITGHEOo5JB6S4pPt5aGcqel9143aTiTpjJXU1jMNitpOUVU9ZcYDUhniNRSvmToRAOvknTt30+NWNRCzAcdq1jz6TiUN2LcTHbXgrS1bj48GxEjaN7+RRjpUtk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787266776; c=relaxed/simple;
	bh=pV/fPEuj1JfKA1KXpCatzc8yZDKQrAxX4cPw2Jj7vj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nONiAo3fxY9j7rTEahtuXwjfMku5LfAN1QLa4jAnGuJNulxek6g3O+i8Xmcviv2ZWFMA2Y3bsAIZSfFFmAcZhqEZxCPCA2wAqP/bf9If0TlGudQKu8I0VFflt180UetUn8Vv6tjuhW22ZBV7Vbkc4vl/a3t37GoHjIRw69YrJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYRK08j6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYRK08j6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF9D1F000E9;
	Thu, 20 Aug 2026 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787266774;
	bh=SoNNm7jFJ7hNLP+hM/DABTadjVQbBib2kSdB/cwOkP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dYRK08j6zoNmRTenwAv4fe3QLob2k1Oijqnwr8N7gOcTDx0GRNBqUp4DT7AirBFEC
	 sl+9kri54hrncueZcPwOZ+FYQNnvdas7fhxowPFfKlbYNzULq5q0DfpQ6Kn1qe2q/j
	 3sQBIdQy4G2M++zMUeXuqe3nj07qXmhz6xnYboMoF8/mwrFrp7QOv7YE5n6ObpjSNG
	 ECLjgezFhsiTM0FBpmALnkPaqKlE4yHpv5jXaDcvlJeE8lKdts63ibt897WDQ3sgBN
	 6vxIpAaRUGED8Zjfp0cRmBLla/cZypSCDZtPRGvEoTBE0DbNPvT3rpQTECp6tIKjra
	 G8cduID7dYtHQ==
Date: Fri, 21 Aug 2026 00:59:32 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Message-ID: <aoeG1BhFsTV2T_p4@pavilion.home>
References: <20260820110008.v2Tlr0_H@linutronix.de>
 <aob12RahomSmpUQY@localhost.localdomain>
 <20260820135500.hXUAsbHR@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820135500.hXUAsbHR@linutronix.de>

Le Thu, Aug 20, 2026 at 03:55:00PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2026-08-20 14:40:57 [+0200], Frederic Weisbecker wrote:
> > Le Thu, Aug 20, 2026 at 01:00:08PM +0200, Sebastian Andrzej Siewior a écrit :
> > > The irq_work in srcu is used to schedule a delayed work. The work item
> > > is not scheduled directly because it is not always possible wake a
> > > thread directly.
> > > 
> > > On PREEMPT_RT the default irq_work is initialized with IRQ_WORK_LAZY and
> > > is delayed to the irq_work thread. A system booted with the command line
> > > "trace_event=…" will freeze during boot because the irq_work thread is
> > > not yet deployed (and tracing uses synchronize_srcu() in
> > > tp_rcu_cond_sync()).
> > > 
> > > The irq_work performs just a wakeup a thread, there is nothing wrong
> > > with doing this from hardirq context on PREEMPT_RT.
> > > 
> > > Use IRQ_WORK_INIT_HARD for srcu's irq_work.
> > > 
> > > Fixes: 7c405fb3279b3 ("rcu: Use an intermediate irq_work to start process_srcu()")
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  kernel/rcu/srcutree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 7c2f7cc131f7a..b703233d4a63f 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -218,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> > >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> > >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > >  	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > > -	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
> > > +	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);
> > 
> > It may need a comment to not lose that.
> 
> We could also make irq_work.o earlier in the Makefile, right at the top
> so it comes before tracing. This was one of the first ideas and makes
> the issue also go away. But given that it is just a wake we avoid waking
> the irq_work/ thread just to schedule a timer/ wake workqueue.
> 
> > >  	ssp->srcu_sup->sda_is_static = is_static;
> > >  	if (!is_static) {
> > >  		ssp->sda = alloc_percpu(struct srcu_data);
> > > -- 
> > > 2.55.0
> > > 
> > >
> > 
> > Perhaps all irq works queued before the relevant kthread is started should
> > temporarily be queued as hard?
> 
> Urgh. irq_work shouldn't become a widespread user ;)
> If the scheduler is up but irq_work thread is not yet created and the
> irq_work uses sleeping locks then it would create warnings.
> In testing right now I see just wake_up_klogd_work_func() which is
> always LAZY but would qualify otherwise for a warning. We wouldn't
> trigger anything yet but you get the idea.

Fair enough! But should we warn if a non-hard IRQ work is queued before
the kthread is created?

Thanks.

> 
> > Thanks.
> 
> Sebastian
> 

-- 
Frederic Weisbecker
SUSE Labs
