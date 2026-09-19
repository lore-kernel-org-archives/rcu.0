Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADE30F927;
	Sat, 19 Sep 2026 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778134; cv=none; b=HXAB2DXurNXsquM2PXZMe0r0EdcogSe3DCC/XGo32n8zLEkqWQXOJyj0Fb/jfXuZQJFpzz1wdqFwODkOlL9/6oeZIslRD/xOuqLmZuJ0INOG0A/MAb/3Kp2WPFkNhjwRH7DMJXrwPBR6bDQfcgJCj4jsD1VBR16guvzDy++8a9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778134; c=relaxed/simple;
	bh=wpxGuxQwmTKGnbJz/sH1towQjxcnq41v9FLLPUKQjf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwisZ9u08NptJCacycZuYQj5ZozaUCxUv4UlAPD2vQbVKaAJvci0s12YVyAgWE1m5EhUCwxAyXlgSnRKZcm5wvFl/Kn4/CgdZpbUIKXkYkIOe3XPsX9KrZ5uZNlVr9HIQ5NB9T7awVvW+kdv+ueEiJbj82lcQC9iCaUDviKM4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb7p0Ps7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb7p0Ps7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C771F008A2;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=PZ/g22DlBAZ6Rk/0gS40UrHUQ1lyKEErQX+TJkhNBFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eb7p0Ps76DiJs+HStENONzlbOH2fTSPgfNcLOu3Wtg9U9NDd+oBg+3ef2dsWY1C70
	 C7orTUC6Bns6rf5Z51qRL5cM97t/Cru86WT2ElcxXXXMC5COKs+fYCgHsn1+SW1PBx
	 LkAZVx7oniG7TnH81zFO0tMc5C7FtvR7xICP8D0xSgiuLPmjbLGjAMuUUZPrbbQaia
	 0VcgMeTZ5U6O8scND3WL/mQv3d8cqf57vAEI1dttzXgL0DqhwU9yUh2zPumMN6xjvQ
	 7GSA+e53XuCcBUVVimqoGwna4I9mBKNBXtPG8ztxLb1oYtpUaCPXuT8U15ZAoSNt0q
	 GTaVmOfO26e5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2C2CCE1855; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 07/19] srcutree: Disable preemption across synchronize_srcu_atomic()
Date: Fri, 18 Sep 2026 17:35:09 -0700
Message-Id: <20260919003521.3134552-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because synchronize_srcu_atomic() cannot sleep, if a pair of them run
concurrently pinned to the same CPU, it is possible that one will spin
uselessly waiting for the other while at the same time preventing that
other from running.  This commit therefore disables preemption to prevent
this failure mode.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 570d068d1840..61c2375ba2ec 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2123,11 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 
 	// Perhaps others will do our work for us.
 	srcu_state = get_state_synchronize_srcu(ssp);
+	preempt_disable();
 	while (atomic_read(&sup->srcu_atomic_gp_flag) ||
 	       atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
+		preempt_enable();
 		if (poll_state_synchronize_srcu(ssp, srcu_state))
 			return;
 		cpu_relax();
+		preempt_disable();
 	}
 
 	// One last check for others doing our work for us under the lock.
@@ -2135,6 +2138,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	if (poll_state_synchronize_srcu(ssp, srcu_state)) {
 		raw_spin_unlock_irq_rcu_node(sup);
 		atomic_set(&sup->srcu_atomic_gp_flag, 0);
+		preempt_enable();
 		return;
 	}
 
@@ -2152,6 +2156,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	}
 	ASSERT_EXCLUSIVE_WRITER(sup->srcu_atomic_gp_flag);
 	atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
+	preempt_enable();
 	non_block_end();
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
-- 
2.40.1

