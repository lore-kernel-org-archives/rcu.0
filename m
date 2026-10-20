Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508847;
	b=jdrcUiEEjKmqKmdOWaRtSqxN4b/5u7zRNz3GENoC+Zl4PKFa8lkA7ZEtRKuXIR/LbaZR
	 +S/GZAicXAM8XFgDlEecxCRJpjuCFkVaQG650NBKDwZcscWiTi+EhtPJHJAlh1A0bp+qj
	 3z2EjkSjEowb/d0IbV5xCeN/isMZSoDMPa5QbjuwZEtYmZC+G+SIUnqKpT44bkX6r1Qxk
	 FFr1XBESg3WJi1OK4kO4Zrt2Pe2R82A3pLOaznqaNi9Xfqq7oB1xeK/d3yMyMN1joIWy0
	 JcvsLhwAM/jgcmgRZIeDuw+MPKXHu53knXwvlQuheLX92eptljOgNZTUGiJMpsJ8zUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508847;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dMwYRpucwb3EFEd/V5P1GGNUlrzJQR2VuDoeGjsBU1o=;
	b=SokUSEoqvAC6XAYsg9SWi/oeD5ABwhaica92EwauU7zQEHPlJoRSic+mf/QuwmU6xXIj
	 4eoBersve3DCO3SDRKfvT1SQ4xie64MxaxzXaCoh3SbGxy05YCDzEAQCl10lk/C4wHFv0
	 KIwNaetWz7m6zrG41vLBl5qnQDLeHMCl99li9BoHRd6f8lvwCC+p/V28/NLXOOq6ERYMD
	 mBy3TvYPBoDZvPCuRZWRQuXsO7Ta4NvQUjp1ls53bMlOv4PWdWc/WYKBWKZyo+a7RdxXB
	 q+1EB8VFiH8pvmFG7Xcc5z9RYcSCOZtX7+q6qU/PL6xhHPN5gwEVPYWNq8HlSUFwLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=UQH1iBx3;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=H7WpaGKG;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC060A2601;
	Tue, 20 Oct 2026 15:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCC060A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=UQH1iBx3;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=H7WpaGKG
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792508808; bh=dMwYRpucwb3EFEd/V5P1GGN
	UlrzJQR2VuDoeGjsBU1o=; b=UQH1iBx3wq6UCnf6Z3IDEJaveuqL6ClRizkM9ol5BWam2AKFBF
	k2UY7CGb43oLZ0BIGKet3sM8mJ+DJWpqX/swxiFi97D271LNe9tW6asnXqo4m6SSAJYH9ixyyHo
	UxRo6gadKclhy8ulgzNSC7nP9ummRIVlyy2C9EwMpc61miQZlBj0SXCrGIDP6JJmlgZib7lPzt4
	zsI03LoQ1wq3qiv+uCGZWl366zaeCig1yspNmIn1BKE96NCly4ErSi4UVd/NZLaWtASpZMeiQSc
	oPknT/vK3wCoir+NPV0E/mpm3VSC7AdBHLC0pjNyuso62TR9PWNBum8mlgaIqkLFhAg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792508808; bh=dMwYRpucwb3EFEd/V5P1GGN
	UlrzJQR2VuDoeGjsBU1o=; b=H7WpaGKGwf6qjlAIkZISrzEiBciNunvcYDyVQHDhtUjv1AwmbG
	TK+kldBe6mMU49qdHyOnmJGAJ5vuNxy6rGCA==;
Date: Tue, 20 Oct 2026 16:06:49 +0100
From: Bradley Morgan <brads@mainlining.org>
To: qiang.zhang@linux.dev
CC: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_rcutorture=3A_Fix_suspicious_rcu=5Fd?=
 =?US-ASCII?Q?ereference=5Fcheck=28=29_usage_for_trivial-preempt?=
In-Reply-To: <20261020094907.15781-1-qiang.zhang@linux.dev>
Message-ID: <BD9E8AED-23DC-4A7E-86E9-297B8FE29846@mainlining.org>
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

On 20 October 2026 10:49:07 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>Running the trivial-preempt flavor triggers a lockdep "suspicious RCU
>usage" warning from rcu_torture_one_read_start():
>
>WARNING: suspicious RCU usage
>kernel/rcu/rcutorture.c:2581 suspicious rcu_dereference_check() usage!
>...
>lockdep_rcu_suspicious
>rcu_torture_one_read_start
>rcu_torture_one_read
>rcu_torture_reader
>
>The trivial-preempt flavor .readlock_held is set to
>torture_readlock_not_held(),
>which check RCU-bh/RCU-sched critical sections. however, it's read lock
>just increments current->rcu_trivial_preempt_nesting, it's not also RCU
>read critical sections. the rcu_dereference_check() condition is therefore
>false, and lockdep report warnings. this commit therefore drop
>.readlock_held
>callback to avoid this lockdep warnings.
>
>Fixes: c6f4e552e1ea ("rcutorture: Add a textbook-style trivial preemptible RCU")

Looks ok to me.

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>---
> kernel/rcu/rcutorture.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 92ff197f4789..1bbf8192786a 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -1164,7 +1164,6 @@ static struct rcu_torture_ops trivial_preempt_ops = {
> 	.readlock	= rcu_torture_read_lock_trivial_preempt,
> 	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
> 	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
>-	.readlock_held	= torture_readlock_not_held,
> 	.get_gp_seq	= rcu_no_completed,
> 	.sync		= synchronize_rcu_trivial_preempt,
> 	.exp_sync	= synchronize_rcu_trivial_preempt,
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
