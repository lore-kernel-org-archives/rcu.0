Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022B24A05A;
	Thu, 13 Feb 2025 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489172; cv=none; b=XJtjRhEg0UhIehaQGGsGe8Ho6pGxt330whdv/+GT7P1/pr5ebtgtQWTNqwI/9Zkh/wT3H+trg3lyUr3Fx34uyJIUOYmPqqcXMghr2Ny07g+BC/bV80M3rwJkOanmN2aZekiV9lYvJBoiOoX+CvKu8sLUuqotClZYc7k/jHrC9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489172; c=relaxed/simple;
	bh=h2c3p5IRVnPlkrbT+U6oZXQnZrjV6yS35OkqeQuIypw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIkrNVcGsRVl9940PH5uDuwkw66+9G9ncpWzc1tGaAaAT8TI1yHFecM1QoWObAoEJpJ3nYxEeFUiERvGDsbgKHRmh4ZxUMtWYM4a3s3s2NZQe2OmS1wFlwgT1X+9csqAg3uoATlUL235L9CPdS8D/BrvqX5SgcgoLaRMCR6iCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhHgLjbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhHgLjbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C4DC4CEE6;
	Thu, 13 Feb 2025 23:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489172;
	bh=h2c3p5IRVnPlkrbT+U6oZXQnZrjV6yS35OkqeQuIypw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhHgLjbGw/fjNl0yDpInuhIT0/A2dvA9AIpJJC1mNyCdUI3Dsit19P3sfeNJ1Ff38
	 bJlGMIS40Rbga2kW276IEUHqATNKkzrrLl3ATbh2cct5aQ/EPoLrsxX2IRpc3Qdnto
	 X/wPuWBFHpcxH84/LkTNGkCp/+i6lqhulYK5j9XBq5a7BIqcKfAST8fHIxeWr9P/Tf
	 TSB8Fy7BXlChGOk+1SkxMELER5qZMptGPmCzsGpFzLaWVTmVBxmVbMrRBdZknOnbMY
	 wvB8/k4luM8h80/Ayn8Aw9aBLDCK2IgkgfYiki/9bUcH+KweBGZmV3+EXjTkiwU28v
	 MWjytyG56z63g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on task unblock
Date: Fri, 14 Feb 2025 00:25:58 +0100
Message-ID: <20250213232559.34163-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250213232559.34163-1-frederic@kernel.org>
References: <20250213232559.34163-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A full memory barrier in the RCU-PREEMPT task unblock path advertizes
to order the context switch (or rather the accesses prior to
rcu_read_unlock()) with the expedited grace period fastpath.

However the grace period can not complete without the rnp calling into
rcu_report_exp_rnp() with the node locked. This reports the quiescent
state in a fully ordered fashion against updater's accesses thanks to:

1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
   locking while propagating QS up to the root.

2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
   the root rnp to wait/check for the GP completion.

3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
   before the grace period completes.

This makes the explicit barrier in this place superflous. Therefore
remove it as it is confusing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3c0bbbbb686f..d51cc7a5dfc7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
 			     (!empty_norm || rnp->qsmask));
 		empty_exp = sync_rcu_exp_done(rnp);
-		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
 		list_del_init(&t->rcu_node_entry);
 		t->rcu_blocked_node = NULL;
-- 
2.46.0

