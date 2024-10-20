Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FA192B9E;
	Sun, 20 Oct 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729428691; cv=none; b=PfMNSmKTQuNVH9BA6jPCtniIUIYc9oEdh9WRevuW1zgmrNwrMhefm44f4dSh9uI3dkjyw5WycsX0pfemm+qIhEoIQK0HnZQT3XB+a9VN5h8QlXjqYwkAG3xt3ZXOb1zomaWkTnHaK43+QNJN8nu+dSWPGq3/ME9Z4CO6li2q8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729428691; c=relaxed/simple;
	bh=V1Hd2hpF1PC6ov8soQexfZcR7ndvBAQxb+ycPCgw0oM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hJIhwA0V0pTSVKmM+Ykn04Qj6WJk6/kJ4SthqJ32xZUKBdx0pj9SlPoeOsQiF/rbXMGmu2XZGDiM0FCmPpk2vT7poUBBjQkQEgNqdmkF5GH3T4KVOQYAS65MAB4Z7HU9W57ARq1hoOd0HhbR+V/aPWK57SZxNXFPV5iHMuf0uqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6FuUcNH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6FuUcNH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c693b68f5so37954835ad.1;
        Sun, 20 Oct 2024 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729428688; x=1730033488; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Liji241/QeE11KiWMMMGYF8zGuKangkdUYIyn2w04fI=;
        b=G6FuUcNHiPjn+18dBuCFzjlfLTli/Qb0JgUXoLKQ+yT2JZlbrJPBm95YfYFUB1atJu
         ZvX/nQWP8Qg5vA8EtoyiGFdGy3NtOI6Q0bla4zVBJpj3RS+Gvmr2OxYmZ4lVO6AYev3U
         2w99GiDph28dY64eTDnOcRweZ+YpkjWXn8z7CSgVOjZ/nDnO2AXhKzjCNN1d87t38ahf
         33Otz40LuqPPnls9YLyDommHQ+IPBAHTDzFM3BBFj/F6xOO6PxyzIeEZhRLEt4MUprju
         gSpyGmhD863tdR/e+5dyVG7LbBkayOEaiaKrsY4b6O9zBz3uJRmyTzGaClyTFUoVy5Ot
         neAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729428688; x=1730033488;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Liji241/QeE11KiWMMMGYF8zGuKangkdUYIyn2w04fI=;
        b=h1ppkcHWyIg013iAiSECDD8juG+clAVE7H2z40Tw6v5Nue7ry2seqHtZTjaM9CpYFI
         ogjH3mwTclSWyVkJ9cbvK5dRTX+rhjCfGMXydTBuTc4Zon1sxc4bkIQLdzUvpr2t8Eoi
         4B7ate51oO0oqmFtTtiI0FNN0vynK3/bVtfyATauKHDqcxRJt/dnLJYrOj51hmbGRk56
         qpf2VK4FX6welRN3dpZsym2GLnLt0gruRj3LNHAPAbW6KdTSQKf/GYjFuKTKVBamWXq8
         /kI34xT1fcrm8XKgpI6i38TrtZ76NpG89kbnXt3CGj3hLzStcbjZPgfL7GX0m7uWaS3h
         3pvw==
X-Forwarded-Encrypted: i=1; AJvYcCW5p5bfokXolqs1XIig1W56D31+cJ++A3gFHYRDpkFXXHxO7zlCRudMKO9dFvh+zzVx313A@vger.kernel.org, AJvYcCXZYuBhkNscT3p1rxCbQsZo2wjyxDDLQVuII2gyGjRCk+g2qwpREgGKgjaOLN2hT7fUlTSlMJmuXaZPomQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdODFZ7dJJHj1gy1JfexIiYj4iG59R0TON0znX5lSoyha8Q6H
	XpUlyu6MhKOjjC/d9ciHAjknrKYQ9SHAR/nydSEnIXsVqPB8cRwF5/wtRA==
X-Google-Smtp-Source: AGHT+IEJoSu7QQXD8v81l++M/y6bfs2W7vBREvCVBPanmVLmyFPMJhcrwlQJppMUrum1cAnNNNql/Q==
X-Received: by 2002:a17:903:2284:b0:20c:62f4:41c with SMTP id d9443c01a7336-20e5a70d567mr123529715ad.3.1729428688287;
        Sun, 20 Oct 2024 05:51:28 -0700 (PDT)
Received: from localhost.localdomain ([120.244.141.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de4d3sm9915825ad.216.2024.10.20.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 05:51:27 -0700 (PDT)
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
Subject: [PATCH] rcu/nocb: Fix the WARN_ON_ONCE() in rcu_nocb_rdp_deoffload()
Date: Sun, 20 Oct 2024 20:51:19 +0800
Message-Id: <20241020125119.14751-1-qiang.zhang1211@gmail.com>
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
trigger deadlock, this commit therefore check rdp->cblist length
before invoke kthread_parkme(), and the kthread_parkme() is not
invoke until length reaches zero.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_nocb.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8648233e1717..a2b0ebdefee3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -893,6 +893,12 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
 	return !READ_ONCE(rdp->nocb_cb_sleep) || kthread_should_park();
 }
 
+static inline bool nocb_cblist_empty(struct rcu_data *rdp)
+{
+	return !(rcu_rdp_is_offloaded(rdp) &&
+		WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)));
+}
+
 /*
  * Invoke any ready callbacks from the corresponding no-CBs CPU,
  * then, if there are no more, wait for more to appear.
@@ -907,7 +913,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
 	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 					    nocb_cb_wait_cond(rdp));
-	if (kthread_should_park()) {
+	if (kthread_should_park() && nocb_cblist_empty(rdp)) {
 		kthread_parkme();
 	} else if (READ_ONCE(rdp->nocb_cb_sleep)) {
 		WARN_ON(signal_pending(current));
-- 
2.17.1

