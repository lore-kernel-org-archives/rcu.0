Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FDC41443B;
	Wed,  7 Oct 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=CgBipytN0cr/cDHtjTF/Vgp5esJPt79Hk3m2a8iNgVRdWrJFJU+vF2dpnYUH/TeENbam+GeF5B4xlt0P+SgQpgzCFtK7KnmKHwEeP085b1MH30qaqsY/V0FE0nvhvoPJG/kwbP279nxJBITnIE5mEpqWmZoWS5eEjPRBsGSABs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=oXP0aI1z7tTY7p8wi5rU3vAqLEmoIOkgXtaPsZ6DEJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1DwYcpvaLXWlOBF6NfiVGYoaVbWzKbQrFjhPCGB0aGbDYFdonf72M77OmNefzBOYDcgMvBrmQ17JMibd9e1lY2OgMYAKusXgOyxwzD0bXYh9EckM7/UfjGP6nN+oBHoLDI1wfAtBZ/G2Diz59U8ZdqtFDdUKXrs+Yaar6E00tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IodWMfV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IodWMfV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CA61F008AB;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=aeEaCSgnzcldxDU6sqbsyZ7SkwWaCfrjFTTQExafXLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IodWMfV8bBOBWKPl34rrkIYjnYkWXAFonZvWPCbn9bIJRQeft9KDR6jLuKm5M9+PV
	 Ad8ntwbboGvkchiel887hhXhgYf+V8MullQsL200Ea/ycc4gzoyziG6wfF2Cyu88XR
	 unYHU237kf/27r9W/SWyzIUcSdqGcDs1ynWZ2m4kR1aW+UJkyC9YsiZLOVC6AiKQSr
	 1ut5t4c8CqmQJPJTzWy2jdHTpwW7zg+Dx978j81oqSWjw5IKvqEb1m7DRFrXK562GL
	 8OMBkhXMlMxc/xZO2CfslvHePL8iGLjya1pa+Y2T1lurZsEk/X1z0TUCz4b3a1n5yX
	 fWwvImcXnCgkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F887CE3998; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 19/21] srcutree: Add lockdep and early-boot checks to synchronize_srcu_atomic()
Date: Wed,  7 Oct 2026 13:59:22 -0700
Message-Id: <20261007205924.1983367-19-paulmck@kernel.org>
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

Add the lockdep annotation, same-type SRCU nesting warning, and
early-boot check used by __synchronize_srcu().

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6e37d53b412e1..7890f7c7c2ee7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2122,6 +2122,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	unsigned long rdm0, rdm1;
 	unsigned long unlocks0, unlocks1;
 
+	srcu_lock_sync(&ssp->dep_map);
+
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
+			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
 	// Initialize.	Either init_srcu_struct() was invoked or
 	// DEFINE_SRCU() or similar was used.  Therefore, no allocation
 	// will be done here.
-- 
2.40.1

