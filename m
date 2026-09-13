Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172B3DDAE1;
	Sun, 13 Sep 2026 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789323526; cv=none; b=XPEDTQldRzSHDPijqdmYxQT1awlf0j5cRnubhJZobWhs1NqfkrvCWyp02Fj07de0DWhiceHjd+36rKZrCy4L0wZQwb6M2Y8si+MVramq/iK1R+e+nldo4+GkBOGeRlvUsYEId1wqdIQcWPLN+GXpXL2mLgdvSu4DyqQwp9DV7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789323526; c=relaxed/simple;
	bh=YPC8trdTfDccnWr812UeR2fW4dyF6K4xeHrQuWqag18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4Yn32crymm47Gj/hMTX0eD5Czx4zkl8sRil4/TFqEM/Z8A/Tlc12zsvCG5X3Du0ioTdOx5PbPJZuvVn6y4UKNQdVTKDBMwa59SXWMZEmyqcQIC75EnKbtKC5NuVenfBXE/5OPoR3qfadpZqcm9fpLDog8x4ELkpTqy/d/WO5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk2rEo1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk2rEo1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A11F000FF;
	Sun, 13 Sep 2026 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789323524;
	bh=a/s0vCLSNtq8PvdwX6UBCprVJ/110i/nuE2VpGd8M10=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Mk2rEo1E6JoWxQb8wjeSe8sX4vk20LzOeqY2X4tX1vvIZGPozjKEaNsk7XyFcI1Ww
	 Ix1HxCtmdxKrWCxbMK+IY0WMf9MKN6IU/vCn1BoyfeW+vt3spegQu5IFGkrIOq6r2F
	 vSNmm8oxbN3I6SE22gK5eJNrBi4sVYeGfpfwLlPtH2hJ1go/Ku3rtkG6VYfmK9t5M5
	 fG/Ua2GRGyGNIokpqUPxe9AXM+u0/ZfFm7DTxdu8IbCs8m0d3XuA8SfY2j2MGFmPzd
	 g0YDB4+Qg4Jlxbw69QMnST1xR6BaIcO2MZZpF7PaTftzXClfiJxNuhsCxiYa9cHE3s
	 Wu9XFDVhffTDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4ADCFCE107B; Sun, 13 Sep 2026 11:18:43 -0700 (PDT)
Date: Sun, 13 Sep 2026 11:18:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Zqiang <qiang.zhang@linux.dev>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to
 synchronize_srcu_atomic()
Message-ID: <31e11dda-2f23-42b1-89a9-98e08f32d539@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
 <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
 <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>
 <32e952728ea1a9c25c2b56de468f43a32104b8a8@linux.dev>
 <CAN_Opa9v-6Kx2tUFkT4YiOVM_tgZuUVOkbwieOrC6WfbNj_=kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa9v-6Kx2tUFkT4YiOVM_tgZuUVOkbwieOrC6WfbNj_=kA@mail.gmail.com>

On Sun, Sep 13, 2026 at 06:36:56PM +0800, KunWu Chan wrote:
> On Sun, Sep 13, 2026 at 2:21 PM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
> > >
> > > >
> > > > On Sat, Sep 12, 2026 at 12:47 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > >  On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> > > >  > Add the lockdep annotation, same-type SRCU nesting warning, and
> > > >  > early-boot check used by __synchronize_srcu().
> > > >  >
> > > >  > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > >  > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > > >
> > > >  Queued for review and testing, thank you both!
> > > >
> > > >  Interestingly enough, it is now the case that there is a grace-period
> > > >  wait that can be placed in a normal RCU read-side critical section.
> > > >  Does this mean that we should also adjust the --do-srcu-lockdep testing
> > > >  in tools/testing/selftests/rcutorture/bin/torture.sh?
> > > >
> > > >  Thanks, Paul. Good point.
> > > >
> > > >  I’ll check the current `--do-srcu-lockdep` coverage, including the
> > > >  case where `synchronize_srcu_atomic()` is called from a normal RCU
> > > >  read-side critical section, and follow up with the necessary torture
> > > >  testing changes.
> > > >
> > > Sounds good!
> > >
> > > Perhaps you and Zqiang can work together on this. Co-developed-by,
> > > for example.
> >
> > Hi, Paul and KunWu
> 
> Hi Zqiang,
> 
> Thanks for pointing out these cases.
> 
> >
> > Should we also consider the following situations ?
> >
> >
> > idx = srcu_read_lock_atomic(srcu)
> >
> > by interrupt run hardirq context:
> >    synchronize_rcu_atomic(srcu)
> >
> > srcu_read_unlock_atomic(srcu, idx)
> 
> For the same-CPU interrupt case, the existing check in
> synchronize_srcu_atomic() already catches it:
> 
>     synchronize_srcu_atomic(ssp)
>       RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
>         "Illegal synchronize_srcu_atomic() in same-type SRCU ...");
> 
> lockdep_is_held() resolves to __lock_is_held() (lockdep.c:5612),
> which checks current->held_locks[]. The interrupt handler runs with
> the same current, so it sees the SRCU dep_map acquired by
> srcu_read_lock_atomic().

