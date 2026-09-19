Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32522D7DC6;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778128; cv=none; b=KiaD7XkngAluIWEo7lvnFA0zx+ozNwjhleRZ3s1xskHVPFiqswSME0DJhERGc0rPuW8GPP957RomvVKzkM2j9oGfm4cDyEUsunB1XUP19oP0ygDJhXmK1LVaskr2kTnJpL/3veRm7GQkOwl1Y8MczL8Q6o+xeHpzeUAd0YTuwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778128; c=relaxed/simple;
	bh=689wI1HDv4/PsD9e46Ei853dPZ1hkg9mXwm+9n7glPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBOQHyORL/eiqmt0ee8pMpevTazmTPQIHhvkOwnPcw18jB1ctz/y05ZnAadFJscAs8PMa7FFqLe0h0O776X3wNZiTlTkRTXN8IQrXoGakMcu/A/maqzOvHpFnhNt5xOWKSOTZ1aLnPwm62B/oD9A1doZ4UqijxAtavJEIy2rl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmEIudNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmEIudNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16691F000FF;
	Sat, 19 Sep 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778122;
	bh=MhwN3/p0t4+Gd9zRj3mfPFqdYVncauhubyS4he6CO9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PmEIudNIT4TnQKXuHbMlVsOaO2aC4osSneh+5P4hcvqZ1JsQJtkKPOrbQPOyG5NQL
	 C6nHHS0eC/LTzxhCOe58OfZsrx6JbBGGxF+9g8twQCxpzMATzz0YT/inwYNMZBRtHa
	 wEcdS8gB+L2h5IByah36K9b8hSLiyAZKMNn/DP+0frHF9HAKonRPZjV5xWT8mxzVaL
	 xRUmEax/EQUuydW3/xVIceqW2UXygkzERfRgx19VK/QTA6d3YkNV7bJcOPjkl9s39w
	 HT25Acj2aCAl9MTajxocwvu/M1J3HHLRD58Ufs9OLnHSMbPJTxsldMTXo6VdHZ232u
	 Fe3ZtbHU/dInQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92498CE1775; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 01/19] srcutiny: Make a Tiny SRCU grace period imply an RCU grace period
Date: Fri, 18 Sep 2026 17:35:03 -0700
Message-Id: <20260919003521.3134552-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In non-preemptible kernels, a Tiny SRCU grace period implies an RCU
grace period because any context switch suffices.  But in preemptible
kernels, it is possible for a Tiny SRCU grace period to elapse without
a corresponding RCU grace period.

Which was OK until RCU Tasks Trace was re-implemented in terms
of SRCU-fast, which in Tiny SRCU is implemented as SRCU, which is
already fast.  And RCU Tasks Trace grace periods are required to imply
RCU grace periods.  This commit therefore adds a synchronize_rcu(),
but only in preemptible kernels.

Because preemptible Tiny SRCU is not in mainline, this added call to
synchronize_rcu() will not slow anything down:  The comparison would
instead be with TREE SRCU.  But if this added call ever becomes a problem,
the Tiny SRCU srcu_struct structure could track whether or not this is for
SRCU-fast, and to add the synchronize_rcu() only in the SRCU-fast case.
However, at the moment, this is seen as unnecessary complexity.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 5de9a6905838..32b37d63d58a 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -159,6 +159,8 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period
 	do {
 		// Deadlock issues prevent __srcu_read_unlock() from
 		// doing an unconditional wakeup, so polling is required.
-- 
2.40.1

