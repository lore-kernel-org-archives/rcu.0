Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548A2949F7;
	Tue, 29 Apr 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921330; cv=none; b=XafF1URw24KWRwPmXexVWUUqDelKO0tW57y1jU8vW5VA07tGrhyZ67t3yT6KotKonl2yd2r0lZcVi71J+s9ok1GaV5djC1R1Q2oQ2Mw32D5dH8PNp0dUwsWQzW9GENrz3eGrVeFtIhVJUXiw6CtJs/mMdVuSbFGVFpZYIravN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921330; c=relaxed/simple;
	bh=0r7/u/RghNb9eJUw5r37qjxwNthSPVY+EKxonqbSJIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMz+/C1YapTXb5yOXSMp4AWakwBNTDaSgKXQTe0p8M2nHzX8YzsaYF8O1R+Anm6X9jTkC67VFHm6P777O6pB7Laxk4qKJINBV+UXaAWKpl6Ar3gQth7F6OaEgZaIKs7Zok5XdEyPmIR1AYLXU8cMqdFvb6a886ZWUG95cmWD+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP5FMcM8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP5FMcM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF446C4CEE3;
	Tue, 29 Apr 2025 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921329;
	bh=0r7/u/RghNb9eJUw5r37qjxwNthSPVY+EKxonqbSJIA=;
	h=From:To:Cc:Subject:Date:From;
	b=YP5FMcM8WaU9sCyDg1yg8xDL6okyXuUGf7VBD4GerghsL/DxoUbdreuRFdB9oSQsA
	 +sQnUmJmbLTnOqpNWttPa1M64wuCcTqMf4rbevJvOHyttpg90QUY9lrnyjXDPnRvzC
	 xYT0NmA4AIZ9Xj2Zy8i2oT3h9JrIURDS5jBc3V6VkuVuGkfGZh0TYdHkSP/vvKjG08
	 GbErrLhKqOzNrw39wwY92AYw6X6C9jv67FXF8AsMxBRV48BFTENWMJNkLuHfMAcVGk
	 sOaV8ZqLIDpK9j3HBs4dccU7Dpgs1DCya+/twsIBL5NBg/2XDrbJqWcDy6dPFbQBDq
	 El17NM0lDLWAA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH v2] rcu: Robustify rcu_is_cpu_rrupt_from_idle()
Date: Tue, 29 Apr 2025 12:08:40 +0200
Message-ID: <20250429100840.13917-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
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
---
 kernel/rcu/tree.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90d0214c05c7..cbcd579c5630 100644
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

