Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAF291C0F;
	Wed,  9 Jul 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057702; cv=none; b=OL9yiyaBl/3mf8Tjww0oPqmRwrazJreenWsfBdxrokd//TAP+p9OxvBmh4PbctYYDc5XuZZVM6a7LBGlDbkV4vIzSfmR7ska3+3UP3f21PkYR2BwcDJq+cBE0Y56X7nnvIjsgcoNKWRovkRB+utbduAo/Cw7jPBImnLDVH3+BXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057702; c=relaxed/simple;
	bh=3oTDZhx4qliFBI97FxAN+GLECJvSn3lalKekQqoF2jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poRhq/woMwEl+JOIKjyEAJZIbCbPIWxzu77KZX4t6bvh/EWU53HbMvPZyAQ+8YszAB+VmQzAKklUFGngJH/KHtUYQ9C9XOS8LQE0xWhIt22bRGMpuqS93iSg73PlX+LatP+XX5kk7GAn92PgQz0pyiw+xhN5S1rglXHINUiYdxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqOuqJAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqOuqJAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D4C4AF0C;
	Wed,  9 Jul 2025 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057701;
	bh=3oTDZhx4qliFBI97FxAN+GLECJvSn3lalKekQqoF2jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqOuqJAU5Pl75UXamJjzcDf+V89g6IsktFeLWyDcX/mqlJEwZnxG+EK7blMsIGRX7
	 crzz9S68t4hgMN/y1PIKoFSZe02IrKRBpiToWZpuwq1X7AwPX3JHm3yfNt7hqdeHWh
	 ODdeYOKv4pcqHiBB7jFyO42kZ28gE3LRyWKsIV/XIImZuxEW0UVfgBrvhMpmnDHZJC
	 7YiFRJwHC/paziqD7Jlb1O5qOvqjq++WY03Vm06ET803GBeby9g/SPVD7/9CpZVxTQ
	 D9r44YPVJAkUmiy/oc9EC2gViC6iCaHd4Nup/ZOGgxxjDOEpLkQKsomANHLIA4L6rZ
	 Qf8wIIxS7csTw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 1/5] rcu: Robustify rcu_is_cpu_rrupt_from_idle()
Date: Wed,  9 Jul 2025 16:11:14 +0530
Message-Id: <20250709104118.15532-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

RCU relies on the context tracking nesting counter in order to determine
if it is running in extended quiescent state.

However the context tracking nesting counter is not completely
synchronized with the actual context tracking state:

* The nesting counter is set to 1 or incremented further _after_ the
  actual state is set to RCU watching.

* The nesting counter is set to 0 or decremented further _before_ the
  actual state is set to RCU not watching.

Therefore it is safe to assume that if ct_nesting() > 0, RCU is
watching. But if ct_nesting() <= 0, RCU is not watching except for tiny
windows.

This hasn't been a problem so far because rcu_is_cpu_rrupt_from_idle()
has only been called from interrupts. However the code is confusing
and abuses the role of the context tracking nesting counter while there
are more accurate indicators available.

Clarify and robustify accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 14d4499c6fc3..f83bbb408895 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -377,7 +377,7 @@ EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	long nesting;
+	long nmi_nesting = ct_nmi_nesting();
 
 	/*
 	 * Usually called from the tick; but also used from smp_function_call()
@@ -389,21 +389,28 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
-	RCU_LOCKDEP_WARN(ct_nmi_nesting() <= 0,
-			 "RCU nmi_nesting counter underflow/zero!");
 
-	/* Are we at first interrupt nesting level? */
-	nesting = ct_nmi_nesting();
-	if (nesting > 1)
+	/* Non-idle interrupt or nested idle interrupt */
+	if (nmi_nesting > 1)
 		return false;
 
 	/*
-	 * If we're not in an interrupt, we must be in the idle task!
+	 * Non nested idle interrupt (interrupting section where RCU
+	 * wasn't watching).
 	 */
-	WARN_ON_ONCE(!nesting && !is_idle_task(current));
+	if (nmi_nesting == 1)
+		return true;
+
+	/* Not in an interrupt */
+	if (!nmi_nesting) {
+		RCU_LOCKDEP_WARN(!in_task() || !is_idle_task(current),
+				 "RCU nmi_nesting counter not in idle task!");
+		return !rcu_is_watching_curr_cpu();
+	}
 
-	/* Does CPU appear to be idle from an RCU standpoint? */
-	return ct_nesting() == 0;
+	RCU_LOCKDEP_WARN(1, "RCU nmi_nesting counter underflow/zero!");
+
+	return false;
 }
 
 #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
-- 
2.40.1

