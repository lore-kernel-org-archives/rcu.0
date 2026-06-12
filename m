Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0636EA8B
	for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227435; cv=none; b=JoM/ZqP9Me1ninItfckEnhgGJKVz8QGM19TrIm2jSvC9ke6CdJKOo/EoqUfD9xWJsTbUUbOeqlQaqhyUCO507TsLD2XYVFcZlf7QzWbXjc2u2VDFzSkkVCpct/ttQfeLVokEuMXUXy2ro5fDQ2r74NZrOF2PYlalGvrc9AdZ7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227435; c=relaxed/simple;
	bh=OhFsopCG/7ez7Mi1W0hw4lkKEXqVrTrSdnkGh6cqEPo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=j/bTC5ypt48CYPapEkRl4DaqLOfA7yxGMlmzrGLyfp0zV2D4w8Uy4XV+VBQJmofernYKEuPgpdFkQKpNmQW0veTv0uFU889W+Cgl+6+CkfX1DZ94BDmKJaC/hP1rkjdORAS9DIiCNTAJogfQVr/CX8jlBc9BUgRmtdzkOoxBMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iB7fWxFm; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iB7fWxFm"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781227430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flcFIw/Ca4OTCcB6P5xJ5h9IuQQ7USdpHo0/2Kz7kHk=;
	b=iB7fWxFmLletldWTRTitpILfySaYlHMJh5oEilHYjnUSkaYyQoj6hDUTFr17A7zn+UfgKl
	f8qrZ3K4U7yAr++WUxX6lEcLBJXQb4vEGUSENLnTEv+UsVjV7Dvs2IQOFD3OubrBlGQhYz
	f4dsMA49eYJxFD7zUPBHFLmhvAZ87fw=
Date: Fri, 12 Jun 2026 01:23:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <96599e5fe18341789306574cf0cc346a9cc2a36a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] rcu: Use task_state_to_char() in stall-warning prints
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, dave@stgolabs.net,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Kunwu Chan"
 <kunwu.chan@gmail.com>, "Wang Lian" <lianux.mm@gmail.com>
In-Reply-To: <442e80e0-4f91-421c-ab68-d26e0a031472@paulmck-laptop>
References: <20260611073201.3889919-1-kunwu.chan@linux.dev>
 <442e80e0-4f91-421c-ab68-d26e0a031472@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

June 12, 2026 at 3:58 AM, "Paul E. McKenney" <paulmck@kernel.org mailto:p=
aulmck@kernel.org?to=3D%22Paul%20E.%20McKenney%22%20%3Cpaulmck%40kernel.o=
rg%3E > wrote:


>=20
>=20On Thu, Jun 11, 2026 at 03:32:01PM +0800, Kunwu Chan wrote:
>=20
>=20>=20
>=20> From: Kunwu Chan <kunwu.chan@gmail.com>
> >=20=20
>=20>  RCU stall warnings currently print task states as raw hexadecimal
> >  values (e.g., ->state=3D0x402), forcing developers to manually decod=
e
> >  them from memory.
> >=20=20
>=20>  Replace these raw hex values with the compact, single-letter symbo=
ls
> >  already established by sched_show_task():
> >=20=20
>=20>  ->state=3D0x402 becomes ->state=3DI (TASK_IDLE)
> >  ->state=3D0x0 becomes ->state=3DR (TASK_RUNNING)
> >  ->state=3D0x2 becomes ->state=3DD (TASK_UNINTERRUPTIBLE)
> >=20=20
>=20>  Convert five print sites across tree_stall.h, rcutorture.c, and
> >  hazptrtorture.c to use task_state_to_char() instead of the raw
> >  ->__state value.
> >=20=20
>=20>  Suggested-by: Zqiang <qiang.zhang@linux.dev>
> >  Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> >  Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> >  Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >=20
>=20Nice!
>=20
>=20But could you please split this into three commits, one for each file=
?
> That makes it easier to create branches to send to Linus. Especially
> since hazptrtorture.c will likely be in a different pull request. ;-)
>=20
>=20 Thanx, Paul
>=20

Sure,=20I'll split it into one commit per file.=20
Makes=20sense, especially for the hazptr one. ;-)

Thanks!

