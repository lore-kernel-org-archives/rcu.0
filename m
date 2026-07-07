Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78C435AAC;
	Tue,  7 Jul 2026 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442694; cv=none; b=atEsyWYfrTzXr0Dtdoq/rcOOduQXpTzO0AlvzN5gIjNRMZgktvFvXYXfBDBp2SSGojkD449QyhF67lNjMbOh1GodfZi4eOJ4/MpEPGevv4P81zEiksr/zJ+COkv6EARo/e+YuakGVYnfAkIfQZWm/PMKrhbwT/t5+InNmMxVZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442694; c=relaxed/simple;
	bh=Zpc2NjAFQfRM8mKHAICrEvP1x0Aq7CI442kvAYaI3F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHGjyUG1Zl/ubthY7jl/i/FXTJBJi6qDfS+j3LAfk6yp6Lr0HEk1dKlt7BfSo9yj6vACc0Ib6O4PPFs2NKEXnQpwGKAQJ7qkqFY99MbDRPCCQq/akxo2T0aUmTOtMe5dTzEqRdnAUWHCZIxBACZhjKEwkyuEANMgSXfsYJbGTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjGjp9xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjGjp9xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512491F000E9;
	Tue,  7 Jul 2026 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783442693;
	bh=sQxP1Rnu0X9W5x3IPwcoVzOT/cY+XMBeuCMd41HjWrk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KjGjp9xcVfjbZSyRrRkikCEjwyA7xwMfN3DyFzM/XxZFaeTIJf5PGzRZKbjOJjyPR
	 29leU2w1z79LaygmYTs5ToIKoJHHoOhb2MaxzjclHi1/VeRCZLF/GL11Av+Bd1VRGk
	 wobj+F9vMiWoFzzRrl6iAvKSJzFZxeAqmX8dwSJ+R9JLbElWOJsWXAMwNsH/r2fD1L
	 0OFuhW8mK1C4h6T7yYJ82HfLiOwBQV88TUAU7fExTuAv8BaqpDNn27YZSwsNqa7zK1
	 m3oGd7AVPXCwsb2fpUlL0hOD3ayT10LDaZXV0zpzDEwGocDIiDHEUoqRr6kJslvV84
	 YJls7c3btf4/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 21780CE0AD3; Tue,  7 Jul 2026 09:44:53 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:44:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Use __set_current_state() set task state in
 rcu_nocb_toggle()
Message-ID: <a733c594-e856-4abb-9c27-95141413579a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260702101125.14100-1-qiang.zhang@linux.dev>
 <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
 <490e998c483920e9e7bd796b00a337bcd11aa129@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490e998c483920e9e7bd796b00a337bcd11aa129@linux.dev>

On Tue, Jul 07, 2026 at 01:15:10PM +0000, Zqiang wrote:
> > 
> > On Thu, Jul 02, 2026 at 06:11:25PM +0800, Zqiang wrote:
> > 
> > > 
> > > In the rcu_nocb_toggle(), the schedule_hrtimeout() is called after the
> > >  state assignment with no condition check. the release-acquire pair from
> > >  raw_spin_unlock/lock(&cpu_base->lock), guarantee that task->__state is
> > >  visible to the hrtimer callback:
> > >  
> > >  CPU0 CPU1
> > >  __set_current_state(TASK_INTERRUPTIBLE)
> > >  ->WRITE_ONCE(task->__state, TASK_INTERRUPTIBLE)
> > >  schedule_hrtimeout
> > >  ->hrtimer_sleeper_start_expires()
> > >  ->raw_spin_lock_irqsave(&cpu_base->lock)
> > >  ....
> > >  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> > >  
> > >  hard-irq:
> > >  raw_spin_lock_irqsave(&cpu_base->lock)
> > >  __hrtimer_run_queues
> > >  ->__run_hrtimer
> > >  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> > >  ->fn(timer)
> > >  ->hrtimer_wakeup
> > >  ->wake_up_process
> > >  ->try_to_wake_up
> > >  ->READ task->__state
> > >  
> > >  This commit therefore use the __set_current_state() to replace the
> > >  set_current_state() in rcu_nocb_toggle().
> > >  
> > >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > > 
> > This looks correct, and either drops an smp_mb() or converts an
> > xchg() to a WRITE_ONCE(), which does decrease overhead. Except that
> > rcu_nocb_toggle() is invoked very infrequently and has high overhead
> > that I would expect to lose this overhead decrease in the noise. And it
> > forces those reading the code to go figure out what is different between
> > set_current_state() and __set_current_state().
> > 
> > So I am not convinced to take this patch. But am I missing something here?
> 
> Nothing was missed, only from memory ordering perspective,
> using set_current_state() is unnecessary. 
> furthermore, in RCU tasks, we used the following code:
> 
> __set_current_state(TASK_IDLE);  // in this we use __set_current_state()
> schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MODE_REL_HARD);
> 
> Or perhaps we could also add a comment something like this(kernel/time/sleep_timeout.c):
> 
> /*
>  * __set_current_state() can be used in schedule_timeout_*() functions, because
>  * schedule_timeout() calls schedule() unconditionally.
>  */

Would it make sense for a variant of schedule_hrtimeout_range() to take an
TASK_* argument and then use __set_current_state() internally?  That would
get you the performance increase across all calls, but avoid bothering
the typical user with the difference between __set_current_state() vs.
set_current_state().

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> > 
> >  Thanx, Paul
> > 
> > > 
> > > ---
> > >  kernel/rcu/rcutorture.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >  
> > >  diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > >  index b1bab59efde5..a0e6901e0f90 100644
> > >  --- a/kernel/rcu/rcutorture.c
> > >  +++ b/kernel/rcu/rcutorture.c
> > >  @@ -2947,7 +2947,7 @@ static int rcu_nocb_toggle(void *arg)
> > >  atomic_long_inc(&n_nocb_deoffload);
> > >  }
> > >  toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
> > >  - set_current_state(TASK_INTERRUPTIBLE);
> > >  + __set_current_state(TASK_INTERRUPTIBLE);
> > >  schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
> > >  if (stutter_wait("rcu_nocb_toggle"))
> > >  sched_set_normal(current, oldnice);
> > >  -- 
> > >  2.17.1
> > >
> >
