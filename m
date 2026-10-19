Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC747AF6B;
	Mon, 19 Oct 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391399; cv=none; b=eDkVeR8dBpHpgboLI3qkkivprN1X34vjKRnZufFUol4CQUdEpI6c5TibHgFqGFkBePhholnpm2R6zzOXxJLbBTSy0p4lN8sEhReUTnymrkYOyjkEFcDQhgFtIU4CRNCW7XjtI9id42lZFBbz5aeBfBVL/49rArXZ2pFuOvLEpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391399; c=relaxed/simple;
	bh=idL1xUFRh4dVpjSpwHPQXwDsHmFBW3rrPa5+BigKAxg=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=QUD+NSABXPTct/mh96CMgu427wWkN1i/zH5ZLv092lKFcCSpdGZiJ5b1kQ7jjOw3g1Mbg8kH5s5A4L7oux6d0Hue45ykF3w3I4qXFVgabA0NDIdiNxnsh7w6hFfs+icNK694OyZJsfAE+kPyl/9qPEYH8FzuYJJ3nFulVr0sdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=XcqFV8bJ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=2YN/nQEY; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XcqFV8bJ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="2YN/nQEY"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792391372; bh=Wreh1PDJrvE1eo0OygamB9n
	WK47yEict8uXCKUXNDPs=; b=XcqFV8bJbPJdJLbQQ2B0ytpx8ADL7N0DSWRUgw9/9ta1GXYZdD
	WtjkT4oCb3EGnSpHvfx2xyIjpXbPhO3qlrJyDR8dDVPO2YskYB1caNkjG63Z6JOA2Wwdi8cM7oY
	x/RnCMY7mF/Fytk31l0foOcJ2JJjvb3iHm+t4unTkKS5OaxBcxW+yh1z8S/y6vm+UdFU9A5pkYe
	ginHzY2143BzCbbyUO2Bs1hWXtf3tGGIFL03uDFe/rMcapqfgojsTnVyAit0bVaHGsVos5akS2x
	4dkM9Tsb5mRXolkGt/FQAbexfKpi9il/HdZgJEu/26uzg1tzgetQXjscTOJ5vSsu4cA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792391372; bh=Wreh1PDJrvE1eo0OygamB9n
	WK47yEict8uXCKUXNDPs=; b=2YN/nQEY8haf4TdgDw1qh90kNLB1P2F9SD2tw7Rk9T025aC/nL
	5ToOfMKUjHkOl1ZY5+TdVOtg84E0gRXy0kAQ==;
Date: Mon, 19 Oct 2026 07:29:31 +0100
From: Bradley Morgan <brads@mainlining.org>
To: fuwenxin@linux.alibaba.com
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, oliver.yang@linux.alibaba.com,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com, xlpang@linux.alibaba.com
Subject: Re: [PATCH] rcutorture: Fix busted_srcud crash on module unload
In-Reply-To: <20261019023644.2750352-1-fuwenxin@linux.alibaba.com>
Message-ID: <C98A2196-D74E-4BB5-9B24-DE0B91D6973E@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 October 2026 03:36:44 BST, fuwenxin@linux.alibaba.com wrote:
>From: Fu Wenxin <fuwenxin@linux.alibaba.com>
>
>Commit e4ed20c1603c ("rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and
>init_srcu_struct_fast()") split SRCU torture initialization into two
>helpers: srcu_torture_init(), which now only points srcu_ctlp at the
>static srcu_ctl/srcu_ctlf/srcu_ctlfud structures, and the new
>srcud_torture_init(), which calls init_srcu_struct(&srcu_ctld) for the
>dynamically allocated srcu_ctld.
>
>That commit updated srcud_ops to use srcud_torture_init(), but left
>busted_srcud_ops pairing .init = srcu_torture_init (static srcu_ctl) with
>.cleanup = srcu_torture_cleanup (which unconditionally calls
>cleanup_srcu_struct(&srcu_ctld)). As a result srcu_ctld is never
>initialized when running torture_type=busted_srcud, yet it is torn down
>at module unload.
>
>cleanup_srcu_struct() then dereferences ssp->srcu_sup, which is still
>NULL for the zero-initialized srcu_ctld, and faults on the ->lock field
>accessed by raw_spin_lock_irq_rcu_node():
>
>  Unable to handle kernel paging request at virtual address dfff80000000001b
>  ...
>  el1_abort -> do_translation_fault -> do_bad_area -> die_kernel_fault
>
>(The fault address is the KASAN shadow of NULL + offsetof(srcu_usage,
>lock) == 0xd8.)
>
>This is trivially reproducible:
>
>  modprobe rcutorture torture_type=busted_srcud
>  sleep 45
>  rmmod rcutorture    # panic here
>
>Fix it by making busted_srcud_ops initialize the same srcu_ctld that its
>cleanup handler tears down, matching srcud_ops.
>
>Fixes: e4ed20c1603c ("rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()")

Nice catch! I reproduced this bug on my PowerPC host:

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Tested-by: Bradley Morgan <brads@mainlining.org> # Power10

>Signed-off-by: Fu Wenxin <fuwenxin@linux.alibaba.com>
>---
> kernel/rcu/rcutorture.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 8a9282a0245cc..7cc78da1356f9 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -991,7 +991,7 @@ static struct rcu_torture_ops srcud_ops = {
> /* As above, but broken due to inappropriate reader extension. */
> static struct rcu_torture_ops busted_srcud_ops = {
> 	.ttype		= SRCU_FLAVOR,
>-	.init		= srcu_torture_init,
>+	.init		= srcud_torture_init,
> 	.cleanup	= srcu_torture_cleanup,
> 	.readlock	= srcu_torture_read_lock,
> 	.read_delay	= rcu_read_delay,
>



--- Thanks!
"I'm not a very positive person" - Linus torvalds
