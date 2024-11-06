Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28D202F89;
	Wed,  6 Nov 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905160; cv=none; b=NOwOUkMxQTz1ZvsNnFtxNX5vyOxHsl1qU+FCcX1SPiqq6jVM7tuXftuWZRCxiQQbbuqOGPuSajxXyM4gprEMFC+sVB/RdvmNkeYntJJvXXT5X6oUDQXbviLlPEL95Npgo7Her6wQkobUt2Mm50pljZ7v4LuRu8DITUOncy5xyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905160; c=relaxed/simple;
	bh=n40xhh0z9NziEa64CxH5rGePLUJObsn4LcYAfAzqI9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfznepEeOJwjA4XMHxqvhc9LywWTfphJSBdk7Bw8bl6m1rjs2Y4lfSXFHRB/vB+eZf8D5WjpExeC8T1sSuZttAHhEuwaLwkxpt0DI4MSz7Jqrq+hv8YC++R/GupIJtOQHo4zV9OIfWT6ONZUIW9bgdJ91n9KFs3cuqK/705Io3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df/OymoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df/OymoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F2C4CED4;
	Wed,  6 Nov 2024 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905160;
	bh=n40xhh0z9NziEa64CxH5rGePLUJObsn4LcYAfAzqI9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=df/OymoNcVHVKFvXcpxp8QpKO87gY9UmfjHUoIPanFV4Eq1R21/bnhO175jRfoX4O
	 SNCkHgAWUGJKFgrnkdaMCLndb8BH8emxi38GAqROXc+ML3qZSgOFZ0NVGLIWnR8z1A
	 pyDXUZJC2AXyK2Ar4QazCAL7GcVk261Ry7LgYmxauOJDqmq+CqnrL4N2eqrVAgyZXh
	 s8njYZ2BQiG20TpBIfV3nqKR/nZsA67kK7m1Je2WvC65FI8MQ63bBAS26HhBmMr2jT
	 QucXDp1sUHi3AKEgDkA3ZR2LM9urhgAABLChW+brmEzbYZbbqVOvYwIuRcF6C5HIrv
	 CVJbnAj1dg89g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/8] doc: Add rcuog kthreads to kernel-per-CPU-kthreads.rst
Date: Wed,  6 Nov 2024 15:59:04 +0100
Message-ID: <20241106145911.35503-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the rcuog kthreads to the list of callback-offloading
kthreads that can be affinitied away from worker CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index b6aeae3327ce..ea7fa2a8bbf0 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -315,7 +315,7 @@ To reduce its OS jitter, do at least one of the following:
 	to do.
 
 Name:
-  rcuop/%d and rcuos/%d
+  rcuop/%d, rcuos/%d, and rcuog/%d
 
 Purpose:
   Offload RCU callbacks from the corresponding CPU.
-- 
2.46.0

