Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359633CA4B9
	for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239274; cv=none; b=Y5IR1TkImu9UckrALzbXBxGfIHeGttMchE2rGT6njLj8AYlxk2GQHzvdMkmhtP2WyzKMBpzne9cep7wJU0YSDYxjPbdrLTx9GSHsp5cgoG3gXGsnFDTkPs/b1AAt+AFEKb992dq1s4LhZ7C55IVR34VWqr3yGZFhO34Ao+3Sa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239274; c=relaxed/simple;
	bh=O2UYZUCWbDSKof+yS8T8rxW6apZXqTol7muI8jUTw7o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bqCEUKZS3wFrcaT9MGcW+A9cKr7RSXjcYHWUg8C7+IOn8BrCnoQV2Q7aSVQuNSebuPjeUueKQtQM/OpNY10PJrfpnzQ/mXr0IsV5RU5dR03FO05N4aPqAb9H2tGIf+RXIVMXJftt5ZS+nil0oSR5qZJxGzc0z2o+BIyeRee+7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qwPLE0Hk; arc=none smtp.client-ip=91.218.175.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qwPLE0Hk"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O2UYZUCWbDSKof+yS8T8rxW6apZXqTol7muI8jUTw7o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792239269; v=1; x=1792844069;
 b=qwPLE0HknS+1VG8xUQ9TVWSx6f+jQJCQb3cHT4b1g6fwoVD6uKmbjWVM03ahidwrqcdLkpQY
 dy6noGfNhoDdkpMJ6J9loGsCg81+OkfWwZfgD0JT0MQwsciRr3YlWLghf32XU4zMnEbd4Y8/GfO
 LMK6wvMVBVHCYgKJo7s9mhM8=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3a16678bb6dfea46;
	Sat, 17 Oct 2026 12:14:29 +0000
X-Mizu-Trace-ID: 3a16678bb6dfea46
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 12:14:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <aa11c41ba0458bda078c6cdff9e2b155bee1a59b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
To: "Bradley Morgan" <brads@mainlining.org>
Cc: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
In-Reply-To: <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org>
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org>
 <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev>
 <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org>

>=20
>=20On 17 October 2026 00:41:00 BST, Zqiang <qiang.zhang@linux.dev> wrote=
:
>=20
>=20>=20
>=20> >=20
>=20> > On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev> w=
rote:
> > >=20=20
>=20> >  >=20
>=20> >  > The RCU Tasks Rude grace period is implemented by invoking the
> > >  > schedule_on_each_cpu() with an empty work function, which forces
> > >  > a context switch on every online CPU and guarantees that all
> > >  > rude-tasks read-side critical sections have completed. However,
> > >  > schedule_on_each_cpu() can fail (via alloc_percpu() returning
> > >  > -ENOMEM) and returns immediately, in which case those context
> > >  > switches never happen, too-short grace period happen.
> > >  >=20
>=20> >  > This commit therefore wraps the schedule_on_each_cpu() call in
> > >  > WARN_ONCE() so that this failure is reported as a "Too-short
> > >  > grace period" warning.
> > >  >=20
>=20> >  NAK, this seems like a edge case, and potentially panicking the =
system
> > >  with panic on oops doesn't seem right to me, because we would rese=
rve
> > >=20
>=20> that
> >=20
>=20> >=20
>=20> > for when something definitely goes really wrong and we need to no=
tify
> > >  the user.
> > >=20=20
>=20> >  I don't believe this patch should go in for this reason, it's a =
heavy
> > >=20
>=20> edge
> >=20
>=20> >=20
>=20> > case, that doesn't *have* nessesarily need to be accounted for.
> > >=20
>=20> Indeed, this is a rare event, so I use WARN_ONCE() to mark it, the
> > WARN_ONCE()
> > not panicking system unless you set warn_on_oops true, this can help =
us
> > troubleshoot
> > UAF issues caused by a too short tasks-rude grace period.
> >=20
>=20> or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work) t=
o
> > replace
> > alloc_percpu(struct work_struct) queue to all online CPUs.
> >=20
>=20> Anyway, Thank you for your reply. I would also like to hear the opi=
nions
> > of others.
> >=20
>=20Fair enough, but me and Paul done some discussions:
>=20
>=20Here is the TL;DR
>=20
>=20My ^W^Wai slop^W^W tool helped me with this: if the too short grace
> happens,
> it falls back.
>=20
>=20root@p10-linux-brads:~/linux# mailto:root@p10-linux-brads:~/linux#  g=
it diff kernel/rcu
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 627295396cd9..65bb7d4ed632 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1344,15 +1344,23 @@ void exit_tasks_rcu_finish(void) { }
>  // Ordering is provided by the scheduler's context-switch code.
>=20
>=20 // Empty function to allow workqueues to force a context switch.
> -static void rcu_tasks_be_rude(struct work_struct *work)
> +static void __maybe_unused rcu_tasks_be_rude(struct work_struct *work)
>  {
>  }
>=20
>=20 // Wait for one rude RCU-tasks grace period.
> +static void rcu_tasks_rude_ipi(void *info)
> +{
> +}
> +
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> + int cpu;
>  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> - schedule_on_each_cpu(rcu_tasks_be_rude);
> + cpus_read_lock();
> + for_each_online_cpu(cpu)
> + smp_call_function_single(cpu, rcu_tasks_rude_ipi, NULL, 1);
> + cpus_read_unlock();
>  }

