Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EA13A87C;
	Tue, 22 Oct 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568491; cv=none; b=OGJqF997fBPxihftUWjlydmiolJYrkixkB4QqmJFnBJKEPjrh85I8mzOx4Yzr/EIjIS9gMe5Yv9gOFZNmdYiV3xTUXd4dN/HwYPYqCrnoJS/mKOgAOKa27n2lrAEnf2Q6IjGUWLbDEqg/uedtxw0/FjSWrb4iAGd3rBARzp4PVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568491; c=relaxed/simple;
	bh=AFm/0k6SR+qNRolJ/kQ6NdQaMVt7ACcmwee2QkEQsMI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=riH0lbNKA56Z6afYqJRZjkeBAC5fz0VVDYkUF19XKTdOiADI1HA3uY7jWczB4zlVKM0Eugc4K82HLQIObKh9lQoqOLYW3+CnXyftAadq+ILH1j0ZOQNkguVeSz5E5xD5BzBlFpO355+Hle1nGsYgoEogb7AsG5lB4P0XI2t1KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJSFWDMG; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJSFWDMG"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5ffbc6acbso2377266b6e.3;
        Mon, 21 Oct 2024 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729568489; x=1730173289; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yleVfKutHKagA6aWnH6dyM+M+TzSDMyDZKSTomw3IE=;
        b=EJSFWDMGFzdIME2zXM1DyWGxzyyiRj7RPJqOJicH8bULgKMFWMKhft9RRjBwAt/S+g
         zB8OqEMJ1QNjhS/bmLFk3503JlDaUYdzlMtJtaj7rtuccFZJQAA2SNto1kLu5I1HubuS
         bSc5JynqKcAYuOHO0ywJFDvIi5WdDZ7YkWmyncgqeIyd0IYlIRL3WOgsOh5DJsmVPt77
         oZ6BT3fUMGt4ExZ3GnXTFXeDI2NXiMQwPP1ad3IQ/MpUJQAcJfVPsjln6nhw4/yBDmHw
         0bMYIMWA6AFzlwn0HdpmDziCEcj1dmlorQQ+RkMXyTr0ZVMG1ahxmTKGeuML+Kp0CAyk
         wPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729568489; x=1730173289;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yleVfKutHKagA6aWnH6dyM+M+TzSDMyDZKSTomw3IE=;
        b=c3XC5sdrcA967S+45YryKRmgBsqYcywPRltR7X8hpCDSzD+LyHTLaPr1+K8KO+cMD/
         0VgLwYfyb2ZqZgw+wXCdCQoCYuv4E59XTPfj5gr2CrUmFjwS1in34oQfjNZfmeOIWPm6
         Zf+VSLzj2oaUAHadJwpoHrmiVGtjZ5AV4bT4G7Qv4SX9Df0IsAkOzQHrJxV4USuCSxch
         Rf2HfMR/SU6eSNZtNPXfmzGH1mChxAB8R/dYEsmePKD09Zxp84F5edxs8/OsfN903J8e
         sPWFZD+nf40xCGnS52o4UBZj2gF9+pt/1XPVASow+GvMUqy1x6UoVpJ/0vFber0OPq7c
         ZH+A==
X-Forwarded-Encrypted: i=1; AJvYcCUJL3jMFphCIgpxPpx1pim7rfY0vMCoj86UEGnGO3vRRgD6U7pq3lAvUn5kyZXA+4Ca0bzy@vger.kernel.org, AJvYcCUzMZ5QNLh70onevQS0s+B1B1iFEVaGy19sM8D4NlR8vDy/0UQ3mIxxsL2t3/Tz/Mk+0UmCLWBcVfJHXfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbOKVm7+d4sn2U8O09blnMohFiRHfqkCXwGxgLBx5ZtkEA9Ct
	MUJx53arAwltCHcmHV9ll4clbdTYgfsLSG4OQQyKog2IJIOP87EY
X-Google-Smtp-Source: AGHT+IHovOhJbMXYl7W2s+e71+jwqToNAkLnYyXo6XB8W8EP5xYiJsX//NlpX08oHNVfHGUhLPEULQ==
X-Received: by 2002:a05:6808:158e:b0:3e6:153:bb6 with SMTP id 5614622812f47-3e602c87e3fmr12147251b6e.12.1729568488976;
        Mon, 21 Oct 2024 20:41:28 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafbba8sm3901195a12.18.2024.10.21.20.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:41:28 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com,
	boqun.feng@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu/nocb: Fix the WARN_ON_ONCE() in rcu_nocb_rdp_deoffload()
