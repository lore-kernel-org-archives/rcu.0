Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6D17622C;
	Thu, 30 May 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076784; cv=none; b=eQV0YANO1pGViPQksBISR5qFjAOhp+Aop6lfIyXBOC02nz5/U2QQYpeCtWppwawiaREUTPuQoEks6Fp++66l2/GHyaRcHdwWlNDkI33lm4citlTnrGLtLq07Eknv0HagLJjfPfWFRaIDj/rqlcQKkLCboLBc+4aTJ8N9Em7+OuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076784; c=relaxed/simple;
	bh=vKDdPpz7jOZDNyAElQztvVPztBWXtOQUT0AcGjdM2eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3b76bIeXIqg8Xr/L/6Nuo6RAg10fm7W/KmRaG5XRlsDF0HIc2D4Ka8FYt/XyYn6iknJBT1SXC5kpXmB6IysalMvks1wxUhjkThJN9x8g43HJf5tlcfMT5PArJWN5SqrNI+lhOmT9v1CsVM6WdRP62ORWbhWjZ/sargLJvVMYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfNVBNeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfNVBNeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF37C4AF0B;
	Thu, 30 May 2024 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076784;
	bh=vKDdPpz7jOZDNyAElQztvVPztBWXtOQUT0AcGjdM2eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfNVBNeQ6tnVwZRHuT2REsRYE0fdHbYNj22cKYEgC12bhc2aTVqeaNIR9suq/y9jN
	 O52ToT8GMFWz+t4OzQBylLmWCgaUlq+fGXpSyhJ3k8n+p1rwdBgAL1JVIHyHhz+CGB
	 IUKLMqM2T+/TWNvv5hlapVDgXtgAtK1qNCay8YSyruX0pfkD7qk91JubzpgXFvTBFx
	 RC4gOBtpveGEpBcwGEiYbjqcFHAArzaD3Mvmj/kJn7AI+Y1D2ovRE30zVX2p/IfKNQ
	 kUm1vHm/+YI2eNRBIeZQEk398w2QzsYAnMgSbA+u9pUE8CbbGdhqcYssTJHOU+Ovi0
	 iUHDKJukf2a9Q==
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
Subject: [PATCH 07/11] rcu/nocb: Remove halfway (de-)offloading handling from rcu_core()'s QS reporting
Date: Thu, 30 May 2024 15:45:48 +0200
Message-ID: <20240530134552.5467-8-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU core can't be running anymore while in the middle of (de-)offloading
since this sort of transition now only applies to offline CPUs.

The locked callback acceleration handling during the transition can
therefore be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e904c187c281..c502a38dc5f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2381,7 +2381,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needacc = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2418,23 +2417,11 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
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
2.45.1

