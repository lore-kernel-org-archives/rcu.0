Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B029B200;
	Sat, 21 Mar 2026 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774067236; cv=none; b=PC4xOcnG3y4s8Gmamj37yIbjLDgaNETJlIhVRUK88/TWvaaVLV88zzf4owiHrGtR2ODJBGhbiiEesEklij9PR+L9YPJ0Rq5Hepm+BADpuvvVLt3qEWMilPdJqg4FYK+uO1ZGxpregaZOXMTkdhkcLYcv93txTZKY/k0NlFmU+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774067236; c=relaxed/simple;
	bh=d+ffbJH4KZHoNpOYOZuBseV1dxeLfrSzxgv68B6imFo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OOlYmw4c6cLFlzaO5eBVuKzeWvf+7XYa1Om84nQMZwYIktffpGkaDzeYnEZI9xzW9KEsZlc1k8s+QxVJRialOEwrLpvQB3my+ipCVZ+CMEPbWn9+mY7pdrOV/Y7w/u+2YD8AxchqjJrgk6+fE4iiuaMCDOQuMJfWMSXMmWHebro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=li42/erX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="li42/erX"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774067231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+PYCd2sFciXK62osWXLMtHZ9ZoH0cGrwp3zWzciAXQ=;
	b=li42/erXCbIKumZrmvgFOovVOP6nroVjPyjsaFXyS+DEeXHzj9eewMC4rcx2xsI/L6SVSG
	4adjL6s6vF3VBdcb6zXkh7btGAIGUdYD7rza+eQJ4V5v71CmYunoewPZIp35/Vxmhag2Zi
	isxzOtNjr/9xWsOtz1LaBLuPAzjnW4I=
Date: Sat, 21 Mar 2026 04:27:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start
 process_srcu()
To: "Boqun Feng" <boqun@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, frederic@kernel.org, neeraj.iitr10@gmail.com,
 urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, "Tejun Heo"
 <tj@kernel.org>, bpf@vger.kernel.org, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Boqun Feng" <boqun@kernel.org>,
 "Andrea Righi" <arighi@nvidia.com>
In-Reply-To: <20260320181400.15909-1-boqun@kernel.org>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in term=
s
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument ca=
n
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
>=20
>=20[boqun: Apply Joel's feedback]
>=20
>=20Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms=
 of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@=
nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
> @Zqiang, I put your name as Suggested-by because you proposed the same
> idea, let me know if you rather not have it.

Thanks Boqun add me to Suggested-by :) .

>=20
>=20@Joel, I did two updates (including your test feedback, other one is
> call irq_work_sync() when we clean the srcu_struct), please give it a
> try.
>=20
>=20 include/linux/srcutree.h | 1 +
>  kernel/rcu/srcutree.c | 29 +++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index dfb31d11ff05..be76fa4fc170 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -95,6 +95,7 @@ struct srcu_usage {
>  unsigned long reschedule_jiffies;
>  unsigned long reschedule_count;
>  struct delayed_work work;
> + struct irq_work irq_work;
>  struct srcu_struct *srcu_ssp;
>  };
>=20=20
>=20diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2328827f8775..73aef361a524 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -19,6 +19,7 @@
>  #include <linux/mutex.h>
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
> +#include <linux/irq_work.h>
>  #include <linux/rcupdate_wait.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
> @@ -75,6 +76,7 @@ static bool __read_mostly srcu_init_done;
>  static void srcu_invoke_callbacks(struct work_struct *work);
>  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long del=
ay);
>  static void process_srcu(struct work_struct *work);
> +static void srcu_irq_work(struct irq_work *work);
>  static void srcu_delay_timer(struct timer_list *t);
>=20=20
>=20 /*
> @@ -216,6 +218,7 @@ static int init_srcu_struct_fields(struct srcu_stru=
ct *ssp, bool is_static)
>  mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
>  atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
>  INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> + init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
>  ssp->srcu_sup->sda_is_static =3D is_static;
>  if (!is_static) {
>  ssp->sda =3D alloc_percpu(struct srcu_data);
> @@ -713,6 +716,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  return; /* Just leak it! */
>  if (WARN_ON(srcu_readers_active(ssp)))
>  return; /* Just leak it! */
> + /* Wait for irq_work to finish first as it may queue a new work. */
> + irq_work_sync(&sup->irq_work);
>  flush_delayed_work(&sup->work);
>  for_each_possible_cpu(cpu) {
>  struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> @@ -1118,9 +1123,13 @@ static void srcu_funnel_gp_start(struct srcu_str=
uct *ssp, struct srcu_data *sdp,


The following should also be replaced, although under normal situation,
we wouldn't go here:

if (snp =3D=3D snp_leaf && snp_seq !=3D s) {
      srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
      return;
}

Thanks
Zqiang




>  // it isn't. And it does not have to be. After all, it
>  // can only be executed during early boot when there is only
>  // the one boot CPU running with interrupts still disabled.
> + //
> + // Use an irq_work here to avoid acquiring runqueue lock with
> + // srcu rcu_node::lock held. BPF instrument could introduce the
> + // opposite dependency, hence we need to break the possible
> + // locking dependency here.
>  if (likely(srcu_init_done))
> - queue_delayed_work(rcu_gp_wq, &sup->work,
> - !!srcu_get_delay(ssp));
> + irq_work_queue(&sup->irq_work);
>  else if (list_empty(&sup->work.work.entry))
>  list_add(&sup->work.work.entry, &srcu_boot_list);
>  }
> @@ -1979,6 +1988,22 @@ static void process_srcu(struct work_struct *wor=
k)
>  srcu_reschedule(ssp, curdelay);
>  }
>=20=20
>=20+static void srcu_irq_work(struct irq_work *work)
> +{
> + struct srcu_struct *ssp;
> + struct srcu_usage *sup;
> + unsigned long delay;
> +
> + sup =3D container_of(work, struct srcu_usage, irq_work);
> + ssp =3D sup->srcu_ssp;
> +
> + raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
> + delay =3D srcu_get_delay(ssp);
> + raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
> +
> + queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
> +}
> +
>  void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
>  unsigned long *gp_seq)
>  {
> --=20
>=202.50.1 (Apple Git-155)
>
