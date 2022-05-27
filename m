Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667ACC433EF
	for <rcu@archiver.kernel.org>; Fri, 27 May 2022 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352544AbiE0PHw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 May 2022 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352095AbiE0PHv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 May 2022 11:07:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D543D13CD4
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=OHVPhUSj+8Sy9n8xF/GHpPM9wlJLJWPSeBMUVUf5Iwc=; t=1653664070; x=1654873670; 
        b=iyKxM3usRETw0rSWeSUYWCKYLMZoYGkNmadto+UAPnYDKJjFLPuMeUc7tqfSNzkR1xMBRNtYq/h
        I3BrAxf8HydgEBrC6GzpPVTBL42mGe43i5jJxlMRfVpyqdlS25QfzRWLkt/Wy/Gh0/fhauZjDmVZ7
        6l5S9NBQvkI8TBRnrxjN416SRqNjKFTYA0/Ynqj+2KyOsaZYV+gOD0kvQXeQlvX5VkvdmEYKKkb+9
        6fjAz/mbCWX4PHevM57TYXC155/XaczC1F8unLNisVJ0RbyWRpraDJqAsDiJjPE9ejF4kACwV4u61
        oAbOAOTxjW9ndq0HYbu67EjJMWPplAS0a81g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nubZ5-0065E4-Ce;
        Fri, 27 May 2022 17:07:47 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     rcu@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] rcu: tiny: record kvfree_call_rcu() call stack for KASAN
Date:   Fri, 27 May 2022 17:07:45 +0200
Message-Id: <20220527170743.04c21d235467.I1f79da0f90fb9b557ec34932136c656bc64b8fbf@changeid>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When running KASAN with Tiny RCU (e.g. under ARCH=um, where
a working KASAN patch is now available), we don't get any
information on the original kfree_rcu() (or similar) caller
when a problem is reported, as Tiny RCU doesn't record this.

Add the recording, which required pulling kvfree_call_rcu()
out of line for the KASAN case since the recording function
(kasan_record_aux_stack_noalloc) is neither exported, nor
can we include kasan.h into rcutiny.h.

without KASAN, the patch has no size impact (ARCH=um kernel):
    text       data         bss         dec        hex    filename
 6151515    4423154    33148520    43723189    29b29b5    linux
 6151515    4423154    33148520    43723189    29b29b5    linux + patch

with KASAN, the impact on my build was minimal:
    text       data         bss         dec        hex    filename
13915539    7388050    33282304    54585893    340ea25    linux
13911266    7392114    33282304    54585684    340e954    linux + patch
   -4273      +4064         +-0        -209

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/rcutiny.h | 11 ++++++++++-
 kernel/rcu/tiny.c       | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5fed476f977f..d84e13f2c384 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
  */
 extern void kvfree(const void *addr);
 
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	if (head) {
 		call_rcu(head, func);
@@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	kvfree((void *) func);
 }
 
+#ifdef CONFIG_KASAN_GENERIC
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+#else
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	__kvfree_call_rcu(head, func);
+}
+#endif
+
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 340b3f8b090d..58ff3721d975 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 
+#ifdef CONFIG_KASAN_GENERIC
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	if (head) {
+		void *ptr = (void *) head - (unsigned long) func;
+
+		kasan_record_aux_stack_noalloc(ptr);
+	}
+
+	__kvfree_call_rcu(head, func);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+#endif
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
-- 
2.36.1

