Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E92F12AC;
	Fri, 31 Jul 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459719; cv=none; b=IBbK71tBbMsjxz0kgc3pOGggjrBaMTc9ej8vKi0toScJ9VZPrXG+q3jQT2KkRFyIeqdwiE2o4ATgBc+d/eeWf1DXxHCJpPP6/I8x674XLKmgZpU4wReAPR9Mt11rA1L+QBHc0l/9vXMzaiQmyVfmybVtkizo1sTkRj9ruTMTAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459719; c=relaxed/simple;
	bh=t5WQzXm82XcY2lmG6o7wKIY6+mlLPq2sqJQIuT00QvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7mSCTwdRO4+LHt9/wLFF62cVEd4/eFMsdBKD0OZYmmjHozzNhOLsatixFOEtecRAyWN+CDL8WJhwUTFWdXXwM7w1C7LYzy1RTsivNJgQhNGM6kbQvZT/SkH7Da1u9X+YrCLiTAIwcGgriSTwXVrDuZowvanaZkK4fCp3nygY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8gXgSYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8gXgSYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6281F0155C;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=kUJWSJos+ec0YSV4gsbHXxgDbpvO7KILoAM/0D0XkZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8gXgSYHFUh9S7zcajrOLrWdxodX1tbrOZ+uoU5Nstfum6fFjr5WZlE9S3BnmhohF
	 orbnnp1H99+Lb5tG50aawGW8nVuymv1NNjKvmnX69J5iG1Bo1r1PeYcnii0qfMgYlG
	 JRDQgBVgFVukDFiAaVe6JCEPE440RMO3q12Qo56jTxfP4tQmZzAyzi9YMyistUgBJ4
	 VREdLsdqLeBqfSEMeXnlsgbOJDVaCwB8haU8C6j+Hv00c51H5nxpVZuh7aaZbcGdw3
	 bW5iSu/BKQMmY/DLfsHJkHZo03SQV0vL0Zz36HrOuGYrJ38wOt7Ux7b8Nx4t+If5nG
	 lut0xu7f8U/cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8E78CE1A76; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 16/16] rcu: Mark interrupts-enabled accesses to rdp->cpu_no_qs.s
Date: Thu, 30 Jul 2026 18:01:53 -0700
Message-Id: <20260731010153.3531313-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rdp->cpu_no_qs.s field is accessed only by the current CPU,
but can be accessed both at task level and from interrupt handlers.
All accesses from interrupts-enabled code must therefore be marked.
This commit therefore converts from __this_cpu_read() to this_cpu_read(),
but only in interrupts-enabled code, that is, the rcu_qs() function.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 844a9ced67cc0e..6904a4f826d1ea 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -976,7 +976,7 @@ static void __init rcu_bootup_announce(void)
 static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!");
-	if (!__this_cpu_read(rcu_data.cpu_no_qs.s))
+	if (!this_cpu_read(rcu_data.cpu_no_qs.s))
 		return;
 	trace_rcu_grace_period(TPS("rcu_sched"),
 			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
-- 
2.40.1

