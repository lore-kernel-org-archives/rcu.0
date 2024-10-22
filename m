Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF2198838;
	Tue, 22 Oct 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594394; cv=none; b=tnOu/2SCUeZmw8cP8e3N/BHXJz5EJ7s8ln4q6HaKv2AsmJIWr6dahD7CnmqX+mvrgYU4pzdZGMSLKlokAohJaUvTG/uODFBVLtKOJdXITOcApiWU7j1SEBPDHhBSfGA7MMqQDK3di20x9jfAhkliChLbXmPfUaEN6WOEAMtSEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594394; c=relaxed/simple;
	bh=kpUy999RQOtCP+8cRptbeQ0WvLWDerLFOX0uLFEY7WE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fIJrJsTwqETMK0cD+8FFL2YankJUEOtG4oWdpIBmVMxOI3FpZDdJtxaWDhAfpjVWUTjJr1c4bJLRCOd6BkQJxY41qM84zgsPv0Ra1ecgeH1o882JLOcL2+b51vcKAKfvMfDqAsBp1oH6hT2HvJK0ouRWB3OY/QYDTNhmYyN5KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NotISUoG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NotISUoG"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so6142253e87.1;
        Tue, 22 Oct 2024 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729594390; x=1730199190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOgivlSk5K3OIVkjBbotsiwB5LHVrc+2L8huvpuysCU=;
        b=NotISUoG6YiGvrUtApUVA6evbvhFZK0Ozc/1vt2/JBt02yXl8ibDqRaN4tkWB6btjN
         JXC8WtprzDixAKKj0PYIB40b3s4ELRsH997OxiILtjuXLEta5EzCfQGL7C12X6UqwXZE
         0EQxr+dzEc0ldkY1c2Xnlho9xRBOSs9FyemwTtprAA3WIudCU6hP1lNU/BsjvoARAiLg
         P3kLjjoRNDaPTSdlUr0Objlq/OoFtRco9RqQNtmRD52V3AHS4JWGAAL8kkumnlB2fbRk
         FKrc8xfwTLs5VZ6OZKiGCu303ssx7ENvG/vRYorLH7FZOz36Y4z8oEZn+0Q90eMXroyC
         XNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729594390; x=1730199190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOgivlSk5K3OIVkjBbotsiwB5LHVrc+2L8huvpuysCU=;
        b=ejqQeB4SbVq0K4b1SvSpk6qTk9qc58r28lTGIVmoOMnSQsFM3MYiFxq3FHPdJt9CXJ
         hzQcjKKHyWQh1WcmiWURyNxaNoNZzKJafHJiTMEpQjZuo+cUgEE7ohb1aQ+TxFcWCrZt
         obFvmOQH5ft3ozftJaJk0Pc+SjXuHyT2kUMXf8KJ6N6vwElqOYo2v+04mwDlyy9qKxN1
         6wSD1/cjZRkzcbTjRbi2YaOhPncRHcxwk5WtqqHj6t8cvi9Ze+f+Kub9EumEjeG04UPH
         LHPpgVb/vSg5J0Ll+1OZUTTE1MTIGMvDe3ddRoUgwqtNQM4sXDtXfnYAOT9ym4Oqcfbc
         k0Og==
X-Forwarded-Encrypted: i=1; AJvYcCVsGrWmA66TBbJcH7/nQ3MfHKjekzI3VG0NoctrGdYMjN32F88hYItzW+2YVGQyQR2xgRS1n1FfRheMANs=@vger.kernel.org, AJvYcCX4uRDOGULs+Te3hALBCQTKrIDsBzlFg/NHMYf5VJPghw+GrtWgrBcoZN5ifd4Vhhw18MTl@vger.kernel.org
X-Gm-Message-State: AOJu0YximbZCL5Yy5iXgY3FEWZ0tnxmjJRFIC1GZbt/Qc7LicBfHPk86
	S79lSBpUy2b8zOAuuq1MMGS/KLZ41h8xIpEndaH/Q0Lbxrz8Yn9H
X-Google-Smtp-Source: AGHT+IHwT/5zHuXu1w1NkRLJkyaG7gSvoCY9aA5F11uMpbDJkz9QL3DLehY0Hj56nogWjnTrIw6aoQ==
X-Received: by 2002:a05:6512:3f13:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-53b12bfd423mr1571987e87.13.1729594389794;
        Tue, 22 Oct 2024 03:53:09 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242013esm718895e87.164.2024.10.22.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:53:09 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
Subject: [PATCH] rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu
Date: Tue, 22 Oct 2024 12:53:07 +0200
Message-Id: <20241022105307.2857-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reports a data race when access the krcp->monitor_work.timer.expires
variable in the schedule_delayed_monitor_work() function:

<snip>
BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu

read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
 schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]
 kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
 trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
 bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
 bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
 __sys_bpf+0x2e5/0x7a0
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
 x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
 __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
 add_timer_global+0x51/0x70 kernel/time/timer.c:1330
 __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
 queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
 kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound kfree_rcu_monitor
<snip>

kfree_rcu_monitor() rearms the work if a "krcp" has to be still
offloaded and this is done without holding krcp->lock, whereas
the kvfree_call_rcu() holds it.

Fix it by acquiring the "krcp->lock" for kfree_rcu_monitor() so
both functions do not race anymore.

Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/ZxZ68KmHDQYU0yfD@pc636/T/
Fixes: 8fc5494ad5fa ("rcu/kvfree: Move need_offload_krc() out of krcp->lock")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd918..3e486ccaa4ca 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3511,7 +3511,7 @@ static int krc_count(struct kfree_rcu_cpu *krcp)
 }
 
 static void
-schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+__schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
 	long delay, delay_left;
 
@@ -3525,6 +3525,16 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
 }
 
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	__schedule_delayed_monitor_work(krcp);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
 static void
 kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 {
@@ -3836,7 +3846,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_monitor_work(krcp);
+		__schedule_delayed_monitor_work(krcp);
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
-- 
2.39.5

