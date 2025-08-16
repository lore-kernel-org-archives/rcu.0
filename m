Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE93482EB;
	Sat, 16 Aug 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302511; cv=none; b=h+OKqgdtCZb+sILslIHYwUmErcITSWoI54QKZLCwXnOFq5qP0tv7Ymy7SWUN5yijA6O7Wtks0SLeojmY8/zsNLMO8Mvl9FlYfHD6s255oN2MH9bdYu2wxXcUyKuRL0hK52CFgHC+0S+9SGl9LIE3sZZoH72KDNcM/oEvpnc+ejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302511; c=relaxed/simple;
	bh=tt2fnvxyKHuxMWduq2G5iWtwAxgOUA1tzVmzIKN+kzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYbYmhhxXWRqlMM7djLCcFm3sCB/I/yOUPGMHAjeRgfcw9pSw7rf4skk5BFnslBMBulO0TugS0uCk/DT33DVHMDuhe3KcQvEf4dPJs4uPaNoSGIwKsfzrXC4rfYuOdrviGPeXh9E3jE6g5T2lDguV/+ckCDQw7bDfPg54h3tPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfVvMfOG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfVvMfOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C22C4CEEB;
	Sat, 16 Aug 2025 00:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302511;
	bh=tt2fnvxyKHuxMWduq2G5iWtwAxgOUA1tzVmzIKN+kzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfVvMfOG0b1QlhMLnLmblX46MZolGzZjvIs3TBKOhafZopSS0PhOLo13QQXH+vwf6
	 LV76Q3gdo2WypaqEUB4777jVJV2WXpaFcdf2/e6DYEyx63kv35q7OKgxo1L2aJ8P2r
	 Grz2OFYCTC7QMt6oxr4LPRTSP67Zme20HH0HmFF1fhO/81KwGndvGKuKtMNG6HHgGg
	 eSQBIoNtQL14j+3+nPHjR9OqpnEIa+qR8a0uLdoYHmggQtkbboKywiDuH8WpznnWth
	 f77u9gyEwkVISoZJDwK/eDJ82g12NBxsCob6Yzf9cHwQMWfbuQjRr1VfYr07UD3Yph
	 vzJvhbLHS4Y6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D80BCE0B2D; Fri, 15 Aug 2025 17:01:50 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/3] rcu: Document that rcu_barrier() hurries lazy callbacks
Date: Fri, 15 Aug 2025 17:01:47 -0700
Message-Id: <20250816000149.2622447-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
References: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds to the rcu_barrier() kerneldoc header stating that this
function hurries lazy callbacks and that it does not normally result in
additional RCU grace periods.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8eff357b0436be..1291e0761d70ab 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3800,6 +3800,11 @@ static void rcu_barrier_handler(void *cpu_in)
  * to complete.  For example, if there are no RCU callbacks queued anywhere
  * in the system, then rcu_barrier() is within its rights to return
  * immediately, without waiting for anything, much less an RCU grace period.
+ * In fact, rcu_barrier() will normally not result in any RCU grace periods
+ * beyond those that were already destined to be executed.
+ *
+ * In kernels built with CONFIG_RCU_LAZY=y, this function also hurries all
+ * pending lazy RCU callbacks.
  */
 void rcu_barrier(void)
 {
-- 
2.40.1

