Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3E188917;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=aQlWnpwk6mb21SCWCDKu86Rffc9G4EsmG09z3TUPyN15MunTvc2D8pjkUOss6cY6is/uyd6V1f6eBu16UDIK8hCwUsw2s2m2wPprF2GlJI/+wXC1dy6CAcCU2Ve5ScJocN75fCe8Nvhcl2BiR5NS/3EB5+r6ag0YOccPjCkG5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=IJpDFL43PIQmlzhvMZy0oiR7KUJoDwLh5SiwYaWUY+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iv6yAVyRWkeNwT7zMv8mOhNLBzCnx9WX/NoeO53Ay2KaIAE4aaDqLJkBfa2TRlzoRUhsp4xVj0p2ahjPVJ6Mn17r9YphKu3apmSAugvZn6LkpXsBDTgDCAUFy6H2MO6rA0MvwbJj74fB4Mus6d44Jv3qpVvXd3wLduRRi1q2tsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSmgTCe4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSmgTCe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44385C4CEDF;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=IJpDFL43PIQmlzhvMZy0oiR7KUJoDwLh5SiwYaWUY+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSmgTCe4n0fzdRLwPi6TKwobUHvr3OhUpM9EWO2D+CMDbHbQMSfKsw4NdWwvnXbYE
	 RVlxNvEY2wt1ExjUdYiqjoS0qcVVmphmzytp7cT+dWlagxjlu7OCrUzE7Knu9Pq1kD
	 6yKepJ7ceIlL1H8NjvVGtAdo5pX/aJwoBUIoZPVumWr1xYam2rBub5lU0yyboFC03H
	 RWLRDeOCKLAFpNU/GeN20E2tQ4ivieYejSuPNFZrWxuiMqsOYsqUHkYYUb+dSGjAXA
	 vxsTR8/2uVEF7aFpPCw5lfbW1sqkUtbC4Z1CCliMb38Ss096i0JKzOI2hcB79jDyoV
	 qWoMoELAoPs3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF26BCE0FA8; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/18] rcutorture: Use finer-grained timeouts for rcu_torture_writer() polling
Date: Thu, 12 Dec 2024 10:49:44 -0800
Message-Id: <20241212184957.2127441-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_torture_writer() polling currently uses timeouts ranging from
zero to 16 milliseconds to wait for the polled grace period to end.
This works, but it would be better to have a higher probability of
exercising races with the code that cleans up after a grace period.
This commit therefore switches from these millisecond-scale timeouts
to timeouts ranging from zero to 128 microseconds, and with a full
microsecond's worth of timeout fuzz.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0bc6fc5822153..6067f2740247d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1561,8 +1561,8 @@ rcu_torture_writer(void *arg)
 							break;
 						}
 					WARN_ON_ONCE(ulo_size > 0 && i >= ulo_size);
-					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
-								  &rand);
+					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
+							     &rand);
 				}
 				rcu_torture_pipe_update(old_rp);
 				break;
@@ -1582,8 +1582,8 @@ rcu_torture_writer(void *arg)
 							break;
 						}
 					WARN_ON_ONCE(rgo_size > 0 && i >= rgo_size);
-					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
-								  &rand);
+					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
+							     &rand);
 				}
 				rcu_torture_pipe_update(old_rp);
 				break;
@@ -1592,8 +1592,8 @@ rcu_torture_writer(void *arg)
 				gp_snap = cur_ops->start_gp_poll_exp();
 				rcu_torture_writer_state = RTWS_POLL_WAIT_EXP;
 				while (!cur_ops->poll_gp_state_exp(gp_snap))
-					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
-								  &rand);
+					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
+							     &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_POLL_GET_EXP_FULL:
@@ -1601,8 +1601,8 @@ rcu_torture_writer(void *arg)
 				cur_ops->start_gp_poll_exp_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_EXP_FULL;
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full))
-					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
-								  &rand);
+					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
+							     &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_SYNC:
-- 
2.40.1

