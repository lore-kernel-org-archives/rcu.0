Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C69341068
	for <rcu@vger.kernel.org>; Sun, 18 Oct 2026 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291730; cv=none; b=Q5dDtpCSCEga/GOp3NB17emD/azFxCih1NzYy2ik+hjrxwplQJO6ct7qfhho6vTbaEyuUiHiXS757K0XkTn3WmrW4Z0/Btmwo5omftihTW0kWXsnvr1r1crpFE+PGy86umb07tloRLOlpx9ajPCE5Tn8BXPc1iwjeKWhPpi4mKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291730; c=relaxed/simple;
	bh=uq5jlhzj8gzho0xqdOVBria1a7MRHAIccb8VoM1GQlY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Qio27RVi8yybPf8gRfG6SynXTrs8NO8la6+tQdnUjCok/39AMEJOdq9RimL65gYnotcgaVcR0jczr1dnbrpiyW1HqfM3GMRb+YQ0ug2z8AzMxw0qoiynyaXv3ht48sP8bmk664JsZf0RwUDNbAq+va4CPw6fISN22IlQD+cSOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u+Jvf56y; arc=none smtp.client-ip=91.218.175.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u+Jvf56y"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uq5jlhzj8gzho0xqdOVBria1a7MRHAIccb8VoM1GQlY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792291726; v=1; x=1792896526;
 b=u+Jvf56yYboeTNZ/PQiznDVQRXGQsp0mHX6faGlJND9Mx3myERy6lJa34Hpcj9YzVZlFVH2O
 ccWrHre3rxSQx2qGlBM7qt12r5H5M33r4v81/GJROd9rwdy7oF3q2goR8D8QcWwUrIRw1f/ejqP
 zmckQVQG1JnIdmr462Y4BzDQ=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 11a74ca0ca4c8a3b;
	Sun, 18 Oct 2026 02:48:46 +0000
X-Mizu-Trace-ID: 11a74ca0ca4c8a3b
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 Oct 2026 02:48:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <0d94c4f119546b07d10fa5edac08b89ca8b9c04a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu/tasks: Use static per cpu work_struct for Tasks Rude
 grace periods
To: paulmck@kernel.org, "Bradley Morgan" <brads@mainlining.org>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4b456047-62ae-4bc2-8da5-e4e5e603fcbb@paulmck-laptop>
References: <20261017123313.1441679-1-brads@mainlining.org>
 <4b456047-62ae-4bc2-8da5-e4e5e603fcbb@paulmck-laptop>

>=20
>=20On Sat, Oct 17, 2026 at 12:33:13PM +0000, Bradley Morgan wrote:
>=20
>=20>=20
>=20> Zqiang caught a snafu in the rude grace period, if a too small grac=
e
> >  period was reached, a UAF could occur. However, his patch used
> >  a WARN_ONCE() on schedule_on_each_cpu() OOM failures, which would no=
t
> >  have handled the failure properly.
> >=20=20
>=20>  Instead of throwing a warning or relying on dynamic alloc_percpu()=
, replace
> >  the dynamic allocation with static per cpu work_struct instances. Us=
ing
> >  schedule_work_on() and flush_work() keeps everything in task context=
,
> >  guarantees the required context switch on every online CPU, and stay=
s
> >  zero allocation so it cannot fail under OOM.
> >=20=20
>=20>  Suggested-by: Zqiang <qiang.zhang@linux.dev>
> >  Signed-off-by: Bradley Morgan <brads@mainlining.org>
> >=20
>=20Sorry, Bradley, but no, absolutely not.
>=20
>=20Because this not taking a suggestion, but is instead *exactly* Zqiang=
's
> patch. We do not commit plagiarism in the Linux-kernel community.
>=20
>=20Zqiang, please submit a proper patch with appropriate credit to Bradl=
ey.
> The obvious approach would be to following his example, that is, to
> credit him using Suggested-by, but Reported-by or a sentence calling ou=
t
> his feedback in the commit log would suffice. However, I will defer to
> your best judgment.

Thanks, Paul

I will resend it as v2 and add Bradley as Suggested-by.

Thanks
Zqiang


>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> ---
> >  kernel/rcu/tasks.h | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >  index 627295396cd9..f81c0ea0b92a 100644
> >  --- a/kernel/rcu/tasks.h
> >  +++ b/kernel/rcu/tasks.h
> >  @@ -1348,11 +1348,25 @@ static void rcu_tasks_be_rude(struct work_st=
ruct *work)
> >  {
> >  }
> >=20=20
>=20>  +static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
> >  +
> >  // Wait for one rude RCU-tasks grace period.
> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >  {
> >  + int cpu;
> >  +
> >  + guard(cpus_read_lock)();
> >  rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
> >  - schedule_on_each_cpu(rcu_tasks_be_rude);
> >  +
> >  + for_each_online_cpu(cpu) {
> >  + struct work_struct *work =3D &per_cpu(tasks_rude_work, cpu);
> >  +
> >  + INIT_WORK(work, rcu_tasks_be_rude);
> >  + schedule_work_on(cpu, work);
> >  + }
> >  +
> >  + for_each_online_cpu(cpu)
> >  + flush_work(&per_cpu(tasks_rude_work, cpu));
> >  }
> >=20=20
>=20>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback=
_t func);
> >  --=20
>=20>  2.53.0
> >
>
