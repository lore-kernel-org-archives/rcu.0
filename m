Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE3426690;
	Thu,  7 May 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172679; cv=none; b=P8TZLGpOzQl7qLmT6Vq+YL0pwf4PRhhyPSFy4//RRkS57MYW5rQD1iEy16Gob5FKr76RXb+SSo13Ss7Ml37yc/oXsQ9Oxd4uqksjTaVp6LQXQ9DtEFIO/YI2mS/qBGyhPqV5o5Ldnq/vZPSCEgSLr4XlxEg4i24apdDK2lHWKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172679; c=relaxed/simple;
	bh=oNMjz52hJFg8YGBPXWijA1VlYqMdNygZu1Dz5sa7NYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCUu8R/QtTr5Rd/Q/bFat7qVIOVA9THuki/Vh0FDsXMhL5iKMm9kW7SrAWI6u354fOzXJck3T0VU6HWcR5BGagJlDtATpreGUBDE9E0POGNocwS347+th1jUNgjiCzJ3yRePsuoeaG0++ccMxyy3OZ84pVyfw3VCD6D4Th3a8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghBPR9uR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghBPR9uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE87C2BCB8;
	Thu,  7 May 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778172678;
	bh=oNMjz52hJFg8YGBPXWijA1VlYqMdNygZu1Dz5sa7NYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghBPR9uRxdwlMdsRLyQmYLYcsdvZ+vaq87HcpUVwXQPZVD5bOULpswNBhDD1qhYsp
	 aBFdq9eeZAihz73w4JoF1BgB1SI4HzP38tPQKh5P3UHN8dUAhZ0NfBcuNLBP8lr/s2
	 gigH1KJxcYJbJNVC66uPPfgUSMAWHjw32uM35CsT7Cy/4NGO5QnphGYw0WtPiuNVSl
	 0WRUFj7mNki5f7yZr+IVM5ISk5aqyhtLPNnxQRAJbrPRuCktLpeeBCcDJRHKgn23YJ
	 9o9KBXHsjI3LpTgf0qcLo4WCIljH4yKVI8pBSwgIoVycWZKKzC0lxpbtITRNYFhkMG
	 yKoJuflOnvMxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9736ECE0863; Thu,  7 May 2026 09:51:18 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 3/4] hazptrtorture: Add microsecond-scale sleep in readers
Date: Thu,  7 May 2026 09:51:12 -0700
Message-Id: <20260507165113.2039524-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
References: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a default-disabled reader_sleep_us module parameter
that causes the hazard-pointer reader to unconditionally sleep for the
specified number of microseconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 1a61d35ade1d9d..219fd90a7f8840 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -39,6 +39,7 @@ torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=di
 // @@@ Move the rcu_torture_preempt() function and friends to kernel/torture.c.
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
 torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions (ms)");
+torture_param(int, reader_sleep_us, 0, "Reader sleep duration (us)");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
@@ -227,6 +228,8 @@ static void hazptr_read_delay(struct torture_random_state *rrsp)
 		udelay(shortdelay_us);
 	if (!preempt_count() && !(torture_random(rrsp) % (nrealreaders * 500)))
 		torture_preempt_schedule();  /* QS only if preemptible. */
+	if (reader_sleep_us > 0)
+		torture_hrtimeout_us(reader_sleep_us, 0, NULL);
 }
 
 static void hazptr_torture_read_unlock(struct hazptr_ctx *hcp, struct hazptr_torture *htp)
@@ -516,11 +519,13 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 		 "--- %s: nreaders=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
+		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
+		 reader_sleep_us,
 		 shuffle_interval, shutdown_secs, stat_interval, stutter,
 		 verbose);
 }
-- 
2.40.1

