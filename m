Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE30235342;
	Thu,  6 Feb 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859558; cv=none; b=VOOBfXmDofVSN9M6UbX1uvBJ3MpIgGuC/6FCE09QOPfIm5W2IVhHEDh/DicmWu/QWzXrvwAxQDHFsnJjPv5MIcQJDX5gav2i4gvdFyu54g/EutAzEvRhTPf4hxaUD0g5rFJ1d4B1gQE2sZqyy3B+CHHF6IlECPo90Y2mdBQBpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859558; c=relaxed/simple;
	bh=1WPhQojRQB6CLXyDW6586XaRgnWAu9mr00msx/RSff0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEIOP4Dh9sLzs9CzaIZgrUebN+M+u1sWXss7P+gTqRrXgU5fMhFeeBt9GzC46JyqmVPL8lj3ML4nzTy2QvBOrvidrffM6pcrMPABY5ZY7ca2rmMRUk5WmIGzrR+z2k2kQsw01BftyAuoJIMTu06sA1dL/jY2+VKOEdGgcppZ/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8zzMOwM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8zzMOwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D299C4CEDD;
	Thu,  6 Feb 2025 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738859558;
	bh=1WPhQojRQB6CLXyDW6586XaRgnWAu9mr00msx/RSff0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B8zzMOwMR5AjXM+YO6P86j6EWDMZBEEs7Pl0EPJD1m9cYH3xfIsg0Y3nvQKcR1v0S
	 VgshrfO+CJmfDidqhDxa1JJUEID70mMdiFfaaEOy2+TJWRrodYx9FDM7WeanByBry7
	 3yMWWN/wv5rOLMsPFc+HMwT8boKTtNTwwNwlT311Javqr/e/Lhk4C+3xj71/EMl7Ao
	 wJcQdkKBdppuRLvyK/pG6LMH1MM3BMBilUXEnj8GZLwlEbIhSAlt3JJj7yHIilbOk8
	 XIKAWS8hm/t3hWiDmZUwOpZ7uK8/MfBANJA/70ledrjSaew0FyOLcyBoeHWTZUt5XX
	 IxbCVkMFrnymQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C46B7CE03FB; Thu,  6 Feb 2025 08:32:37 -0800 (PST)
Date: Thu, 6 Feb 2025 08:32:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
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
Message-ID: <e852c4fc-7446-46d4-882e-aa20bc235c42@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
 <Z6SXoLnUw6D0xEqh@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6SXoLnUw6D0xEqh@pathway.suse.cz>

On Thu, Feb 06, 2025 at 12:06:08PM +0100, Petr Mladek wrote:
> On Wed 2025-02-05 15:50:14, Paul E. McKenney wrote:
> > On Wed, Feb 05, 2025 at 11:37:25PM +0106, John Ogness wrote:
> > > On 2025-02-05, John Ogness <john.ogness@linutronix.de> wrote:
> > > >> OK, so I don't need to add "if (IS_ENABLED(CONFIG_PREEMPT_RT))" to guard
> > > >> it, then?
> > > >
> > > > For !CONFIG_PREEMPT_RT, if there are legacy consoles registered,
> > > > pr_flush() will additionally perform a blocking lock on the
> > > > console_lock.
> > > 
> > > Sorry, I was just thinking about the flushing component of
> > > pr_flush(). Later in the function it takes the console_lock even for
> > > CONFIG_PREEMPT_RT. So please do _not_ have a guard.

Thank you all for looking this over!

> It should be possible to avoid this console_lock() when only NBCON
> consoles are registered. We take it in pr_flush() for reading con->seq
> and potential race with register_console(). But it can be handled
> another way, for example, by restarting the cycle when non-NBCON
> console suddenly appears.
> 
> But it might be done later. We do not have NBCON consoles at the
> moment so the console_lock() is needed anyway.

Fair enough.

> > > pr_flush() should never hang on the console_lock during shutdown, but if
> > > does, that is something that will need to be debugged and fixed.
> > > 
> > > @pmladek: Looking forward to reading your input on this.
> 
> My only concern is that kernel_power_off() is called in many
> code paths so it is not easy to review all scenarios.
> 
> But I haven't found any code path where it would be an obvious problem.
> Especially, it seems that it is _not_ called in panic situations.
> 
> Also kernel_power_off() calls syscore_shutdown() which takes
> syscore_ops_lock mutex. So that is must be called only in
> a schedulable context even before this patch.
> 
> Summary: I do not see any obvious problem in the end.
> 	 Except, for some small details, see below.

The presence of that syscore_shutdown() call greatly reduced my level
of anxiety as well.  ;-)

> > Here is an updated commit, hopefully applying your feedback correctly.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 35679c18b062368855e183ee6712ca5c16145d8c
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
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
> >  extern bool nbcon_device_try_acquire(struct console *con);
> >  extern void nbcon_device_release(struct console *con);
> >  void nbcon_atomic_flush_unsafe(void);
> > +bool pr_flush(int timeout_ms, bool reset_on_progress);
> >  #else
> >  static inline __printf(1, 0)
> >  int vprintk(const char *s, va_list args)
> > @@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
> >  {
> >  }
> >  
> > +static bool pr_flush(int timeout_ms, bool reset_on_progress)
> 
> There is missing "inline":
> 
> static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
> 
> 
> Otherwise, I get
> 
> In file included from ./include/asm-generic/bug.h:22,
>                  from ./arch/x86/include/asm/bug.h:99,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/page-flags.h:10,
>                  from kernel/bounds.c:10:
> ./include/linux/printk.h:319:13: warning: ‘pr_flush’ defined but not used [-Wunused-function]

Fixed, thank you both!

> > +{
> > +	return true;
> > +}
> > +
> >  #endif
> >  
> >  bool this_cpu_in_panic(void);
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -704,6 +704,7 @@ void kernel_power_off(void)
> >  	migrate_to_reboot_cpu();
> >  	syscore_shutdown();
> >  	pr_emerg("Power down\n");
> > +	pr_flush(1000, 1);
> 
> This should be pr_flush(1000, true) as suggested by Sebastian.

Also fixed, also thank you both!

> >  	kmsg_dump(KMSG_DUMP_SHUTDOWN);
> >  	machine_power_off();
> >  }
> 
> With the two changes:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Paul, I assume that you will pass this via the RCU tree together with
> the other changes. Or would you prefer to route this particular
> change via printk tree? Both ways are fine to me.

One advantage of carrying it via RCU is that I can arrange things so that
rcutorture users don't see this problem.  So unless a problem arises,
thank you, and I do plan to send this up via RCU.

							Thanx, Paul
