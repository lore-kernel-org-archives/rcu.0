Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68216ABDE;
	Tue,  7 May 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074580; cv=none; b=Vy8V1IY2L6j6aY6ZdIolxA8KMYzyo5/JNR0JTtfLMuwJ9AxlQDQZvLJ9uxbsgLhb4VpnvyOrIlWsRrW9THB8QSD76DzCtkRA61sJ2xWk5wR5GoVLeKjDJ0B3SATsPzT20SvQhQMfgW90Qa88aUz3rzJyUEyB8QVa5kDTCBK40rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074580; c=relaxed/simple;
	bh=o8QNqUWMDKmYcupNV+ex08qslA455LJ6fBNThqJ+gjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUfmlVe4qMPqT/Vt/EaDNRqw4NND8KFw9s0XiImpCvFVBRNfOeSirk1o+1ZKnULMM79q9kGLKy4x15TbbJuKVTcZfDcjtggMxUbNeJLUWZ2X444V9ACYvu0gi2ykKrXL69mdlo6AuoN8IBPdhbxJdSgTMCEOa0IqLnI1dMTe3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcHzRh6c; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcHzRh6c"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so16684711fa.2;
        Tue, 07 May 2024 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074576; x=1715679376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4giIpQovPJ+xyAcNjMeRcsmVa+ZmTidW6qcBvozTz1s=;
        b=lcHzRh6cXbmo0+iVSqIlwKMJUWA+Q7mnLNR3/wZEsRvMcLk32sdlM0AJ7vQW8zuJpX
         xLr2Lxl0SGW6ClhDkSwFanVzXsMzN62hqFK6pIg44YiMVEKMPRmPpoQKamFN3b2m1kUa
         noy9rmSlMG7dmGPT+eitnP4YbSC3Su9u9vOUYe0JPeFXJ/ASJ38oNilJLmXIKarLYbb1
         EWft7g5ZkAtchljdcJe+9CMopMn/A4zvcjE3Fq6kj3ngM3mk7Dh//Oy04D6qj4ajl5Pc
         yFsk4C2n71rC4RofZcvorxBO4Ho+DTDh+RgY3y2ns89oU6NT3N1FjBmM1ZAuwZxBpA/d
         hOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074576; x=1715679376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4giIpQovPJ+xyAcNjMeRcsmVa+ZmTidW6qcBvozTz1s=;
        b=IDPTZvV+uBcUyrC/43Br5CjfH7sD3Vbr25BJZxdR1cRW337WTUioO0Z9GSWYzffinQ
         tVs5rrWevz3PrU0+4OoK49cZq2Hh5L4qXANyD2cNb39CGrQio1pwSpR/fPbdQX/4Tmy+
         GqRmnrj2L5kZZ8pE+VmtNzALiD6fshZ6HPLNjhR7802Xmk3SWSrV0FhanDnrtHhEY9wm
         PotzFJzzfD8DYBTE21m/NbE5odDDi34Trd1zHsxoEYQiGO3YLcn7lq2aQ1tcQrMOnuol
         PBKF4GDxRmO5H69MpHMAcBI6koJTMwi3WcD8y3FU6b4r/gxC46wP2PM/eiCVUwAVYHbP
         9tXA==
X-Forwarded-Encrypted: i=1; AJvYcCW2NEbSEWKUuruVJZyKTaTI6nm1nEdOWT7lZPGtmExcCb9efUro57CuxUwXSAYMfYGJoP2PVqFPmI5wRJBenxtMTVHVNcb5gVg6rz3y
X-Gm-Message-State: AOJu0YznvVPJg4xp1O1jxaqWHtLBCI+aj684uGWP0F9aBo6Qt04JbdQS
	QzjBAMA8yCMRX044iJ03MuE5jjC0a9USxnJefxIo7a+CLi9JbX6W
X-Google-Smtp-Source: AGHT+IEdlgPKASMcAXsb/+V3a2DOzgPncU0m0YsG/SFNTfc0/QFiE1TnVpkcvSZUdWq5OXpIRGNrsA==
X-Received: by 2002:a2e:9ccd:0:b0:2e2:466b:1a68 with SMTP id g13-20020a2e9ccd000000b002e2466b1a68mr6610640ljj.41.1715074576562;
        Tue, 07 May 2024 02:36:16 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:16 -0700 (PDT)
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
Subject: [PATCH 45/48] rcutorture: Make stall-tasks directly exit when rcutorture tests end
Date: Tue,  7 May 2024 11:35:27 +0200
Message-Id: <20240507093530.3043-46-urezki@gmail.com>
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

