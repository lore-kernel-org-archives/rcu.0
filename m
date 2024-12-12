Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08129223338;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=Z0Mrn/OQmtOmUHlu6jmcUginAOX6bc6LMsh51iL9QskoDTTnbiYDD1PMzVyPkkwovFp3KrNOAHQg2KAsQbR8XL5RSec80sknaVQ/dhjppNC6lUaA0cK32AFvEf2yT5MyeE9OI9aHJ+T4HwE8C+gDfRzlABJ/+vZH3tKmfoIqboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=g21gc7AS//+ZO/xrObk2j3kFAlOk5t+Q2Kv//5gsaIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hYuHFybvYrNK/fX0C26Cwq6vhhlVQG/eyZJJBJtS5I2TisKs2w5/wX4JVLciXvcDdX6Hx9dyfc27BuuA75CLmsn72VIXffH1jGTPsAWgy2L61zrUHITkH5IN5yb//j4Gsf3h2dZ6o6rXPj1ixH8RXpbOlFqmezaVl2Cg5mBgO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS8jcBO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS8jcBO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B282DC4CED3;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028777;
	bh=g21gc7AS//+ZO/xrObk2j3kFAlOk5t+Q2Kv//5gsaIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GS8jcBO0erv0QhwErxHUuNIL7jjiD1Eqf58stY6Zjvx6FqrU58OmQGcvqz8oBMmLj
	 VAVYk+W2ASMa8AvXJJ3tMtDmwze34A5Nm8d180P0Ju0XTavJUY7xgx9eJUx/GCKtND
	 pQTLkD+39MQG1JYHmmNfKotAO8G27Ll2CiTaCjUhdVZpL0cDwVr/YUaBjpmBZaVVKm
	 1xPeV/QUsgxjQd4hAxsDrU0weW4Y71/Xaa5q2cb9TOvaMLSd13G4cvflctjxTEvB3+
	 oqG/06v2rd8g1BodugH3vsu9G9zarKM8bi85ywZcnB5OS2q5gPuPrfgMzP/CGiIxfa
	 18NcDfv3JtZUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 413E7CE0F9A; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 3/8] rcu: Move rcu_report_exp_rdp() setting of ->cpu_no_qs.b.exp under lock
Date: Thu, 12 Dec 2024 10:39:31 -0800
Message-Id: <20241212183936.1936196-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit reduces the state space of rcu_report_exp_rdp() by moving
the setting of ->cpu_no_qs.b.exp under the rcu_node structure's ->lock.
The lock isn't really all that important here, given that this per-CPU
field is supposed to be written only by its CPU, but the disabling of
interrupts excludes things like rcu_exp_handler(), which also can write
to this same field.  Avoiding this sort of interleaved access reduces
the state space.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 581e88d39542d..5c4ea66cc00dd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -260,8 +260,8 @@ static void rcu_report_exp_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	struct rcu_node *rnp = rdp->mynode;
 
-	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
 	rcu_report_exp_cpu_mult(rnp, flags, rdp->grpmask, true);
 }
 
-- 
2.40.1

