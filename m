Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BD279907;
	Thu, 16 Jul 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161424; cv=none; b=Xs/xHJdba+uZH+U4Q0UpfIUDJmkKeVQwMJsFs8Jp+3qZgZbyK043Y/qUfcDoIWG33A3vB9s8FMsjvChOQw/flnnIvq+2LHUoSYq7pfU1i4TfdRh/ez2Y/7oBYC8NHYjgQVbNC/M90qQXPXkJvpWlRd2NtxjYtvCpDnvi1N+byiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161424; c=relaxed/simple;
	bh=iqoAIdCEzAX3DUvsRDNwHLgSBngO/mWbr4fCwZWRC5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYIWAyKeV2NGM8seG9M0CVGL9UfNUf0fFSs+sTSpLQrMVfqBmIRA7oKD/GryWA/z3cAxEOe6fOcmD0SYPc9Q6TciSIKaDCWuGfZ8H3qD2/jmV7RUWfWk64Ost0pqVXYT5qmUSam9L0CARowaCZGX0M3sovsSI8ednQI9J3zHccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X48oci3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X48oci3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7207A1F00ADB;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=KfUyhiM9EnLCPMvsieJRQ8z3kIir57yeVPER9WvBHqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X48oci3FjFS0kCVxrF/eZrSe3bxN2/q+WqHz219oggBu/R6HZSUgqdiGQ4CxuCtau
	 qzLn1HbB8B/WyF0ZHNSuf+hmJHw37/wQZedn7pOHZIPwdNAwOzSdauJ2FzWf9iH1/x
	 FJMB7qyGFhjDlpsJ6x1XVE/7AZrJm3h0zNg2YTBGfN2IuzPME3e/MZJqmqjWeuZlqH
	 1AXyN+bHnYp7ChfOpfL4DlzHc/H7ZBt53z4C1lapHymwLAQlRI2k/NLrsE9XidUavx
	 GJNTBOC7AuNqwDFWha2fIab0M7QuVpBFicAzsW5k8OL2Y/aFe9cff46P0++j+Azp4A
	 vJehGwvDMehrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A777CE0E86; Wed, 15 Jul 2026 17:23:41 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 10/10] rcu-tasks: Update comments in call_rcu_tasks_generic()
Date: Wed, 15 Jul 2026 17:23:39 -0700
Message-Id: <20260716002339.11717-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
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
index 79aa5d51388c45..8456b132950278 100644
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
+	// irq_work in order to to avoid potential scheduler-lock-deadlock
+	// lockdep splats.
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		irq_work_queue(&rtpcp->rtp_irq_work);
 }
-- 
2.40.1

