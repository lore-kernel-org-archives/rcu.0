Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314719AA58;
	Thu, 12 Dec 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029401; cv=none; b=gdhGM+AIYILRx9mSrb0Mq0c2tGRWlDfQaxN65fwcDA2FxBtboWK3QI1hwTVXhMFifUPiBzw7+yZW37HN6X1+m7HJCXqji635DmuOrYoKSW/dKwUfgb7kZvE2J8w5OpMK+56KWxcPk4VokCfRa58EHWKbE5W/T4GlY6nfWVXS3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029401; c=relaxed/simple;
	bh=WNXOR3bkU8ZY6zzF+I4d/B5cSyAyoy9fCPzYCnu+3LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnnfJaQQC9e5MGst8Pdqs5ubFdHoMkPxh/tnz6D/zbomnLJo4rw8GNbvVl0oI5XBnREU5H4auHUI7p7lQJmPo2n8ZOs/CTqtkpCv8vZQL8te5gvst7IzMpawfIfT8F2YB8rFyKTQ0WSo3as6IATXXZ5tBr5p2rE4G4pb1fkexE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqt/Rb8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqt/Rb8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA544C4CEEC;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=WNXOR3bkU8ZY6zzF+I4d/B5cSyAyoy9fCPzYCnu+3LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xqt/Rb8PcQWMhSuv59yfkDgHoGLJ050uMQwjtfdclTNnHcI7z7W3pJprT2EqnBWXA
	 cDpxVr7m4dVl9VqkaydCcx//Q6bIbSieWm88V/KLZnaON00M4GM3WlrxLIiLnFOvAG
	 4SVkFu4Tie11lJtO44zrky4E2F6gpe6CP7lArcaLWSOPhU3QNwCSL240oQMASTQTKQ
	 dSnPe6AeKLW5K34JTGGbc1GBcEH9fvABi8dHs09O0Z6CLi/6a7lIlVCWBUATradAsO
	 ZZZQvZCSk0W8u7siTvNdcKVTmp/PMTIbv+MhIhyzwn/PRVeTJAqXE7DhLhwv5i3L2F
	 1Qjnoe0bPR/CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D83DCCE1482; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/18] rcutorture: Add parameters to control polled/conditional wait interval
Date: Thu, 12 Dec 2024 10:49:53 -0800
Message-Id: <20241212184957.2127441-14-paulmck@kernel.org>
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

This commit adds rcutorture module parameters gp_cond_wi, gp_cond_wi_exp,
gp_poll_wi, and gp_poll_wi_exp to control the wait interval for
conditional, conditional expedited, polled, and polled expedited grace
periods, respectively.  When rcu_torture_writer() is testing these types
of grace periods, hrtimers are used to randomly wait up to the specified
number of microseconds, but with nanosecond granularity.

In the case of conditional grace periods (get_state_synchronize_rcu()
and cond_synchronize_rcu(), for example) there is just one
wait.  For polled grace periods (start_poll_synchronize_rcu() and
poll_state_synchronize_rcu(), for example), there is a repeated series
of waits until the grace period ends.

For normal grace periods, the default is 16 jiffies (for example, 16,000
microseconds on a HZ=1000 system) and for expedited grace periods the
default is 128 microseconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 38 +++++++++++++++++++
 kernel/rcu/rcutorture.c                       | 37 ++++++++++++------
 2 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03d13ca0604fc..3152f2c1da294 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5380,6 +5380,25 @@
 			concurrent normal grace periods into account,
 			if available.
 
+	rcutorture.gp_cond_wi= [KNL]
+			Nominal wait interval for normal conditional
+			grace periods (specified by rcutorture's
+			gp_cond and gp_cond_full module parameters),
+			in microseconds.  The actual wait interval will
+			be randomly selected to nanosecond granularity up
+			to this wait interval.	Defaults to 16 jiffies,
+			for example, 16,000 microseconds on a system
+			with HZ=1000.
+
+	rcutorture.gp_cond_wi_exp= [KNL]
+			Nominal wait interval for expedited conditional
+			grace periods (specified by rcutorture's
+			gp_cond_exp and gp_cond_exp_full module
+			parameters), in microseconds.  The actual wait
+			interval will be randomly selected to nanosecond
+			granularity up to this wait interval.  Defaults to
+			128 microseconds.
+
 	rcutorture.gp_exp= [KNL]
 			Use expedited update-side primitives, if available.
 
@@ -5405,6 +5424,25 @@
 			primitives that also take concurrent normal
 			grace periods into account, if available.
 