When the rcutorture tests start to exit, the rcu_torture_cleanup() is
invoked to stop kthreads and release resources, if the stall-task
kthreads exist, cpu-stall has started and the rcutorture.stall_cpu
is set to a larger value, the rcu_torture_cleanup() will be blocked
for a long time and the hung-task may occur, this commit therefore
add kthread_should_stop() to the loop of cpu-stall operation, when
rcutorture tests ends, no need to wait for cpu-stall to end, exit
directly.

Use the following command to test:

insmod rcutorture.ko torture_type=srcu fwd_progress=0 stat_interval=4
stall_cpu_block=1 stall_cpu=200 stall_cpu_holdoff=10 read_exit_burst=0
object_debug=1
rmmod rcutorture

[15361.918610] INFO: task rmmod:878 blocked for more than 122 seconds.
[15361.918613]       Tainted: G        W
6.8.0-rc2-yoctodev-standard+ #25
[15361.918615] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[15361.918616] task:rmmod           state:D stack:0     pid:878
tgid:878   ppid:773    flags:0x00004002
[15361.918621] Call Trace:
[15361.918623]  <TASK>
[15361.918626]  __schedule+0xc0d/0x28f0
[15361.918631]  ? __pfx___schedule+0x10/0x10
[15361.918635]  ? rcu_is_watching+0x19/0xb0
[15361.918638]  ? schedule+0x1f6/0x290
[15361.918642]  ? __pfx_lock_release+0x10/0x10
[15361.918645]  ? schedule+0xc9/0x290
[15361.918648]  ? schedule+0xc9/0x290
[15361.918653]  ? trace_preempt_off+0x54/0x100
[15361.918657]  ? schedule+0xc9/0x290
[15361.918661]  schedule+0xd0/0x290
[15361.918665]  schedule_timeout+0x56d/0x7d0
[15361.918669]  ? debug_smp_processor_id+0x1b/0x30
[15361.918672]  ? rcu_is_watching+0x19/0xb0
[15361.918676]  ? __pfx_schedule_timeout+0x10/0x10
[15361.918679]  ? debug_smp_processor_id+0x1b/0x30
[15361.918683]  ? rcu_is_watching+0x19/0xb0
[15361.918686]  ? wait_for_completion+0x179/0x4c0
[15361.918690]  ? __pfx_lock_release+0x10/0x10
[15361.918693]  ? __kasan_check_write+0x18/0x20
[15361.918696]  ? wait_for_completion+0x9d/0x4c0
[15361.918700]  ? _raw_spin_unlock_irq+0x36/0x50
[15361.918703]  ? wait_for_completion+0x179/0x4c0
[15361.918707]  ? _raw_spin_unlock_irq+0x36/0x50
[15361.918710]  ? wait_for_completion+0x179/0x4c0
[15361.918714]  ? trace_preempt_on+0x54/0x100
[15361.918718]  ? wait_for_completion+0x179/0x4c0
[15361.918723]  wait_for_completion+0x181/0x4c0
[15361.918728]  ? __pfx_wait_for_completion+0x10/0x10
[15361.918738]  kthread_stop+0x152/0x470
[15361.918742]  _torture_stop_kthread+0x44/0xc0 [torture
7af7f9cbba28271a10503b653f9e05d518fbc8c3]
[15361.918752]  rcu_torture_cleanup+0x2ac/0xe90 [rcutorture
f2cb1f556ee7956270927183c4c2c7749a336529]
[15361.918766]  ? __pfx_rcu_torture_cleanup+0x10/0x10 [rcutorture
f2cb1f556ee7956270927183c4c2c7749a336529]
[15361.918777]  ? __kasan_check_write+0x18/0x20
[15361.918781]  ? __mutex_unlock_slowpath+0x17c/0x670
[15361.918789]  ? __might_fault+0xcd/0x180
[15361.918793]  ? find_module_all+0x104/0x1d0
[15361.918799]  __x64_sys_delete_module+0x2a4/0x3f0
[15361.918803]  ? __pfx___x64_sys_delete_module+0x10/0x10
[15361.918807]  ? syscall_exit_to_user_mode+0x149/0x280

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3f9c3766f52b..456185d9e6c0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2489,8 +2489,8 @@ static int rcu_torture_stall(void *args)
 			preempt_disable();
 		pr_alert("%s start on CPU %d.\n",
 			  __func__, raw_smp_processor_id());
-		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
-				    stop_at))
+		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(), stop_at) &&
+		       !kthread_should_stop())
 			if (stall_cpu_block) {
 #ifdef CONFIG_PREEMPTION
 				preempt_schedule();
-- 
2.39.2

