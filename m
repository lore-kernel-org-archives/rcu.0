Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9B2D322E;
	Thu, 16 Jul 2026 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161707; cv=none; b=OcagkJ5AIK9L5Ggx+9hdbHE69S2AVybpBGEyT5YruT8R394WLhdsM0enufy81zZc9IsgBf0fj9+mDwtqoWo6x9lqWXmvIBA42quWWkPkGQBxJaR8wjHxk/NjbryUrNhORer9IjDg1HmZup3nO87gevSGLDMgqhfFIpudGXPrYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161707; c=relaxed/simple;
	bh=Rl00XC1ehwn2H9cCcEJlBpQZhGpGhXrtCG4dWtCYznY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpIBfIg7Hl7xNqHeMMBKhQRnz3THTr3egxnwI0NPNWdNctPMXV0NmrRHC5bb+ZkiZxvfHdhYR11kiTWFDzQwAXORYAC9XNQDR6UcSImE3YD1Cp52Kx97lrJ8YYUdxGzBsa2TfPWuWBepyHCsOrs0PcnevcAOVcnJfzyfbxycLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKUNvPA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKUNvPA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C991F00A3E;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161705;
	bh=cck7VcezaFz+NOrwA1nANKOT+K8ZYsRsfJL4fBsY8Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKUNvPA13JogXK5F+ZpqTPHn7szWb2HqkvEtWGO962B+mmTAXk/Om+HmVZoWsfDwv
	 WQlpTV0vrOT97yzNSyDRwLLISfWX9muWXikpwqfc59xkhwbGCWpEpGmfvy9AC4YO+C
	 kmHZHCHEJAPaERX3a0YF/H8rY1jU/GWo+27sRc8mUihUxoX9zR1qfUDfQ4ii1umQ2Q
	 maK+uJnoxo8GKgUs74IqlX3suUXtscJGMIBaUrKLYJWhCJf6VDnUWq1+DpHfmxq84c
	 eiwyhs0SnQ9dDMIo+kcXq1JQHJDX6XPQF2lNpyRVg6M1sMgSipINY7COY6T/xEBxJb
	 bd34N1ErRhtjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED06FCE0D3B; Wed, 15 Jul 2026 17:28:24 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/6] srcu: Queue sdp->work when the delay timer is successfully deleted
Date: Wed, 15 Jul 2026 17:28:23 -0700
Message-Id: <20260716002823.12176-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
References: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

In the cleanup_srcu_struct() function, when iterating over per-cpu's
srcu_data, timer_delete_sync(&sdp->delay_work) is called to cancel the
delayed work before doing flush_work(&sdp->work).

However, suppose that timer_delete_sync() returns 1, which means that it
successfully deleted an pending timer before it had a chance to fire.
But this also means that the sdp->work will not be queued, so that the
subsequent flush_work(&sdp->work) will returns immediately without waiting
for anything.  Taken together, all of this means that any recently queued
SRCU callbacks to not be invoked, which can result in memory leaks,
hangs, or worse.

Fix this by checking the return value of timer_delete_sync(), if it
returns 1, explicitly queue sdp->work so that the callbacks will be
invoked and the following flush_work() will correctly wait for all of
those callbacks to finish executing.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4a00e90e17fc07..8b4e7783bdc963 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -701,7 +701,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		timer_delete_sync(&sdp->delay_work);
+		// Call srcu_barrier() before this cleanup_srcu_struct()
+		// to avoid triggering this WARN_ON().
+		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
+					rcu_cpu_beenfullyonline(sdp->cpu))
+			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
-- 
2.40.1

