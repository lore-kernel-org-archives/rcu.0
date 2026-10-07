Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF441D22B;
	Wed,  7 Oct 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=MAgsg3KAxHWGYtm7HvDC61GEG3xiT1BN9Ie+tIVSkD/wCjuy2StM/TGhHV/nJgVfAUHjePeZh2hhemu5lxFvfPrfZJpZzExK2zC14LSyuE3BUl6EC3Ew6JPlEBuUfUwCwcYxF/+WFomS190J3DyXbFyVNjGjIVCu7fCQTVTUgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=fJBdrFqoB44/Fys/D6/YiuP5wNz9PyXPTMcrYoZxFAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opRqP81eYxn2xSVeEUOIWsCCmqBMo1x1KMzt1T/sFPQFj9Ekgh6gx0ss54XcFf9hq9j5AQ+WeV6r08bBi1M+owGHcerfx7BUv75/+ksApLMHU31Y4bKn/2A6IFUvHJOaRRKtQQrY8J6DyLyQdvmv3ZYqU0jCOL7aWCLrordkOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiwtYw8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiwtYw8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016821F008BC;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406766;
	bh=rPplkbMSyOzFb+SZPkk06gagN1hpHgkgFggQBlz0TrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NiwtYw8CNIOIHu+ULXR4H+P7tHPyJA19xZkzH7uworEKWeuHbp0jn+V8YrOgUQ2/o
	 FPkjOlhJlXPYp1xBYj33NrJHC0unL7Kw6kFW5G6Ns3yYId+OfOJe6inZUPIfcN1gHl
	 DFoLx3ylW5rTRCw9q33VKVISSKkuTTWUMA3pvkfbTEWzC9yhO4VLRQ6QNAderrfjFT
	 tUX7Unac+tIS/xZ1BNADgQPMg6mR7hCigdgli1mbmOgKyPRr6E/xoc/HDWTvhXoVZH
	 i8gx9biZzYYi2OKsn4ZCBZu0yAuGT5Ou/e5pzHtM5ES1EJu5YCNiC+KPnH30RnLmKJ
	 M31hLLhAjiumw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42525CE399C; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 20/21] srcutiny: Add lockdep and early-boot checks to synchronize_srcu_atomic()
Date: Wed,  7 Oct 2026 13:59:23 -0700
Message-Id: <20261007205924.1983367-20-paulmck@kernel.org>
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

From: Kunwu Chan <kunwu.chan@gmail.com>

Add the RCU_LOCKDEP_WARN and early-boot check that the Tree version
gained, srcu_lock_sync() was already present.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index a31398def0b18..63a3f0a8bc53c 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -361,6 +361,12 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 
 	srcu_lock_sync(&ssp->dep_map);
 
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
+			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
 	if (IS_ENABLED(CONFIG_PREEMPTION))
 		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
 				   // And in Tiny RCU, it is near zero cost and doesn't block.
-- 
2.40.1

