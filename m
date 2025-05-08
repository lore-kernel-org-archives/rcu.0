Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7582343AB;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747904; cv=none; b=Yk6sr9sT7pZw+H7+4LHM2CaaxGkGjtOZzf+fVap1WRw/7YkACoNUjvFaUEVqR+AAifnH1HlGTEj9Tj11lyiBmmh4S99xUEJ/BwTZ2380CGn8gX+6OGzD3p1t91EotRYaXmEQbNmBqbdFsgtBFcdLN4LlkNIBrilMglo60S9zlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747904; c=relaxed/simple;
	bh=wdDK5nxaELS/PQC9NgXLAp9F6KeKLLYF3gwJtidFXPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8rXccfq3StOJt0xgt8K/B8+8N4dRijjzzNGz5uCRRjtR3qLpHfqwprM3nOwdt+QxQ4g0jCAlzRL+wobZALKwjVACK9UEX4afagLuMDFhuEe8QWlOMRnFRv92uw7zZD4d7OoZfPRWuvZkOunG6QyAwAGvPzDO0FvUbRUPZZBwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbf/5fNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbf/5fNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319F5C4CEF3;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747904;
	bh=wdDK5nxaELS/PQC9NgXLAp9F6KeKLLYF3gwJtidFXPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbf/5fNXpdHxIyDjSWs3/IG/Rhvmefqgwjiv+grJYs0+PE56Ow9A/1IRJqLEJ05JB
	 igjn8F/Mc+lQddBj7JQCo+8L1W+5JwNMoa9jn6B0QjPiVkVPH1H+bwZz0panAobMsi
	 Qip2GzLj0riZ6x5Ah5lVIwB6JdhIfsrYtu1NkRS8t36jNUVFtZH57WrIG8d1mIriaQ
	 IjQIGhZE9fltUaS5w0K6RsCmjZgX6D8XmVASrqK0SAKUs5TOHRmMOOOpH0JgX5Qume
	 hmZdrVdIbTHmJ0ni6GdJiAAmm0/Px5BpPaJUKCMmKUiZQ7Y/j6jrMMcYL3if0ssnls
	 3lqMadOtpuY4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA383CE122F; Thu,  8 May 2025 16:45:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/5] rcutorture: Print only one rtort_pipe_count splat
Date: Thu,  8 May 2025 16:45:02 -0700
Message-Id: <20250508234502.1996788-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
References: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_torture_writer() function scans the memory blocks after a stutter
(or forced idle) interval, complaining about any that have not passed
through ten grace periods since the start of the stutter interval.
But one splat suffices, so this commit therefore stops at the first splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 62f082e24d3b9..2699f47557bf7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1781,6 +1781,7 @@ rcu_torture_writer(void *arg)
 						cur_ops->gp_kthread_dbg();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 					rcu_ftrace_dump(DUMP_ALL);
+					break;
 				}
 		if (stutter_waited)
 			sched_set_normal(current, oldnice);
-- 
2.40.1

