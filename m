Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CB282F22
	for <rcu@vger.kernel.org>; Thu,  9 Jul 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598733; cv=none; b=ZoHanVQP9olgXC9ZlpE3WtQeyw2FzMGswdEwT+QvjPIftACyi6q2uBfzTX6LBAV5eeunPs4kx3A6Dp5hgfGBVuUsceHD0+bWKBvlbMEFkJk5v9JqrB4lwkFHzLSJO8TS2R0dL1kKlcWT0d6Sfi2v8VlbqfjdAQbKGFRtPIl+4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598733; c=relaxed/simple;
	bh=13VwL2M/pOhzguitruni4ulFisd0HKNLOMEi2/kqjsE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=aO0MuyMAQvE7zJq8OejwoPHxWxQvr8ojhg5pR72S3yyJN8UnBql2bFsuUVzJMOSTvVrBTuB8mbVA/hUC3ZMx5/kU0P5wL+bWmyXGwgsd34zeek1hX9fGdKHdfUZdjcw/650A13H5xVlAPAVMMjH/Z78ti9j9WPAU2J1CqmRmfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMzSOshP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMzSOshP"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783598729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JLxK0wAxMofA3cDWWhRLal1aR5UpvIxEg6JrRKJtMg=;
	b=vMzSOshPcPBxNL5V7lERaKs4J1TMxcDe30e54chmatDkBFkzjyGG+NkJLl9KuOBqwmWUae
	SCYbbcQgx1CCALZavEQ18auqBTrVKFwmPYQ9TKa1rL3hjbYejM/C3GNMUh1TTLBLOcKR0e
	C1IlplSdunKd68uh+y5SrXHfJKfvceM=
Date: Thu, 09 Jul 2026 12:05:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <8ec6e6f111e19bd489fbd5986e4f01dac68a4351@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcutorture: Use __set_current_state() set task state in
 rcu_nocb_toggle()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <a733c594-e856-4abb-9c27-95141413579a@paulmck-laptop>
References: <20260702101125.14100-1-qiang.zhang@linux.dev>
 <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
 <490e998c483920e9e7bd796b00a337bcd11aa129@linux.dev>
 <a733c594-e856-4abb-9c27-95141413579a@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Tue, Jul 07, 2026 at 01:15:10PM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> On Thu, Jul 02, 2026 at 06:11:25PM +0800, Zqiang wrote:
> >=20=20
>=20>  >=20
>=20>  > In the rcu_nocb_toggle(), the schedule_hrtimeout() is called aft=
er the
> >  > state assignment with no condition check. the release-acquire pair=
 from
> >  > raw_spin_unlock/lock(&cpu_base->lock), guarantee that task->__stat=
e is
> >  > visible to the hrtimer callback:
> >  >=20
>=20>  > CPU0 CPU1
> >  > __set_current_state(TASK_INTERRUPTIBLE)
> >  > ->WRITE_ONCE(task->__state, TASK_INTERRUPTIBLE)
> >  > schedule_hrtimeout
> >  > ->hrtimer_sleeper_start_expires()
> >  > ->raw_spin_lock_irqsave(&cpu_base->lock)
> >  > ....
> >  > ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> >  >=20
>=20>  > hard-irq:
> >  > raw_spin_lock_irqsave(&cpu_base->lock)
> >  > __hrtimer_run_queues
> >  > ->__run_hrtimer
> >  > ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> >  > ->fn(timer)
> >  > ->hrtimer_wakeup
> >  > ->wake_up_process
> >  > ->try_to_wake_up
> >  > ->READ task->__state
> >  >=20
>=20>  > This commit therefore use the __set_current_state() to replace t=
he
> >  > set_current_state() in rcu_nocb_toggle().
> >  >=20
>=20>  > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  >=20
>=20>  This looks correct, and either drops an smp_mb() or converts an
> >  xchg() to a WRITE_ONCE(), which does decrease overhead. Except that
> >  rcu_nocb_toggle() is invoked very infrequently and has high overhead
> >  that I would expect to lose this overhead decrease in the noise. And=
 it
> >  forces those reading the code to go figure out what is different bet=
ween
> >  set_current_state() and __set_current_state().
> >=20=20
>=20>  So I am not convinced to take this patch. But am I missing somethi=
ng here?
> >=20=20
>=20>  Nothing was missed, only from memory ordering perspective,
> >  using set_current_state() is unnecessary.=20
>=20>  furthermore, in RCU tasks, we used the following code:
> >=20=20
>=20>  __set_current_state(TASK_IDLE); // in this we use __set_current_st=
ate()
> >  schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MOD=
E_REL_HARD);
> >=20=20
>=20>  Or perhaps we could also add a comment something like this(kernel/=
time/sleep_timeout.c):
> >=20=20
>=20>  /*
> >  * __set_current_state() can be used in schedule_timeout_*() function=
s, because
> >  * schedule_timeout() calls schedule() unconditionally.
> >  */
> >=20
>=20Would it make sense for a variant of schedule_hrtimeout_range() to ta=
ke an
> TASK_* argument and then use __set_current_state() internally? That wou=
ld
> get you the performance increase across all calls, but avoid bothering
> the typical user with the difference between __set_current_state() vs.
> set_current_state().

This is a good idea.

Thanks
Zqiang

>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> Thanks
> >  Zqiang
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  Thanx, Paul
> >=20=20
>=20>  >=20
>=20>  > ---
> >  > kernel/rcu/rcutorture.c | 2 +-
> >  > 1 file changed, 1 insertion(+), 1 deletion(-)
> >  >=20
>=20>  > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >  > index b1bab59efde5..a0e6901e0f90 100644
> >  > --- a/kernel/rcu/rcutorture.c
> >  > +++ b/kernel/rcu/rcutorture.c
> >  > @@ -2947,7 +2947,7 @@ static int rcu_nocb_toggle(void *arg)
> >  > atomic_long_inc(&n_nocb_deoffload);
> >  > }
> >  > toggle_delay =3D torture_random(&rand) % toggle_fuzz + toggle_inte=
rval;
> >  > - set_current_state(TASK_INTERRUPTIBLE);
> >  > + __set_current_state(TASK_INTERRUPTIBLE);
> >  > schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
> >  > if (stutter_wait("rcu_nocb_toggle"))
> >  > sched_set_normal(current, oldnice);
> >  > --=20
>=20>  > 2.17.1
> >  >
> >
>
