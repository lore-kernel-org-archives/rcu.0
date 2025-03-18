Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A542070;
	Tue, 18 Mar 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306195; cv=none; b=LGw2uqwgGTKOitoqZji611QzpfZuiQeI9kbcs8QR67H+efWa9fPZiyhY4T5WtIA2noD5i27C30NugKgddvrNlkI1hEviukvmEQJwUTNLIj055wD6ekRknZuKnydF9hlSyuVNMSIogCOuQSfkH6IXUe9642gcqAD1QFuzIRmZOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306195; c=relaxed/simple;
	bh=iODjk+JvPaqauEX/2q96+DypdFzdm4oQDx3Dh0AUUnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDdjMcFcN416t+AWO/CnniGHoM0kfsdpEdqRvGFQqaea5RAxG5sKHii2cIWHLTBLbKQFRcDDPKK1cMDLYK3FHiAlvCYDED0PXYQe1Hsod5XrA0NcMYnljQbQHJKYrPa27+9Hnrm5Jx0mPcaKX4Si3gg5E5ZH/54u3Um3zj5ucmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBZGLSi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBZGLSi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032F2C4CEE3;
	Tue, 18 Mar 2025 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306194;
	bh=iODjk+JvPaqauEX/2q96+DypdFzdm4oQDx3Dh0AUUnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBZGLSi9eLvvXcHcDdrO8ZxbkAYpOJZfoKuSNaJVIOacScspj7semQyQr5IzUMkyS
	 SX9No4kNGK/RRs+adUhTFcQq6eGsC4Pnuc/0lEp/SzvJUu6FIWKT86SfAjgE7RhySg
	 nfpWJZ6JSkTbguDSTtGYpW1x7SzfGSmgZ+7yhmGbv6ztJlDGLEtdw/Cwg10EdIgwS+
	 NZZZCOn3zZF2TJdrMVVRRDq1aJyhsUl0Oe9/XyEEYgdwqOUZvHv92M3BoYekxeRw5w
	 Wp0Sh9Lhiqa7NQTcTg/y5UoUAkooUQbivzvmS/wyzHijtGE4QklJu/ryGmvJNoQp+l
	 ETDGUPDHE4dog==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 2/2] rcu: Robustify rcu_is_cpu_rrupt_from_idle()
Date: Tue, 18 Mar 2025 14:56:19 +0100
Message-ID: <20250318135619.4300-3-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318135619.4300-1-frederic@kernel.org>
References: <20250318135619.4300-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU relies on the context tracking nesting counter in order to determine
if it is running in extended quiescent state.

However the context tracking nesting counter is not completely
synchronized with the actual context tracking state:

* The nesting counter is set to 1 or incremented further _after_ the
  actual state is set to RCU not watching.

   (then we know for sure we interrupted RCU not watching)

* The nesting counter is set to 0 or decremented further _before_ the
  actual state is set to RCU watching.

Therefore it is safe to assume that if ct_nesting() > 0, RCU is not
watching. But if ct_nesting() <= 0, RCU is watching except for a tiny
window.

This hasn't been a problem so far because rcu_is_cpu_rrupt_from_idle()
has only been called from interrupts. However the code is confusing
and abuses the role of the context tracking nesting counter while there
are more accurate indicators available.

Clarify and robustify accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79dced5fb72e..90c43061c981 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	long nesting;
+	long nmi_nesting = ct_nmi_nesting();
 
 	/*
 	 * Usually called from the tick; but also used from smp_function_call()
@@ -379,21 +379,28 @@ static int rcu_is_cpu_rrupt_from_idle(void)
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
 
-	/* Does CPU appear to be idle from an RCU standpoint? */
-	return ct_nesting() == 0;
+	/* Not in an interrupt */
+	if (!nmi_nesting) {
+		RCU_LOCKDEP_WARN(!in_task() || !is_idle_task(current),
+				 "RCU nmi_nesting counter not in idle task!");
+		return !rcu_is_watching_curr_cpu();
+	}
+
+	RCU_LOCKDEP_WARN(1, "RCU nmi_nesting counter underflow/zero!");
+
+	return false;
 }
 
 #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
-- 
2.48.1

