Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C53D45DE;
	Sat, 17 Oct 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267479; cv=none; b=AEKRNd2IouArc/3iA/WCda3iS9Kr/k8B6TW7X1CvnGi+3aoUtM6jKW3JtrAeyOnoGg22RNMGOBgIqAx8Bg/SZG6AQ6/iP27CoMAZhggTdqZUk8EelJIe7trfAjqPt/fBFF1dhIG8qH0pXvUCh64cgmnju33/YRK1mSgkpv4gddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267479; c=relaxed/simple;
	bh=kPBa35ZIZOSowlDq+1A975XlBQyamFUYeo+hSw/32Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2U2WOpr/I7ekg4pmvC/Ci2atN/vDP5kbZ5MuQQrJyjb8XKnBM0qOG/Wmpp5RXJN3CJtrk144vnUIbXCMpeeuTzNFosNPMKixGfEPY5yBGpfxU8vsDe+t19q9hH5k78uE9WtzUSfzyd6wP4Kd4sQzzGh/tuNF7hF4WL8iU7F7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz05FIP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz05FIP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE161F000C4;
	Sat, 17 Oct 2026 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792267477;
	bh=qRP3vyBEJ2t0noEtwUXg4HTqo/d122GPQHEtZAe2QME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Dz05FIP6+mcrgC02FJSoNhMEK4jXVwA2TQ2rDpSokxtfCTIWFBI7hj/fVObRW5vqT
	 R563kNReF98+aZHOA3RJEPmq27YyrB/GLotirA/Khxn4mUxJX0bH7qkO7NbxCLp7qP
	 4ITDsMjZfHZAbIGKz8zqTfysHvRxa2wkkwX5TDD7FKpgxxesJtXu+cMBQdXW4AuYK3
	 F0x8IQRZ1RxR/VJynOLneCM/DO7DnKxpuOEDHQSxtyPfWSLn0jA9FS7WHGVPusuK2D
	 9WW+83SWpZsTxnaIWybtUY3cIkBihIdTrGfNdBDlWXySRB/NNiUU+2PS5ZjNzS31HA
	 u9Q/RNi923DKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79D5FCE1ADC; Sat, 17 Oct 2026 13:04:37 -0700 (PDT)
Date: Sat, 17 Oct 2026 13:04:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Zqiang <qiang.zhang@linux.dev>, boqun@kernel.org, frederic@kernel.org,
	joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
Message-ID: <82551705-77de-48d3-b310-ba23a5549903@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org>
 <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev>
 <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org>
 <3fc682be-c0ed-48b2-ae91-af80d1535520@paulmck-laptop>
 <0E5D0BB2-BEF1-430A-B30C-C53F4254214F@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E5D0BB2-BEF1-430A-B30C-C53F4254214F@mainlining.org>

