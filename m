Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566013FEE;
	Wed, 30 Oct 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296453; cv=none; b=sWigQGd3YqD3Fz1EjxriB7Kbr0YwKsdOzDiXm7c33sXaOOUudi9eAJdXR+49b8xtmBijg5s/zJ6kVDabeAldjrER+ydxN8psfqW4os714DJb4GD2db5L+GcB6YY6sUR1deSfcNc5b+aI6cTqH3BmxYhqrh+PudBcLl7c3uXaP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296453; c=relaxed/simple;
	bh=PhXYYAn+2LT8w0L4LGY0S9YENmYHSpGxQ6PQjfy3S0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMX0ANgG2FOSzDJKIPR/423wNRdOUMgCZgmyzfSju9AC/kBnZ4UuF1PN4m1XhP0CB7D3gzC99MMe5/46z5Wj6PjDFfI9oiHNa9lSbYtbpYP6OtOPajyezJ55UGsbtNPMRfZBdv6Gjt4+aFZpnO5vSlek77aFA+vr26gX57mC4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRrWfpHI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRrWfpHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF98C4CECE;
	Wed, 30 Oct 2024 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296452;
	bh=PhXYYAn+2LT8w0L4LGY0S9YENmYHSpGxQ6PQjfy3S0w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iRrWfpHI1cpj16s7bdO00D1EDQY9ZR0HXUyhoQ9o5LF1XXlAOWFX/qhNzU+gKAChw
	 2lKx9I4zTpddP/WC9aDfRv+aXDpvKTS6RYkuvjyHLl7Qcc5reyA6xs4nSRZfppxtQv
	 nd3uqfHm1oieKfFR9bwbAnrK00QHO40TN7SMrBJn+zzUPDl3RsNXYx2RGoqIhu9WIj
	 I1NR+K8o4q4L9+ez4RrH+QRibW8I/xZXH1f712hUYoJO2eZ9zOcPMShMFpctb0/irP
	 niejR/jT/el1EBfyNKm+09NrBkkWR6L1B6CMVq2i4xns+1FY19dJmRNB0ejxX5dkh9
	 ePR6+Dwxunu5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D4FDCE09DB; Wed, 30 Oct 2024 06:54:12 -0700 (PDT)
Date: Wed, 30 Oct 2024 06:54:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>
Cc: "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Message-ID: <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org>
 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>

On Wed, Oct 30, 2024 at 03:55:56AM +0000, Cheng-Jui Wang (王正睿) wrote:
> On Tue, 2024-10-29 at 09:29 -0700, Paul E. McKenney wrote:
> > External email : Please do not click links or open attachments until you have verified the sender or the content.
> > 
> > 
> > On Tue, Oct 29, 2024 at 02:20:51AM +0000, Cheng-Jui Wang (王正睿) wrote:
> > > On Mon, 2024-10-28 at 17:22 -0700, Paul E. McKenney wrote:
> > > > The result is that the current leaf rcu_node structure's ->lock is
> > > > acquired only if a stack backtrace might be needed from the current CPU,
> > > > and is held across only that CPU's backtrace. As a result, if there are
> > > 
> > > After upgrading our device to kernel-6.11, we encountered a lockup
> > > scenario under stall warning.
> > > I had prepared a patch to submit, but I noticed that this series has
> > > already addressed some issues, though it hasn't been merged into the
> > > mainline yet. So, I decided to reply to this series for discussion on
> > > how to fix it before pushing. Here is the lockup scenario We
> > > encountered:
> > > 
> > > Devices: arm64 with only 8 cores
> > > One CPU holds rnp->lock in rcu_dump_cpu_stack() while trying to dump
> > > other CPUs, but it waits for the corresponding CPU to dump backtrace,
> > > with a 10-second timeout.
> > > 
> > >    __delay()
> > >    __const_udelay()
> > >    nmi_trigger_cpumask_backtrace()
> > >    arch_trigger_cpumask_backtrace()
> > >    trigger_single_cpu_backtrace()
> > >    dump_cpu_task()
> > >    rcu_dump_cpu_stacks()  <- holding rnp->lock
> > >    print_other_cpu_stall()
> > >    check_cpu_stall()
> > >    rcu_pending()
> > >    rcu_sched_clock_irq()
> > >    update_process_times()
> > > 
> > > However, the other 7 CPUs are waiting for rnp->lock on the path to
> > > report qs.
> > > 
> > >    queued_spin_lock_slowpath()
> > >    queued_spin_lock()
> > >    do_raw_spin_lock()
> > >    __raw_spin_lock_irqsave()
> > >    _raw_spin_lock_irqsave()
> > >    rcu_report_qs_rdp()
> > >    rcu_check_quiescent_state()
> > >    rcu_core()
> > >    rcu_core_si()
> > >    handle_softirqs()
> > >    __do_softirq()
> > >    ____do_softirq()
> > >    call_on_irq_stack()
> > > 
> > > Since the arm64 architecture uses IPI instead of true NMI to implement
> > > arch_trigger_cpumask_backtrace(), spin_lock_irqsave disables
> > > interrupts, which is enough to block this IPI request.
> > > Therefore, if other CPUs start waiting for the lock before receiving
> > > the IPI, a semi-deadlock scenario like the following occurs:
> > > 
> > > CPU0                    CPU1                    CPU2
> > > -----                   -----                   -----
> > > lock_irqsave(rnp->lock)
> > >                         lock_irqsave(rnp->lock)
> > >                         <can't receive IPI>
> > > <send ipi to CPU 1>
> > > <wait CPU 1 for 10s>
> > >                                                 lock_irqsave(rnp->lock)
> > >                                                 <can't receive IPI>
> > > <send ipi to CPU 2>
> > > <wait CPU 2 for 10s>
> > > ...
> > > 
> > > 
> > > In our scenario, with 7 CPUs to dump, the lockup takes nearly 70
> > > seconds, causing subsequent useful logs to be unable to print, leading
> > > to a watchdog timeout and system reboot.
> > > 
> > > This series of changes re-acquires the lock after each dump,
> > > significantly reducing lock-holding time. However, since it still holds
> > > the lock while dumping CPU backtrace, there's still a chance for two
> > > CPUs to wait for each other for 10 seconds, which is still too long.
> > > So, I would like to ask if it's necessary to dump backtrace within the
> > > spinlock section?
> > > If not, especially now that lockless checks are possible, maybe it can
> > > be changed as follows?
> > > 
> > > -                     if (!(data_race(rnp->qsmask) & leaf_node_cpu_bit(rnp, cpu)))
> > > -                             continue;
> > > -                     raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > -                     if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
> > > +                     if (data_race(rnp->qsmask) & leaf_node_cpu_bit(rnp, cpu)) {
> > >                               if (cpu_is_offline(cpu))
> > >                                       pr_err("Offline CPU %d blocking current GP.\n", cpu);
> > >                               else
> > >                                       dump_cpu_task(cpu);
> > >                               }
> > >                       }
> > > -                     raw_spin_unlock_irqrestore_rcu_node(rnp,
> > > flags);
> > > 
> > > Or should this be considered an arm64 issue, and they should switch to
> > > true NMI, otherwise, they shouldn't use
> > > nmi_trigger_cpumask_backtrace()?
> > 
> > Thank you for looking into this!
> > 
> > We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs, so,
> > yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just like
> > the name says.  ;-)
> 
> In the comments of following patch, the arm64 maintainers have
> differing views on the use of nmi_trigger_cpumask_backtrace(). I'm a
> bit confused and unsure which perspective is more reasonable.
> 
> https://lore.kernel.org/all/20230906090246.v13.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid/

