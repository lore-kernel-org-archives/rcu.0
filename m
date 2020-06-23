Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ADAC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81BB206C3
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871030;
	bh=eD4czF0d2HNg5wSs6AJ7/+z4RbtvjTsUWsnO4cskESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rC+JsfXiw+1ajxbBuFx/RpP5pjE62JosrGTlviYNSAmg4WtA/hXwwJOg6ctSHd3l
	 9N4+14V1VZcfr/WWDpQLOLuMnNaKn3HZ3peVP5HAgn9Bgs4VoTZ7nBl9kMyDxYYSRW
	 AIFw6AnxX6G1PQwuaLmpeuYWMS5fIcMhrVMj80kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgFWAJv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbgFWAJu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D7C20786;
        Tue, 23 Jun 2020 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870989;
        bh=eD4czF0d2HNg5wSs6AJ7/+z4RbtvjTsUWsnO4cskESA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYUfbBpHIh6eZc4IIo662WMeeoqPrioSHeU0K36v4Y1xnNInMawsynSC8hJlk4gD9
         z9RWncDwvEid/rsAcruDGvItVk79WN9NxFl5d0/4/Maj+tEG9yuPbUGEze64yQh421
         dRSPkduR64f5cEAPQPWy3IN0UgXlPHwfeqd7zWzU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] docs: RCU: Convert lockdep-splat.txt to ReST
