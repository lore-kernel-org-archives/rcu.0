Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDE165FB2;
	Tue,  7 May 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074581; cv=none; b=GDNByb9PptH07gWtCPKHEmBNulxUc+yFnxIU1jyMwsLik4JBL/SX4clzhT2l/k8gip4dsXWfnYQaeJ5Jovc/L98mmnGMOifRcaW4eb0gDjwEy5+RLklB69X0+Zeu7w6sn9SM8TeznAxLITguv0FSVpDQ9SQAnC2ck6iNcfg583k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074581; c=relaxed/simple;
	bh=3CB9bqogXmxT3xgnGjFG4YsM0X24b664O2CNVeLO1Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz7GrUAxgOQP0Rb+Fy19dk4Y/ALBf9RgSrokjNJjDHFxwpZRgqYbgjDC9cxpOclQT42lYGgbrcC1ilxKu/Lh5k89HQ3rP06ZCX49rpWmtUVTxXsaZIZOhWTKUg3UoHlcL8gyqydR42IHzWbmbXiBVRVlFyqXfLs/GeK/ZkPd9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/KHWKVq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/KHWKVq"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e242b1df60so34989161fa.1;
        Tue, 07 May 2024 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074577; x=1715679377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSbSW28iEU5SGTrhgUEkX06lcEl9tav85cbSpYw4LcU=;
        b=Y/KHWKVqXDtgQ8eokJZYvKKs90aTM0koAOjS/6npABuGJcjaiLw1grBSnFfWSCR4vQ
         V2I6TMNaHZigzBzuGTMdHyiUttNAsIYx0cVFyXQmnBNHNzsVv6gXyYZExFxiUJKcT+g9
         EvDn0GuHH4d5HzN4PyyGqr+6vdjo7JjoASrb3CBzBE01p3H2UtDDMEnEVyTJTlbK7KRr
         izSus8U+8Y2HUv+H1eTuWIDJZvyZUTRQGEsUqBAflGxR/6W/F5mZGrLfjIcNLjpBi+AL
         U488IYOf3lN9lZ95gzT6qc/+p9AU5zYbynA+eHqXg1U5+dfHcCQVSScBG0fCUQoEXadM
         xyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074577; x=1715679377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSbSW28iEU5SGTrhgUEkX06lcEl9tav85cbSpYw4LcU=;
        b=t0eJvO4jey3HnI6X1poWnQqMP/w85gbaTsdKx8pygTjtRJRSzrSCIaT/9JOT1aWwo1
         /WuJbHV36zQYQTtIV9BqzkwbTnxnWq3sKPYHRu2vi9vEerg8AYbnSi0sRWkHYuydBFgm
         R/4qhUNWOBGR+9sEcvJST/WNfJlu7sk7ekIN3x/bsjcxXpzbRXvyHXCSgi+bvDK1OIxW
         v4YVeqFKHdcglBBg12VKUA1akXVIRTFxNr0f4Fx8YbjXVi5RF+/mBjiCpYZkLxMavYGA
         QQBtz1KL5aahiid7fuhYeZCSH5OkI3DP0IO5wd5I4E7pJ07A5gk1+Ztn1CUrGtMNbvLy
         xgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBEcbCxP26L35/aC/KyyJbK5vt41bwFYji0I6kqpwjy1WuYcuesSxBbrmxXoDZppaMjzTd9WR6JZpKa/B2Eq2NfT99lYcsoB4Cz+iZ
X-Gm-Message-State: AOJu0YyzVPqQ6vKAIpPF75JfuSRNHW7KsU6WcVtWxKRlFWiWScWO+9LM
	cfTsRP5IFRFbahTk/KSjxKR9njS7LjtT+Sqj47swcABq44EKUtUS
X-Google-Smtp-Source: AGHT+IFxu5RfY4AEiX+Eze/I9NGzwR7AEcv/jV/cGqqNCDGTMRqjo2Fo5+9CvJ/Mh2mLwjNS58vTaQ==
X-Received: by 2002:a2e:b0f4:0:b0:2d8:5b4e:bddb with SMTP id h20-20020a2eb0f4000000b002d85b4ebddbmr10957170ljl.52.1715074577428;
        Tue, 07 May 2024 02:36:17 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:17 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 46/48] rcutorture: Fix invalid context warning when enable srcu barrier testing
Date: Tue,  7 May 2024 11:35:28 +0200
Message-Id: <20240507093530.3043-47-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

When the torture_type is set srcu or srcud and cb_barrier is
non-zero, running the rcutorture test will trigger the
following warning:

