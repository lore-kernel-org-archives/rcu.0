Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A336166A;
	Mon, 19 Oct 2026 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377418; cv=none; b=Tf147S0ZgcD2GIldodc+K+fNkIFf9zJikkITa5Xg9DYCf8E/ZZZnhAmf2TIqg4RxLszmjlfCMLiGBplH4xMnS0R267Zh75mUGCwyFSTL3UDiTZOMAPOWjWnQsH1aWHGPVZD4xoR7gRZPZHGhDYyT2MOMDWbHnlsmRTUpWY8tDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377418; c=relaxed/simple;
	bh=voy+69M2j73/rg5pZ/Gi4GdtPGNNDipFw+0cyyMnrkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XL9EhOFWItTN3bDiMzab27hbY6ANfOBMV2cH+U6JVTxHv9CKT+MTeW/v3b1/uAsH//oSetIzdVOq5pHGFdv+09KDyh6k8E1L8FmfKO72GFjQ6tDvE9U0tEELFzsj9KTrS83LMgli+VmGCfI5v41CPL60O50EQgSE7GBycilG29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RmhkwRNb; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RmhkwRNb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792377405; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bYulk3GXLoVYYpQAyazL7Lp8MZaupBoLyMjOWYb39QM=;
	b=RmhkwRNbkFBjEi9HzsMbDRHolRlsag1MU6PA0ekAkkL7NeB30tyilt6aKpGPSI9DbOxsiN01l+Slux0v5vW1w3fydJpesOWxLikljugu7DaHttSwZs7OKH36YTGn5NsZuBqWUmbW2EYtRWe2JWj6HuFvkZVsj67CVhFYHqqX0JY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fuwenxin@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XD-LCcj_1792377404;
Received: from t50b09067.sqa.eu95.tbsite.net(mailfrom:fuwenxin@linux.alibaba.com fp:SMTPD_---0XD-LCcj_1792377404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 10:36:45 +0800
From: fuwenxin@linux.alibaba.com
To: paulmck@kernel.org,
	frederic@kernel.org,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	oliver.yang@linux.alibaba.com,
	xlpang@linux.alibaba.com
Subject: [PATCH] rcutorture: Fix busted_srcud crash on module unload
Date: Mon, 19 Oct 2026 10:36:44 +0800
Message-ID: <20261019023644.2750352-1-fuwenxin@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fu Wenxin <fuwenxin@linux.alibaba.com>

Commit e4ed20c1603c ("rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and
init_srcu_struct_fast()") split SRCU torture initialization into two
helpers: srcu_torture_init(), which now only points srcu_ctlp at the
static srcu_ctl/srcu_ctlf/srcu_ctlfud structures, and the new
srcud_torture_init(), which calls init_srcu_struct(&srcu_ctld) for the
dynamically allocated srcu_ctld.

That commit updated srcud_ops to use srcud_torture_init(), but left
busted_srcud_ops pairing .init = srcu_torture_init (static srcu_ctl) with
.cleanup = srcu_torture_cleanup (which unconditionally calls
cleanup_srcu_struct(&srcu_ctld)). As a result srcu_ctld is never
initialized when running torture_type=busted_srcud, yet it is torn down
at module unload.

cleanup_srcu_struct() then dereferences ssp->srcu_sup, which is still
NULL for the zero-initialized srcu_ctld, and faults on the ->lock field
accessed by raw_spin_lock_irq_rcu_node():

  Unable to handle kernel paging request at virtual address dfff80000000001b
  ...
  el1_abort -> do_translation_fault -> do_bad_area -> die_kernel_fault

(The fault address is the KASAN shadow of NULL + offsetof(srcu_usage,
lock) == 0xd8.)

This is trivially reproducible:

  modprobe rcutorture torture_type=busted_srcud
  sleep 45
  rmmod rcutorture    # panic here

Fix it by making busted_srcud_ops initialize the same srcu_ctld that its
cleanup handler tears down, matching srcud_ops.

Fixes: e4ed20c1603c ("rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()")
Signed-off-by: Fu Wenxin <fuwenxin@linux.alibaba.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8a9282a0245cc..7cc78da1356f9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -991,7 +991,7 @@ static struct rcu_torture_ops srcud_ops = {
 /* As above, but broken due to inappropriate reader extension. */
 static struct rcu_torture_ops busted_srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
+	.init		= srcud_torture_init,
 	.cleanup	= srcu_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
-- 
2.43.7