> >=20
>=20> ---
> >  Based on: linux-rcu repo (dev branch)
> >  URL: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-r=
cu.git
> >  base-commit: 85bf11e84 ("smp: Make CSD lock acquisition atomic for d=
ebug mode")
> >  ---
> >  kernel/rcu/hazptrtorture.c | 4 ++--
> >  kernel/rcu/rcutorture.c | 4 ++--
> >  kernel/rcu/tree_stall.h | 12 ++++++------
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture=
.c
> >  index 0da0a4606..19ea479c9 100644
> >  --- a/kernel/rcu/hazptrtorture.c
> >  +++ b/kernel/rcu/hazptrtorture.c
> >  @@ -497,10 +497,10 @@ hazptr_torture_stats_print(void)
> >  unsigned long __maybe_unused gp_seq =3D 0;
> >=20=20
>=20>  wtp =3D READ_ONCE(writer_task);
> >  - pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu =
%d\n",
> >  + pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %=
d\n",
> >  hazptr_torture_writer_state_getname(),
> >  hazptr_torture_writer_state, gp_seq, flags,
> >  - wtp =3D=3D NULL ? ~0U : wtp->__state,
> >  + wtp =3D=3D NULL ? '?' : task_state_to_char(wtp),
> >  wtp =3D=3D NULL ? -1 : (int)task_cpu(wtp));
> >  if (!splatted && wtp) {
> >  sched_show_task(wtp);
> >  diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >  index fcb421ced..4d4ebeeea 100644
> >  --- a/kernel/rcu/rcutorture.c
> >  +++ b/kernel/rcu/rcutorture.c
> >  @@ -3074,10 +3074,10 @@ rcu_torture_stats_print(void)
> >  if (cur_ops->get_gp_data)
> >  cur_ops->get_gp_data(&flags, &gp_seq);
> >  wtp =3D READ_ONCE(writer_task);
> >  - pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu =
%d\n",
> >  + pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %=
d\n",
> >  rcu_torture_writer_state_getname(),
> >  rcu_torture_writer_state, gp_seq, flags,
> >  - wtp =3D=3D NULL ? ~0U : wtp->__state,
> >  + wtp =3D=3D NULL ? '?' : task_state_to_char(wtp),
> >  wtp =3D=3D NULL ? -1 : (int)task_cpu(wtp));
> >  if (!splatted && wtp) {
> >  sched_show_task(wtp);
> >  diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >  index 317ef91b1..7ca434b08 100644
> >  --- a/kernel/rcu/tree_stall.h
> >  +++ b/kernel/rcu/tree_stall.h
> >  @@ -596,13 +596,13 @@ static void rcu_check_gp_kthread_starvation(vo=
id)
> >=20=20
>=20>  if (rcu_is_gp_kthread_starving(&j)) {
> >  cpu =3D gpk ? task_cpu(gpk) : -1;
> >  - pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->sta=
te=3D%#x ->cpu=3D%d\n",
> >  + pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->sta=
te=3D%c ->cpu=3D%d\n",
> >  rcu_state.name, j,
> >  (long)rcu_seq_current(&rcu_state.gp_seq),
> >  data_race(READ_ONCE(rcu_state.gp_flags)),
> >  gp_state_getname(rcu_state.gp_state),
> >  data_race(READ_ONCE(rcu_state.gp_state)),
> >  - gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
> >  + gpk ? task_state_to_char(gpk) : '?', cpu);
> >  if (gpk) {
> >  struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> >=20=20
>=20>  @@ -639,12 +639,12 @@ static void rcu_check_gp_kthread_expired_fqs=
_timer(void)
> >  time_after(jiffies, jiffies_fqs + RCU_STALL_MIGHT_MIN) &&
> >  gpk && !READ_ONCE(gpk->on_rq)) {
> >  cpu =3D task_cpu(gpk);
> >  - pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%l=
d f%#x %s(%d) ->state=3D%#x\n",
> >  + pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%l=
d f%#x %s(%d) ->state=3D%c\n",
> >  rcu_state.name, (jiffies - jiffies_fqs),
> >  (long)rcu_seq_current(&rcu_state.gp_seq),
> >  data_race(READ_ONCE(rcu_state.gp_flags)), // Diagnostic read
> >  gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
> >  - data_race(READ_ONCE(gpk->__state)));
> >  + task_state_to_char(gpk));
> >  pr_err("\tPossible timer handling issue on cpu=3D%d timer-softirq=3D=
%u\n",
> >  cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
> >  }
> >  @@ -971,10 +971,10 @@ void show_rcu_gp_kthreads(void)
> >  jr =3D j - data_race(READ_ONCE(rcu_state.gp_req_activity));
> >  js =3D j - data_race(READ_ONCE(rcu_state.gp_start));
> >  jw =3D j - data_race(READ_ONCE(rcu_state.gp_wake_time));
> >  - pr_info("%s: wait state: %s(%d) ->state: %#x ->rt_priority %u delt=
a ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %=
lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_f=
lags %#x\n",
> >  + pr_info("%s: wait state: %s(%d) ->state: %c ->rt_priority %u delta=
 ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %l=
u ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_fl=
ags %#x\n",
> >  rcu_state.name, gp_state_getname(rcu_state.gp_state),
> >  data_race(READ_ONCE(rcu_state.gp_state)),
> >  - t ? data_race(READ_ONCE(t->__state)) : 0x1ffff, t ? t->rt_priority=
 : 0xffU,
> >  + t ? task_state_to_char(t) : '?', t ? t->rt_priority : 0xffU,
> >  js, ja, jr, jw, (long)data_race(READ_ONCE(rcu_state.gp_wake_seq)),
> >  (long)data_race(READ_ONCE(rcu_state.gp_seq)),
> >  (long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
> >  --=20
>=20>  2.43.0
> >
>
