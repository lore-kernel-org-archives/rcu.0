Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4628BAA6;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781643; cv=none; b=LVliHPUzZ/+FXpJXtsWur/muPq5ajqybo0AYTU4og93gOV6JQV+uKgXj3/5nzmtJCdGh3ZNAGHEre7/de9TxsoZJNH5hDRQwzFGqbE5lLieQA7X0jPfh1Y1vA2iHNLAsmUBDOu0XEZzRD747vrMs78/tQ9Jn7NTBs5GSUxlPM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781643; c=relaxed/simple;
	bh=4X5dARQ2Ga38uOazZA0mEWLOEAGFA1bLRWqCo/q5AUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVzEleCIM1iF3QKpI9kxmNiK6PAPhvtk8VSWZL9jrGyhzc493+SMNYuPEqexBU6IiyPr1x/L4ke+H9M2LL0/wUZNd1B7/YdI0eq8sn31uPEKlmZS1Qql+CpBda9FhIvDZud/r+GCWn91nLM2vnDkZjjbFhmormkPiC9DBpJe8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4JY7NCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4JY7NCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2CC4CEF3;
	Tue, 24 Jun 2025 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781643;
	bh=4X5dARQ2Ga38uOazZA0mEWLOEAGFA1bLRWqCo/q5AUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4JY7NCwez5/zlnsJboPfzD0glMD8NYttk6yXJNgv9/fY8IsW3tnnkDshtnJ264lV
	 pkchZq+o4mbks44b2DOCg+8IO2u7ZGywSGPGj+0k0Tj6vN82KsvBQq6dHbglqGqwAt
	 RtUSWXM5tlT7d1yUoRXdOoy8aRiYdC8v4R3kRyHbI5rPuTUTcW4s1zu0lCn6TFeX/h
	 qA8SlO3yEIe9iS9VBV3hmnhl6Cw/rlWCtD6XTVXyXHQGw0F1Lb0GTW4x+8ovk6aKGD
	 2QcqWKDI5+PCZUP/qeqFqNDDw+JSVzepD+YDG7/YRRbvDQNMqa1cs/eU3tlZGFSYu6
	 MKn59EYiCI5YA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86043CE0C35; Tue, 24 Jun 2025 09:14:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/5] rcutorture: Remove support for SRCU-lite
Date: Tue, 24 Jun 2025 09:13:58 -0700
Message-Id: <20250624161400.867880-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
References: <e5dd6af2-fdbf-4773-9732-13b84ca13a12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because SRCU-lite is being replaced by SRCU-fast, this commit removes
support for SRCU-lite from rcutorture.c

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

