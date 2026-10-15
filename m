Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DD365A00;
	Thu, 15 Oct 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081916; cv=none; b=eywq0w0mI6MhCchsIZch05/+clCvr6o/DHd+ZI5nY4orqc5FRaAXq//oZHqMaEDu36hu41SfBikrfPRYSSCpxOXcoGhcwOcPnEn+bVUydySTr9M9O1iWex1qujUAllPXLN1EOQmC+qbZfBPjW+LY5E4vMG7GsICKOIBjvEVKFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081916; c=relaxed/simple;
	bh=B1M2pN4VveBby4ovtQf/5/8/ipwclZuER8gaMg3bVRA=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BxX9aZnf1qpc0XS7w0XNrVzpJ+vFHh9IfTc9iRn+tenKgv5tmWh71aLP9t/3fwwZ3acT6FgI8ZZJLfLvbwhh0XqX6+LQDPO7LjizD+YMlH3F4k+TmEC5u8J0wVf0b0VTGAtJueHd2J6xLYS1h+89E5uub4pVbxYX3scY3tyk/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qXyHPqyn; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=u9p0BpJi; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qXyHPqyn";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="u9p0BpJi"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792081892; bh=uq7GJkJIP8YwuurGT4wgScK
	ZezGRTHeJG8LQPSk+wwg=; b=qXyHPqyn4y34F8J716xCodGXxVCac5iYYJgbNcFG+T8Q+lZ+8p
	n6/VkRGavWL88Uvrahaq5R2STW7yr+tbBzyH8ktIWWC6cGYBSobPJyeR55NkuyilNlHhvtB2aVQ
	qGI4D/l6POeTyPAyzNejigWs5HoWK6CAR1Xjivtj9AtIB68AwOnhBTd8NlRdnuKj1H7A8gvIJcE
	9njgzMd6/B+3B/qe7aMB4AKR6IOP9XRXK0aCgL9E2rhLnlxLNwpER20j9O6WN3vwYxSC5sE1otN
	YEzQ1KnEBKp9fJ2jpryymK3FRYHDmvYcIvkXcMPIZi7Y0ZhqGI7jPQi6x4Ji9JyHQxg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792081892; bh=uq7GJkJIP8YwuurGT4wgScK
	ZezGRTHeJG8LQPSk+wwg=; b=u9p0BpJiojelSRWUQRiwwmXJHgjFvvsdtXgFK/mNObBVGwOZrI
	E/PY8NQf1uF/PipD0qN17NeXghjWec0k7yCQ==;
Date: Thu, 15 Oct 2026 17:31:32 +0100
From: Bradley Morgan <brads@mainlining.org>
To: qiang.zhang@linux.dev
CC: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
In-Reply-To: <20261015094619.8773-1-qiang.zhang@linux.dev>
Message-ID: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>The RCU Tasks Rude grace period is implemented by invoking the
>schedule_on_each_cpu() with an empty work function, which forces
>a context switch on every online CPU and guarantees that all
>rude-tasks read-side critical sections have completed. However,
>schedule_on_each_cpu() can fail (via alloc_percpu() returning
>-ENOMEM) and returns immediately, in which case those context
>switches never happen, too-short grace period happen.
>
>This commit therefore wraps the schedule_on_each_cpu() call in
>WARN_ONCE() so that this failure is reported as a "Too-short
>grace period" warning.

NAK, this seems like a edge case, and potentially panicking the system
with panic on oops doesn't seem right to me, because we would reserve that
for when something definitely goes really wrong and we need to notify
the user.


I don't believe this patch should go in for this reason, it's a heavy edge
case, that doesn't *have* nessesarily need to be accounted for.

Zqiang, have you reproduced this OOM on your own system, if so, could you
tell me more details, you may turn my frown into a smiley face ;)


>
>Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>---
> kernel/rcu/tasks.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>index fcac7361ec51..91c25717402e 100644
>--- a/kernel/rcu/tasks.h
>+++ b/kernel/rcu/tasks.h
>@@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct work_struct *work)
> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> {
> 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
>-	schedule_on_each_cpu(rcu_tasks_be_rude);
>+	WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
>+		  "%s: Too-short grace period, OOM is now expected behavior!!!\n", rtp->name);

Good message, makes sense. But I don't think this is right, see above.

> }
> 
> static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
> func);
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