+	rcutorture.gp_poll_wi= [KNL]
+			Nominal wait interval for normal conditional
+			grace periods (specified by rcutorture's
+			gp_poll and gp_poll_full module parameters),
+			in microseconds.  The actual wait interval will
+			be randomly selected to nanosecond granularity up
+			to this wait interval.	Defaults to 16 jiffies,
+			for example, 16,000 microseconds on a system
+			with HZ=1000.
+
+	rcutorture.gp_poll_wi_exp= [KNL]
+			Nominal wait interval for expedited conditional
+			grace periods (specified by rcutorture's
+			gp_poll_exp and gp_poll_exp_full module
+			parameters), in microseconds.  The actual wait
+			interval will be randomly selected to nanosecond
+			granularity up to this wait interval.  Defaults to
+			128 microseconds.
+
 	rcutorture.gp_sync= [KNL]
 			Use normal (non-expedited) synchronous
 			update-side primitives, if available.  If all
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3595ce889b44f..235a73dad2801 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -92,12 +92,20 @@ torture_param(bool, gp_cond_exp, false, "Use conditional/async expedited GP wait
 torture_param(bool, gp_cond_full, false, "Use conditional/async full-state GP wait primitives");
 torture_param(bool, gp_cond_exp_full, false,
 		    "Use conditional/async full-stateexpedited GP wait primitives");
+torture_param(int, gp_cond_wi, 16 * USEC_PER_SEC / HZ,
+		   "Wait interval for normal conditional grace periods, us (default 16 jiffies)");
+torture_param(int, gp_cond_wi_exp, 128,
+		   "Wait interval for expedited conditional grace periods, us (default 128 us)");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
 torture_param(bool, gp_poll_exp, false, "Use polling expedited GP wait primitives");
 torture_param(bool, gp_poll_full, false, "Use polling full-state GP wait primitives");
 torture_param(bool, gp_poll_exp_full, false, "Use polling full-state expedited GP wait primitives");
+torture_param(int, gp_poll_wi, 16 * USEC_PER_SEC / HZ,
+		   "Wait interval for normal polled grace periods, us (default 16 jiffies)");
+torture_param(int, gp_poll_wi_exp, 128,
+		   "Wait interval for expedited polled grace periods, us (default 128 us)");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
@@ -1370,6 +1378,7 @@ static void rcu_torture_write_types(void)
 		pr_alert("%s: gp_sync without primitives.\n", __func__);
 	}
 	pr_alert("%s: Testing %d update types.\n", __func__, nsynctypes);
+	pr_info("%s: gp_cond_wi %d gp_cond_wi_exp %d gp_poll_wi %d gp_poll_wi_exp %d\n", __func__, gp_cond_wi, gp_cond_wi_exp, gp_poll_wi, gp_poll_wi_exp);
 }
 
 /*
@@ -1536,7 +1545,8 @@ rcu_torture_writer(void *arg)
 			case RTWS_COND_GET:
 				rcu_torture_writer_state = RTWS_COND_GET;
 				gp_snap = cur_ops->get_gp_state();
-				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				torture_hrtimeout_us(torture_random(&rand) % gp_cond_wi,
+						     1000, &rand);
 				rcu_torture_writer_state = RTWS_COND_SYNC;
 				cur_ops->cond_sync(gp_snap);
 				rcu_torture_pipe_update(old_rp);
@@ -1544,7 +1554,8 @@ rcu_torture_writer(void *arg)
 			case RTWS_COND_GET_EXP:
 				rcu_torture_writer_state = RTWS_COND_GET_EXP;
 				gp_snap = cur_ops->get_gp_state_exp();
-				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				torture_hrtimeout_us(torture_random(&rand) % gp_cond_wi_exp,
+						     1000, &rand);
 				rcu_torture_writer_state = RTWS_COND_SYNC_EXP;
 				cur_ops->cond_sync_exp(gp_snap);
 				rcu_torture_pipe_update(old_rp);
@@ -1552,7 +1563,8 @@ rcu_torture_writer(void *arg)
 			case RTWS_COND_GET_FULL:
 				rcu_torture_writer_state = RTWS_COND_GET_FULL;
 				cur_ops->get_gp_state_full(&gp_snap_full);
-				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				torture_hrtimeout_us(torture_random(&rand) % gp_cond_wi,
+						     1000, &rand);
 				rcu_torture_writer_state = RTWS_COND_SYNC_FULL;
 				cur_ops->cond_sync_full(&gp_snap_full);
 				rcu_torture_pipe_update(old_rp);
@@ -1560,7 +1572,8 @@ rcu_torture_writer(void *arg)
 			case RTWS_COND_GET_EXP_FULL:
 				rcu_torture_writer_state = RTWS_COND_GET_EXP_FULL;
 				cur_ops->get_gp_state_full(&gp_snap_full);
-				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
+				torture_hrtimeout_us(torture_random(&rand) % gp_cond_wi_exp,
+						     1000, &rand);
 				rcu_torture_writer_state = RTWS_COND_SYNC_EXP_FULL;
 				cur_ops->cond_sync_exp_full(&gp_snap_full);
 				rcu_torture_pipe_update(old_rp);
@@ -1580,8 +1593,8 @@ rcu_torture_writer(void *arg)
 							break;
 						}
 					WARN_ON_ONCE(ulo_size > 0 && i >= ulo_size);
-					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
-							     &rand);
+					torture_hrtimeout_us(torture_random(&rand) % gp_poll_wi,
+							     1000, &rand);
 				}
 				rcu_torture_pipe_update(old_rp);
 				break;
@@ -1601,8 +1614,8 @@ rcu_torture_writer(void *arg)
 							break;
 						}
 					WARN_ON_ONCE(rgo_size > 0 && i >= rgo_size);
-					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
-							     &rand);
+					torture_hrtimeout_us(torture_random(&rand) % gp_poll_wi,
+							     1000, &rand);
 				}
 				rcu_torture_pipe_update(old_rp);
 				break;
@@ -1611,8 +1624,8 @@ rcu_torture_writer(void *arg)
 				gp_snap = cur_ops->start_gp_poll_exp();
 				rcu_torture_writer_state = RTWS_POLL_WAIT_EXP;
 				while (!cur_ops->poll_gp_state_exp(gp_snap))
-					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
-							     &rand);
+					torture_hrtimeout_us(torture_random(&rand) % gp_poll_wi_exp,
+							     1000, &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_POLL_GET_EXP_FULL:
@@ -1620,8 +1633,8 @@ rcu_torture_writer(void *arg)
 				cur_ops->start_gp_poll_exp_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_EXP_FULL;
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full))
-					torture_hrtimeout_us(torture_random(&rand) % 128, 1000,
-							     &rand);
+					torture_hrtimeout_us(torture_random(&rand) % gp_poll_wi_exp,
+							     1000, &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_SYNC:
-- 
2.40.1

