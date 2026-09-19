Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190330F7FB;
	Sat, 19 Sep 2026 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778144; cv=none; b=szh36iMrmhzpddz9wGJ0FHIvYj3kYbd3inJFDcEY5Se7CQhRl/ruh05/Z7gpYwaRFQH/72+4FKYoPGiV7q4vYBcrQjvwb7eQjNJ9cAernEqVPNom3AKcwrkLTkJ3oK7iI/3RbJ9ctgDyprnYrVsnZgX2t0MgBjNZrKxwfBHRTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778144; c=relaxed/simple;
	bh=e7jkUh+A7HynrbIIM434c25BwDym5L11ALJNVJFKl4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQUXAwTjg7qvNlk3R7S8Zk9OwbIWkELc0azVRwopyYD4DYx4jdf+0JvHPKkY4rV1b0QMuvTNErZg/brH5duMEsjGOqDPC21E7zvkZLgAJopF3nqNXTupny/5YfYX+6Z8gT3a936b2wey55RU1qGf3a7tqYTYFB3EOMJuoQu81yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmUeCtbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmUeCtbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DB31F008BE;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=6pq7VquZ+VbmZ/kNLwHzh1Y+rigLbMnLqxyYRhFn5Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmUeCtbp/cGZcbOivG51bM7/FjXekmsU5838Vr0oEVvj8zf/4vgZvYNvV/oVnkpAI
	 9PbphcD+fSkGpH/rN5Bqdfn8kFsY/ZTMKCOMwjEgY70Eaxz5DvJ+nCPzftXwbKY/V/
	 HNGUPjjvpMWCYx3sNtYWL2h8ar6u2oS6t6itCEa9tE85EDvqmYFAq7THjzGdf0Q4Px
	 FCZ9EHzMqsy7StO0iX5ilsSTz7LMGALNyW4Lg4xt8dcI2XiVaOvZjajsyTggKQ17sx
	 dg+SYHX5lAGbJm6DiqQZUqdPA1oEiWGde5AVvNcVYe2gQE1vEbCMecM3/2eh7JikJu
	 aySBmUPHzg61w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BAB01CE1D5F; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 16/19] srcu: Restrict atomic-SRCU non_block annotation to task context
Date: Fri, 18 Sep 2026 17:35:18 -0700
Message-Id: <20260919003521.3134552-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

srcu_read_lock_atomic() and srcu_read_unlock_atomic() arm and disarm
might_sleep() checks via non_block_start()/non_block_end(), skipping
hardirq so the update does not land on the interrupted task's
->non_block_count.

Inline softirqs run on the interrupted task's stack as well, so a
timer callback running atomic-SRCU readers races with the interrupted
task's own ->non_block_count updates, as KCSAN reports:

	BUG: KCSAN: data-race in srcu_torture_read_lock / srcu_torture_read_unlock

	write to 0xffffa00f818ea418 of 4 bytes by interrupt on cpu 0:
		srcu_torture_read_lock+0x422/0x470
		rcutorture_one_extend+0xdc/0x600
		rcu_torture_one_read+0xd1/0x330
		rcu_torture_timer+0x75/0x140
		call_timer_fn+0xe6/0x2f0
		...
		run_timer_softirq+0xb7/0x130
		handle_softirqs+0xfc/0x3f0
		__irq_exit_rcu+0x8e/0x100

Use in_task() so the annotation is applied only in task context; it
is redundant elsewhere because might_sleep() already warns about
sleeping from atomic context.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 3f232f2e0524..1a8a465a5650 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -346,11 +346,13 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
 	/*
 	 * Arm might_sleep() to catch even a *potentially* sleeping call
 	 * in the section, not just an actual schedule: the atomic-domain
-	 * promise must hold on every path, contended or not. In hardirq
-	 * the annotation would land on the interrupted task; it is also
+	 * promise must hold on every path, contended or not. In hardirq,
+	 * softirq, or NMI the annotation would land on the interrupted
+	 * task, and can also result in data races against that task's
+	 * own non_block_start()/non_block_end() invocations; it is also
 	 * redundant there, so skip it.
 	 */
-	if (!in_hardirq())
+	if (in_task())
 		non_block_start();
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
 	retval = __srcu_read_lock(ssp);
@@ -562,7 +564,7 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
-	if (!in_hardirq())
+	if (in_task())
 		non_block_end();
 	preempt_enable();
 }
-- 
2.40.1

