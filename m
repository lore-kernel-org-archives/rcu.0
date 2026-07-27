Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DB29898B
	for <rcu@vger.kernel.org>; Mon, 27 Jul 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177466; cv=none; b=G2p6qQcISgj47vqp4jJGwZ+nudj4SMmG6o2AuUNDTvmH3UIM1VzxvfS7jvvbTNukUiFHq9Z0+JM06yIWe/e+NskeKu9UOB6hB635hYJAn7R8ttlzx9HDEC1wggv7gpXWBGTXJ2lXWwd24plOMKoY2B6yvFLEhxpg2Tk9XASX1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177466; c=relaxed/simple;
	bh=fapvYc8IoWLzrhT0yWXHWtWcySFEL3tITVFTXNkxhsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIa2yFWqdC7Zg84DRQec6EbE8BTZEpbWxbWCXHO6AV3/lWfn09nOmbgC99ZEg7aCBukFH0hD8BanHo1m4p2NGyiGn2joqAEUrDrjogmJ2m2BEG5CDBjE9JGYD0jZzw38JKDMspcHZmPKIRlrqnup90pN8wgjpBKAoeTWFd8ywvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSPUgEJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSPUgEJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373351F000E9;
	Mon, 27 Jul 2026 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177465;
	bh=770Uy9X5w22d/lQgp29Ci5F7IeBSkHQ49FnmsRGoTRg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ZSPUgEJAOkox1bBbtifm1rpDw/KY6v+/Ivb9x98dF7r7eozHptUsjO8wl1pOSyGPV
	 kW2aLO1uF+GICKx3T2TGcqUstkMmkRjf4kzOW0MFx7HnXNA+o+2Tb0x1Bg/1x0Q1bS
	 sDjvzM6ZFNCKs0G0nJ3bu9mT6Ny6tyKLp4BeNhFxNd7G3WQ1alswHDlqcMMW1R8bGb
	 Qkka1rIVQGKE4tudcLIX8RggR/fFnLmVg6J9yJ+qYeDfMIo211riSthR8f/Uo/LYgj
	 69tZ1JhymDYPxq6U/FjRBSCNOluPluo06l3BjnCAtX6GiMI+qgJ3LKm+lvncQjpgLs
	 su68dQ+ldbP7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F81CCE08BC; Mon, 27 Jul 2026 11:37:45 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:37:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: GROTEPASS Frans - Contractor <Frans.GROTEPASS@nl.thalesgroup.com>
Cc: rcu@vger.kernel.org
Subject: Re: rcu timeouts
Message-ID: <16548bd6-79c3-4a70-b3f3-dec899268e61@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cc0b1ab120d5428794d92f55c932e077@nl.thalesgroup.com>
 <d9fb7819-ad5b-45dd-b6fb-0534f5ca0ef2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9fb7819-ad5b-45dd-b6fb-0534f5ca0ef2@paulmck-laptop>

This time correctly spelling the RCU list...

							Thanx, Paul

