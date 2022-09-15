Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A765ECAAD3
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 08:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIOIbc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Sep 2022 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOIbb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Sep 2022 04:31:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6689CFD;
        Thu, 15 Sep 2022 01:31:29 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSr0C0z5nzNmJX;
        Thu, 15 Sep 2022 16:26:51 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 16:31:27 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <pbonzini@redhat.com>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <kvm@vger.kernel.org>, <rcu@vger.kernel.org>, <liwei391@huawei.com>
Subject: [PATCH -next] rcu: remove unused 'cpu' in rcu_virt_note_context_switch
Date:   Thu, 15 Sep 2022 16:38:24 +0800
Message-ID: <20220915083824.766645-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Remove unused function argument, and there is
no logic changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 include/linux/kvm_host.h | 2 +-
 include/linux/rcutiny.h  | 2 +-
 include/linux/rcutree.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f4519d3689e1..9cf0c503daf5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -417,7 +417,7 @@ static __always_inline void guest_context_enter_irqoff(void)
 	 */
 	if (!context_tracking_guest_enter()) {
 		instrumentation_begin();
-		rcu_virt_note_context_switch(smp_processor_id());
+		rcu_virt_note_context_switch();
 		instrumentation_end();
 	}
 }
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 768196a5f39d..9bc025aa79a3 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -142,7 +142,7 @@ static inline int rcu_needs_cpu(void)
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
  */
-static inline void rcu_virt_note_context_switch(int cpu) { }
+static inline void rcu_virt_note_context_switch(void) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_irq_exit_check_preempt(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 5efb51486e8a..70795386b9ff 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -27,7 +27,7 @@ void rcu_cpu_stall_reset(void);
  * wrapper around rcu_note_context_switch(), which allows TINY_RCU
  * to save a few bytes. The caller must have disabled interrupts.
  */
-static inline void rcu_virt_note_context_switch(int cpu)
+static inline void rcu_virt_note_context_switch(void)
 {
 	rcu_note_context_switch(false);
 }
-- 
2.25.1

