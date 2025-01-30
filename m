Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993371EC00D;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263202; cv=none; b=mxcp5Y72ZFHr4PSeTTitO4tKg1JMX2MB2sS3Sq3+DKNBLJQPfMxkdEhMvc0Xu9dye5XVCYW8lIvCaee930xRFm75rtbX+SaUxRItG2/JHhv95zL+YesGP7t5tr+75AsHpptsYK7+5+bg0jKMG3v3RcWrlS+fEuNf12/oE9MkLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263202; c=relaxed/simple;
	bh=XGODaq8sM0M1EIXd4Gz/Z9HheyceTKMSkjYKFBOTTBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lq0PqLvSyEldvtb8nNzAo+oFCY6y2R5c9/ad6dF+OmLD+Lnz7KEYOFHCrj9SagVkTZn4Gk3qXo76QaT2hqzwGtIg1e4VXYsk4yj3kH7YUzDRqCXaHOb7rS5g5R0k90P/HYltvgGTC7hPE6qsSpuGpaT6PCQxhyU8souZm4/0S9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK6gwIG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK6gwIG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EECC4CED2;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263202;
	bh=XGODaq8sM0M1EIXd4Gz/Z9HheyceTKMSkjYKFBOTTBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PK6gwIG9zlmVuUmrkONS3HxliK7c47dC+g8egCtzbjxvuRdiVb5/Hhs2ArBVpIuuL
	 +ebSvS8iEUfA0CN2hPevC8ThOZdoejIZCyvCb1cmLYZVjTafJtYNnkq9SaTXlnyTYz
	 l/7SCSTTh1qzR1wIKrSHWzjnUU2l1eLj3C3c87eKNrYizUCfvq7+sUzBgpBBhKB9yh
	 JZQJExQz3L3GHXs701cG0VmeaMH2cg0BNovBN8+2KuaBYIhoT+mDvqWpNquYzzhXAv
	 FAQ05R2tZGEKvUTNgO1zaIdZrr8T6oUu2/mgCinyFC/KLFQ/kUSzxsXTXcBvwACVi3
	 7/yHnPu6+kwlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCBD8CE37D9; Thu, 30 Jan 2025 10:53:21 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu v2] 1/5] rcu: Split rcu_report_exp_cpu_mult() mask parameter and use for tracing
Date: Thu, 30 Jan 2025 10:53:16 -0800
Message-Id: <20250130185320.1651910-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit renames the rcu_report_exp_cpu_mult() function from "mask"
to "mask_in" and introduced a "mask" local variable to better support
upcoming event-tracing additions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 77efed89c79e..8d4895c854c5 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -230,17 +230,19 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
  * specified leaf rcu_node structure, which is acquired by the caller.
  */
 static void rcu_report_exp_cpu_mult(struct rcu_node *rnp, unsigned long flags,
-				    unsigned long mask, bool wake)
+				    unsigned long mask_in, bool wake)
 				    __releases(rnp->lock)
 {
 	int cpu;
+	unsigned long mask;
 	struct rcu_data *rdp;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!(rnp->expmask & mask)) {
+	if (!(rnp->expmask & mask_in)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
+	mask = mask_in & rnp->expmask;
 	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
-- 
2.40.1