Date: Tue, 22 Oct 2024 11:41:17 +0800
Message-Id: <20241022034117.2294-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Currently, running rcutorture test with torture_type=rcu fwd_progress=8
n_barrier_cbs=8 nocbs_nthreads=8 nocbs_toggle=100 onoff_interval=60
test_boost=2, will trigger the following warning:

WARNING: CPU: 19 PID: 100 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.537322] Call Trace:
[18839.538006]  <TASK>
[18839.538596]  ? __warn+0x7e/0x120
[18839.539491]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.540757]  ? report_bug+0x18e/0x1a0
[18839.541805]  ? handle_bug+0x3d/0x70
[18839.542837]  ? exc_invalid_op+0x18/0x70
[18839.543959]  ? asm_exc_invalid_op+0x1a/0x20
[18839.545165]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
[18839.546547]  rcu_nocb_cpu_deoffload+0x70/0xa0
[18839.547814]  rcu_nocb_toggle+0x136/0x1c0
[18839.548960]  ? __pfx_rcu_nocb_toggle+0x10/0x10
[18839.550073]  kthread+0xd1/0x100
[18839.550958]  ? __pfx_kthread+0x10/0x10
[18839.552008]  ret_from_fork+0x2f/0x50
[18839.553002]  ? __pfx_kthread+0x10/0x10
[18839.553968]  ret_from_fork_asm+0x1a/0x30
[18839.555038]  </TASK>

CPU0                               CPU2                          CPU3
//rcu_nocb_toggle             //nocb_cb_wait                   //rcutorture

// deoffload CPU1             // process CPU1's rdp
rcu_barrier()
    rcu_segcblist_entrain()
        rcu_segcblist_add_len(1);
        // len == 2
        // enqueue barrier
        // callback to CPU1's
        // rdp->cblist
                             rcu_do_batch()
                                 // invoke CPU1's rdp->cblist
                                 // callback
                                 rcu_barrier_callback()
                                                             rcu_barrier()
                                                               mutex_lock(&rcu_state.barrier_mutex);
                                                               // still see len == 2
                                                               // enqueue barrier callback
                                                               // to CPU1's rdp->cblist
                                                               rcu_segcblist_entrain()
                                                                   rcu_segcblist_add_len(1);
                                                                   // len == 3
                                 // decrement len
                                 rcu_segcblist_add_len(-2);
                             kthread_parkme()

// CPU1's rdp->cblist len == 1
// Warn because there is
// still a pending barrier
// trigger warning
WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
cpus_read_unlock();

                                                                // wait CPU1 comes online
                                                                // invoke barrier callback on
                                                                // CPU1 rdp's->cblist
                                                                wait_for_completion(&rcu_state.barrier_completion);
// deoffload CPU4
cpus_read_lock()
  rcu_barrier()
    mutex_lock(&rcu_state.barrier_mutex);
    // block on barrier_mutex
    // wait rcu_barrier() on
    // CPU3 to unlock barrier_mutex
    // but CPU3 unlock barrier_mutex
    // need to wait CPU1 comes online
    // when CPU1 going online will block on cpus_write_lock

The above scenario will not only trigger WARN_ON_ONCE(), but also
trigger deadlock, this commit therefore check rdp->nocb_cb_sleep
flags before invoke kthread_parkme(), and the kthread_parkme() is
not invoke until there are no pending callbacks and set 
rdp->nocb_cb_sleep is true.

Fixes: 1fcb932c8b5c ("rcu/nocb: Simplify (de-)offloading state machine")
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_nocb.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8648233e1717..44c7cbe1db8e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -908,7 +908,18 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 					    nocb_cb_wait_cond(rdp));
 	if (kthread_should_park()) {
-		kthread_parkme();
+		/*
+		 * kthread_park() must be preceded by an rcu_barrier().
+		 * But yet another rcu_barrier() might have sneaked in between
+		 * the barrier callback execution and the callbacks counter
+		 * decrement.
+		 */
+		if (rdp->nocb_cb_sleep) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			kthread_parkme();
+		}
 	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
 		WARN_ON(signal_pending(current));
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
-- 
2.17.1

