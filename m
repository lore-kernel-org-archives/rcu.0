Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FC1A0BDC;
	Wed,  9 Oct 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478318; cv=none; b=roafxk3xGg8aYlABTxrSNvLpFSo0QcQ43rYQgnT63Xl7cwyn5emj6yxfG6Me8wyM817+XkscU9R7V4pruH0+0K+A4kymeaAj0zPD2eN7kmTEnndgujPJyHHqtS2Sy5YbMTOiTcQrlWECZnpnIXCQqh0qcihvXoUV6vuNnVOOpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478318; c=relaxed/simple;
	bh=Vse4+IeX1I6gTLyGFA7QmaJV7gC8q/+woRsbl3quBDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBkstxjvvQypiu2znLSbG/jqllVUo0PSK3pDNUyzubB9dJfNxaFQH+CkvUUMc8Etv3OG/pdTG2UoidNrXL5cySfcxUJfrkgMvRnIHOCfkkONuGRtO91GyK3XoZJQDq2NkY64yKwo6ee/o4nUodRvWF4nPrCeWqUM/U5DzYOQiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYHxrEWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYHxrEWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C564C4CEC5;
	Wed,  9 Oct 2024 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478317;
	bh=Vse4+IeX1I6gTLyGFA7QmaJV7gC8q/+woRsbl3quBDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYHxrEWr62dprPX4XvwAQTZUdX4/fNJcf1toXJPwHQn1g4WNllmPG0EMHLQAniRwF
	 7f2/kDOHJXvoWv21izfGpPPctjsKRsZsObUb9EW7EFzHW1ATxqudgk0kcGdmdfNtbN
	 9hSF61E2NdcBqONDdbrF57GbaLPKpxuD1rUO1SAslRf3MNxcAUkPUUeakOcmKyjLR2
	 j/WPSekI7TP6AqUpLf/fh6PUowSi2t4LDisTF9xnRPAyCTs1SMGlPnIbAYoZAKGUH3
	 ptudWgjmFLXOFXSE3rX9/NAG0dLBn9GIs59GBcXCVjmPPJuTrm1qYT9+6ovXI8NU51
	 90pQuUmrp444A==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 03/10] rcu/tasks: Move holdout checks for idle task to a separate function
Date: Wed,  9 Oct 2024 18:21:20 +0530
Message-Id: <20241009125127.18902-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Move checks for an idle task being a holdout task for RCU-tasks
to a separate function - rcu_idle_task_is_holdout(). This function
will be used in subsequent commits to add additional checks for
idle task. No functional change intended.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6333f4ccf024..56015ced3f37 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -976,6 +976,15 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
+static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
+{
+	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
+	if (!rcu_cpu_online(cpu))
+		return false;
+
+	return true;
+}
+
 /* Check for quiescent states since the pregp's synchronize_rcu() */
 static bool rcu_tasks_is_holdout(struct task_struct *t)
 {
@@ -995,9 +1004,8 @@ static bool rcu_tasks_is_holdout(struct task_struct *t)
 
 	cpu = task_cpu(t);
 
-	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
-	if (t == idle_task(cpu) && !rcu_cpu_online(cpu))
-		return false;
+	if (t == idle_task(cpu))
+		return rcu_idle_task_is_holdout(t, cpu);
 
 	return true;
 }
-- 
2.40.1

