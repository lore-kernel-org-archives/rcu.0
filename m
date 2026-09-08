Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A749550A;
	Tue,  8 Sep 2026 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880972; cv=none; b=nUV0AKuYPk/cKKivVweCMyhZxCf51c2t8tq0//7yr+xEnrrsYKm202AltqSczIhhygSs9mUtTSbA3JDl05Ayhc3IhE660o2IErg9mtOP3VjJuBJFlbCjSC3nIoeJzx7RlqMi4FyYEr3IBqlypgcLCbD3/Q1cdBE4szdJc6/8i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880972; c=relaxed/simple;
	bh=mTGBytBy30yR2n8RIN0aGhOmetmxyZc7H67s2rG2XKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmsTi/bMmiXwVMU9Vtt8pQlRRztIeuIbRkJe+++Xi+xQ933yJVXMaD2ziDGB8BiG23JptxExw6gxYH1MAbS6x7wsGL81VDz98la2CyXfy/MI2fSGR6+IfnaBpyeLczjQMcDtfxvsZSIm1DxyDmcAqBOVjkiqvBCMpqE0GB2UOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PnRRoogu; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PnRRoogu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1788880952;
	bh=Ll8O7/oSDXteWBBd8gjtRbrrqAVJ9v6gypCgNt3Ws/M=;
	h=From:To:Cc:Subject:Date:From;
	b=PnRRooguu8xbF24LY4+G/MqRn42L01zfQiqXRVVKi+/+Bgn6huwl7DU0FWDyPTlHd
	 LYSxX4waxbG+rNeEWCffC3W1kTUskMCwsadwdhqd5hJXfPPJE/2zjyDa3SOqVZNql2
	 ISQcDMf8x9Ix/xyj1WoJV8CfURQAUTS7gffCFkoC/WbyyMZFCoyXwctdj/nq8XJpSg
	 2J+uLReOcZFzQrsRQtypCLZsoU1fF9CO4ro4A7Q+MVZkCOeMb+kfH/fuXRSyQ+X5w+
	 UKkUIKXwVpCB/4H169AOPbVX9qAlIOc8rr8SWT6mTivwPF5H2kgKZmY3b/u7Vw+K9t
	 mvLUrDi2/y9mw==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4hfSNl75KlzY3s;
	Tue, 08 Sep 2026 11:22:31 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kernel test robot <yi1.lai@intel.com>,
	Bradley Morgan <brads@mainlining.org>,
	Boqun Feng <boqun@kernel.org>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH] hazptr: handle NULL address in hazptr_detach
Date: Tue,  8 Sep 2026 11:22:14 -0400
Message-ID: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hazptr_acquire loads a NULL pointer, it sets:

- slot_item->slot.addr = NULL,
- slot_item->ctx.ctx = ctx
- ctx->slot = slot

And it returns NULL.

Then hazptr_detach is called on this ctx, it will act on the ctx as if
needed to be promoted to backup slot, even though it has a NULL addr.

Looking at what hazptr_note_context_switch() does before promoting
to backup slot, it checks for a NULL slot->addr, which is exactly
what is missing from hazptr_detach.

With this in place there would be no need to explicitly check the
hazptr_acquire() return value before calling hazptr_detach().

hazptr_release() has a early return check for NULL addr as well, so it
makes sense that detach does an early return (no-op) similarly.

Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 include/linux/hazptr.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 43122c5673bd..d1670121947a 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
 	struct hazptr_slot *slot;
 
 	guard(preempt)();
+	slot = ctx->slot;
+	if (!slot->addr)
+		return;
 #ifdef CONFIG_HAZPTR_DEBUG
 	ctx->detach_task = ctx->detach_cpu = true;
 #endif
-	slot = ctx->slot;
 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
 		return;
 	hazptr_promote_to_backup_slot(ctx, slot);
-- 
2.43.0

