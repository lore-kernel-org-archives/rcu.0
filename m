Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBB2877E5
	for <rcu@vger.kernel.org>; Tue,  5 May 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969232; cv=none; b=EqNeD9b/Xwy+tqQT9BXmV8Lu873jlO3MK6CBIXgcQgIFcVTc3X/0QlJ5CKHhRhr36ZpEHOpkHxa8oWvxSCPLTi3uoA3FjjohwugQwPhLvI5I+TKw3IcahDLLRsx1kQCXepaoIe9rqypodPNss08v6EL0bH6tf7XheidTmb8mDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969232; c=relaxed/simple;
	bh=R6zK5AUA3ReAaVE7yLnp1VTQo+rBlgPut73aqTg18tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo1OBzIQdv0DHvE0Ai4pwYw01ejYMqQf1L/OgQIvKphhszdZAXAaXl65TDWtxHnupiPEongZ1yB0XjUfXuywM1vZoMymIQLnhCffVHbZ0W5wKc+UAPXWrzT8o6SwDtHJUOo7FCLq8WaX9LgTCHCleXgKVpjwPQX2vdfmsDwQjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFwuKS4c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFwuKS4c"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-356337f058aso3156683a91.2
        for <rcu@vger.kernel.org>; Tue, 05 May 2026 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777969230; x=1778574030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSLbkw7xRXP5QSYBn/JzKFk3JWJUAlfv40FrPMgnGwE=;
        b=WFwuKS4cwYee0g+zUG0Wq4rNhyfXiSdtjGuxP1wBUSAw2/5h8FCZsZnTiyCXsCUo2a
         nKpj+ue+9KikZ6Spi0Fyzq5GH3H41lC4MQGNCuJ5TSmVzfG8yBCvkTXCyPJm8HMsef7S
         RwJv5JCMKJ8WWPEuxHyR6f75YUQbJyFqXSMEYB88UZM3jr+i2lnbGI7GxS4Ioivsd3WH
         zuEt+1VahfZKe95SQ647nM1A+ARqY7jhyHBV6a0TjRvdEsBmL3+2Grd2wcO9Mg4Vb6xN
         h5i6c7SYrMXjjm5zdIP74wDZjmBGgDCLMXqZxZqocKydZUq1dtWW4gEDBpxBbI4jKckx
         8xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777969230; x=1778574030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSLbkw7xRXP5QSYBn/JzKFk3JWJUAlfv40FrPMgnGwE=;
        b=LujibkFT8cAxn8zN9ty8bAwRaWnpX+lB1SeIWVAf2vJCGdk2hYbR7gVOe2X4AuZ6q4
         Qt5Rj9OLXvMVnHYzWwxDkMM7uEs80vjBiGSFu2shWjEMh1KpV5xUyuuuCzsXDzihKPj7
         nfQJ0z6ZKtXbL0QTQjguTJBkOFjZgi0JjeS8QtDs+cfw6GGwlFogBwvb7+L+L/Edvuf/
         s6gzNL8u6KUqAqIXRYinj+Nrx6CWPf93ERXenccmaUiqvJz9+UvJk0bzAFQz7eL5640r
         EdhXVUe8e1XGWw/RDdhHD1dfDoBsGGclSD7tQjf0I52Ik1XGvBsCdpBTDub1uUMy0xZR
         8AEw==
X-Forwarded-Encrypted: i=1; AFNElJ/Rpl6nTbyYTktySXPSMqTA0KzVreDN6d2f0T1W3F39LHWv0gRuR2r6CvARoCCUpwexuVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyX35DR1afZggHHiSxV/z2PEaoGEyZoLYQLLMT9z+hXaEHpWh
	lJMfJBmCfLjm70DJx/A++V5LMxpFA9z/ob7sAcuV3lMzqAxG3BUNucfo