I clearly need to have a chat with the arm64 maintainers, and thank
you for checking.

> > /*
> >  * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the
> name,
> >  * nothing about it truly needs to be implemented using an NMI, it's
> >  * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> >  * returned false our backtrace attempt will just use a regular IPI.
> >  */
> 
> > Alternatively, arm64 could continue using nmi_trigger_cpumask_backtrace()
> > with normal interrupts (for example, on SoCs not implementing true NMIs),
> > but have a short timeout (maybe a few jiffies?) after which its returns
> > false (and presumably also cancels the backtrace request so that when
> > the non-NMI interrupt eventually does happen, its handler simply returns
> > without backtracing).  This should be implemented using atomics to avoid
> > deadlock issues.  This alternative approach would provide accurate arm64
> > backtraces in the common case where interrupts are enabled, but allow
> > a graceful fallback to remote tracing otherwise.
> > 
> > Would you be interested in working this issue, whatever solution the
> > arm64 maintainers end up preferring?
> 
> The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrace().
> It is shared code and not architecture-specific. Currently, I haven't
> thought of a feasible solution. I have also CC'd the authors of the
> aforementioned patch to see if they have any other ideas.

It should be possible for arm64 to have an architecture-specific hook
that enables them to use a much shorter timeout.  Or, to eventually
switch to real NMIs.

> Regarding the rcu stall warning, I think the purpose of acquiring `rnp-
> >lock` is to protect the rnp->qsmask variable rather than to protect
> the `dump_cpu_task()` operation, right?

As noted below, it is also to prevent false-positive stack dumps.

> Therefore, there is no need to call dump_cpu_task() while holding the
> lock.
> When holding the spinlock, we can store the CPUs that need to be dumped
> into a cpumask, and then dump them all at once after releasing the
> lock.
> Here is my temporary solution used locally based on kernel-6.11.
> 
> +	cpumask_var_t mask;
> +	bool mask_ok;
> 
> +	mask_ok = zalloc_cpumask_var(&mask, GFP_ATOMIC);
> 	rcu_for_each_leaf_node(rnp) {
> 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> 		for_each_leaf_node_possible_cpu(rnp, cpu)
> 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
> {
> 				if (cpu_is_offline(cpu))
> 					pr_err("Offline CPU %d blocking
> current GP.\n", cpu);
> +				else if (mask_ok)
> +					cpumask_set_cpu(cpu, mask);
> 				else
> 					dump_cpu_task(cpu);
> 			}
> 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 	}
> +	if (mask_ok) {
> +		if (!trigger_cpumask_backtrace(mask)) {
> +			for_each_cpu(cpu, mask)
> +				dump_cpu_task(cpu);
> +		}
> +		free_cpumask_var(mask);
> +	}
> 
> After applying this, I haven't encountered the lockup issue for five
> days, whereas it used to occur about once a day.

We used to do it this way, and the reason that we changed was to avoid
false-positive (and very confusing) stack dumps in the surprisingly
common case where the act of dumping the first stack caused the stalled
grace period to end.

So sorry, but we really cannot go back to doing it that way.

							Thanx, Paul
