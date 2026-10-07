Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591E41BA9B;
	Wed,  7 Oct 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406770; cv=none; b=VMSu5WUrOgIKDA8FLtWIc9KuopI87cxW+TEWKQ1h16+rmnWoOORFpWeczMk05UKw5ttH/7j8tvRBreuO/3U3pa2cMUl/7IJ6U9bAD4lLmZox3488UlIuytNUZKixuBwSpXOtNzBWJHUpFItpLBYmZ4Tzo3AZhxFQfzrJjNKb3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406770; c=relaxed/simple;
	bh=iyoc/KTi+0WyM76X3n8wJ/4/zNnc6bdd6T8yNaaQLHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4WdJqfzZMOxGCnuSszkUPeQZ8OpUnujdT9zKlbUsatjL5uUjmGRDnbuv3yo36LsjK5XGxCmfCyH5Wc9oSveL1ytIljr1SPvpxxNCIJhb1yDB9aJ3fH7S73u2lwnAyybybJxwTAkwpOedcA3WoM0tcqX7rUbNWBjllwRtuVjlHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAImgnS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAImgnS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3C91F008A7;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=VSmAohWCQqYNsxKXKpXluLGBppm0H0MUrwYwILS9GgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAImgnS0iY6Sy3GN5gB14D58xJjuKvpqy5jqC2R6ELMZLs5/xZFHgdK3FJvwRsjUE
	 cHE8u1SHvps+flPd2KpZCyv93+SZzCbKsYkdZ+NaA9Vo9YnW9t4Bzyc7KWop1mHmQH
	 BSzmisHeztkMFM5Fd+u0etmKuTWCT2Ip9CH5n5mttbmfe52kgmluZ8LIZ24xwGyfWC
	 bt43JP0cdY5XfxVNBSnsIWGHXl+vpudNUKTUQj//8q+ujBiAZSTPb694EuNQfr0xND
	 mJKWPZy2d3BnqNf7/RiMIfhzrdnNkmieL59KKv9bcWGf/6PNCwTYraEIJ2wSi5i3YT
	 0i7uPxO0OhIrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 35D03CE3993; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 15/21] srcu: Restrict atomic-SRCU non_block annotation to task context
Date: Wed,  7 Oct 2026 13:59:18 -0700
Message-Id: <20261007205924.1983367-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
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
index 3f232f2e05244..1a8a465a5650d 100644
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