X-Gm-Gg: AeBDietju5Et8Ko0ONAJVWxeVrv+ol+Y9Y0TgRU9Wh7g39YfEKnLkhRmUWgV+TYl25r
	IoMCj1HXxmbZmQgG8/tvwiuB5yDr4Pt8i5rfMKM+h1tWiQ1+WAPJ1829Pjm/+6iTCh+r8RojFZU
	7us+8u2++4anq/vAzi/kAwS4jD6zFUv8aRyEa0OBd0vKfyPxrGghicM4W5xmEdNwSsKkt1pPR9g
	NWenIfDHOuPmQp+aF/QsKnfXVq9kL6sZ9Xi3Kzz7pXCOUhkiHbBMab1CkQ2XO+FDB5oPcPzwmg4
	VrMk7vOsmy+F4KUbc5jblhfkvR57BU1Qlpf+F0snOM+xj/TW1nNbS0GwBbaf6Pzxn+62UyPP9sd
	/NunGh85ub3h9s+xjxoxWiU7IVBLw3YBmwdeXgeB4RJ3iOVGmDZ71pbDh/v8xvYX3zf2QrEuGpt
	Mo+1g6e7LN4gUnump88V8XQLdDBhK10cCUQi45vLQhvTEXgMo19dyC3/h2t2NhznWYLmF3FJqKP
	zRNiyRd4KwI7ItW
