Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1B1F0E4F;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=XkIHG/ZUpkk1+vmTuxEw/Fx2EXXFByoq3CUgIuF5IO4S1Bh6LP/QyIMZtf8YKVJmCoDKwzWloUyS1r5haOgo+ABQ6tZ8PZMA0FSMMXk9wgodjhvMhZyQx/EjJ8UV1+MAZ1OtApGsxVPbWubI6co2nEwGPteS6xnMqJVOAriT07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=9oSvYec02iMCgTRNU+MsLaNfu3vQBdFnRvJxD4744hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WL+x0xl0gJJlIcS23pJL55nWpAtBVGAYnRhMHiK6ro1lyQPm3Z4QQwtxXb6VziYwnApWtgOPcZ23Kq7QNwQYLdNC6ueOeEfBobiZX+EdeLLfZHQaZ9aokOHol0usBW7Q4BZB8VY3IrEbDtS4b8HjY8MZliMOSZg3DO7sBUJGlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPjYqCpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPjYqCpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362ACC4CEEF;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=9oSvYec02iMCgTRNU+MsLaNfu3vQBdFnRvJxD4744hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPjYqCpa/Gv7mZ/H3WDmqUthou6SoCpWEOSQssa37+Y9j5c255cuBCz+E0X9Hzzrj
	 iIAeNCYK8WGa2+pNC2DSXKcjhUURw/3xOFDx9ZmjG+LBDrHzlPYfh/6GUSy3WhFvaS
	 OiQzteM4vxqrMB6x6B/A4tJ5AaSUgOd3xGs/67W5TSAZegkWs3rg5oAPSeIPDlRlU2
	 f6u8VQc36q3wEI/T5EfmZD7LsQUlT0QDqG0r54/nRAt7wI9RmsKm4uE1CCnzyazINH
	 hfM3AXOP9KIo19yXg5XrbNpf+pujr5u8bdA75iukSbYujcqHHG+/wPgBI8ERpGw7SD
	 p9nxLfia2fa6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96957CE37E2; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu v2] 7/9] rcu: limit PREEMPT_RCU configurations
Date: Thu, 30 Jan 2025 10:55:20 -0800
Message-Id: <20250130185522.1652093-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
which allows for dynamic switching of preemption models.

The choice of PREEMPT_RCU or not, however, is fixed at compile time.

Given that PREEMPT_RCU makes some trade-offs to optimize for latency
as opposed to throughput, configurations with limited preemption
might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.

Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
model PREEMPT_DYNAMIC.

This means the throughput oriented models, PREEMPT_NONE,
PREEMPT_VOLUNTARY, and PREEMPT_LAZY will run with PREEMPT_RCU=n.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 582d461c9ab7..80242957fa41 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.40.1

