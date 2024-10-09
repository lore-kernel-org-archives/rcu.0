Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FA1E1A0B;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496976; cv=none; b=N85Y4XtFnOLa6Yjmn3eAijCg3APTkbK4iHGgAI61WWzaQ+dUQ7xGBBeSoJhSaIUuV2R0PfkkEfDTLGSrNIZY6xx2lhze5j0bcFtnXFM86x8qpH2rJAkzaUt2wmQATYnFMIaHmo5sEiSmn/Foi1fe20ItpbyEMiY18hPT5G56KyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496976; c=relaxed/simple;
	bh=r+7xfcD7mxFvIDSheG/tRqNVT2+4G41e+4hHqbryp2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yipe5MjUv/37TIfoKoK0LkSCmgZQU87OR4fDctFoq3QfxKJy9Zdauk3FMr/OudtJ9iy9qCHj2lY3dSpvfYvxJmLNmcZguo3ttZgQzxDJaIIOyrpWFa6TLVLH4FupmmPrUn073NLTucrj28atsgC4CEDV1qzTy4gv3JFqbmFVkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9+JjfhU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9+JjfhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B694C4CEC3;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496976;
	bh=r+7xfcD7mxFvIDSheG/tRqNVT2+4G41e+4hHqbryp2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9+JjfhUmZ0+opHk7pINHKDaAMx12EBs+g5xii95TnzTdZpm4L5kOxRr4gnI+Xeem
	 ap1FKMIO95RXZNa5pbu6/o0hkU/XRlvF8A3wktDQk/Gh/L17L9SjB/qyWoDe2nv56Y
	 ZELzekIeDVEYWYitKZE2mYpdsjBEAUtsYLPhpSMyxWhzwb1dRify3dwUUTbyoo+HLl
	 +JMJL5sOK8ESs32Z8o8Vn73NBts9VkHDhu2MZJcTlMBzW9myq4NpZ+od1yCiPCC4tK
	 uliwR3xDVlq4n40M0a8QX1z8l0X4XE6fMXG2OyetxkYrviigaENKaln4g+nkwOhEAc
	 imltHfVJibScA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C50D8CE08E5; Wed,  9 Oct 2024 11:02:55 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] refscale: Add test for sched_clock()
Date: Wed,  9 Oct 2024 11:02:49 -0700
Message-Id: <20241009180253.777965-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
References: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a "sched-clock" test for the sched_clock() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 0db9db73f57f2..639d1cfc657b2 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/torture.h>
 #include <linux/types.h>
+#include <linux/sched/clock.h>
 
 #include "rcu.h"
 
@@ -498,6 +499,39 @@ static const struct ref_scale_ops acqrel_ops = {
 
 static volatile u64 stopopts;
 
+static void ref_sched_clock_section(const int nloops)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--)
+		x += sched_clock();
+	preempt_enable();
+	stopopts = x;
+}
+
+static void ref_sched_clock_delay_section(const int nloops, const int udl, const int ndl)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x += sched_clock();
+		un_delay(udl, ndl);
+	}
+	preempt_enable();
+	stopopts = x;
+}
+
+static const struct ref_scale_ops sched_clock_ops = {
+	.readsection	= ref_sched_clock_section,
+	.delaysection	= ref_sched_clock_delay_section,
+	.name		= "sched-clock"
+};
+
+
 static void ref_clock_section(const int nloops)
 {
 	u64 x = 0;
@@ -1083,8 +1117,8 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
-		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &sched_clock_ops, &clock_ops,
+		&jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.40.1

