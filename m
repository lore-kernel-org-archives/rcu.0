Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950E412280;
	Wed,  7 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406767; cv=none; b=ez8UGefZo7nKR2fDVxVdV320RrQ+ZQK584qGqbz1c0XAmH9+eOy/tPD1bh6nL6aoiiIEMQ7twPEetGhAyjQlIlwOeDMwp1yQk/nDkmLKBMsyHWSYGShQ7fl98sf2XHWJjR4zNxu/R55HGzAW2N0vS/MWadf6wChV0ZhGo3kSZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406767; c=relaxed/simple;
	bh=A0LW6WwWyoCXq56cXBc1nwoS+475qVlMzcDI3fTSliA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bju2AlGLm/1bZZciLFBiiUKWnN6hLp81ajaJuMO8vMvZ2MfwfEQcSImY7WdA/MNicBWRO5+QFVVOItjV386A+z7G+bYXV51U48z+Zh/xQFqzGm9rk/NoUKZeCxHHOW6EUHWqHHWmc3d6Uji2j+MKHk8IlLYebTy4adREI4qn2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFFD6Oej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFFD6Oej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26E81F0089E;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=l8m2R1iUj1WS1nPYEo2oxSt5baa+cngxkyr/SPSprUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFFD6OejrRqD5eoZLKznHym28HdC97EbP/KL/AZjHbnt4m+ZIScGz8rOVu0vtTtM+
	 isESG9Z2VUTn3wRyNrMfdWCT0oSXQuHQEsnk6NcYNRlSsqqCN1MTbYIqVbCa8sVRoC
	 U8B5Byu8/NCz7S506RstYlKsl1SXzuMqADZ51vukl9AAT7w2V2/IDuVhEDsVdBVg/e
	 VQz27uSZ7n17etOkNNYwIuBIQOA3SZn6fx8OO60tucMRcCBaftxLFuBoiEqtK1zUfg
	 tRuVgdbiWcIoWmiu0+v+6ipYxdIx5SAgXonLtWGBw9V4aMJClhIQ7QtptT86/BjB20
	 yVTZLI9cNt/JA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 21476CE272D; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 07/21] srcutree: Disable preemption across synchronize_srcu_atomic()
Date: Wed,  7 Oct 2026 13:59:10 -0700
Message-Id: <20261007205924.1983367-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
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
index 7ff45e992c011..672fb41345c91 100644
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