On Mon, Jul 27, 2026 at 11:36:59AM -0700, Paul E. McKenney wrote:
> On Mon, Jul 27, 2026 at 11:28:00AM +0000, GROTEPASS Frans - Contractor wrote:
> > Classified as: {OPEN}
> > 
> > Hi Paul,
> > 
> > I watched an interesting talk you gave about the RCU errors. Thanks for providing these insights. We are busy with i.MX8 development and ran into this issue with a kernel version using RT_PREEMPT enabled. With RT_PREEMPT enabled we noticed that rcu_preempt timeouts were generated and there were also kernel messages pointing to the mmc. I assembled the localized logs for you. What we used:
> > 
> > i.MX8sx8x running linux-fslc-6.12.x-fslc
> > 
> > We found a work around not needing the RT_PREEMPT, so the error is not blocking for us anymore, but if you might need extra support with this one, I can collect a sample for you with more logging in my own time.
> 
> Hello, Frans,
> 
> I added rcu@vger.kernel.org on CC in case the other RCU maintainers have
> thoughts or suggestions.
> 
> Starting with serial_run_0012.txt, please note these lines:
> 
> [   77.010227] rcu:     3-...!: (1 GPs behind) idle=ca5c/1/0x4000000000000000 softirq=0/0 fqs=156 rcuc=21000 jiffies(starved)
> [   77.010235] rcu:     (t=21000 jiffies g=12173 q=94 ncpus=4)
> [   77.010240] rcu: rcu_preempt kthread timer wakeup didn't happen for 20351 jiffies! g12173 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x1000
> [   77.010245] rcu:     Possible timer handling issue on cpu=0 timer-softirq=2461
> 
> The "rcuc=21000 jiffies(starved)" indicates that RCU's rcuc kthread
> (which is used in place of RCU_SOFTIRQ in PREEMPT_RT) is not getting
> any CPU time.  Do you have a CPU-bound real-time process that is
> preventing this rcuc kthread from running?
> 
> In addition, RCU relies on its grace-period kthread (in this case named
> "rcu_preempt") being awakened every few jiffies so that it can check
> the state of idle CPUs.  The above lines say that this kthread was not
> awakened, which by itself would cause this CPU stall warning.
> I suggest looking carefully at your PREEMPT_RT timer setup.  Or perhaps
> whatever is preventing the rcuc kthread from running is also preventing
> the timers from running.
> 
> In serial_run_0026.txt, there is this:
> 
> [   75.643219] rcu:     0-....: (1 GPs behind) idle=4044/1/0x4000000000000000 softirq=0/0 fqs=4750 rcuc=21004 jiffies(starved)
> 
> The "rcuc=21004 jiffies(starved)" indicates that RCU's rcuc kthread
> (which is used in place of RCU_SOFTIRQ in PREEMPT_RT) is not getting
> any CPU time.  Which might (or might not) be related to the "mmc2:
> Timeout waiting for hardware interrupt" messages.
> 
> Similar messages appear in serial_run_0112.txt, serial_run_0184.txt,
> and serial_run_0330.txt.
> 
> In serial_run_0116.txt:
> 
> [   68.051976] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:^M
> [   68.051987] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P29/3:b..l^M
> [   68.052001] rcu:     (detected by 2, t=21002 jiffies, g=8581, q=6949 ncpus=4)^M
> [   68.052008] task:ksoftirqd/1     state:R  running task     stack:0     pid:29    tgid:29    ppid:2      flags:0x00000008^M
> [   68.052017] Call trace:^M
> [   68.052019]  __switch_to+0xe8/0x148^M
> [   68.052033]  __schedule+0x2bc/0x874^M
> [   68.052039]  preempt_schedule+0x48/0x60^M
> [   68.052047]  try_to_wake_up+0x128/0x44c^M
> [   68.052054]  wake_up_process+0x18/0x24^M
> [   68.052059]  hrtimer_wakeup+0x20/0x38^M
> [   68.052065]  __hrtimer_run_queues+0x138/0x1fc^M
> [   68.052071]  hrtimer_run_softirq+0x7c/0xdc^M
> [   68.052077]  handle_softirqs.isra.0+0xe8/0x1f0^M
> [   68.052083]  run_ksoftirqd+0x38/0x84^M
> [   68.052089]  smpboot_thread_fn+0x204/0x228^M
> [   68.052096]  kthread+0x110/0x114^M
> [   68.052105]  ret_from_fork+0x10/0x20^M
> 
> This could happen if your workload produced a flood of hrtimers.  Or if
> one of your hrtimer handlers had a longer-than-average loop.
> 
> In serial_run_0121.txt, there are lots of these:
> 
> [   64.721625] tlv320aic32x4 15-0018: ASoC: error at soc_component_read_no_lock on tlv320aic32x4.15-0018 for register: [0x0000005f] -110
> 
> In addition, there is the same message as above:
> 
> [   64.922583] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   64.922593] rcu:     0-....: (1 GPs behind) idle=98d4/1/0x4000000000000000 softirq=0/0 fqs=4374 rcuc=21004 jiffies(starved)
> 
> Again, the "rcuc=21004 jiffies(starved)" indicates that the rcuc kthreads
> are not getting any CPU time.
> 
> I hope that this helps.
> 
> 							Thanx, Paul
> 
> > Best regards,
> > 
> > Frans
> > 
> > 
> > ------------------------------------------------------------------------------------------------------------
> > Disclaimer:
> > 
> > If you are not the intended recipient of this email, please notify the sender and
> > delete it.
> > Any unauthorized copying, disclosure or distribution of this email or its
> > attachment(s) is forbidden.
> > Thales Nederland BV will not accept liability for any damage caused by this email or
> > its attachment(s).
> > Thales Nederland BV is seated in Hengelo and is registered at the Chamber of
> > Commerce under number 06061578.
> > ------------------------------------------------------------------------------------------------------------
> > 
> 
> 
