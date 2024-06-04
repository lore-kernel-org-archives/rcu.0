Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828014B09F;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540014; cv=none; b=mqTaxE8FeBDYL1yulrMNwEkRI/J12gw0BGrzHsFWVPOML+6P4FB1nMCorQYjWZN/hbozezG16P49BXq5cswD6/aj9jcE8Txh5URHMR2gqGcYTZUCMCNadAUVVp+9d0UaIUaE3k4e3fAcrT5QdISC0G0K/1uh6blX/eltEA1sIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540014; c=relaxed/simple;
	bh=EJa2/B/2JEA6GDpzIc1X8nYf8o99b9S13mmhOSyFJjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZ+C4DT8jm9/uyyni0IaclAzlu6r4P/2gjhEeaaohDZQ1ROZCmKJQLWl4XtO24COuCsZkc07M87B9rBoaZ7sNH6lnMt2QSftC055b2COHH6ifOOUe09AKAlNj/LfvO+DiEVHLA7ozryefBsLp/7+fF6r2INx5nBgoJJtNLTYD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNP9oZK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNP9oZK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CAFC4AF11;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540014;
	bh=EJa2/B/2JEA6GDpzIc1X8nYf8o99b9S13mmhOSyFJjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNP9oZK04DbR4/EDzSV05mXsdh1GSeulV1RssYxdMCv9AvT/L+hDvS71a8+nWwi/S
	 yXKf9kwMM0CeLDPh5c1QbTH8Og14ds02FRyeRWMBvyw6zGfWAeRzykf4GvH1fxvZyY
	 6DGyzmqtITU3Y7Ctpn8cVHvyJVJyt8bcVomaW/azeDS3qTMGtG1USQWAsIVREd2aOC
	 msNRKXeStwciMR8rUy58BB2wfnY7zGlZZAx6Z92DFG1OiXIXtQkZ4Haz1Ipdjq2ool
	 rzIzSxUuA2EdBL3+kR21nLvIqcz5q+PfLLv62AzeUkd4LXo3eSZJyfDGpqqBDuBO0B
	 HJn9QzTSzSjwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0487ECE3F30; Tue,  4 Jun 2024 15:26:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/6] rcu/exp: Remove redundant full memory barrier at the end of GP
Date: Tue,  4 Jun 2024 15:26:52 -0700
Message-Id: <20240604222652.2370998-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

A full memory barrier is necessary at the end of the expedited grace
period to order:

1) The grace period completion (pictured by the GP sequence
   number) with all preceding accesses. This pairs with rcu_seq_end()
   performed by the concurrent kworker.

2) The grace period completion and subsequent post-GP update side
   accesses. Pairs again against rcu_seq_end().

This full barrier is already provided by the final sync_exp_work_done()
test, making the subsequent explicit one redundant. Remove it and
improve comments.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index bec24ea6777e8..721cb93b1fece 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -265,7 +265,12 @@ static bool sync_exp_work_done(unsigned long s)
 {
 	if (rcu_exp_gp_seq_done(s)) {
 		trace_rcu_exp_grace_period(rcu_state.name, s, TPS("done"));
-		smp_mb(); /* Ensure test happens before caller kfree(). */
+		/*
+		 * Order GP completion with preceding accesses. Order also GP
+		 * completion with post GP update side accesses. Pairs with
+		 * rcu_seq_end().
+		 */
+		smp_mb();
 		return true;
 	}
 	return false;
@@ -959,7 +964,6 @@ void synchronize_rcu_expedited(void)
 	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
 		   sync_exp_work_done(s));
-	smp_mb(); /* Work actions happen before return. */
 
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
-- 
2.40.1

