Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCE2F12CE
	for <rcu@vger.kernel.org>; Tue,  7 Jul 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430126; cv=none; b=YD4Tf+bV3GwSGZWkjW//2sT67pssV0CnLTtvaEzGGhTIZM8c6WRwd8VjHF9WULmnJHlqLil+fAtGxXQHy3f78j0K56MwlEzmLmXXerl0cvpejxfy2eTqx6yNBTzP76tR1NmFIZ9ZpPKbMzXrwGUi9AgkM+4ft6sadYkMLhqNg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430126; c=relaxed/simple;
	bh=7LqoTVjKkBvB5eAM5l9gsj9nJs3/BOcPMIWESHdQ8zM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bMSYNO0lyftZe7s0mKrHqo7rk6OjGZbE8zWpLs4oRtPunvWYdoT+tnKIrZNttvaZq9269XHplDenDfmtLOfqivD/eVv+9DfVePTD9NWUSbD+KyKC9lNVqU8WqK7fo5nAvl3OXpv86zj5Xv57XI++yJGu3Lv+Ie2f48QVP5GZa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5JDY9JR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5JDY9JR"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783430113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTozMCXXMxtwyWztgvatnq1ldnZjC9XpykYYmsplnZY=;
	b=b5JDY9JRuu+zrzwJZw/MRNONjIDl24BH1g0u6cio6ryaf6e8lXC7pkfSDAvb2kIQaw2S/x
	JdThS5fei8OJtlVkCpZLkmEOH8fYa6hQPAkosDWcgOoSNim3QgkdTqW/MfkAHUoLLHpdbR
	DUWou9sH6rafMNlOjr8AhpQwCIE4hFA=
Date: Tue, 07 Jul 2026 13:15:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <490e998c483920e9e7bd796b00a337bcd11aa129@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcutorture: Use __set_current_state() set task state in
 rcu_nocb_toggle()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
References: <20260702101125.14100-1-qiang.zhang@linux.dev>
 <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Thu, Jul 02, 2026 at 06:11:25PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> In the rcu_nocb_toggle(), the schedule_hrtimeout() is called after =
the
> >  state assignment with no condition check. the release-acquire pair f=
rom
> >  raw_spin_unlock/lock(&cpu_base->lock), guarantee that task->__state =
is
> >  visible to the hrtimer callback:
> >=20=20
>=20>  CPU0 CPU1
> >  __set_current_state(TASK_INTERRUPTIBLE)
> >  ->WRITE_ONCE(task->__state, TASK_INTERRUPTIBLE)
> >  schedule_hrtimeout
> >  ->hrtimer_sleeper_start_expires()
> >  ->raw_spin_lock_irqsave(&cpu_base->lock)
> >  ....
> >  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> >=20=20
>=20>  hard-irq:
> >  raw_spin_lock_irqsave(&cpu_base->lock)
> >  __hrtimer_run_queues
> >  ->__run_hrtimer
> >  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
> >  ->fn(timer)
> >  ->hrtimer_wakeup
> >  ->wake_up_process
> >  ->try_to_wake_up
> >  ->READ task->__state
> >=20=20
>=20>  This commit therefore use the __set_current_state() to replace the
> >  set_current_state() in rcu_nocb_toggle().
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20This looks correct, and either drops an smp_mb() or converts an
> xchg() to a WRITE_ONCE(), which does decrease overhead. Except that
> rcu_nocb_toggle() is invoked very infrequently and has high overhead
> that I would expect to lose this overhead decrease in the noise. And it
> forces those reading the code to go figure out what is different betwee=
n
> set_current_state() and __set_current_state().
>=20
>=20So I am not convinced to take this patch. But am I missing something =
here?

Nothing was missed, only from memory ordering perspective,
using set_current_state() is unnecessary.=20
furthermore,=20in RCU tasks, we used the following code:

__set_current_state(TASK_IDLE);  // in this we use __set_current_state()
schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MODE_REL=
_HARD);

Or perhaps we could also add a comment something like this(kernel/time/sl=
eep_timeout.c):

/*
 * __set_current_state() can be used in schedule_timeout_*() functions, b=
ecause
 * schedule_timeout() calls schedule() unconditionally.
 */


Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/rcutorture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >  index b1bab59efde5..a0e6901e0f90 100644
> >  --- a/kernel/rcu/rcutorture.c
> >  +++ b/kernel/rcu/rcutorture.c
> >  @@ -2947,7 +2947,7 @@ static int rcu_nocb_toggle(void *arg)
> >  atomic_long_inc(&n_nocb_deoffload);
> >  }
> >  toggle_delay =3D torture_random(&rand) % toggle_fuzz + toggle_interv=
al;
> >  - set_current_state(TASK_INTERRUPTIBLE);
> >  + __set_current_state(TASK_INTERRUPTIBLE);
> >  schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
> >  if (stutter_wait("rcu_nocb_toggle"))
> >  sched_set_normal(current, oldnice);
> >  --=20
>=20>  2.17.1
> >
>
