Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368B7EE4996
	for <rcu@archiver.kernel.org>; Mon, 21 Aug 2023 13:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHUNon (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Aug 2023 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjHUNom (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Aug 2023 09:44:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC52BC;
        Mon, 21 Aug 2023 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=woAYeuzI4KVxSPDcp2ZulPbG4CyD8JH8smET3OYMxQU=; b=KJcBYZjgPk2qgQOVq/TtQrG6pa
        0/OIgI1U9C5b+NOZtLFQWxaD3BQYsuhfMAZfL7Zcpun0EXxnhravPYID1yO2zXkeOoGSrpw7KO4mk
        Q5djvZ4oDZWktXCkzoc8lULn9eZ6Y2moKlIz24b/4IjyNToIVYIACdB/CTECsuydTk84XM0cd5UyI
        3tsh743Cy+Z2rUj1X4RmYVvDyQDJwK72u5GB1K5eNBIjaZ+NM/rWT3fC/9cGGOZ4XyA670VcjctBZ
        2F3jp31+UAhNg+oKDP0N5hpqOfPUVCjd7mpIbX170WTbm/Xwz5BEnlsF0qAo3EazoXGymhqBmmmH4
        NnC9RuBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY5Cs-00AVf8-Sn; Mon, 21 Aug 2023 13:44:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Tong Tiangen <tongtiangen@huawei.com>, rcu@vger.kernel.org
Subject: [PATCH] sched: Assert for_each_thread() is properly locked
Date:   Mon, 21 Aug 2023 14:44:28 +0100
Message-Id: <20230821134428.2504912-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

list_for_each_entry_rcu() takes an optional fourth argument which
allows RCU to assert that the correct lock is held.  Several callers
of for_each_thread() rely on their caller to be holding the appropriate
lock, so this is a useful assertion to include.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 669e8cff40c7..f1eae7f53be9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -659,7 +659,8 @@ extern bool current_is_single_threaded(void);
 	while ((t = next_thread(t)) != g)
 
 #define __for_each_thread(signal, t)	\
-	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node)
+	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node, \
+		lockdep_is_held(&tasklist_lock))
 
 #define for_each_thread(p, t)		\
 	__for_each_thread((p)->signal, t)
-- 
2.40.1

