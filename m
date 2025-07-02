Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B4611E;
	Wed,  2 Jul 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415815; cv=none; b=F08i1shej4qrvUFcVp7GBQqjcqNYwrdHn9aKamQt8Ynf8KaaLI/x1P8RC/Sjy+fdgW8ByGDjRBwGJeBgh+kmuTJgtmzX2Q7PsNtaR1Q3VrESZnT3cn/uy7x2OLoNiYhepjuqdVLruEto2IXROVLOaNHFLz6B/Xmwqw9E2/Pg7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415815; c=relaxed/simple;
	bh=XKD9SBZvmJ9Juwqm61OliBDzCPO44hPv2Dn9w0s6sgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXhE2PR6SKfhadX+Hs14d98f6ERqjJ9do1bT8Z0S9nINUMvDjFFOPKY4f8I/zHQkbAkJIuy+27sT8xaKFrBtj/1TUMK+O1y1MLCSri83uzP9N3R7vr+345vzeDq3fRKPFEnOfrWJMM3ST/NU0zG4cZG8Y982FB5QqXChgGlh7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb6K1gq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb6K1gq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5380C4CEF1;
	Wed,  2 Jul 2025 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415814;
	bh=XKD9SBZvmJ9Juwqm61OliBDzCPO44hPv2Dn9w0s6sgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qb6K1gq9Zwa+YqzablAoKehd5PC1r2p5S1L3jNWs4+fWQN/XtL8wU49lc8QAJ98tj
	 MDv418d9xJ+njZw6pUNsHFZw8/iOKLV6ePpcBCdtUB8AGd8dNZCwSaWuQWZcHDOXt5
	 FEAaaJ3qU4lbZgQb/Yxno5fhFBc7Fg/YCKRqwmT34rRlek4nQJXlilWSuo+twFDu2o
	 /DMw9ndnP1m3RmY4pU3jJpGkl2nfiJyBmmmwXKbhnRWDlTIWl2Gs5896Hw6yfOHj8T
	 XgGtFDxep/RVfZpFYQDaOt9XmMjFOxJG8CqEByQ7ekEH9KVPHk9NfUVSnZtH8NB/oG
	 SyURmK7rvu/Lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CB5FCE0EA4; Tue,  1 Jul 2025 17:23:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 3/5] rcutorture: Remove support for SRCU-lite
Date: Tue,  1 Jul 2025 17:23:28 -0700
Message-Id: <20250702002330.1074433-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
References: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because SRCU-lite is being replaced by SRCU-fast, this commit removes
support for SRCU-lite from rcutorture.c

Both SRCU-lite and SRCU-fast provide faster readers by dropping the
smp_mb() call from their lock and unlock primitives, but incur a pair
of added RCU grace periods during the SRCU grace period.  There is a
trivial mapping from the SRCU-lite API to that of SRCU-fast, so there
should be no transition issues.

[ paulmck: Apply Christoph Hellwig feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h    | 2 +-
 kernel/rcu/rcutorture.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 900b0d5c05f54..c20dacb563e55 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -49,7 +49,7 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
 #define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
 #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-				SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST) // All of the above.
+				SRCU_READ_FLAVOR_FAST) // All of the above.
 #define SRCU_READ_FLAVOR_SLOWGP	(SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 213f23f20a64b..7a893d51d02b6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -718,11 +718,6 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 1;
 	}
-	if (reader_flavor & SRCU_READ_FLAVOR_LITE) {
-		idx = srcu_read_lock_lite(srcu_ctlp);
-		WARN_ON_ONCE(idx & ~0x1);
-		ret += idx << 2;
-	}
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
 		scp = srcu_read_lock_fast(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
@@ -756,8 +751,6 @@ static void srcu_torture_read_unlock(int idx)
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
-	if (reader_flavor & SRCU_READ_FLAVOR_LITE)
-		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
-- 
2.40.1

