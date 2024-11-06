Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7022064F5;
	Wed,  6 Nov 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908961; cv=none; b=K1YEphkw6kf7qycwP3bB1lFwHjQVSiSoeqx/vtNFOOFroC+rhIY7if4LoL1xlh5O6pJVvHYwyjuvK1MpJRGCkYYi1zNFQ59SB9oKeO2W+qxYLNOZt3zO1//BiYuOjqPMSlVxE45taSLF9lnockNqtPO2PpaawIh/m+0OV1U8DG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908961; c=relaxed/simple;
	bh=4glDQSNUoXiax4XF8AjgBBQOPX1MeTdEr5B6E0keNH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFFBiggH5dLSCE+8x/FeQ9UfT6N43PkrF4L0PtQHsX3wEm4Z4GUQp0RrtO90S33qXO4lgiexp99YfySgyDKOolpyWLNGRF/T1u0gJzRbB2jjBwXFfEdYX78MLMJI7vF5y779/f+RirIyb3WUsTmY7I2nUwk7aObowfzo+dYbe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXLpXb1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXLpXb1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE061C4CED4;
	Wed,  6 Nov 2024 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908961;
	bh=4glDQSNUoXiax4XF8AjgBBQOPX1MeTdEr5B6E0keNH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXLpXb1J6rVW/SuU/Gqadi2jhe22nOaPSsoC+PTIlHtR5nBDiY0G5GOYyPWta6RXo
	 S7cEWf89VH/aDQzPKRzjywAUo+YZ1l2nJOu5qhu52HYB3FN/nHcSmnZUrwYh9nx6ZN
	 obqGLnYSCsaiKRZV9PxwXneMgPMv/KsSJKGAC+RSSjdenkSCOoqzLz1bteX4vnQN3I
	 cGfiHRKwaYqd4DqTV1y5AJH2RxZoXLl/U1Kcghz46wyt0iCw9PlqSH1Z+QAZQLXgLM
	 +rL231KJC5usVG9EwX+P/RWI6b8Uu44gUMCOPUPUOrmnO2E1KZ00WNEzCrswJVlvak
	 YqRbLkx8NNIzA==
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
Subject: [PATCH 4/6] rcutorture: Avoid printing cpu=-1 for no-fault RCU boost failure
Date: Wed,  6 Nov 2024 17:02:21 +0100
Message-ID: <20241106160223.42119-5-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

If a CPU runs throughout the stalled grace period without passing
through a quiescent state, RCU priority boosting cannot help.
The rcu_torture_boost_failed() function therefore prints a message
flagging the first such CPU.  However, if the stall was instead due to
(for example) RCU's grace-period kthread being starved of CPU, there will
be no such CPU, causing rcu_check_boost_fail() to instead pass back -1
through its cpup CPU-pointer parameter.

Therefore, the current message complains about a mythical CPU -1.

This commit therefore checks for this situation, and notes that all CPUs
have passed through a quiescent state.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800..e92fa97fc76f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1059,8 +1059,13 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *star
 			// At most one persisted message per boost test.
 			j = jiffies;
 			lp = READ_ONCE(last_persist);
-			if (time_after(j, lp + mininterval) && cmpxchg(&last_persist, lp, j) == lp)
-				pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
+			if (time_after(j, lp + mininterval) &&
+			    cmpxchg(&last_persist, lp, j) == lp) {
+				if (cpu < 0)
+					pr_info("Boost inversion persisted: QS from all CPUs\n");
+				else
+					pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
+			}
 			return false; // passed on a technicality
 		}
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
-- 
2.46.0