RCU Tasks Rude use preempt_disable/enable as the read critical section,
you use smp_call_function_single() to send ipi to each online CPUs,=20
it's=20not forces a context sched switch, and not wait the preempt_disabl=
e/enable
read critical section to exit, this is the wrong mechanism. ;-(

Obviously, we only need to not apply alloc_percpu dynamic allocation:

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcac7361ec51..49b629b0010b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1357,11 +1357,25 @@ static void rcu_tasks_be_rude(struct work_struct =
*work)
 {
 }

+static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
+
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+       int cpu;
+
+       guard(cpus_read_lock)();
        rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
-       schedule_on_each_cpu(rcu_tasks_be_rude);
+
+       for_each_online_cpu(cpu) {
+               struct work_struct *work =3D &per_cpu(tasks_rude_work, cp=
u);
+
+               INIT_WORK(work, rcu_tasks_be_rude);
+               schedule_work_on(cpu, work);
+       }
+
+       for_each_online_cpu(cpu)
+               flush_work(&per_cpu(tasks_rude_work, cpu));
 }

 static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t fun=
c);


Thanks
Zqiang



>=20
>=20 static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t=
 func);
> root@p10-linux-brads:~/linux# mailto:root@p10-linux-brads:~/linux#=20
>=20
> On POWERPC, this passes 12 hours of rcutorture on the RUDE01 config.
>=20
>=20If you plan on submitting this into a patch, please add my authorship=
, or
> my c-d-b.=20
>=20
> Feel free to rcutorture test it ;d
>=20
>=20BTW: have you reproduced this on your own system?
>=20
>=20>=20
>=20> Thanks
> > Zqiang
> >=20
>=20> >=20
>=20> > Zqiang, have you reproduced this OOM on your own system, if so, c=
ould
> > >=20
>=20> you
> >=20
>=20> >=20
>=20> > tell me more details, you may turn my frown into a smiley face ;)
> > >=20=20
>=20> >  >=20
>=20> >  > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > >  > ---
> > >  > kernel/rcu/tasks.h | 3 ++-
> > >  > 1 file changed, 2 insertions(+), 1 deletion(-)
> > >  >=20
>=20> >  > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > >  > index fcac7361ec51..91c25717402e 100644
> > >  > --- a/kernel/rcu/tasks.h
> > >  > +++ b/kernel/rcu/tasks.h
> > >  > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct work_=
struct
> > >=20
>=20> *work)
> >=20
>=20> >=20
>=20> > > static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> > >  > {
> > >  > rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> > >  > - schedule_on_each_cpu(rcu_tasks_be_rude);
> > >  > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
> > >  > + "%s: Too-short grace period, OOM is now expected behavior!!!\n=
",
> > >=20
>=20> rtp->name);
> >=20
>=20> >=20
>=20> > >=20
>=20> >  Good message, makes sense. But I don't think this is right, see =
above.
> > >=20=20
>=20> >  >=20
>=20> >  > }
> > >  >=20
>=20> >  > static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_call=
back_t
> > >  > func);
> > >  >=20
>=20> >  --- Thanks!
> > >  "I'm not a very positive person" - Linus torvalds
> > >
> >=20
>=20--- Thanks!
> "I'm not a very positive person" - Linus torvalds
>
