Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB243C761AF
	for <rcu@archiver.kernel.org>; Thu, 30 Mar 2023 07:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjC3Hch convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Thu, 30 Mar 2023 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjC3HcS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Mar 2023 03:32:18 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B365B7
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 00:32:13 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 32U7Vusp049397;
        Thu, 30 Mar 2023 15:31:56 +0800 (+08)
        (envelope-from Ziwei.Dai@unisoc.com)
Received: from ziwei-lenovo.spreadtrum.com (10.0.74.54) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 30 Mar 2023 15:31:52 +0800
From:   Ziwei Dai <ziwei.dai@unisoc.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <shuang.wang@unisoc.com>, <yifan.xin@unisoc.com>,
        <ke.wang@unisoc.com>, <xuewen.yan@unisoc.com>,
        <zhiguo.niu@unisoc.com>
Subject: [PATCH] rcu: Make sure new krcp free business is handled after the wanted rcu grace period.
Date:   Thu, 30 Mar 2023 15:31:37 +0800
Message-ID: <1680161497-19817-1-git-send-email-ziwei.dai@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.74.54]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 32U7Vusp049397
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: 代子为 (Ziwei Dai) <ziwei.dai@ziwei-lenovo.spreadtrum.com>

In kfree_rcu_monitor(), new free business at krcp is attached to any free
channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
business is handled after the rcu grace period. But if there is any none-free
channel at krwp already, that means there is an on-going rcu work,
which will cause the kvfree_call_rcu()-triggered free business is done
before the wanted rcu grace period ends.

This commit ignore krwp which has non-free channel at kfree_rcu_monitor(),
to fix the issue that kvfree_call_rcu() loses effectiveness.

Below is the css_set obj "from_cset" use-after-free issue caused by
kvfree_call_rcu() losing effectiveness.
Core 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes.
Core 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
Core 2 frees "from_cset" after current gp end. "from_cset" is reallocated.
Core 0 references "from_cset"'s member, which causes crash.

Core 0                                  Core 1                                  Core 2
count_memcg_event_mm()
|rcu_read_lock()  <---
|mem_cgroup_from_task()
 |// <css_set ptr> is the "from_cset" mentioned on core 1
 |<css_set ptr> = rcu_dereference((task)->cgroups)
 |// Hard irq comes, current task is scheduled out.

                        Core 1:
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
                          |kfree_rcu(cset, rcu_head) <--- means to free from_cset after new gp
                           |add_ptr_to_bulk_krc_lock()
                           |schedule_delayed_work(&krcp->monitor_work, ..)

                        kfree_rcu_monitor()
                        |krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
                        |queue_rcu_work(system_wq, &krwp->rcu_work)
                         |if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
                         |call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request a new gp

                                                                // There is a perious call_rcu(.., rcu_work_rcufn)
                                                                // gp end, rcu_work_rcufn() is called.
                                                                rcu_work_rcufn()
                                                                |__queue_work(.., rwork->wq, &rwork->work);
                                                                Core 3：
                                                                // or there is a pending kfree_rcu_work() work called.
                                                                |kfree_rcu_work()
                                                                |krwp->bulk_head_free[0] bulk is freed before new gp end!!!
                                                                |The "from_cset" mentioned on core 1 is freed before new gp end.
Core 0:
// the task is schedule in after many ms.
 |<css_set_ptr>->subsys[(subsys_id) <--- caused kernel crash, because <css_set_ptr>="from_cset" is freed.

Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
---
 kernel/rcu/tree.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e880c0..4fe3c53 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3107,15 +3107,16 @@ static void kfree_rcu_monitor(struct work_struct *work)
        for (i = 0; i < KFREE_N_BATCHES; i++) {
                struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);

-               // Try to detach bulk_head or head and attach it over any
-               // available corresponding free channel. It can be that
-               // a previous RCU batch is in progress, it means that
-               // immediately to queue another one is not possible so
-               // in that case the monitor work is rearmed.
-               if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
-                       (!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
-                               (READ_ONCE(krcp->head) && !krwp->head_free)) {
-
+               // Try to detach bulk_head or head and attach it, only when
+               // all channels are free.  Any channel is not free means at krwp
+               // there is on-going rcu work to handle krwp's free business.
+               if (!list_empty(&krwp->bulk_head_free[0]) ||
+                       !list_empty(&krwp->bulk_head_free[1]) ||
+                               !krwp->head_free)
+                       continue;
+               if (!list_empty(&krcp->bulk_head[0]) ||
+                       !list_empty(&krcp->bulk_head[1]) ||
+                       READ_ONCE(krcp->head)) {
                        // Channel 1 corresponds to the SLAB-pointer bulk path.
                        // Channel 2 corresponds to vmalloc-pointer bulk path.
                        for (j = 0; j < FREE_N_CHANNELS; j++) {
--
1.9.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
