Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266524168F;
	Thu, 16 Jan 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=mDTv8hnD3XhK9CAFz6fo5/CPEsURbdpysFJcfRMefsRH4nSycDDZwQq+vNNRDQ9ObXD/7ljq8Mxp4GPN/eiahaMdP6RNM0P4ykNlQvbbRpO04+wilwvGNBDmmYJ3K2vKJ5CNQa9IZyRt8psXfvbEQWK8CN3WAPdnsdK18PoM3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=lS+VTDHcbfCovgK+C4MkX0AzlheKwnhQP7lt1rpOa24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EvY7/rvz8sMrp4irA6C8Us0vwybUW6FM0266Vz9IvTXj9ilWviK8d1XP0EnxIK0c5+e6ntwtzvA+/C6m0L0xxWhMeY1XH5wezRKC/G3d5lW5zqIEXbvYAOQx2Lzl/NR4FkvttzQ0l0cGn5fphHqE/WoDhlfqm4IBU1nGt+M9b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlyVQmqX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlyVQmqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2014C4CEED;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058410;
	bh=lS+VTDHcbfCovgK+C4MkX0AzlheKwnhQP7lt1rpOa24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlyVQmqXWLVaTShp182BCOGEchEohIk9t+FBGtunkHsq23zfdJBkd5sOnHIrQfkXY
	 nIRlK5MMzls9rxRj7vvxriEokb2HVL+mUCdC/SIz/3CIIIEoq9jSD7kf8l4prWc+sh
	 DLuSPoRDJpyaNXltrjon3VBiKyNAuo/aY9W1XCzKOHvYugb2tgK9bJcghmCjPYV2bB
	 N/q8j13/L+z0kNLM8YIRoJ7l400dLpU6i9WxSMzuqVB5tIhcsFqcSDFlhWRq1uUe5p
	 mcK/+Xdn+0FPebQlx49Z12JAKezIiHFHa+9bO9qIj1/DMe/lBtO48Tqn+EJxNdoSF1
	 pQLNjSbHzfjiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 58BD8CE37D2; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 7/9] rcu: limit PREEMPT_RCU configurations
Date: Thu, 16 Jan 2025 12:13:25 -0800
Message-Id: <20250116201327.3782963-7-paulmck@kernel.org>
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
index 582d461c9ab7d..80242957fa417 100644
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

