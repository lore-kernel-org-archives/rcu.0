Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093977;
	b=rQRadCE5dTXV8ACun+j15w6qH0P0sCgJCQnayE8pPZ2tjulBvUM+9VtmRekMtxk68bF3
	 3Mxgj69DgjziVmcXaTWuhF/t3Zzwh4dPW8sYMIkC9QgxFLGgDaal/O8GctMC4q65UEfPT
	 XALPo2P5CgU3miriEcyuFERgK9fUWKggLjATdfq3JSd6axNjUQmTFWed2xIg+5YS6tiXn
	 8BhwgsyVOJ7uOGLN8oN/eT6DJlbJTspNocMr3QItewDon4f5n/SgUXPiTmBSGjKIkPLfK
	 LFI+bsC7c4vrY7oSk1PYZPm+OaUUmDKgGO77lbkdDe3POlqTy2si/PIGfRlo5vugdAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093977;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/q9SNtsLpOQFFz2oKvKluMnW2OJakwogm3d9thiIdhU=;
	b=f8Y6VEFmWBDfO/dJytKfSjt2Pu/H6JRcsGNrQ+hQbZsZ9qhyqsteQ5ux9XLPeIk5v+N7
	 4yNuu63R1LBUybsQaeeCSSH+enlcorphlymYwMsBWV4YkwlJHIk9KQ2w4XOL17EvdceAv
	 rgGVXpt1AiG+qPxHxnfLrmdYZAgPY+IMCH7vmf9xUGRnxXRSJzqX5mq7DooyUySuXl19x
	 3Id1Vy9Lgh2+tGqnMknQIr7qc/n6dLE9kNAVVhAxZQcDKX8CD/rPwUVZlW4RHmRUFdsa5
	 YFQqhJ8Mr6PIoAKqWw2+FeKK++q8KFNpSWmD8l0bJC/Qxe3SPR8nmyYj4gfxB/R6N0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=AOeIJYOR;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YQYnhD9X;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76068606A326;
	Sat,  7 Nov 2026 23:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76068606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=AOeIJYOR;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YQYnhD9X
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1794093932; bh=/q9SNtsLpOQFFz2oKvKluMn
	W2OJakwogm3d9thiIdhU=; b=AOeIJYORBXfowH3BYcw0naI77CLWquvoZFQy+B97Xs9BTdcmeB
	kn0HDLjlC+x9fySko8qeENCGroixRrX6+DvQFHyoMfzqM0xzWtM648jPvF0W3EhB+FTxlS5Zeqt
	xIaupZRM5JBgv/zifM3qgo7ims4/fSemqUVpGzXf1P8EzzCpPqu1202NrfEzPtNaHD/OyluDSxA
	Ie9Kp39HOm03d1pFdGnRT0k0wHXAb8HnMazH4RiRCGFheADlR/0G7jo9n9plEb+J+8hxj4IPA/V
	pg6wcFVAZ+k65F2OadUZxBZSTwN+nYBUSPbaDkA4M3xCpId/Ky/+0KLw8iY0RLZPilQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1794093932; bh=/q9SNtsLpOQFFz2oKvKluMn
	W2OJakwogm3d9thiIdhU=; b=YQYnhD9XSRkPIZs20QDd0PSg961IAgz5OcIKM7q3xRFJ8kmgkM
	SzFk2tvwwr2XJKOxvk0eA/XtL4AqMAYq8rBQ==;
Date: Sat, 07 Nov 2026 23:25:32 +0000
From: Bradley Morgan <brads@mainlining.org>
To: christophe.jaillet@wanadoo.fr
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
In-Reply-To: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
Message-ID: <B33D74A6-E196-45F4-AA77-32B4FDCD0817@mainlining.org>
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

On 7 November 2026 21:02:25 GMT, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>'struct rcu_scale_ops' is not modified in this driver.
>
>Constifying these structures moves some data to a read-only section, so
>increases overall security, especially when the structure holds some
>function pointers.
>
>On a x86_64, with allmodconfig:
>Before:
>======
>   text	   data	    bss	    dec	    hex	filename
>  45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>
>After:
>=====
>   text	   data	    bss	    dec	    hex	filename
>  46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>

Well, thanks. so you just consted rcu_scale_ops()? Uhh, well, this makes
enough sense to be feasible

