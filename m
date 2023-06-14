Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECBEB64D7
	for <rcu@archiver.kernel.org>; Wed, 14 Jun 2023 01:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbjFNBgD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjFNBf5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jun 2023 21:35:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC6B8
        for <rcu@vger.kernel.org>; Tue, 13 Jun 2023 18:35:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc68c4e046aso278611276.0
        for <rcu@vger.kernel.org>; Tue, 13 Jun 2023 18:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686706552; x=1689298552;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNbjIv9UztkQJDHGD9DnfdQkL6UlrA7FC1c39cDNZuE=;
        b=eyugeBWL0qB4Gpp57gMQT7qdf7kD8/4I+srAOg6u2/bQZmhW3nSYJ6fM/IB8sQV/Tn
         tDiP0pelZvhXsvror//iBofxTZVgjJKM0pylsocMM2uLyW52MPBchyTwXKQjt55nrcVq
         bOjM+emVBITSFCkqu0b6rRNX+n2vToUEB4O6UciVKV1jo8YtW5746P1VgiYwdyR5I6+B
         v2/7Pk+zzIN/gnuaQjKBRooskKzfh0uHAAuQyA/KnYyTRu/dERBT0fTtyMMWKwP7puf9
         FJGslewR6DRZ3Z4Wt0GJQmSoypMK6cfMOLP09koWzaROAKKV558jsflYIIoMtHdLMaT7
         FBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686706552; x=1689298552;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNbjIv9UztkQJDHGD9DnfdQkL6UlrA7FC1c39cDNZuE=;
        b=UPaEla1nkeFmFkhJPlYebtbuqnJYsr6ZvXEoVjVB0SgpXtVv/M/5AWNX75KUFFmJCi
         umjTtVsMq2mWw2ZTxP8mW+93V6eFu0lhXgJFtWsGhH/92tR2q/IX2+z9DRaQbyj+rOUG
         ctyBuIq6B6hOtdlr1ncQIMeIAni2prjTMAJ1zYRNLyrKlV+s1VU9QDYboB9jgWNoEUYH
         3obB51KeXuYPGJzvk3XycsmRksLZKbJTwO7fK7oXx77uLZGBu6vZHgfxizWBkAiDGZ8m
         1/CnY1U8BsEdLJ1xWyljrM9aaau79WkoOl6jjiOHe2GeTI4FS/yZQnIFBEfjvDMrrxpN
         hJNA==
X-Gm-Message-State: AC+VfDy9FIqb6uX0Q4xBS/Adb9saaPrvbanN4WKPh+r0q4gnDmeyZsj8
        xLWsw2Id4EZGanrleTr1Va9JFY6eCQc=
X-Google-Smtp-Source: ACHHUZ6vuGG4+I5GBkw+0LADnXcFi5QG+Mc52Hk94fnlv+PrB2C8lQR2SjPva3OA+QGOpiAmiCXtrjb/Fsk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:bbff:ed76:4140:fb87])
 (user=surenb job=sendgmr) by 2002:a25:db54:0:b0:bcc:285c:66ea with SMTP id
 g81-20020a25db54000000b00bcc285c66eamr260349ybf.3.1686706552295; Tue, 13 Jun
 2023 18:35:52 -0700 (PDT)
Date:   Tue, 13 Jun 2023 18:35:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614013548.1382385-1-surenb@google.com>
Subject: [RESEND 1/1] linux-5.10/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
From:   Suren Baghdasaryan <surenb@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

commit 5da7cb193db32da783a3f3e77d8b639989321d48 upstream.

Memory passed to kvfree_rcu() that is to be freed is tracked by a
per-CPU kfree_rcu_cpu structure, which in turn contains pointers
to kvfree_rcu_bulk_data structures that contain pointers to memory
that has not yet been handed to RCU, along with an kfree_rcu_cpu_work
structure that tracks the memory that has already been handed to RCU.
These structures track three categories of memory: (1) Memory for
kfree(), (2) Memory for kvfree(), and (3) Memory for both that arrived
during an OOM episode.  The first two categories are tracked in a
cache-friendly manner involving a dynamically allocated page of pointers
(the aforementioned kvfree_rcu_bulk_data structures), while the third
uses a simple (but decidedly cache-unfriendly) linked list through the
rcu_head structures in each block of memory.

On a given CPU, these three categories are handled as a unit, with that
CPU's kfree_rcu_cpu_work structure having one pointer for each of the
three categories.  Clearly, new memory for a given category cannot be
placed in the corresponding kfree_rcu_cpu_work structure until any old
memory has had its grace period elapse and thus has been removed.  And
the kfree_rcu_monitor() function does in fact check for this.

