Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E22107;
	Tue, 29 Oct 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219354; cv=none; b=PZ1EMKuJrpEvlSqxiq74tTj9LJCEbkxAjjETHrcDaEuX56S3162De/nu4KSqQCoMsWkTTVvdLd2jBoi2NN2QNryvaZNw1F5DL3dlqzEZw3sHt794lWhtOkjgUh+9nlqum6klSdHqduYnLxSt6NYLNDS8O6MhUPsffqbOVpzvPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219354; c=relaxed/simple;
	bh=XEi6ujTZMgV90pVEuH+kg3iRvzVKiuquwcJsySkcQag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwNgwG+uzI//qSlhEe7YpqFxAygOV6PrkguuWMkDhVbtZTdIU6l4GKAhr1DasLRhLE6J81zkgoBp8m6u6BOOS39lVjVFGvMjdsXr4fKyDdmZH0IpFEDqz4R4IP2A5tGqTtYrCom4JAZCVehy0j2tOELGrIEzq2nUWFXcaMIinrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/mtpTFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/mtpTFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A062BC4CECD;
	Tue, 29 Oct 2024 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219353;
	bh=XEi6ujTZMgV90pVEuH+kg3iRvzVKiuquwcJsySkcQag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A/mtpTFNOIDEmG7Ze1WALWqQZJPU54ohHyi1YdzQY98lRuaKWr08MGA2P9YIV8IZU
	 Euwxu/Gurl6J4Rf6Dc6bZClCxbStiMumHxbsOUUh9tyl4neOR0mbbqKwH3LiLIfBYu
	 4VKx1WadPJxPX2yS6IaP4FJNbWF34wPGYKlvV92DcTApZeM1gbUh+feZFqWsbDrYpx
	 s+uNFr1UEI7NuEci+Cmt8JckTBxJ5yMsHFEGCXC6HIplfzMqIiV8mEMatAQuCDwfIk
	 k6RHpyjyVX2HZQavevNhiNYwAzv4gL7dicodSWVbfBTyeE2bMV/BaducVWX+TlccY2
	 MWv07DaPPNoiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 477EFCE0A48; Tue, 29 Oct 2024 09:29:13 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:29:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>
Cc: "frederic@kernel.org" <frederic@kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Message-ID: <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org>
 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>

On Tue, Oct 29, 2024 at 02:20:51AM +0000, Cheng-Jui Wang (王正睿) wrote:
> On Mon, 2024-10-28 at 17:22 -0700, Paul E. McKenney wrote:
> > The result is that the current leaf rcu_node structure's ->lock is
> > acquired only if a stack backtrace might be needed from the current CPU,
> > and is held across only that CPU's backtrace. As a result, if there are
> 
> After upgrading our device to kernel-6.11, we encountered a lockup
> scenario under stall warning. 
> I had prepared a patch to submit, but I noticed that this series has
> already addressed some issues, though it hasn't been merged into the
> mainline yet. So, I decided to reply to this series for discussion on
> how to fix it before pushing. Here is the lockup scenario We
> encountered:
> 
> Devices: arm64 with only 8 cores
> One CPU holds rnp->lock in rcu_dump_cpu_stack() while trying to dump
> other CPUs, but it waits for the corresponding CPU to dump backtrace,
> with a 10-second timeout.
> 
>    __delay()
>    __const_udelay()
>    nmi_trigger_cpumask_backtrace()
>    arch_trigger_cpumask_backtrace()
>    trigger_single_cpu_backtrace()
>    dump_cpu_task()
>    rcu_dump_cpu_stacks()  <- holding rnp->lock
>    print_other_cpu_stall()
>    check_cpu_stall()
>    rcu_pending()
>    rcu_sched_clock_irq()
>    update_process_times()
> 
> However, the other 7 CPUs are waiting for rnp->lock on the path to
> report qs.
> 
>    queued_spin_lock_slowpath()
>    queued_spin_lock()
>    do_raw_spin_lock()
>    __raw_spin_lock_irqsave()
>    _raw_spin_lock_irqsave()
>    rcu_report_qs_rdp()
>    rcu_check_quiescent_state()
>    rcu_core()
>    rcu_core_si()
>    handle_softirqs()
>    __do_softirq()
>    ____do_softirq()
>    call_on_irq_stack()
> 
> Since the arm64 architecture uses IPI instead of true NMI to implement
> arch_trigger_cpumask_backtrace(), spin_lock_irqsave disables
> interrupts, which is enough to block this IPI request.
> Therefore, if other CPUs start waiting for the lock before receiving
> the IPI, a semi-deadlock scenario like the following occurs:
> 
> CPU0                    CPU1                    CPU2
> -----                   -----                   -----
> lock_irqsave(rnp->lock)
>                         lock_irqsave(rnp->lock)
>                         <can't receive IPI>
> <send ipi to CPU 1>
> <wait CPU 1 for 10s>
>                                                 lock_irqsave(rnp->lock)
>                                                 <can't receive IPI>
> <send ipi to CPU 2>
> <wait CPU 2 for 10s>
> ...
> 
> 
> In our scenario, with 7 CPUs to dump, the lockup takes nearly 70
> seconds, causing subsequent useful logs to be unable to print, leading
> to a watchdog timeout and system reboot.
> 
> This series of changes re-acquires the lock after each dump,
> significantly reducing lock-holding time. However, since it still holds
> the lock while dumping CPU backtrace, there's still a chance for two
> CPUs to wait for each other for 10 seconds, which is still too long.
> So, I would like to ask if it's necessary to dump backtrace within the
> spinlock section?
> If not, especially now that lockless checks are possible, maybe it can
> be changed as follows?
> 
> -			if (!(data_race(rnp->qsmask) & leaf_node_cpu_bit(rnp, cpu)))
> -				continue;
> -			raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
> +			if (data_race(rnp->qsmask) & leaf_node_cpu_bit(rnp, cpu)) {
> 				if (cpu_is_offline(cpu))
> 					pr_err("Offline CPU %d blocking current GP.\n", cpu);
> 				else
> 					dump_cpu_task(cpu);
> 				}
> 			}
> -			raw_spin_unlock_irqrestore_rcu_node(rnp,
> flags);
> 
> Or should this be considered an arm64 issue, and they should switch to
> true NMI, otherwise, they shouldn't use
> nmi_trigger_cpumask_backtrace()?

Thank you for looking into this!

We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs, so,
yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just like
the name says.  ;-)

Alternatively, arm64 could continue using nmi_trigger_cpumask_backtrace()
with normal interrupts (for example, on SoCs not implementing true NMIs),
but have a short timeout (maybe a few jiffies?) after which its returns
false (and presumably also cancels the backtrace request so that when
the non-NMI interrupt eventually does happen, its handler simply returns
without backtracing).  This should be implemented using atomics to avoid
deadlock issues.  This alternative approach would provide accurate arm64
backtraces in the common case where interrupts are enabled, but allow
a graceful fallback to remote tracing otherwise.

Would you be interested in working this issue, whatever solution the
arm64 maintainers end up preferring?

							Thanx, Paul