Reviewed-by: Bradley Morgan
<brads@mainlining.org>

But how is this worth it? Why doesn't this work now? how will this make it
better? Those are my questions. 

Well, I'm shrugging, but my tag would stand here, because it won't break
anything in particular.

>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
>Compile tested only.
>---
> kernel/rcu/rcuscale.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>index 1097ec15879c..522f7bc2e693 100644
>--- a/kernel/rcu/rcuscale.c
>+++ b/kernel/rcu/rcuscale.c
>@@ -159,7 +159,7 @@ struct rcu_scale_ops {
> 	const char *name;
> };
> 
>-static struct rcu_scale_ops *cur_ops;
>+static const struct rcu_scale_ops *cur_ops;
> 
> /*
>  * Definitions for rcu scalability testing.
>@@ -185,7 +185,7 @@ static void rcu_sync_scale_init(void)
> {
> }
> 
>-static struct rcu_scale_ops rcu_ops = {
>+static const struct rcu_scale_ops rcu_ops = {
> 	.ptype		= RCU_FLAVOR,
> 	.init		= rcu_sync_scale_init,
> 	.readlock	= rcu_scale_read_lock,
>@@ -247,7 +247,7 @@ static void srcu_scale_synchronize_expedited(void)
> 	synchronize_srcu_expedited(srcu_ctlp);
> }
> 
>-static struct rcu_scale_ops srcu_ops = {
>+static const struct rcu_scale_ops srcu_ops = {
> 	.ptype		= SRCU_FLAVOR,
> 	.init		= rcu_sync_scale_init,
> 	.readlock	= srcu_scale_read_lock,
>@@ -276,7 +276,7 @@ static void srcu_sync_scale_cleanup(void)
> 	cleanup_srcu_struct(srcu_ctlp);
> }
> 
>-static struct rcu_scale_ops srcud_ops = {
>+static const struct rcu_scale_ops srcud_ops = {
> 	.ptype		= SRCU_FLAVOR,
> 	.init		= srcu_sync_scale_init,
> 	.cleanup	= srcu_sync_scale_cleanup,
>@@ -313,7 +313,7 @@ static void rcu_tasks_scale_stats(void)
> 	rcu_tasks_torture_stats_print(scale_type, SCALE_FLAG);
> }
> 
>-static struct rcu_scale_ops tasks_ops = {
>+static const struct rcu_scale_ops tasks_ops = {
> 	.ptype		= RCU_TASKS_FLAVOR,
> 	.init		= rcu_sync_scale_init,
> 	.readlock	= tasks_scale_read_lock,
>@@ -357,7 +357,7 @@ static void rcu_tasks_rude_scale_stats(void)
> 	rcu_tasks_rude_torture_stats_print(scale_type, SCALE_FLAG);
> }
> 
>-static struct rcu_scale_ops tasks_rude_ops = {
>+static const struct rcu_scale_ops tasks_rude_ops = {
> 	.ptype		= RCU_TASKS_RUDE_FLAVOR,
> 	.init		= rcu_sync_scale_init,
> 	.readlock	= tasks_rude_scale_read_lock,
>@@ -396,7 +396,7 @@ static void tasks_trace_scale_read_unlock(int idx)
> 	rcu_read_unlock_trace();
> }
> 
>-static struct rcu_scale_ops tasks_tracing_ops = {
>+static const struct rcu_scale_ops tasks_tracing_ops = {
> 	.ptype		= RCU_TASKS_FLAVOR,
> 	.init		= rcu_sync_scale_init,
> 	.readlock	= tasks_trace_scale_read_lock,
>@@ -693,7 +693,7 @@ rcu_scale_writer(void *arg)
> }
> 
> static void
>-rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
>+rcu_scale_print_module_parms(const struct rcu_scale_ops *cur_ops, const char *tag)
> {
> 	pr_alert("%s" SCALE_FLAG
> 		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d nexp=%d exp_interval=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
>@@ -1109,7 +1109,7 @@ rcu_scale_init(void)
> 	int firsterr = 0;
> 	long i;
> 	long j;
>-	static struct rcu_scale_ops *scale_ops[] = {
>+	static const struct rcu_scale_ops *scale_ops[] = {
> 		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> 	};
> 
>

--- Thanks!
