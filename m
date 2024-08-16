Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762683A19;
	Fri, 16 Aug 2024 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789569; cv=none; b=NdhEFo9fXlSIOlTXYTqDY1t26wjdr07S+5nhqlMMgxZm9am7f0Wl/uJux/PwQ7qh3nl/GTtwt+j/P/eI+N/fCjcMd67xcqts21x+pR3NQrA4peYDDdvBIaN7Ye7BP3aZ/dorskt2k9Ep+/NkSKcrvzemieI0ZkxAGKQPuiQ13UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789569; c=relaxed/simple;
	bh=a50R6TKDimULRwRc+zcx9JdRK9sWmFMjeOzUflwXYxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KF7cJM/iK0VUfwhCfqUgx/SCh7+kGriQwwfap7wAVIm+Xqovd3Bm8iRVchUciuqaxkDvzXTBbusCirN5KGQKhVugoFGd3S7M+XUVp5a3mDQyjzazNKDAI+Ru3w6/etYUhr/r3NAocILWBk9W0csam/jh7uPZPn6fN+pXqoD1rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHU/GKcu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHU/GKcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB52C4AF0B;
	Fri, 16 Aug 2024 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723789569;
	bh=a50R6TKDimULRwRc+zcx9JdRK9sWmFMjeOzUflwXYxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHU/GKcuVuTGQT9e45RWGxgEVXZRahejvymggApyTzqEAhgcQieh5QztFb9vdn1Lk
	 t4IgqUqNFXZs1+LUz3qMbwH2kaR7p0cxTQ9Sb/1HeXK3SS2zvclHJGY7LLXGMKO6S+
	 9H3srNFfZwZHt57h5YOlnDDmaFVWAEY5pROCe/vdsXIiyG8M5K9ZjKfS7YdLrF+Ivy
	 4//vp3CBOBVBud1MHLEpYSUu1Ury2wUhRRjC90aGb9P9YL5i3XIM7Lz32QV0ibKwYd
	 dO03XxhhEy8MP0tSdZOnWYuvr2N0OEM8v0Z0VzDJv9q0H1sggJNemZxZ2uDOzDQ6kH
	 K/D3AI0eefSRw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 2/3] srcu: Check for concurrent updates of heuristics
Date: Fri, 16 Aug 2024 11:55:31 +0530
Message-Id: <20240816062532.51893-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816062445.GA51253@neeraj.linux>
References: <20240816062445.GA51253@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

SRCU maintains the ->srcu_n_exp_nodelay and ->reschedule_count values
to guide heuristics governing auto-expediting of normal SRCU grace
periods and grace-period-state-machine delays.  This commit adds KCSAN
ASSERT_EXCLUSIVE_WRITER() calls to check for concurrent updates to
these fields.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6fd9c914ce64..aaee09a6748c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -629,6 +629,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
+			ASSERT_EXCLUSIVE_WRITER(sup->srcu_n_exp_nodelay);
 			WRITE_ONCE(sup->srcu_n_exp_nodelay, READ_ONCE(sup->srcu_n_exp_nodelay) + 1);
 			if (READ_ONCE(sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
 				jbase = 1;
@@ -1819,6 +1820,7 @@ static void process_srcu(struct work_struct *work)
 	} else {
 		j = jiffies;
 		if (READ_ONCE(sup->reschedule_jiffies) == j) {
+			ASSERT_EXCLUSIVE_WRITER(sup->reschedule_count);
 			WRITE_ONCE(sup->reschedule_count, READ_ONCE(sup->reschedule_count) + 1);
 			if (READ_ONCE(sup->reschedule_count) > srcu_max_nodelay)
 				curdelay = 1;
-- 
2.40.1