Except that the kfree_rcu_monitor() function checks these pointers one
at a time.  This means that if the previous kfree_rcu() memory passed
to RCU had only category 1 and the current one has only category 2, the
kfree_rcu_monitor() function will send that current category-2 memory
along immediately.  This can result in memory being freed too soon,
that is, out from under unsuspecting RCU readers.

To see this, consider the following sequence of events, in which:

o	Task A on CPU 0 calls rcu_read_lock(), then uses "from_cset",
	then is preempted.

o	CPU 1 calls kfree_rcu(cset, rcu_head) in order to free "from_cset"
	after a later grace period.  Except that "from_cset" is freed
	right after the previous grace period ended, so that "from_cset"
	is immediately freed.  Task A resumes and references "from_cset"'s
	member, after which nothing good happens.

In full detail:

CPU 0					CPU 1
----------------------			----------------------
count_memcg_event_mm()
|rcu_read_lock()  <---
|mem_cgroup_from_task()
 |// css_set_ptr is the "from_cset" mentioned on CPU 1
 |css_set_ptr = rcu_dereference((task)->cgroups)
 |// Hard irq comes, current task is scheduled out.

					cgroup_attach_task()
					|cgroup_migrate()
					|cgroup_migrate_execute()
					|css_set_move_task(task, from_cset, to_cset, true)
					|cgroup_move_task(task, to_cset)
					|rcu_assign_pointer(.., to_cset)
					|...
					|cgroup_migrate_finish()
					|put_css_set_locked(from_cset)
					|from_cset->refcount return 0
					|kfree_rcu(cset, rcu_head) // free from_cset after new gp
					|add_ptr_to_bulk_krc_lock()
					|schedule_delayed_work(&krcp->monitor_work, ..)

					kfree_rcu_monitor()
					|krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
					|queue_rcu_work(system_wq, &krwp->rcu_work)
					|if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
					|call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request new gp

					// There is a perious call_rcu(.., rcu_work_rcufn)
					// gp end, rcu_work_rcufn() is called.
					rcu_work_rcufn()
					|__queue_work(.., rwork->wq, &rwork->work);

					|kfree_rcu_work()
					|krwp->bulk_head_free[0] bulk is freed before new gp end!!!
					|The "from_cset" is freed before new gp end.

// the task resumes some time later.
 |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.

This commit therefore causes kfree_rcu_monitor() to refrain from moving
kfree_rcu() memory to the kfree_rcu_cpu_work structure until the RCU
grace period has completed for all three categories.

v2: Use helper function instead of inserted code block at kfree_rcu_monitor().

[UR: backport to 5.10-stable]
[UR: Added missing need_offload_krc() function]
Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Resending per Greg's request.
Original posting: https://lore.kernel.org/all/20230418102518.5911-1-urezki@gmail.com/

 kernel/rcu/tree.c | 49 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 30e1d7fedb5f..eec8e2f7537e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3281,6 +3281,30 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 }
 
+static bool
+need_offload_krc(struct kfree_rcu_cpu *krcp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krcp->bkvhead[i])
+			return true;
+
+	return !!krcp->head;
+}
+
+static bool
+need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krwp->bkvhead_free[i])
+			return true;
+
+	return !!krwp->head_free;
+}
+
 /*
  * Schedule the kfree batch RCU work to run in workqueue context after a GP.
  *
@@ -3298,16 +3322,13 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		krwp = &(krcp->krw_arr[i]);
 
-		/*
-		 * Try to detach bkvhead or head and attach it over any
-		 * available corresponding free channel. It can be that
-		 * a previous RCU batch is in progress, it means that
-		 * immediately to queue another one is not possible so
-		 * return false to tell caller to retry.
-		 */
-		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
-			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
-				(krcp->head && !krwp->head_free)) {
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (need_wait_for_krwp_work(krwp))
+			continue;
+
+		if (need_offload_krc(krcp)) {
 			// Channel 1 corresponds to SLAB ptrs.
 			// Channel 2 corresponds to vmalloc ptrs.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
@@ -3334,12 +3355,12 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
-
-		// Repeat if any "free" corresponding channel is still busy.
-		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
-			repeat = true;
 	}
 
+	// Repeat if any "free" corresponding channel is still busy.
+	if (need_offload_krc(krcp))
+		repeat = true;
+
 	return !repeat;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

