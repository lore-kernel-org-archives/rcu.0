Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454351FFC4B;
	Wed,  5 Feb 2025 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792547; cv=none; b=s4yEgY7lnD+nz5gSqkLLjJ7jPqha2YQMRnzodzO1ZlgL7Tq/x2Ifs2+o9TPdVIGoIVQmqAmfbfjvrXJeNO5prVfyCTaFqcUJ0ZtaiwwrGZMsPiroOU+cOh2DxaZod8r2teM1x3r9BaaBDv8Xo4SYbQpoa3d8vc+OQQx8h626iYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792547; c=relaxed/simple;
	bh=yfjw1WVbr3v23A4GuT3d2uGdZhEl7n/fUcuk9hvPcUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZU2EzOdck06V73UfnMD5IU2HDGzjWRocoKXPcYz4PA+hktJbsmoIMZWPO8/903k8Py2w7IaV4Rdyf9FEzrpWQMhb6hJYwcooCFkhPiJCqUO1RPupml9V+yfZ+baBV+h0+oRrl2STJfxtCOnOm4kKe1abPXkLTrn+XEtCvBpOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw0mF2bq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw0mF2bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADA2C4CEE4;
	Wed,  5 Feb 2025 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738792546;
	bh=yfjw1WVbr3v23A4GuT3d2uGdZhEl7n/fUcuk9hvPcUc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qw0mF2bqoIDS28Fu3wDgWhh3oNNDmEWer85N1ATtUDKuubec3PmBcggphMjYpld4f
	 n4B4fFCoNd548AbQLemfltmCTE1f4VqFwkYlsaz+Li/D9bknEZeWfaZkEekKvQUb0u
	 w/+EZOdePIyTXpueNGremUGooxDHbC0kb+s66AEyFEgubT1NL2jtV2cRBZFwEZDpTY
	 Ym8T+y5azt/FdSCmG5Kt0m2GjRDqBco+OVm1Guu/aI3+zF8foaTTZWrRJZe1IMmIX4
	 7N2PWGFgvJEFu//LgYxsbtxXte5YUGPVjDJRbgpDTVOnOuanL4t6IblUVXgDc2HriX
	 IKQh5pbvFCf4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4AB0CCE0749; Wed,  5 Feb 2025 13:55:46 -0800 (PST)
Date: Wed, 5 Feb 2025 13:55:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250130185320.1651910-4-paulmck@kernel.org>
 <20250204102611.OVuHn9rS@linutronix.de>
 <ff2ed5ba-52f4-4e82-ac0c-6e6a7013d86e@paulmck-laptop>
 <20250204163409.ueObHFje@linutronix.de>
 <9ed4e0fd-75c4-400a-9a0b-74c68286bad3@paulmck-laptop>
 <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ed0c1401.fsf@jogness.linutronix.de>

On Wed, Feb 05, 2025 at 10:28:06PM +0106, John Ogness wrote:
> On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> Would it make sense to put a call to pr_flush() at the beginning of the
> >> kernel_power_off() function?  I suspect that would take care of much
> >> more than just rcutorture.
> >> 
> >> Or maybe after the pr_emerg("Power down\n"), since that is normally
> >> the last thing that shows up on rcutorture's console logs.
> 
> Yes, after the pr_emerg("Power down\n"), as in your patch below.
> 
> > And that does the trick!  I specified 500ms, but maybe -1 would be
> > better?  You tell me!  ;-)
> 
> I probably would have chosen 1000ms, but if the kthread has made no
> forward progress after a few max timeslices, it probably is dead or will
> not be scheduled anyway.

I picked 500ms randomly, so I am happy to make it be 1000ms.

> If there is no backlog, pr_flush() returns immediately.

OK, so I don't need to add "if (IS_ENABLED(CONFIG_PREEMPT_RT))" to guard
it, then?

> I recommend _not_ using timeout_ms=-1 here, in case the kthread cannot
> be scheduled (for whatever reason).

Sounds eminently reasonable to me!

> > ------------------------------------------------------------------------
> >
> > commit 172b692a79ec5801eab57cb55d2f9c398f244c62
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Feb 5 12:27:23 2025 -0800
> >
> >     printk: Flush console log from kernel_power_off()
> >     
> >     Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
> >     and shutdown time, which hides shutdown-time RCU issues from rcutorture.
> >     Therefore, make pr_flush() public and invoke it after then last print
> >     in kernel_power_off().
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Petr Mladek <pmladek@suse.com>
> >     Cc: Steven Rostedt <rostedt@goodmis.org>
> >     Cc: John Ogness <john.ogness@linutronix.de>
> >     Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 4217a9f412b2..b3e88ff1ecc3 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -806,4 +806,6 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
> >  #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
> >  	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
> >  
> > +
> > +bool pr_flush(int timeout_ms, bool reset_on_progress);
> 
> This will fail to link for !CONFIG_PRINTK.
> 
> In kernel/printk/printk.c currently there is:
> 
> #ifdef CONFIG_PRINTK
> static bool pr_flush(int timeout_ms, bool reset_on_progress);
> #else
> static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
> #endif
> 
> This would need to move to include/linux/printk.h
> 
> There you will find an existing CONFIG_PRINTK if/else block to move
> those to.

Thank you, will do!

> >  #endif
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 80910bc3470c..e0c6e5a99897 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2461,7 +2461,7 @@ asmlinkage __visible int _printk(const char *fmt, ...)
> >  }
> >  EXPORT_SYMBOL(_printk);
> >  
> > -static bool pr_flush(int timeout_ms, bool reset_on_progress);
> > +bool pr_flush(int timeout_ms, bool reset_on_progress);
> >  static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
> >  
> >  #else /* CONFIG_PRINTK */
> > @@ -4466,7 +4466,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >   * Context: Process context. May sleep while acquiring console lock.
> >   * Return: true if all usable printers are caught up.
> >   */
> > -static bool pr_flush(int timeout_ms, bool reset_on_progress)
> > +bool pr_flush(int timeout_ms, bool reset_on_progress)
> >  {
> >  	return __pr_flush(NULL, timeout_ms, reset_on_progress);
> >  }
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index a701000bab34..3448e6ae3556 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -704,6 +704,7 @@ void kernel_power_off(void)
> >  	migrate_to_reboot_cpu();
> >  	syscore_shutdown();
> >  	pr_emerg("Power down\n");
> > +	pr_flush(500, 1);
> 
> I would have chosen:
> 
> 	pr_flush(1000, true);
> 
> but I really don't have an argument either way.

Hey, of the two of us, you are the printk() expert, so I will make it
be 1000.  ;-)

							Thanx, Paul

> >  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
> >  	machine_power_off();
> >  }
> 
> John Ogness
