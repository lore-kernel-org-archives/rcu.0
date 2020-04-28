Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09FC83008
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9C6206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV/CkO5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD1U7h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgD1U7f (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E90C03C1AD;
        Tue, 28 Apr 2020 13:59:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so189725ljj.11;
        Tue, 28 Apr 2020 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f76tELWeD+Cq+rZ2nxZRf+Lr/87HEoPSQFMjularl7s=;
        b=gV/CkO5+yDyR2BtTpL6acO8ksCDaXgZ/Mdr2KfSt7vXdkvrp4vOh/EADiQ+zywJynU
         SW+xHfk1uQ7+y0BZmXWDIBpHOcaYmayvBGUtylXj+cpbhBc7CTIYYMNu+GmNXzuoNrcK
         LQQL+TKgLOAdzqkzJdIXnyxJl2ESUoKsAUj7M8ZORs+qdnsrzVtbAW4m+j9OmrKINiQL
         kMqQ9fkjfLUv92lX/AsSVbgu57rLtx+1xZzxIXBJqv0tzjziR3KKb4pVigwpCSfoe2Sh
         4ziWCwAOPAaSd2ZobdNxQWOKAXSX/P3uF0WYwAfizNleUDYBDPtSggXR9NgJBbf/lPNL
         8O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f76tELWeD+Cq+rZ2nxZRf+Lr/87HEoPSQFMjularl7s=;
        b=EPU3xjR8w9QEJZq2MmapaNW5YSooUYV45aW5krcuxC1g6AwAP9IaLO/7qVUvKa3Gga
         91DEX1ST1OaFKv9ytZoCexAh1Ucou4z4IRcWaQaSrFyATwKnSnIX2XyBRQMRS1eKoSZV
         /NVfRrXBdo3u+NsdsFCVJJEvaiYNzNLN/ki3gNhlENK2vMwv/v9rGl49CTDof9QAENRe
         xipLfP9SxJ1C85TLwQaQ2svZ2CKrrZo3x/9VB3oFtjB7lsedotPEY+j2SXThhMa9BPDr
         Jf6ijn53C75UhE+9oF7+mCRHu72J+f7KrVeFATvmCUljrQ9K7YBHTsPrMyuQe5z0X44O
         5oSg==
X-Gm-Message-State: AGi0PuYdM8UgCgt+38IInbfpEOBzZ6dULILcOc0OpKm4PuBM4VG41SOp
        i8oSokk7FqJ4R6K6rL8mFYEGZx56lQkIVQ==
X-Google-Smtp-Source: APiQypIyLU6bchTrGUBspJZC7W9x7kj6ckHQy61yTYUJR3oMfNtrovTxVulDU2ZLcnOnbM6O4XdWEQ==
X-Received: by 2002:a2e:909a:: with SMTP id l26mr18315311ljg.262.1588107572992;
        Tue, 28 Apr 2020 13:59:32 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:32 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 04/24] rcu/tree: Repeat the monitor if any free channel is busy
Date:   Tue, 28 Apr 2020 22:58:43 +0200
Message-Id: <20200428205903.61704-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It can be that one of the channels can not be detached
due to the fact that its free channel and previous data
has not been processed yet. From the other hand another
channel can be successfully detached causing the monitor
work to stop.

To prevent that, if there are any channels are still in
pending state after a detach attempt, just reschedule
the monitor work.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1487af8e11e8..0762ac06f0b7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2995,7 +2995,7 @@ static void kfree_rcu_work(struct work_struct *work)
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
 	struct kfree_rcu_cpu_work *krwp;
-	bool queued = false;
+	bool repeat = false;
 	int i;
 
 	lockdep_assert_held(&krcp->lock);
@@ -3033,11 +3033,14 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			 * been detached following each other, one by one.
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
-			queued = true;
 		}
+
+		/* Repeat if any "free" corresponding channel is still busy. */
+		if (krcp->bhead || krcp->head)
+			repeat = true;
 	}
 
-	return queued;
+	return !repeat;
 }
 
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-- 
2.20.1

