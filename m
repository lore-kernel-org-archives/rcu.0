Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E582361DA;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=Zv68jDhsV7sXvtSkuIul9QXcnY3724laHanilxkmeaflLejIVCk9vjOMmQCXVRu0+HrP/QIsIt0RVWuZOnCCJLm3A71p6d/TwOORpUZcgdaZ7L0CihZPPy50WLjB37u4UjNXv7nGCm2o6ljPnQ0VZ42OGZg0K59jLpQjEPVLzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=2kCcpwrxC+sFJfs74p9b/NIfUYLNRgHwpLZRtUNE9V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWElAjj2CFNqby6Zm4zL+qhXjG0fvNXV/d2vVKyvrW3YIrGloU6bdoHYxFt25pdAx+nQ2iGi4eppTCoLR1pICWMTTigFQ9MjMGeBZl9hSEBTOopSMRZOhpl8dyNPjW3H2ZywQRXI9/Cz8YfyLYkG5YJwRYwLUR6eZuP5+YUs7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EftLCmGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EftLCmGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924AEC4CED6;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058409;
	bh=2kCcpwrxC+sFJfs74p9b/NIfUYLNRgHwpLZRtUNE9V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EftLCmGh+enD1SyXPE7Y7u1LRrwuoIdHkG63yGpyiGGuXD2JqLJnQ85L31DBgmxPZ
	 mvC5zlxq174sSOXz6+W7fovl6g3QSdce5d5kW6SOE+6+oFTPoBcpHKpsxCTqnOOWsa
	 K58CuJpzpAYynbqiukXCsX01qrlx0fbaRi+S0V4PPX7ZsxpHj7X7She3FLGB8MkA0T
	 ho/QHbasEWAw6i17Q1DT0qYV4TQdfKOEqS8caZXW5JEjpzaH/j1lKdcvRdflGGhXd9
	 rQm29pf5bPJyUJKAB0YYXrWq5oRI8Et4YiKmiT3XqguEcPJfaqFq2ev9pHqnsRvC9X
	 rYhwzsegbABrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A827CE12BE; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH rcu 1/9] rcu: fix header guard for rcu_all_qs()
Date: Thu, 16 Jan 2025 12:13:19 -0800
Message-Id: <20250116201327.3782963-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 27d86d9127817..aad586f15ed0c 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.40.1

