Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E214658E;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=DnAaHZsEdQ+up1lmXSgnAZU8JWMwx8URYaSSiqdTS0w3H1oI4hOwvFSEgjQL6xzPMPQN/fma8eRIaaaSRTf8flCR+YeiCmWMjq03O0JLll+CnXJhWwoFmcWkX8lqowkv2gQ40tGAQnjfDKHK3DeGRdEZ7n9gzRI7vuiLCFir/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=rhuvEgtcACTNn6ax1Ziuj5pEwRCIs7jJ27srtcjn1HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOc/rXC/fETodbfabDJLexBQoYpRfI8CuEPfFGpk5kDsAnPKN5BwZIrNhH09Ky5641rixmaRDSmAEWkiECFUHAwCFDbiOEGFKMQioq9nRb3mwxMIADjCMIqFsGwO/CK0uvJk6VRQUVpVSk26R9bACtQmANC8ge4ZSJhSgccSk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReR8ITPj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReR8ITPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDECC4AF0C;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539836;
	bh=rhuvEgtcACTNn6ax1Ziuj5pEwRCIs7jJ27srtcjn1HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReR8ITPjfVvne78bEQaAxExpg3RF0XUt4R8qbyytwNbtj1rg9Uu/DTwB5RDlx8eWs
	 xcD+EGg3oETsALlRitka2BSNwJcNrf5LUdFHtxMB4dU1ecBJbQeDmTVwKqzCFudNOu
	 jPuqz0dn2orXdacMJ/boYrrzjNPMd2wk655zYXP0PnCH+pasb/CBqS2xHdEGwUMH6L
	 p6Lt/kjUmu3nHHcFggUbeE9Ylt2X5gYkBl3wPeVxjJYAuhJrZ4XInHuBkIL34urcJH
	 L78EYU4svrkUP/jzbV96TMh3bv/8LzVMPFMXVE5QShtkg60QWwexbDs9Bs3SK69iVb
	 6aGxE1h23cmGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 645E4CE3F2C; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH rcu 5/9] srcu: Disable interrupts directly in srcu_gp_end()
Date: Tue,  4 Jun 2024 15:23:51 -0700
Message-Id: <20240604222355.2370768-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupts are enabled in srcu_gp_end(), so this commit switches from
spin_lock_irqsave_rcu_node() and spin_unlock_irqrestore_rcu_node()
to spin_lock_irq_rcu_node() and spin_unlock_irq_rcu_node().

Link: https://lore.kernel.org/all/febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bc4b58b0204e9..d14d350f505f4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -845,7 +845,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	bool cbs;
 	bool last_lvl;
 	int cpu;
-	unsigned long flags;
 	unsigned long gpseq;
 	int idx;
 	unsigned long mask;
@@ -907,12 +906,12 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	if (!(gpseq & counter_wrap_check))
 		for_each_possible_cpu(cpu) {
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			spin_lock_irqsave_rcu_node(sdp, flags);
+			spin_lock_irq_rcu_node(sdp);
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed + 100))
 				sdp->srcu_gp_seq_needed = gpseq;
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed_exp + 100))
 				sdp->srcu_gp_seq_needed_exp = gpseq;
-			spin_unlock_irqrestore_rcu_node(sdp, flags);
+			spin_unlock_irq_rcu_node(sdp);
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
-- 
2.40.1

