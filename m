Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF0136E23;
	Fri, 16 Aug 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791071; cv=none; b=RSaAtwAqRmkPs5aDB0l5l2k4dXs/8+g/yqy0nFnDcZ9DI7OR9jK1Zo2wit27BaPtn+oDYOGXTH3JXXMopy5XmXOLXLcXC/os7LShD08tLgCdNbHfhfr/bc6OmgsjPwXwT42JA2vSXv6VAEMxsOiv7rhtCOhkzGt1wS5/eWSzYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791071; c=relaxed/simple;
	bh=ezgPeV6bSSDC6r/9nIfy0Dm82DBCIOzBZILfHQLQEio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gp2hu2WmmIrhUJzpFr8+g9uR7N79ToZkGBz5ACZxDGMsHP8Az1YAfJ8e6vzbsnxeOUSy1dnwmGGCF9YO4cQzJSz3gQmgKee4DLSM2ZN3ehsUXfXg5jUJN9OhBK9DxsxdIaOeo1UBOFfh/YPD7ShX4oSZ7GMjC0SMSp+LfnGKdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO9aWaGQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO9aWaGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CEAC4AF0F;
	Fri, 16 Aug 2024 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791070;
	bh=ezgPeV6bSSDC6r/9nIfy0Dm82DBCIOzBZILfHQLQEio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QO9aWaGQRgAbQ1FnNFvTCCRy0s+beqUmEF9lS/AHxa7ivqirceEQdNCxZaDpPeZzy
	 5XyU4VguWnC0RBFApZ/eoPhjd9NBf6ATMPVcmSjAK0L2PsaxeE3cWZBFN0dumYBdhu
	 a8eIJQn0ZQ0hS3yFuB8rwRhPnn6W0AoBG/sfanoNFjTbmgNIoRK2CEPGmBhKjZ5DAe
	 bCIUqCjJt7jK8v/U204GBmBXJEOJ07R+L0NWpCMyObgZnYSnn5UCFqwOTXGmBzVypF
	 nuyUZtdkO/oZWpWUq1yYP2xl1siLZGWnlLNFeXYo5NQsI1+MAG077G8aBzT7EX5XCS
	 NTsqZBqRC5iaQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 07/12] rcu/tasks: Check processor-ID assumptions
Date: Fri, 16 Aug 2024 12:19:16 +0530
Message-Id: <20240816064921.57645-7-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The current mapping of smp_processor_id() to a CPU processing Tasks-RCU
callbacks makes some assumptions about layout.  This commit therefore
adds a WARN_ON() to check these assumptions.

[ neeraj.upadhyay: Replace nr_cpu_ids with rcu_task_cpu_ids. ]

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 72d564c84499..9fb8bb0afff7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -357,6 +357,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rcu_read_lock();
 	ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
 	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
+	WARN_ON_ONCE(chosen_cpu >= rcu_task_cpu_ids);
 	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
 	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
-- 
2.40.1