X-Received: by 2002:a17:903:22cc:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2b9f2808597mr123975305ad.25.1777969230021;
        Tue, 05 May 2026 01:20:30 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-109-31.dynamic-ip.hinet.net. [36.225.109.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaae662sm129435035ad.22.2026.05.05.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 01:20:29 -0700 (PDT)
Date: Tue, 5 May 2026 16:20:25 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <20260505154006.G743b@cchengyang.duckdns.org>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
 <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>

Hi Paul, Tejun,

On Mon, May 04, 2026 at 08:44:48PM -0700, Paul E. McKenney wrote:
> On Tue, May 05, 2026 at 12:08:20AM +0800, Cheng-Yang Chou wrote:
> > handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
> > for two paths:
> > 
> > - scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
> >   irq_work may run elsewhere; pass the local cpu explicitly.
> > - scx_rcu_cpu_stall() takes no CPU, recording the detector rather than
> >   the stalled one; add stalled_cpu to its signature and
> >   panic_on_rcu_stall(), threading it from print_cpu_stall() (current
> >   CPU) and print_other_cpu_stall() (first detected stalled CPU).
> > 
> > Add an exit_cpu parameter to handle_lockup() so callers pass the correct
> > CPU directly. Remove the now-unused scx_verror() macro.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > ---
> >  include/linux/sched/ext.h   |  4 ++--
> >  kernel/rcu/tree_exp.h       |  2 +-
> >  kernel/rcu/tree_stall.h     | 11 +++++++----
> >  kernel/sched/ext.c          | 14 ++++++++------
> >  kernel/sched/ext_internal.h |  2 --
> >  5 files changed, 18 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> > index d05efcac794d..16bbf24089ca 100644
> > --- a/include/linux/sched/ext.h
> > +++ b/include/linux/sched/ext.h
> > @@ -259,7 +259,7 @@ void sched_ext_dead(struct task_struct *p);
> >  void print_scx_info(const char *log_lvl, struct task_struct *p);
> >  void scx_softlockup(u32 dur_s);
> >  bool scx_hardlockup(int cpu);
> > -bool scx_rcu_cpu_stall(void);
> > +bool scx_rcu_cpu_stall(int stalled_cpu);
> >  
> >  #else	/* !CONFIG_SCHED_CLASS_EXT */
> >  
> > @@ -267,7 +267,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
> >  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
> >  static inline void scx_softlockup(u32 dur_s) {}
> >  static inline bool scx_hardlockup(int cpu) { return false; }
> > -static inline bool scx_rcu_cpu_stall(void) { return false; }
> > +static inline bool scx_rcu_cpu_stall(int stalled_cpu) { return false; }
> 
> There might be more than one stalled CPU.  You could pass in a cpumask_t
> or similar to print all of them, or take the first or the last or
> some such.

sched_ext's exit_info carries a single s32 exit_cpu, so we can only
record one CPU. Would taking the first stalled CPU be acceptable as a 
best-effort hint, or would you prefer we pass -1 and skip the CPU field
entirely for the RCU stall paths?

> >  
> >  #endif	/* CONFIG_SCHED_CLASS_EXT */
> >  
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 82cada459e5d..fa83e273a648 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
> >  
> >  		nbcon_cpu_emergency_exit();
> >  
> > -		panic_on_rcu_stall();
> > +		panic_on_rcu_stall(raw_smp_processor_id());
> 
> As Tejun pointed out, this gets you whatever random CPU was running
> RCU's expedited grace-period processing, which is almost certainly not
> the stalled CPU.
> 
> In addition, in preemptible kernels, it is possible to stall not on a CPU,
> but on a task that was preempted within an RCU read-side critical section.
> (It is also possible to stall on some CPUs and on some tasks.)
> 
> So suppose that the expedited grace period is stalled not on a CPU, but
> instead on a task.  What do you want to do in that case?
> 
> If you only care about CPUs, then synchronize_rcu_expedited_stall()
> could return the number of the first stalled CPU that it encountered,
> or -1 if there were no CPUs doing any stalling.  If you wanted the first
> CPU, you could capture it within the first rcu_for_each_leaf_node()
> loop in that function.  Or you could pass in a cpumask_t and have
> synchronize_rcu_expedited_stall() fill it in, getting all the CPUs.
> And you could pass in an array (along with its size) to capture the PIDs
> of any stalled tasks, which synchronize_rcu_expedited_stall() would in
> turn pass down to rcu_print_task_exp_stall(), which could fill in the
> PIDs of the first stalled tasks in the ->blkd_tasks lists.
> 
> Whatever you collect would then be passed down to panic_on_rcu_stall()
> and from there to scx_rcu_cpu_stall().
> 
> Much depends on exactly what you are trying to accomplish with the
> additional information.

So, the goal here is best-effort: when sched_ext is aborted due to an
RCU stall, record which CPU was involved for the dump header. There is
no task-based filed in exit_info, so task stalls would naturally fall
through to -1.

Would you prefer:
 (a) pass -1 unconditionally
 (b) have synchronize_rcu_expedited_stall() return the first stalled CPU
     (or -1 if only tasks are stalled)?

> 
> More inline below.
> 
> 						Thanx, Paul
> 
> >  	}
> >  }
> >  
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b67532cb8770..172ac08e673d 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
> >  early_initcall(check_cpu_stall_init);
> >  
> >  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> > -static void panic_on_rcu_stall(void)
> > +static void panic_on_rcu_stall(int stalled_cpu)
> >  {
> >  	static int cpu_stall;
> >  
> > @@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
> >  	 * Attempt to kick out the BPF scheduler if it's installed and defer
> >  	 * the panic to give the system a chance to recover.
> >  	 */
> > -	if (scx_rcu_cpu_stall())
> > +	if (scx_rcu_cpu_stall(stalled_cpu))
> >  		return;
> >  
> >  	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> > @@ -631,6 +631,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
> >  static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  {
> >  	int cpu;
> > +	int first_stalled_cpu = -1;
> >  	unsigned long flags;
> >  	unsigned long gpa;
> >  	unsigned long j;
> > @@ -660,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  			for_each_leaf_node_possible_cpu(rnp, cpu)
> >  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
> >  					print_cpu_stall_info(cpu);
> > +					if (first_stalled_cpu < 0)
> > +						first_stalled_cpu = cpu;
> 
> This gets the first stalled CPU.  Maybe that is also what you want for
> the expedited stalls?
> 
> Again, there might not be any stalled CPUs, but only stalled tasks...
> 

Understood. For print_other_cpu_stall() itself, first_stalled_cpu = -1
when only tasks are stalled seems acceptable since exit_cpu < 0 is
already handled gracefully.

Is there a convention I should follow here, or is -1 fine?

> >  					ndetected++;
> >  				}
> >  		}
> > @@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  
> >  	nbcon_cpu_emergency_exit();
> >  
> > -	panic_on_rcu_stall();
> > +	panic_on_rcu_stall(first_stalled_cpu);
> 
> ...in which case panic_on_rcu_stall() gets a -1.  Which might not be what
> the user wants to see.
> 
> >  	rcu_force_quiescent_state();  /* Kick them all. */
> >  }
> > @@ -754,7 +757,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  
> >  	nbcon_cpu_emergency_exit();
> >  
> > -	panic_on_rcu_stall();
> > +	panic_on_rcu_stall(smp_processor_id());
> 
> In this case, we do just have the current CPU doing the stall, so this
> does work fine.  (If there are more CPUs and tasks involved, there
> could be additional RCU CPU stall warning messages.)

