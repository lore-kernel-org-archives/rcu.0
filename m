Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BA1F03E8;
	Thu, 30 Jan 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262968; cv=none; b=NnPa4xHWsxZLsvNJG6Pz6nXs4rV1dhWfV3Gdu5w4MeUZFy2HOGH3ueUVxq5WkAF1Cj4ontmuGonCLB63EPzdC2qOjf2gExch3Shl5ViZ34bhn5qzOJoD9sfaJBUAE38SsEN8qbkN1TtRLakfSH9MkC2YXuelVpTwQmvO3J/7qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262968; c=relaxed/simple;
	bh=VydZE0P4L/LZcwHPe6EIAqUlXj2KVbd6m5WrTYx83ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVPdS6m3Oh+geQ8SLADL4UvmSRel+ai+pAypSCyR4Q8O4dxlnA2HgJDhicr9AXutJen4yEWs+UyWz+ahnqpX6ekmTZQFvevOpnFbj40AJHfF6cRJ0tFvzy43jinXnmZW8uJjxL/HqhL0Nh22rg1V1Avc/lSakKCzLlnCoaY0dnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf3dyeag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf3dyeag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93FAC4CEE4;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262967;
	bh=VydZE0P4L/LZcwHPe6EIAqUlXj2KVbd6m5WrTYx83ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf3dyeagGO3lHsz3fzg9A13l+2SU9nM4ekQ3sbU3Jgxh1M3694mKQ1FCOgLwvK6ye
	 xHt5pcpwi7Yjq9t0ekONsh04sN9QcUKOi3/Ky3vpQ+g/X0hYJVIEHCNZ+aRVRRp1Rp
	 mY3QbrNhPQ7soGaB15oPM5IewP2b3ih1MLa8T4jtX1XYIv753xrjk6WLaYznLVqheU
	 dPoM0VN47I/nPut3L3oBKgENiCgmMtlOKP4oozcDaGl8CqbQ+WEckjL0za+rt4oUGo
	 56vErVxpzKo7dnfaodY7HfQjhkh/SNZjfwoRa+eg1+KKQ282LYPuugsNBQUMV8R+O8
	 uOp9CFDqGB9pQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36154CE37E0; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2 6/7] rcu: Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text
Date: Thu, 30 Jan 2025 10:49:24 -0800
Message-Id: <20250130184925.1651665-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
References: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit wordsmiths the RCU_LAZY and RCU_LAZY_DEFAULT_OFF Kconfig
options' help text.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b9b6bc55185d..2bb22dac3b5a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -323,21 +323,27 @@ config RCU_LAZY
 	depends on RCU_NOCB_CPU
 	default n
 	help
-	  To save power, batch RCU callbacks and flush after delay, memory
-	  pressure, or callback list growing too big.
+	  To save power, batch RCU callbacks and delay starting the
+	  corresponding grace  period for multiple seconds.  The grace
+	  period will be started after this delay, in case of memory
+	  pressure, or if the corresponding CPU's callback list grows
+	  too large.
 
-	  Requires rcu_nocbs=all to be set.
+	  These delays happen only on rcu_nocbs CPUs, that is, CPUs
+	  whose callbacks have been offloaded.
 
-	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
+	  Use the rcutree.enable_rcu_lazy=0 kernel-boot parameter to
+	  globally disable these delays.
 
 config RCU_LAZY_DEFAULT_OFF
 	bool "Turn RCU lazy invocation off by default"
 	depends on RCU_LAZY
 	default n
 	help
-	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
-	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
-	  it back on.
+	  Build the kernel with CONFIG_RCU_LAZY=y, but cause the kernel
+	  to boot with these energy-efficiency delays disabled.  Use the
+	  rcutree.enable_rcu_lazy=0 kernel-boot parameter to override
+	  the this option at boot time, thus re-enabling these delays.
 
 config RCU_DOUBLE_CHECK_CB_TIME
 	bool "RCU callback-batch backup time check"
-- 
2.40.1

