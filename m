Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781C2D9EED;
	Fri, 31 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459847; cv=none; b=tiEmPeekTKMDUB9TDMUyQy0ytn6N38OwEUugKh9eG//lDYv33JpXdJxMJYlwN4N6W9u4dPFnVnFmjRemYzGV0q2Ig+hCStQdMUlx+BZRBuCSohKpp6QHPwdZcUKTjy1uPvjJZV0ibeOGNZfP94ZaP+wXyAAhOhKOvnsi7OsS72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459847; c=relaxed/simple;
	bh=kixO6JvWknVv0y5UXghrF9REqzOJ/0OUqWnDzoXcuvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lik2wk0dRgXxgz/CHlC8ZncOJJkwOO9fV4L2yjninMJQBnV0+T0OpDieMX1QcmrNhn/aHIqkgkI7bkIH7Smsv5R2+Ew32p9X12WN3vuw+tpJuouTwvwszyfhGRwDdTfB5IGbpdIvhwTuddr2P2TNkRily3ayV5vu8Zr6TnN0K80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n27tkRLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n27tkRLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004501F00ACF;
	Fri, 31 Jul 2026 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459844;
	bh=nEKeOsgSe/HXocB7lbj72PDx0xCpbC4xVzX2wWZdGt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n27tkRLcFZRRDOKZnGSNnfOl2iO8FMdc8I/bhQOIqshVyjd/3nuX5+ZEMD2zFq54h
	 X0/U5/Dcd/Xcf8W9AmRYLY9kiORAnnMfRO7xClRvg2XVVoE+sTmxvKIrJdeThhM28S
	 7iouHg7+4Z3l9zXMpNgDITqw9gLBGHASvRnQlAdT2JBlgY3MTGUrefopGofZ8Civa5
	 CEJ9oLPedC7pPbSqXhtnNZVed9uBr8mLuKbxZHtzztBIljRZJZxA9tw44WvGb+lxp+
	 Vu5AgSJOK1z+J85UOcZ27rNW4gI7ptI0fVyA4FQFzj8Jy1cz2gINlhaSVeHZNiadwX
	 FkQlqU7cDoMbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 973DECE1018; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 06/10] rcu-tasks: Update comments in call_rcu_tasks_generic()
Date: Thu, 30 Jul 2026 18:03:57 -0700
Message-Id: <20260731010401.3531631-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

This commit updates the comment "We can't create the thread unless
interrupts are enabled." from 'commit 4929c913bda5 ("rcu: Make
call_rcu_tasks() tolerate first call with irqs disabled")' to be more
clear and also to cover deferred wakeup and to take into account the fact
that kthread creation has been move to core_initcall() time by 'commit
c63eb17ff06d ("rcu: Create call_rcu_tasks() kthread at boot time")'.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 79aa5d51388c45..bc49698a3bcc14 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -395,7 +395,11 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
 	rcu_read_unlock();
-	/* We can't create the thread unless interrupts are enabled. */
+	// We can't create the kthread with interrupts disabled because a
+	// scheduler spinlock might be held, so kthread creation is deferred
+	// until core_initcall() time.  Similarly, wakeups are deferred using
+	// irq_work in order to avoid potential scheduler-lock-deadlock
+	// lockdep splats.
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		irq_work_queue(&rtpcp->rtp_irq_work);
 }
-- 
2.40.1