Good to know, thanks for confirming.

> 
> >  	/*
> >  	 * Attempt to revive the RCU machinery by forcing a context switch.
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 48c65ac8e230..8a0b1662a75a 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5069,6 +5069,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
> >  
> >  /**
> >   * handle_lockup - sched_ext common lockup handler
> > + * @exit_cpu: CPU to record in exit_info; pass the stalled/hung CPU, not current
> >   * @fmt: format string
> >   *
> >   * Called on system stall or lockup condition and initiates abort of sched_ext
> > @@ -5078,7 +5079,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
> >   * resolve the lockup. %false if sched_ext is not enabled or abort was already
> >   * initiated by someone else.
> >   */
> > -static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
> > +static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
> >  {
> >  	struct scx_sched *sch;
> >  	va_list args;
> > @@ -5094,7 +5095,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
> >  	case SCX_ENABLING:
> >  	case SCX_ENABLED:
> >  		va_start(args, fmt);
> > -		ret = scx_verror(sch, fmt, args);
> > +		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
> >  		va_end(args);
> >  		return ret;
> >  	default:
> > @@ -5114,9 +5115,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
> >   * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
> >   * else already initiated abort.
> >   */
> > -bool scx_rcu_cpu_stall(void)
> > +bool scx_rcu_cpu_stall(int stalled_cpu)
> >  {
> > -	return handle_lockup("RCU CPU stall detected!");
> > +	return handle_lockup(stalled_cpu, "RCU CPU stall detected!");
> >  }
> >  
> >  /**
> > @@ -5131,7 +5132,8 @@ bool scx_rcu_cpu_stall(void)
> >   */
> >  void scx_softlockup(u32 dur_s)
> >  {
> > -	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
> > +	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
> > +			   smp_processor_id(), dur_s))
> 
> Repeating "smp_processor_id()" in the argument list seems a bit redundant?

Will save to a local variable in v3.

> 
> >  		return;
> >  
> >  	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
> > @@ -5150,7 +5152,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
> >  {
> >  	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
> >  
> > -	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
> > +	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
> 
> Repeating "cpu" in the argument list seems a bit redundant?
> 

The first occurrence is exit_cpu (struct field), the second is the %d
format argument for the readable message. BOth serve different purposes
so both are needed.

Thanks.

> >  		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
> >  				cpu);
> >  }
> > diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> > index b4f5dd28855e..2d04f27cf7c5 100644
> > --- a/kernel/sched/ext_internal.h
> > +++ b/kernel/sched/ext_internal.h
> > @@ -1486,8 +1486,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
> >  	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
> >  #define scx_error(sch, fmt, args...)						\
> >  	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> > -#define scx_verror(sch, fmt, args)						\
> > -	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
> >  
> >  /*
> >   * Return the rq currently locked from an scx callback, or NULL if no rq is
> > -- 
> > 2.48.1
> > 
> > 

-- 
Cheers,
Cheng-Yang