Date:   Mon, 22 Jun 2020 17:09:39 -0700
Message-Id: <20200623000947.25222-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst                        |   1 +
 .../RCU/{lockdep-splat.txt => lockdep-splat.rst}   | 109 +++++++++++----------
 2 files changed, 58 insertions(+), 52 deletions(-)
 rename Documentation/RCU/{lockdep-splat.txt => lockdep-splat.rst} (54%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index c1ba4d1..430a371 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -11,6 +11,7 @@ RCU concepts
 
    arrayRCU
    checklist
+   lockdep-splat
    rcubarrier
    rcu_dereference
    whatisRCU
diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.rst
similarity index 54%
rename from Documentation/RCU/lockdep-splat.txt
rename to Documentation/RCU/lockdep-splat.rst
index b809631..2a5c79d 100644
--- a/Documentation/RCU/lockdep-splat.txt
+++ b/Documentation/RCU/lockdep-splat.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Lockdep-RCU Splat
+=================
+
 Lockdep-RCU was added to the Linux kernel in early 2010
 (http://lwn.net/Articles/371986/).  This facility checks for some common
 misuses of the RCU API, most notably using one of the rcu_dereference()
@@ -12,55 +18,54 @@ overwriting or worse.  There can of course be false positives, this
 being the real world and all that.
 
 So let's look at an example RCU lockdep splat from 3.0-rc5, one that
-has long since been fixed:
-
-=============================
-WARNING: suspicious RCU usage
------------------------------
-block/cfq-iosched.c:2776 suspicious rcu_dereference_protected() usage!
-
-other info that might help us debug this:
-
-
-rcu_scheduler_active = 1, debug_locks = 0
-3 locks held by scsi_scan_6/1552:
- #0:  (&shost->scan_mutex){+.+.}, at: [<ffffffff8145efca>]
-scsi_scan_host_selected+0x5a/0x150
- #1:  (&eq->sysfs_lock){+.+.}, at: [<ffffffff812a5032>]
-elevator_exit+0x22/0x60
- #2:  (&(&q->__queue_lock)->rlock){-.-.}, at: [<ffffffff812b6233>]
-cfq_exit_queue+0x43/0x190
-
-stack backtrace:
-Pid: 1552, comm: scsi_scan_6 Not tainted 3.0.0-rc5 #17
-Call Trace:
- [<ffffffff810abb9b>] lockdep_rcu_dereference+0xbb/0xc0
- [<ffffffff812b6139>] __cfq_exit_single_io_context+0xe9/0x120
- [<ffffffff812b626c>] cfq_exit_queue+0x7c/0x190
- [<ffffffff812a5046>] elevator_exit+0x36/0x60
- [<ffffffff812a802a>] blk_cleanup_queue+0x4a/0x60
- [<ffffffff8145cc09>] scsi_free_queue+0x9/0x10
- [<ffffffff81460944>] __scsi_remove_device+0x84/0xd0
- [<ffffffff8145dca3>] scsi_probe_and_add_lun+0x353/0xb10
- [<ffffffff817da069>] ? error_exit+0x29/0xb0
- [<ffffffff817d98ed>] ? _raw_spin_unlock_irqrestore+0x3d/0x80
- [<ffffffff8145e722>] __scsi_scan_target+0x112/0x680
- [<ffffffff812c690d>] ? trace_hardirqs_off_thunk+0x3a/0x3c
- [<ffffffff817da069>] ? error_exit+0x29/0xb0
- [<ffffffff812bcc60>] ? kobject_del+0x40/0x40
- [<ffffffff8145ed16>] scsi_scan_channel+0x86/0xb0
- [<ffffffff8145f0b0>] scsi_scan_host_selected+0x140/0x150
- [<ffffffff8145f149>] do_scsi_scan_host+0x89/0x90
- [<ffffffff8145f170>] do_scan_async+0x20/0x160
- [<ffffffff8145f150>] ? do_scsi_scan_host+0x90/0x90
- [<ffffffff810975b6>] kthread+0xa6/0xb0
- [<ffffffff817db154>] kernel_thread_helper+0x4/0x10
- [<ffffffff81066430>] ? finish_task_switch+0x80/0x110
- [<ffffffff817d9c04>] ? retint_restore_args+0xe/0xe
- [<ffffffff81097510>] ? __kthread_init_worker+0x70/0x70
- [<ffffffff817db150>] ? gs_change+0xb/0xb
-
-Line 2776 of block/cfq-iosched.c in v3.0-rc5 is as follows:
+has long since been fixed::
+
+    =============================
+    WARNING: suspicious RCU usage
+    -----------------------------
+    block/cfq-iosched.c:2776 suspicious rcu_dereference_protected() usage!
+
+other info that might help us debug this::
+
+    rcu_scheduler_active = 1, debug_locks = 0
+    3 locks held by scsi_scan_6/1552:
+    #0:  (&shost->scan_mutex){+.+.}, at: [<ffffffff8145efca>]
+    scsi_scan_host_selected+0x5a/0x150
+    #1:  (&eq->sysfs_lock){+.+.}, at: [<ffffffff812a5032>]
+    elevator_exit+0x22/0x60
+    #2:  (&(&q->__queue_lock)->rlock){-.-.}, at: [<ffffffff812b6233>]
+    cfq_exit_queue+0x43/0x190
+
+    stack backtrace:
+    Pid: 1552, comm: scsi_scan_6 Not tainted 3.0.0-rc5 #17
+    Call Trace:
+    [<ffffffff810abb9b>] lockdep_rcu_dereference+0xbb/0xc0
+    [<ffffffff812b6139>] __cfq_exit_single_io_context+0xe9/0x120
+    [<ffffffff812b626c>] cfq_exit_queue+0x7c/0x190
+    [<ffffffff812a5046>] elevator_exit+0x36/0x60
+    [<ffffffff812a802a>] blk_cleanup_queue+0x4a/0x60
+    [<ffffffff8145cc09>] scsi_free_queue+0x9/0x10
+    [<ffffffff81460944>] __scsi_remove_device+0x84/0xd0
+    [<ffffffff8145dca3>] scsi_probe_and_add_lun+0x353/0xb10
+    [<ffffffff817da069>] ? error_exit+0x29/0xb0
+    [<ffffffff817d98ed>] ? _raw_spin_unlock_irqrestore+0x3d/0x80
+    [<ffffffff8145e722>] __scsi_scan_target+0x112/0x680
+    [<ffffffff812c690d>] ? trace_hardirqs_off_thunk+0x3a/0x3c
+    [<ffffffff817da069>] ? error_exit+0x29/0xb0
+    [<ffffffff812bcc60>] ? kobject_del+0x40/0x40
+    [<ffffffff8145ed16>] scsi_scan_channel+0x86/0xb0
+    [<ffffffff8145f0b0>] scsi_scan_host_selected+0x140/0x150
+    [<ffffffff8145f149>] do_scsi_scan_host+0x89/0x90
+    [<ffffffff8145f170>] do_scan_async+0x20/0x160
+    [<ffffffff8145f150>] ? do_scsi_scan_host+0x90/0x90
+    [<ffffffff810975b6>] kthread+0xa6/0xb0
+    [<ffffffff817db154>] kernel_thread_helper+0x4/0x10
+    [<ffffffff81066430>] ? finish_task_switch+0x80/0x110
+    [<ffffffff817d9c04>] ? retint_restore_args+0xe/0xe
+    [<ffffffff81097510>] ? __kthread_init_worker+0x70/0x70
+    [<ffffffff817db150>] ? gs_change+0xb/0xb
+
+Line 2776 of block/cfq-iosched.c in v3.0-rc5 is as follows::
 
 	if (rcu_dereference(ioc->ioc_data) == cic) {
 
@@ -70,7 +75,7 @@ case.  Instead, we hold three locks, one of which might be RCU related.
 And maybe that lock really does protect this reference.  If so, the fix
 is to inform RCU, perhaps by changing __cfq_exit_single_io_context() to
 take the struct request_queue "q" from cfq_exit_queue() as an argument,
-which would permit us to invoke rcu_dereference_protected as follows:
+which would permit us to invoke rcu_dereference_protected as follows::
 
 	if (rcu_dereference_protected(ioc->ioc_data,
 				      lockdep_is_held(&q->queue_lock)) == cic) {
@@ -85,7 +90,7 @@ On the other hand, perhaps we really do need an RCU read-side critical
 section.  In this case, the critical section must span the use of the
 return value from rcu_dereference(), or at least until there is some
 reference count incremented or some such.  One way to handle this is to
-add rcu_read_lock() and rcu_read_unlock() as follows:
+add rcu_read_lock() and rcu_read_unlock() as follows::
 
 	rcu_read_lock();
 	if (rcu_dereference(ioc->ioc_data) == cic) {
@@ -102,7 +107,7 @@ above lockdep-RCU splat.
 But in this particular case, we don't actually dereference the pointer
 returned from rcu_dereference().  Instead, that pointer is just compared
 to the cic pointer, which means that the rcu_dereference() can be replaced
-by rcu_access_pointer() as follows:
+by rcu_access_pointer() as follows::
 
 	if (rcu_access_pointer(ioc->ioc_data) == cic) {
 
-- 
2.9.5

