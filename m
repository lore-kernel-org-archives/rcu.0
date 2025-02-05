Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B821504A;
	Wed,  5 Feb 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786254; cv=none; b=f9gh4RNffLmC+Z+L0fVCm1A9QPBcnyNUDzFDLeYUpKJgDSf2re85Xb1AdOWBnjJ0m4PNP7mjgjPIPhyLxM34mV/pbOQyzePh2aYk2Qt3FzPH8RZMC6j9R+E0J9dfFPyFVYe9y4FHa7hdVH1Zasf5iW4sbkTt9QvM4HzHrdAR41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786254; c=relaxed/simple;
	bh=AltkV5SpHD5RUI0aKQ9BmOwJVz1uB4LMWX8efj3lETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i545t0E2y2xaIGMK1HVqYFEcX5UwkbDkQ8oETvIVryFRzeJuM0JeT6yvpFb0tlqiN4NQ2uCty5LGxx7Tau+xSUvLit49IhpLUiqg1hRHc2kqZ3daHsIIxsoAMLAmRTqUPDftd92S3+nXi+sTn3VkI4Md9n9UrcOvRmQLnm4szDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JToYd4hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JToYd4hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4347C4CED1;
	Wed,  5 Feb 2025 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738786253;
	bh=AltkV5SpHD5RUI0aKQ9BmOwJVz1uB4LMWX8efj3lETg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JToYd4hwk98TqDXKrO3uUvDKMPgU/GVkGLR+O6oyOXu/LL9YG+jWoJnLmU8AkLDMd
	 b3bGFR+74JBR3dNID0d2mec/UqdjdGhXZcInrnpqRSOL7plUONdduOTiDFkX+nqgQ4
	 kvlJv3UtcjLRmjipzjYtCyTgQyas/CZZwVL1VqE0fbiaKDBGoWekh8RVHD4Ihv4RWr
	 OJTUeRg+9HG8DpZNLo64lM3FSLS/jwVoV5MQVSNmyeKHuUNm5ATkfe0i1kwgBvqlz5
	 Xp/70ksp+sOsOptPh3cCCXXfGQ4SwYoj4ZF1Qh24eLURstUCzUYCfqM23dhWHsuBHN
	 ceteTYYsD0lBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42991CE0749; Wed,  5 Feb 2025 12:10:53 -0800 (PST)
Date: Wed, 5 Feb 2025 12:10:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
 <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84pljwi2w0.fsf@jogness.linutronix.de>

On Wed, Feb 05, 2025 at 09:00:07PM +0106, John Ogness wrote:
> On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> This is caused by RCU falling behind a callback-flooding kthread that
> >> invokes call_rcu() in a semi-tight loop.  Setting rcutree.kthread_prio=40
> >> avoids the splat, but still gets the shutdown-time hang.  Retrying with
> >> the default rcutree.kthread_prio=2 failed to reproduce the splat, but
> >> it did reproduce the shutdown-time hang.
> >> 
> >> OK, maybe printk buffers are not being flushed?  A 100-millisecond sleep
> >> at the end of of rcu_torture_cleanup() got all of rcutorture's output
> >> flushed, but lost the subsequent shutdown-time console traffic.  The
> >> pr_flush(HZ/10,1) seems more sensible, but this is private to printk().
> >>
> >> I would like to log the shutdown-time console traffic because RCU can
> >> sometimes break things on that path.
> 
> pr_flush() was changed to private because there were no users. It would
> not be a problem to make it available. Adding a pr_flush() to
> rcu_torture_cleanup() would be an appropriate workaround for now (more
> on this at the end).

Ah, got it.

> > There is a call to kmsg_dump(KMSG_DUMP_SHUTDOWN) in kernel_power_off()
> > that appears to be intended to dump out the printk() buffers,
> 
> It only dumps the buffers to the registered kmsg_dumpers. It is not
> responsible for flushing console backlogs.

That would explain its not doing much for me.  ;-)

> > but it
> > does not seem to do so in kernels built with CONFIG_PREEMPT_RT=y.
> > Does there need to be a pr_flush() call prior to the call to
> > migrate_to_reboot_cpu()?  Or maybe even to do_kernel_power_off_prepare()
> > or kernel_shutdown_prepare()?
> 
> With CONFIG_PREEMPT_RT=y, legacy consoles only print via a dedicated
> kthread. Without a pr_flush() somewhere, there is basically no chance
> that they will get backlogs flushed because noone is waitig for them.
> 
> The new console API (NBCON) provides support for "atomic consoles",
> which _do_ flush by transitioning to synchronous printing during
> shutdown/reboot. Unfortunately we still don't have any NBCON atomic
> console implemented in the kernel. The 8250 UART will be our first
> driver, most likely available in 6.15. (With the current PREEMPT_RT
> patch applied, the 8250 NBCON atomic driver is used.)
> 
> Since only CONFIG_PREEMPT_RT=y has this issue, I am not sure if we want
> to sprinkle pr_flush() calls on all sleepable shutdown/reboot paths,
> although that is certainly one way to handle it. For your case, adding a
> pr_flush() to rcu_torture_cleanup() and making pr_flush() non-private
> would be an easy solution to avoid your problem.

Would it make sense to put a call to pr_flush() at the beginning of the
kernel_power_off() function?  I suspect that would take care of much
more than just rcutorture.

Or maybe after the pr_emerg("Power down\n"), since that is normally
the last thing that shows up on rcutorture's console logs.

I will give that a shot and see what happens.  ;-)

							Thanx, Paul
