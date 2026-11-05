Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903251;
	b=YdNuxksZYMo6IsTdVLpAW1Q8K6Gt3w68jMRyawevgsNMWA4NHVTCYkZ9irIPA4uE0zOX
	 EOaQx5sJbUlvtuWaHC8dhxIHkcxFXywICLB1LOlXnZn3YWduweJSCjDZ9JqlCm3jLer4b
	 DAjUKczQQXE8U3M0c36bmgfSeyUd4PpkZDhzIivyR5jIV96HJdMeFoHvh9kdUrOlwZyqi
	 wFshrdcazlpLcsg2YehagULAorOgOElRbpl/efQ03y+jP3O7WnSuPla1eQjJvbyWetyC6
	 l4Ik1/gIg1bfutjZqA08vIwQnWNfnl+V9huRW4ieVFZPjHaZhUC3+3Rum8DrevK5fZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903251;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v9bf5TraVDBw+BXmTb1pntN5SpIF/07yRWB5dx4ozSk=;
	b=xBRmLEZoXsWr+m7BmBVI1LBRRP8TQpqPrqZIj769GFg3RPjXOy+KH3TETPhXBcufUx39
	 i1ML7K2BlG8m22YTllBfUh8UJEnZp7YLyhw14kZxlrF8xdFr6uN9fz1jw4kDFXLyl95A5
	 tvlfvlX0lZjtelhhz0RdSosvl6uZ4BIjntgz3mf99SYaNucDNYmVFobkDtCWLS0wo/gMF
	 uEtiGPjvM28pY/7+qBKaMwfrtAJP6Gp7vUejDHzu6KjA3S+70C/8Qq1Ps2ilO6fn6xq7Y
	 O2hm4D0LZnhDlPDaXkYIosr7RwGmwQDf0xAzlEH/RVynPZUmALAsdaHc+EXTJ0VKlng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jxijkUNy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6wHXkpcO;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C944606A329
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 18:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C944606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jxijkUNy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6wHXkpcO
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793903214; bh=v9bf5TraVDBw+BXmTb1pntN
	5SpIF/07yRWB5dx4ozSk=; b=jxijkUNyQgQC1O1YGmbst97vWkuVILwTT5hFnAYwqO31iYFotj
	O8wuTJsU9UAhcVBggQnbSGcSq98QztSdPHe9lvErSJCKSYgZHAVyT3I9O/0PcozKC4xDaFkNY+0
	a2733LyWSky2Be2rYqN5SsEId9l3pRjo4Yilh26P+1IAnvrMVCgP7HQMMFCLHZ3f2ooyvyKm+5Y
	EOZNcyR8OLn6VQcK9nzeVzvDhQwIMLXKtqX0hIwmYrWLXrbCZYTlmD/E3Z3It0JX8KjTGNDEnH5
	oS+D4oUfqAmB92wCbZryNqXJmz4B3sErHZ3w8X0O5zvulaTqx+Hmf6blWS838H7sKrg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793903214; bh=v9bf5TraVDBw+BXmTb1pntN
	5SpIF/07yRWB5dx4ozSk=; b=6wHXkpcO6iGutudRYL+m+fjmRMISpYO8vKX0LYJgGDeGK4Yhlx
	daJjlqEex/J2QweYq4L5O+a1MA+o/TwfsiBg==;
Date: Thu, 05 Nov 2026 18:26:57 +0000
From: Bradley Morgan <brads@mainlining.org>
To: bigeasy@linutronix.de
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, juri.lelli@redhat.com,
 linux-rt-devel@lists.linux.dev, mingo@redhat.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, peterz@infradead.org, rcu@vger.kernel.org,
 urezki@gmail.com
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
In-Reply-To: <20261105165113.82N-rPMG@linutronix.de>
Message-ID: <3422A405-7F7A-4CD4-AFEF-52E91BFB7C47@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 November 2026 16:51:13 GMT, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
>tests") added the ability to disable RT throttling while rcutorture was
>run.
>
>Since v6.12 the DL fair_server takes control of throttling and this
>interface no longer serves this purpose. That sysctl control still
>exists but serves a different cause.
>
>There is no in-kernel interface to provide this feature, one needs to
>echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
>
>Since sysctl_sched_rt_runtime does not do what it once did, remove it
>from rcutorture.
>

Thanks a ton for this patch!

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>---
> kernel/rcu/rcu.h        |  2 --
> kernel/rcu/rcutorture.c | 35 -----------------------------------
> 2 files changed, 37 deletions(-)
>
>diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>index d60444bf3a02d..6d1034e49d411 100644
>--- a/kernel/rcu/rcu.h
>+++ b/kernel/rcu/rcu.h
>@@ -69,8 +69,6 @@
> /* A complete grace period count */
> #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
> 
>-extern int sysctl_sched_rt_runtime;
>-
> /*
>  * Return the counter portion of a sequence number previously returned
>  * by rcu_seq_snap() or rcu_seq_current().
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 968343be4e0d1..acab425e72ad5 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -1333,39 +1333,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
> 	return cur_ops->gp_diff(new, old);
> }
> 
>-/*
>- * RCU torture priority-boost testing.  Runs one real-time thread per
>- * CPU for moderate bursts, repeatedly starting grace periods and waiting
>- * for them to complete.  If a given grace period takes too long, we assume
>- * that priority inversion has occurred.
>- */
>-
>-static int old_rt_runtime = -1;
>-
>-static void rcu_torture_disable_rt_throttle(void)
>-{
>-	/*
>-	 * Disable RT throttling so that rcutorture's boost threads don't get
>-	 * throttled. Only possible if rcutorture is built-in otherwise the
>-	 * user should manually do this by setting the sched_rt_period_us and
>-	 * sched_rt_runtime sysctls.
>-	 */
>-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
>-		return;
>-
>-	old_rt_runtime = sysctl_sched_rt_runtime;
>-	sysctl_sched_rt_runtime = -1;
>-}
>-
>-static void rcu_torture_enable_rt_throttle(void)
>-{
>-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
>-		return;
>-
>-	sysctl_sched_rt_runtime = old_rt_runtime;
>-	old_rt_runtime = -1;
>-}
>-
> static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned
> long *start)
> {
> 	int cpu;
>@@ -3390,7 +3357,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
> 	mutex_lock(&boost_mutex);
> 	t = boost_tasks[cpu];
> 	boost_tasks[cpu] = NULL;
>-	rcu_torture_enable_rt_throttle();
> 	mutex_unlock(&boost_mutex);
> 
> 	/* This must be outside of the mutex, otherwise deadlock! */
>@@ -3428,7 +3394,6 @@ static int rcutorture_booster_init(unsigned int cpu)
> 
> 	/* Don't allow time recalculation while creating a new task. */
> 	mutex_lock(&boost_mutex);
>-	rcu_torture_disable_rt_throttle();
> 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
> 	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
> 					      cpu, "rcu_torture_boost_%u");
>

--- Thanks!
