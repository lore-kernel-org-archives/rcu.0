Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616B80027;
	Fri, 16 Aug 2024 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784247; cv=none; b=KGEGopvgaq8xtNU3TW6Dec1b2a9HZ8cBlS3I9DZdoqtfZehKHlOoKqZ5xzMskuKpFfcCBGXNVOLstJVvuDvnj8JFmMfuD0v+XgOsr3Lnv7mLPZeSbWSvHHEs2T9eebY27N0/Ma8FZHIT6BCPxPp/OLPLStRrl7KoRx2qA5M4l+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784247; c=relaxed/simple;
	bh=rF+0vUIHc6rNRHp8c/Sh5lSPFbUceqWXdRxT2SGUHFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPP2FI33BjXcQp6wf2aRYSzpUuXKeM1h9Rd6cO+Rr7NUsCurLbqRf02N35k2GEGIGFvcqUxYT19SPyB+ktpxLavnHacQCb5HD+lJs1x8ljGIMDS5xLdcfOzzvGyPprpy21sVVGqI94WfSOAbiXWqfErTZKaHX8YFl1pzHsy/o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfmgxlZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfmgxlZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FA6C4AF0E;
	Fri, 16 Aug 2024 04:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784246;
	bh=rF+0vUIHc6rNRHp8c/Sh5lSPFbUceqWXdRxT2SGUHFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfmgxlZctGjI/Hwf6Y6d7NylevMr34biCNMjLFM3ntu9gZ9jDuFjIH+951l/Zw2FU
	 1EPVjs+uRomBAhyqblmLgbCib6/pRrilJRKSvnBRD04MAWmxVfdW0jQhceJ63Hu38V
	 ERydVFWM/e/S+SykuykgREwt6LmzhtycFFaCG4soCr+Wyr2/Lj7SBDiBjBVW57X+db
	 J7heWwdRuQzfD8TaTnAfsUFbWSdphGAor/o1clxMm6PjZqoDQ1+HtkTzwc8zsvPmJb
	 B38DfxjB8GmtbHFtflknZzK8zO56+6NiaYZUhs25Rn1ndU2644VaDEUnF9IsqhAhKS
	 DTcZsDCbHvNEw==
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
Subject: [PATCH rcu 07/11] rcu/nocb: Remove halfway (de-)offloading handling from rcu_core()'s QS reporting
Date: Fri, 16 Aug 2024 10:26:04 +0530
Message-Id: <20240816045608.30564-8-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

RCU core can't be running anymore while in the middle of (de-)offloading
since this sort of transition now only applies to offline CPUs.

The locked callback acceleration handling during the transition can
therefore be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2b9e713854b0..60f271f5c079 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2386,7 +2386,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needacc = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2423,23 +2422,11 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 			 * to return true.  So complain, but don't awaken.
 			 */
 			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
-		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
-			/*
-			 * ...but NOCB kthreads may miss or delay callbacks acceleration
-			 * if in the middle of a (de-)offloading process.
-			 */
-			needacc = true;
 		}
 
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-
-		if (needacc) {
-			rcu_nocb_lock_irqsave(rdp, flags);
-			rcu_accelerate_cbs_unlocked(rnp, rdp);
-			rcu_nocb_unlock_irqrestore(rdp, flags);
-		}
 	}
 }
 
-- 
2.40.1

