Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531478;
	b=HvmxNVji0W6hOlUc6eUyx/B6vhsUNc8A33wkWGX1NsaxYf3aQA8GzdLAFIIm8xlN2VAB
	 XX4x9QtF/ACPac655q2DXRLhLuN+MM5+igZgx6A4PFQE2AVlKWbkYUraa90IccIf/unCW
	 qlnbIXOaEl9NQSNAtYkr9g3SA1hmM1mX6GBXW9G8jQ0poJoAtSH6ZvoWC6Acuv3jHqcI3
	 +nFPV4YPTYLRCD6P2MgcuwbhvGBXB6kIrWMlQ/IGfNqnlzrPDk1Nt9A4GzBdOvicxMUGX
	 rbaR7J3rbkDmEZPo1z1NEujiYTElu/zakafuXAh5W2SgOfbbuSfVmWbjUAlzxuk0+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IknZmEWAdldR//1Yta31sNLHcFw2Abm5r3KZMQB10qM=;
	b=sC3JY1u0CTo47HWuIkvu3hD7MuyPV56Dq5Ev/qwIInBaVUrSqFbO9A9VEQLKffn8K2QI
	 3zO3qxivsw/LMObYVk+oBJKSdrm4FvfLMhKxp/ZKu0vyx9Id+tZ83JfqHE28BtunIYdyJ
	 DfVp1kuUg4McifbmOauqxDetmyE4prhv11D94l5o5XTVPcXqmLvxHsHabM0N7lcf1UJHO
	 fFFyg957kaeOr8DglKBVa05wdruL27IjBWQtbNhmt3sJtYCzPbt6mv9MunfsZoOMMF7Gd
	 IEsXMJlO1D3w1fc/qFa5etpDcSUMCoFXgg/vjEchnJJRtgfuww5zjHPfpdbyJBuGmBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lI36hGjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 35348606A8A9;
	Fri, 13 Nov 2026 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lI36hGjI
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B61AF1F000D1;
	Fri, 13 Nov 2026 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531478;
	bh=IknZmEWAdldR//1Yta31sNLHcFw2Abm5r3KZMQB10qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lI36hGjI6pCDN92JfiIRrGjtLEFD/zE4qKOOG/w76z/aAne4O2CLvEuLQE0WJrmf6
	 V+bqZnEkpsyajqcOghGq1rXe0L5P0tIV5hRyp9qA8osIX97YVfBDoMWIUtmAIA7Uqs
	 f7MLhB4lFZ3FmCEIM32Z0JiGSKvWVRlC1OdksuOyJtDVlTYaaVm9nHFS+MWA8LGJU8
	 iIGWZ8NoekKCtyDf/UEGVTSnyDuqYVKbp+2blo5LwHdcle4sXIHhuLuSCaszBumzko
	 ygFycwgWm9vUv/ZGsnk3mbPR9DibUhqnZg8B1le8stsmPft3ex0e5qLGMqAiqq4e+C
	 ivQYxEmtklRZQ==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org,
	Fu Wenxin <fuwenxin@linux.alibaba.com>
Subject: [PATCH for-v7.5 04/14] rcutorture: Fix busted_srcud crash on module unload
Date: Thu, 12 Nov 2026 19:57:31 -0500
Message-ID: <20261113005747.2977123-5-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
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
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Link: https://lore.kernel.org/r/20261019023644.2750352-1-fuwenxin@linux.alibaba.com
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 93ca7f06371e..e88573b9b7c6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1055,7 +1055,7 @@ static struct rcu_torture_ops srcud_ops = {
 /* As above, but broken due to inappropriate reader extension. */
 static struct rcu_torture_ops busted_srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
+	.init		= srcud_torture_init,
 	.cleanup	= srcu_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
-- 
2.54.0

