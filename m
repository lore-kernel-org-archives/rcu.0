Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC722CBEE;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057945; cv=none; b=uqYET2YO54QNICWohQcxp9oZDZb+S3EVmWHQlAx1xFi3WpbZO1wef7ptSApf86l7opZP+PYVqwf2MF18ND8Pe1+X9L1MSsN7JLdcOOWk14xH9fB4AezrfxOwnx6Fbg+arurM9lFZhD1kcS/80PvIqJLNFY+m2KzSDagAhoZhii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057945; c=relaxed/simple;
	bh=WMQ7DP9OiOxGto+2UoZj3IavynbQoyjALlXlLrmJ9XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K66eAaaL+yYN8jwGRwW85KFhEtFG73NqpTPxz/tS34ENcnb8fwXqRAoJsPXGQ8NH6lqXgCp+A9rFUXHQXSriSga+g05d3ou36Q7X426dEbljzlmQ/QhwQjS7UC+QAkwES2D3TFr5LajtUI7yDKdAmkgXVaeQ3l4gFBqdF3ExIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfGbICgQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfGbICgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D72C4CED6;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057945;
	bh=WMQ7DP9OiOxGto+2UoZj3IavynbQoyjALlXlLrmJ9XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfGbICgQLsRbw3ftKiz4V5vKHFBzrCDmivdd4/DsNTsomLjOUIfi0LiyOnOJERlo+
	 0cFPbQNnEpiIXsaAEt23SjWkrueXCg6QNlfzgI2wQld4i+cPJ9d8NZnHKz7a9xVps4
	 3C9Ze7iqo1IDIARxP2ts8WuWeshquPJ+7REABNlLwIiEUF4NlxmSkxG7RAW/HxfaN7
	 Ev1oBq+cxsPKNNnDDO4o1PiqVw3QDDV2YAa5kz/uVipwUP59Ekv2gAOBcwvXHhCrPM
	 LpSEXJjul4ddw2s5DtheJzTFMT7+9xH5hCMHFUka1YV/4Rl0q5ccx5aa4T7xuQw7tZ
	 0Sj/cqHaqTrmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02437CE10F9; Thu, 16 Jan 2025 12:05:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 1/5] rcu: Split rcu_report_exp_cpu_mult() mask parameter and use for tracing
Date: Thu, 16 Jan 2025 12:05:39 -0800
Message-Id: <20250116200543.3782539-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
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
index 77efed89c79e3..8d4895c854c59 100644
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

