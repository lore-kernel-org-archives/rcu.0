Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45212AAD3;
	Wed, 15 May 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777632; cv=none; b=YYwV/A3FgOGabnHZ9/1PlyFtxK/pMaAoaJUuVOki5ToqwGJKWJSHeiHqBXYVF9wPBRugvrHjkrawfO/YELj877t7+I1PkPHrECI/h3TLnLZYLWErLRmLv4YXrOZ7jUE/MBvYZbPFL0d4FY0fKbdZvosteHXhI8zfLl90D848DfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777632; c=relaxed/simple;
	bh=61n4BvWS+RKXfIV6Crmix3uFCPd3dUP3naHmOjOk0/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXkjGAX4+I7udrtJJyFk/6HeSZCKt1sYF0J9sGW0+fuDaASWn0WNZuyO2bqZeuhCQ4tvvj9+vyV8Y3biAJw978lyE2dLr/rM/MNlawFccTLlJ1JjnTtA7IBgOx7wyMycKwHGdVcqnoLuCA8SoeTdrH8DcmX+3jgCp/omW4uq5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOP210ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOP210ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB15C4AF07;
	Wed, 15 May 2024 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777632;
	bh=61n4BvWS+RKXfIV6Crmix3uFCPd3dUP3naHmOjOk0/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOP210ma84aHUIqjdbTezTc6vStV8NonefdGSCfvpWLsE+X/49qBJg38k8b6KCPPC
	 lafQb+1GJQ1YHBEHgkD5uSdi+Oify/E7brJF2l/rkO0jBjb65iFO+8mx++JcJW31p1
	 MQDBjBGo+4HIF+BnHwBN0IU3QH/Zbva8io9toYEj6gWMuAcRP2O07erl1db3Ke++Z+
	 U4U5WPdsBJeMysx67cBHP/UeS6pZ3+lK7zL8nIZNYN8mueyTCOgahEkkpMlgPbgBlp
	 nBeVVCmzMdesWIkdMF1ODbtYpt62MqamVbmYM941LWarhvXdEEoH2a4atEx9KUNiwU
	 gvJk320hR2TCw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 6/6] rcu/exp: Remove redundant full memory barrier at the end of GP
Date: Wed, 15 May 2024 14:53:32 +0200
Message-ID: <20240515125332.9306-7-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515125332.9306-1-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tree_exp.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index bec24ea6777e..721cb93b1fec 100644
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
2.44.0