On Sat, Oct 17, 2026 at 06:49:41PM +0100, Bradley Morgan wrote:
> On 17 October 2026 18:46:25 BST, "Paul E. McKenney" <paulmck@kernel.org>
> wrote:
> >On Sat, Oct 17, 2026 at 12:16:48PM +0100, Bradley Morgan wrote:
> >> On 17 October 2026 00:41:00 BST, Zqiang <qiang.zhang@linux.dev> wrote:
> >> >> 
> >> >> On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev>
> >wrote:
> >> >> 
> >> >> > 
> >> >> > The RCU Tasks Rude grace period is implemented by invoking the
> >> >> > schedule_on_each_cpu() with an empty work function, which forces
> >> >> > a context switch on every online CPU and guarantees that all
> >> >> > rude-tasks read-side critical sections have completed. However,
> >> >> > schedule_on_each_cpu() can fail (via alloc_percpu() returning
> >> >> > -ENOMEM) and returns immediately, in which case those context
> >> >> > switches never happen, too-short grace period happen.
> >> >> > 
> >> >> > This commit therefore wraps the schedule_on_each_cpu() call in
> >> >> > WARN_ONCE() so that this failure is reported as a "Too-short
> >> >> > grace period" warning.
> >> >> > 
> >> >> NAK, this seems like a edge case, and potentially panicking the
> >system
> >> >> with panic on oops doesn't seem right to me, because we would reserve
> >> >that
> >> >> for when something definitely goes really wrong and we need to notify
> >> >> the user.
> >> >> 
> >> >> I don't believe this patch should go in for this reason, it's a heavy
> >> >edge
> >> >> case, that doesn't *have* nessesarily need to be accounted for.
> >> >
> >> >Indeed, this is a rare event, so I use WARN_ONCE() to mark it, the
> >> >WARN_ONCE()
> >> >not panicking system unless you set warn_on_oops true, this can help us
> >> >troubleshoot
> >> >UAF issues caused by a too short tasks-rude grace period.
> >> >
> >> >or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work) to
> >> >replace
> >> >alloc_percpu(struct work_struct) queue to all online CPUs.
> >> >
> >> >Anyway, Thank you for your reply. I would also like to hear the
> >opinions
> >> >of others.
> >> 
> >> Fair enough, but me and Paul done some discussions:
> >> 
> >> Here is the TL;DR
> >> 
> >> My ^W^Wai slop^W^W tool helped me with this: if the too short grace
> >> happens,
> >> it falls back.
> >> 
> >> 
> >> root@p10-linux-brads:~/linux# git diff kernel/rcu
> >> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >> index 627295396cd9..65bb7d4ed632 100644
> >> --- a/kernel/rcu/tasks.h
> >> +++ b/kernel/rcu/tasks.h
> >> @@ -1344,15 +1344,23 @@ void exit_tasks_rcu_finish(void) { }
> >>  // Ordering is provided by the scheduler's context-switch code.
> >> 
> >>  // Empty function to allow workqueues to force a context switch.
> >> -static void rcu_tasks_be_rude(struct work_struct *work)
> >> +static void __maybe_unused rcu_tasks_be_rude(struct work_struct *work)
> >>  {
> >>  }
> >> 
> >>  // Wait for one rude RCU-tasks grace period.
> >> +static void rcu_tasks_rude_ipi(void *info)
> >> +{
> >> +}
> >> +
> >>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >>  {
> >> +       int cpu;
> >>         rtp->n_ipis += cpumask_weight(cpu_online_mask);
> >> -       schedule_on_each_cpu(rcu_tasks_be_rude);
> >> +       cpus_read_lock();
> >> +       for_each_online_cpu(cpu)
> >> +               smp_call_function_single(cpu, rcu_tasks_rude_ipi, NULL,
> >1);
> >> +       cpus_read_unlock();
> >>  }
> >> 
> >>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
> >func);
> >> root@p10-linux-brads:~/linux#
> >> 
> >> On POWERPC, this passes 12 hours of rcutorture on the RUDE01 config.
> >
> >That is surprising, given that when I run your patch shown above on my
> >x86 laptop, rcutorture reports a too-short grace period within 20 seconds.
> 
> Odd! I definitely ran it for 12 hours, on PowerPC, so this is certainly odd

Those who care are free run it themselves on the systems of their choice.

							Thanx, Paul

> >> If you plan on submitting this into a patch, please add my authorship,
> >or
> >> my c-d-b. 
> >> 
> >> Feel free to rcutorture test it ;d
> >> 
> >> BTW: have you reproduced this on your own system?
> >> 
> >> >
> >> >Thanks
> >> >Zqiang
> >> >
> >> >
> >> >> 
> >> >> Zqiang, have you reproduced this OOM on your own system, if so, could
> >> >you
> >> >> tell me more details, you may turn my frown into a smiley face ;)
> >> >> 
> >> >> > 
> >> >> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >> >> > ---
> >> >> >  kernel/rcu/tasks.h | 3 ++-
> >> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >> > 
> >> >> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >> >> > index fcac7361ec51..91c25717402e 100644
> >> >> > --- a/kernel/rcu/tasks.h
> >> >> > +++ b/kernel/rcu/tasks.h
> >> >> > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct
> >work_struct
> >> >*work)
> >> >> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >> >> >  {
> >> >> >  rtp->n_ipis += cpumask_weight(cpu_online_mask);
> >> >> > - schedule_on_each_cpu(rcu_tasks_be_rude);
> >> >> > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
> >> >> > + "%s: Too-short grace period, OOM is now expected behavior!!!\n",
> >> >rtp->name);
> >> >> > 
> >> >> Good message, makes sense. But I don't think this is right, see
> >above.
> >> >> 
> >> >> > 
> >> >> > }
> >> >> >  
> >> >> >  static void call_rcu_tasks_rude(struct rcu_head *rhp,
> >rcu_callback_t
> >> >> >  func);
> >> >> > 
> >> >> --- Thanks!
> >> >> "I'm not a very positive person" - Linus torvalds
> >> >>
> >> 
> >> --- Thanks!
> >> "I'm not a very positive person" - Linus torvalds
> 
> --- Thanks!
> "I'm not a very positive person" - Linus torvalds