I am not sure whether or not it is worth checking in lockdep, but the
general rule is (almost) that if synchronize_rcu_atomic() runs in a given
context, then srcu_read_lock_atomic() must be invoked from a context
that is at least as strict.  So if synchronize_srcu_atomic() is invoked
with interrupts disabled, then all of the SRCU-atomic readers for that
same srcu_struct structure must also be invoked with interrupts disabled.

For the "almost" part, note that preemption-enabled context is
treated the same as is preemption-disabled context because both
synchronize_srcu_atomic() and srcu_read_lock_atomic() disable preemption.

> > or:
> >
> >
> >
> >            CPU0:                                                                  CPU1:
> >
> > idx = srcu_read_lock_atomic(srcu)
> >
> > smp_call_function_single(CPU1, som_func, NULL, 1)
> > to send IPI to CPU1, and sync wait complete.
> >                                                                    hardirq context or ide task context:
> >
> >                                                                           some_func()
> >                                                                           ->synchronize_rcu_atomic(srcu)
> >
> > srcu_read_unlock_atomic(srcu, idx)
> 
> The cross-CPU case is different. current->held_locks[] is part of
> struct task_struct (sched.h:1302), so the existing
> __lock_is_held() check can only see the current task's held locks.
> It cannot see the SRCU read-side lock held by the task running on
> another CPU. The same limitation applies to the
> lock_is_held(&rcu_lock_map) check in synchronize_srcu() at
> srcutree.c:1665.

The rule stated above also prevents this situation.  The problem in
the above scenario is that srcu_read_lock_atomic() was invoked with
interrupts enabled, which means that invoking synchronize_srcu_atomic()
for that same srcu_struct structure from the interrupts-disabled IPI
handler is a usage bug.

> > Add WARN_ON(irqs_disabled()) to synchronize_rcu_atomic() ?
> >
> > Any thoughts?
> 
> WARN_ON(irqs_disabled()) wouldn't help with the cross-CPU case:
> CPU1 could be running in process context with interrupts enabled, so
> the WARN would not trigger. It would also add a false positive for
> legitimate hardirq calls. synchronize_srcu_atomic() omits
> might_sleep() (compare __synchronize_srcu() at srcutree.c:1676)
> because it is designed to work in contexts where sleeping is not
> allowed, including hardirq context.
> 
> Whether a general cross-CPU read-side-hold check is feasible is an
> open question. It would need to account for the read-side state across
> CPUs without adding too much overhead to the SRCU read-side fast path.
> 
> I'm happy to discuss and explore whether there is a reasonable way to
> handle this cross-CPU case.

If lockdep could check for the rule stated above, that would be quite
nice.  ;-)

							Thanx, Paul

> Thanks,
> Kunwu
> 
> >
> > Thanks
> > Zqiang
> >
> >
> > >
> > >  Thanx, Paul
> > >
> > > >
> > > > Thanks,
> > > >  Kunwu
> > > >
> > > >
> > > >  Thanx, Paul
> > > >
> > > >  > ---
> > > >  > kernel/rcu/srcutree.c | 8 ++++++++
> > > >  > 1 file changed, 8 insertions(+)
> > > >  >
> > > >  > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > >  > index 6a9c432a3bd0..6c729e805fb3 100644
> > > >  > --- a/kernel/rcu/srcutree.c
> > > >  > +++ b/kernel/rcu/srcutree.c
> > > >  > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> > > >  > unsigned long rdm0, rdm1;
> > > >  > unsigned long unlocks0, unlocks1;
> > > >  >
> > > >  > + srcu_lock_sync(&ssp->dep_map);
> > > >  > +
> > > >  > + RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > > >  > + "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
> > > >  > +
> > > >  > + if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> > > >  > + return;
> > > >  > +
> > > >  > // Initialize. Either init_srcu_struct() was invoked or
> > > >  > // DEFINE_SRCU() or similar was used. Therefore, no allocation
> > > >  > // will be done here.
> > > >  > --
> > > >  > 2.43.0
> > > >  >
> > > >
> > >
