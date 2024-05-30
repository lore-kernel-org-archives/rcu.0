Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2E17D8B6;
	Thu, 30 May 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076767; cv=none; b=nqc57JtR2u4ONpIeA8Hf/I2iNRI/Q/9RSHAXWmMgFrzsrqpq07UTQjxjlfwzuqIqOKNSx2HwWb0kSI73Jwcpzukjb0QPvlkAxZNQbOyipPKjrpAfwjjJNkyfwfmcQKNJvzbAGAccd92uYSetULeOKDUm3ezsY20LSKaUTXGO6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076767; c=relaxed/simple;
	bh=NawS5FIK/UBSIsMh81EVPQx6KaknSeZy9r3xaRXEbCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFV9OTI1iZ9Z35vjXwhLhhwUgXHYNB8A8Z9JnfYDmZhJRX2uA636hROAaFX0YfLPCUjBM0Uom9OOoYqKm4xVSzj3E3qDovls4CZRm4FCA7cv+EkNagaV4Jb5JrQ8OORjjPANpBTs+ebl8zBTFukYYdNwo2eLUvKrjBLB3oLgvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCNCG1RB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCNCG1RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B24C4AF08;
	Thu, 30 May 2024 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076767;
	bh=NawS5FIK/UBSIsMh81EVPQx6KaknSeZy9r3xaRXEbCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCNCG1RBRB339C6P4DXdUifWTwWOnIUkuqzxWs9vdt+MDCR1j/8yudpyF41aY11DV
	 AveE2C/j3qJngHmNXlQRlyfee4Kr0Qh4HVs+yv9+xjVMwe4R5CBCHXb3/2Dd4UEQuv
	 jBRzg5Ee2JIWLcCLHFpRnVe/1VDXNBOIgGCXcrkI3W3Wi2m1NC/CO+KqZU7m6EIlvM
	 OAIh95d02qE950OgAJH1hN0ukumH6h6aM4sBGlmiACOD5UvuSbLIUKvdiSDkj+a6g9
	 3m/DiCotRFusug8UggvQNDsThJdZLe18+AZUJEE/cunjc4Se5wF3WtsC+tDExdQ1Gz
	 lZ5vV+ie4aQ/w==
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
Subject: [PATCH 02/11] rcu/nocb: Move nocb field at the end of state struct
Date: Thu, 30 May 2024 15:45:43 +0200
Message-ID: <20240530134552.5467-3-frederic@kernel.org>
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

nocb_is_setup is a rarely used field, mostly on boot and CPU hotplug.
It shouldn't occupy the middle of the rcu state hot fields cacheline.

Move it to the end and build it conditionally while at it. More cold
NOCB fields are to come.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fcf2b4aa3441..a297dc89a09c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -411,7 +411,6 @@ struct rcu_state {
 	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
-	int nocb_is_setup;			/* nocb is setup from boot */
 
 	/* synchronize_rcu() part. */
 	struct llist_head srs_next;	/* request a GP users. */
@@ -420,6 +419,10 @@ struct rcu_state {
 	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 	struct work_struct srs_cleanup_work;
 	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
+
+#ifdef CONFIG_RCU_NOCB_CPU
+	int nocb_is_setup;			/* nocb is setup from boot */
+#endif
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.45.1

