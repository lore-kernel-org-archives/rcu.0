Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147B495022;
	Mon, 12 Oct 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816611; cv=none; b=WA8fY4s/4r9JKYn15JXAZVtz6URoYejlvMzkLlozaIh/FPt3M0cWUfoWCKGB/SIR1mASYnM4BjhusCrXlcWGlThKAvnTqPE9uALjykcRy3RBVv5hQv2S73tKeSP2l1ovDzvWiFXteEmy0VD28L0hGtTKqHJQonk3l4J4FCw1qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816611; c=relaxed/simple;
	bh=ojlWEdTYH85IupYSdx+gfD5KiVSkj/6N624919m3v+A=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tSi1oXiwZMOcYIfMvITsOGDDD2EkeC5NOaDEHjZmaE98gZN+6cARcepBZEzDyNewZwwvbwBcHwALh1bryJRALXyfIMprHkf9uUBha8W4gIGLloEDVgyh3CnZhGMqKvhMFZDLeGKw8GJGxZKrORYnvjwZwYAz1YkZof7LAenLLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=EBOJWke6; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qDeWqptg; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="EBOJWke6";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qDeWqptg"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791816603; bh=J2a6KtlKXaupIikV0psaf1D
	FdBBvOwkAXf/qL/tKI/o=; b=EBOJWke6bO3lfrr5vCCEScZxRiNNnn7BUfiZcUvQYpUNB0Qiqx
	cr3FO8OqlwbCYrUi6OMoItrPvl1lnmC/83fH0LzqLqbjNCn3HMt8LMbjBs5eN+4zG9A3BDZ4a41
	cdAR+zDjSoAY9Bj9B25hYxNvAOT/3Z/uJWxG8BNZWD/UXrZD8ZQbLdksKC6SPu0tp/3bpUSTUqO
	ljvOj1f3Sl0f0zHDmaGT1TSBGoC6KlSKbag4d6ossXTjfrmAk8atxQylEWxaYHyAhCuphya2c30
	J5KtfA0YdbnCCUzmJlKHTLbYxLFd/q8w6sUzwuU/YjKytrcls0UVIdvaVeUq3I00gnQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791816603; bh=J2a6KtlKXaupIikV0psaf1D
	FdBBvOwkAXf/qL/tKI/o=; b=qDeWqptgJpz3d+0jRuAUhUJ4/EUQRdsRrx4tTjG+04yYDT45/d
	rvmWqLJPcgnODe4DDWM3osut1TMGFqM0OTAA==;
Date: Mon, 12 Oct 2026 15:50:04 +0100
From: Bradley Morgan <brads@mainlining.org>
To: qiang.zhang@linux.dev
CC: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_rcutorture=3A_Clear_cbflood=5Fma?=
 =?US-ASCII?Q?x_for_tasks-rude_and_srcu-atomic_testing?=
In-Reply-To: <20261012104134.16268-1-qiang.zhang@linux.dev>
Message-ID: <CB7858D2-103F-4EB5-8A7B-55E1A65042FA@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 12 October 2026 11:41:34 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>When running the tasks-rude and srcu-atomic tests, the fwd_prog_tasks
>kthread is created because the default value of fwd_progress is 1.
>however, the two RCU flavors not support ->call():
>
>1. tasks-rude: commit b428a9de9bba ("rcutorture: Stop testing RCU Tasks
>   Rude asynchronous APIs") removed .call and .cb_barrier from tasks-rude,
>   but left the .cbflood_max = 50000.
>
>2. srcu-atomic: srcu_torture_init_forbidden_apis() sets ->call to NULL
>   for SRCU_READ_FLAVOR_ATOMIC runs, but leaves ->cbflood_max untouched.
>
>In both cases, the non-zero ->cbflood_max fools the check above into
>creating the fwd_prog_tasks kthreads, even though those kthreads cannot
>possibly carry out any forward-progress test:
>
>1. The rcu_torture_fwd_prog_cr() returns immediately due to cur_ops->call
>   is NULL:
>
>[   68.022674] rcu_torture_fwd_prog_cr: No ->call(), so no
>forward-progress test 0
>[  129.462046] rcu_torture_fwd_prog_cr: No ->call(), so no
>forward-progress test 0
>[  190.902123] rcu_torture_fwd_prog_cr: No ->call(), so no
>forward-progress test 0
>[  252.343809] rcu_torture_fwd_prog_cr: No ->call(), so no
>forward-progress test 0
>
>2. The rcu_torture_fwd_prog_nr() is never even invoked, because its caller
>   requires cur_ops->stall_dur, and neither tasks-rude nor srcu-atomic
>   provide ->stall_dur (only rcu_ops does).
>
>Therefore, creating fwd_prog_tasks kthreads is pointless, this commit
>removes the .cbflood_max from tasks-rude and clears ->cbflood_max in the
>srcu_torture_init_forbidden_apis().
>
>simple verification output:
>
>[    3.062959][    T1] srcu-torture: rcu_torture_fwd_prog_init: Disabled,
>unsupported by RCU flavor under test
>[    2.922323][    T1] tasks-rude-torture: rcu_torture_fwd_prog_init:
>Disabled, unsupported by RCU flavor under test

Fixes tag?

This LGTM anyway so:

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>
>Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>---
> kernel/rcu/rcutorture.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 968343be4e0d..00db87256e78 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -723,6 +723,7 @@ static void srcu_torture_init_forbidden_apis(void)
> 	cur_ops->deferred_free = NULL;
> 	cur_ops->exp_current = NULL;
> 	cur_ops->start_gp_poll = NULL;
>+	cur_ops->cbflood_max = 0;
> }
> 
> static void srcu_torture_init(void)
>@@ -1250,7 +1251,6 @@ static struct rcu_torture_ops tasks_rude_ops = {
> 	.exp_sync	= synchronize_rcu_tasks_rude,
> 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
> 	.get_gp_data	= rcu_tasks_rude_get_gp_data,
>-	.cbflood_max	= 50000,
> 	.irq_capable	= 1,
> 	.name		= "tasks-rude"
> };
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