[  163.910989][    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[  163.910994][    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[  163.910999][    C1] preempt_count: 10001, expected: 0
[  163.911002][    C1] RCU nest depth: 0, expected: 0
[  163.911005][    C1] INFO: lockdep is turned off.
[  163.911007][    C1] irq event stamp: 30964
[  163.911010][    C1] hardirqs last  enabled at (30963): [<ffffffffabc7df52>] do_idle+0x362/0x500
[  163.911018][    C1] hardirqs last disabled at (30964): [<ffffffffae616eff>] sysvec_call_function_single+0xf/0xd0
[  163.911025][    C1] softirqs last  enabled at (0): [<ffffffffabb6475f>] copy_process+0x16ff/0x6580
[  163.911033][    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  163.911038][    C1] Preemption disabled at:
[  163.911039][    C1] [<ffffffffacf1964b>] stack_depot_save_flags+0x24b/0x6c0
[  163.911063][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.8.0-rc4-rt4-yocto-preempt-rt+ #3 1e39aa9a737dd024a3275c4f835a872f673a7d3a
[  163.911071][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[  163.911075][    C1] Call Trace:
[  163.911078][    C1]  <IRQ>
[  163.911080][    C1]  dump_stack_lvl+0x88/0xd0
[  163.911089][    C1]  dump_stack+0x10/0x20
[  163.911095][    C1]  __might_resched+0x36f/0x530
[  163.911105][    C1]  rt_spin_lock+0x82/0x1c0
[  163.911112][    C1]  spin_lock_irqsave_ssp_contention+0xb8/0x100
[  163.911121][    C1]  srcu_gp_start_if_needed+0x782/0xf00
[  163.911128][    C1]  ? _raw_spin_unlock_irqrestore+0x46/0x70
[  163.911136][    C1]  ? debug_object_active_state+0x336/0x470
[  163.911148][    C1]  ? __pfx_srcu_gp_start_if_needed+0x10/0x10
[  163.911156][    C1]  ? __pfx_lock_release+0x10/0x10
[  163.911165][    C1]  ? __pfx_rcu_torture_barrier_cbf+0x10/0x10
[  163.911188][    C1]  __call_srcu+0x9f/0xe0
[  163.911196][    C1]  call_srcu+0x13/0x20
[  163.911201][    C1]  srcu_torture_call+0x1b/0x30
[  163.911224][    C1]  rcu_torture_barrier1cb+0x4a/0x60
[  163.911247][    C1]  __flush_smp_call_function_queue+0x267/0xca0
[  163.911256][    C1]  ? __pfx_rcu_torture_barrier1cb+0x10/0x10
[  163.911281][    C1]  generic_smp_call_function_single_interrupt+0x13/0x20
[  163.911288][    C1]  __sysvec_call_function_single+0x7d/0x280
[  163.911295][    C1]  sysvec_call_function_single+0x93/0xd0
[  163.911302][    C1]  </IRQ>
[  163.911304][    C1]  <TASK>
[  163.911308][    C1]  asm_sysvec_call_function_single+0x1b/0x20
[  163.911313][    C1] RIP: 0010:default_idle+0x17/0x20
[  163.911326][    C1] RSP: 0018:ffff888001997dc8 EFLAGS: 00000246
[  163.911333][    C1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffffae618b51
[  163.911337][    C1] RDX: 0000000000000000 RSI: ffffffffaea80920 RDI: ffffffffaec2de80
[  163.911342][    C1] RBP: ffff888001997dc8 R08: 0000000000000001 R09: ffffed100d740cad
[  163.911346][    C1] R10: ffffed100d740cac R11: ffff88806ba06563 R12: 0000000000000001
[  163.911350][    C1] R13: ffffffffafe460c0 R14: ffffffffafe460c0 R15: 0000000000000000
[  163.911358][    C1]  ? ct_kernel_exit.constprop.3+0x121/0x160
[  163.911369][    C1]  ? lockdep_hardirqs_on+0xc4/0x150
[  163.911376][    C1]  arch_cpu_idle+0x9/0x10
[  163.911383][    C1]  default_idle_call+0x7a/0xb0
[  163.911390][    C1]  do_idle+0x362/0x500
[  163.911398][    C1]  ? __pfx_do_idle+0x10/0x10
[  163.911404][    C1]  ? complete_with_flags+0x8b/0xb0
[  163.911416][    C1]  cpu_startup_entry+0x58/0x70
[  163.911423][    C1]  start_secondary+0x221/0x280
[  163.911430][    C1]  ? __pfx_start_secondary+0x10/0x10
[  163.911440][    C1]  secondary_startup_64_no_verify+0x17f/0x18b
[  163.911455][    C1]  </TASK>

This commit therefore use smp_call_on_cpu() instead of
smp_call_function_single(), make rcu_torture_barrier1cb() invoked
happens on task-context.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 456185d9e6c0..8654e99bd4a3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3044,11 +3044,12 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 }
 
 /* IPI handler to get callback posted on desired CPU, if online. */
-static void rcu_torture_barrier1cb(void *rcu_void)
+static int rcu_torture_barrier1cb(void *rcu_void)
 {
 	struct rcu_head *rhp = rcu_void;
 
 	cur_ops->call(rhp, rcu_torture_barrier_cbf);
+	return 0;
 }
 
 /* kthread function to register callbacks used to test RCU barriers. */
@@ -3074,11 +3075,9 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
-					     &rcu, 1)) {
-			// IPI failed, so use direct call from current CPU.
+		if (smp_call_on_cpu(myid, rcu_torture_barrier1cb, &rcu, 1))
 			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
-		}
+
 		if (atomic_dec_and_test(&barrier_cbs_count))
 			wake_up(&barrier_wq);
 	} while (!torture_must_stop());
-- 
2.39.2

