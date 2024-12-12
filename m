Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303CC1A7273;
	Thu, 12 Dec 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029488; cv=none; b=Om2PQ6qlz0oWbsEElpI6Ck+LFNZFlAKt/hsJR2L9JoUQ7RUNMBdJ1Wf58trF2Kiv+mOmiS9nnjoYodga7dAr+E6bbR23K/CN8ZyHbo9f6fWtS2KeBtyG7pE+eTsKwhR9avY6y7NP0NFi+eBTu3jr+9KmYAtTyvXxImGXdHhPKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029488; c=relaxed/simple;
	bh=9LAc+KmzGouRxxmiYt4dsholAgVMkHQ0Pn+gD/Oc/CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwnSbaKsfa3CGUfNLmJZ2E6COZVONoxyLuYE+BeOTbXvLzv1VhoGnf3ALYlq3ri98iOrat25SMlh/EVIKL2l1nfLifBayHjtIBPfzolGy47hNCKnr1GcuA+dcYClAObCvbDo9dmyPaBTwhjRJO9kBWkT0Z9MbwE/ccBhmvgYOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXKQijTd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXKQijTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1E4C4CECE;
	Thu, 12 Dec 2024 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029488;
	bh=9LAc+KmzGouRxxmiYt4dsholAgVMkHQ0Pn+gD/Oc/CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXKQijTdfcekib4r9pTkqLNtX5yrcOCqY/7AIRyaAnHxQhG/7KDpd5aD92vWYt6sf
	 /HyRDtr9l40bz+zm7cXLUCMqnl44npV/yluIGfshWj2l8dWmAnT5coL8uxMxPeVvh6
	 /yA7h8p6J03Y/nzevGSRk3R2XuGV/2QTHQmxboZ1ifx9wqVtEtyFRocnFzhIOYN6Yg
	 7AEWH5kBvkkfb3g4DfU6d3lUaP58yfRLaGk/IY5U7UnaXGVlgQ+BCfSQdD7epCCQ7m
	 ms9w2kfv2N03K+BgZgBs7irURy9gPSwTzua80eh77qunVmJRH97vS1SkjFG+CONFvq
	 CdW64HbpfWdxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C12FDCE0F53; Thu, 12 Dec 2024 10:51:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH rcu 1/3] srcu: Guarantee non-negative return value from srcu_read_lock()
Date: Thu, 12 Dec 2024 10:51:24 -0800
Message-Id: <20241212185126.2193701-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
References: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For almost 20 years, the int return value from srcu_read_lock() has
been always either zero or one.  This commit therefore documents the
fact that it will be non-negative, and does the same for the underlying
__srcu_read_lock().

[ paulmck: Apply Andrii Nakryiko feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/srcu.h  | 15 ++++++++-------
 kernel/rcu/srcutree.c |  3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 08339eb8a01c8..abaddd7e6ddf7 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -232,13 +232,14 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
  * a mutex that is held elsewhere while calling synchronize_srcu() or
  * synchronize_srcu_expedited().
  *
- * The return value from srcu_read_lock() must be passed unaltered
- * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
- * the matching srcu_read_unlock() must occur in the same context, for
- * example, it is illegal to invoke srcu_read_unlock() in an irq handler
- * if the matching srcu_read_lock() was invoked in process context.  Or,
- * for that matter to invoke srcu_read_unlock() from one task and the
- * matching srcu_read_lock() from another.
+ * The return value from srcu_read_lock() is guaranteed to be
+ * non-negative.  This value must be passed unaltered to the matching
+ * srcu_read_unlock().  Note that srcu_read_lock() and the matching
+ * srcu_read_unlock() must occur in the same context, for example, it is
+ * illegal to invoke srcu_read_unlock() in an irq handler if the matching
+ * srcu_read_lock() was invoked in process context.  Or, for that matter to
+ * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
+ * from another.
  */
 static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5e2e534647946..26ef58b481aae 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.
- * Returns an index that must be passed to the matching srcu_read_unlock().
+ * Returns a guaranteed non-negative index that must be passed to the
+ * matching __srcu_read_unlock().
  */
 int __srcu_read_lock(struct srcu_struct *ssp)
 {
-- 
2.40.1

