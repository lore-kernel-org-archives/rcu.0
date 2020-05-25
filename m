Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83359C433E1
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657D920776
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3m9JiCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgEYVtI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbgEYVsP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88664C061A0E;
        Mon, 25 May 2020 14:48:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m12so19757198ljc.6;
        Mon, 25 May 2020 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AXOThceM9HQTaD/1C2DnJHW4BibV/GSMKqCaOTg8gw=;
        b=P3m9JiCzUkqtxpY3mGwyXff/VaAi3lP8/Tw+HlJuwPCpcTr92OEkjgnqiZ51xr+MHa
         z49tq0aEIaaYGJKwcR6O6FW9FIExXQV1fFTdIfYDAjMWi+wCwWncxFYb/JFPYlqTXRBy
         VCUuHP7h++feYt4Np0dchSCZwta7xjAVajnIwZR8hWoZ/a7tG+J8V6FMvgGM7Rez+tsl
         wfN00uPkBMigNVhsfJGkkX+qjkKyweTM+CS6DU1+ugrgKsVomI/1uCAPxvj8+xcLvX8e
         lfWO+lPdcbH1PdVu9/kxMln3KnnoOJJqj1I0kKe/FE6oBlUYB4pysxmaQ+FYMmGNX0WT
         dmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AXOThceM9HQTaD/1C2DnJHW4BibV/GSMKqCaOTg8gw=;
        b=Hm0BA7XIlzBDC74czRdDU5cRD0P4b2obQtazJ+tdE+65nfZNdFqv8/0U6TdfmA0UwY
         WlqNYS9bm1oMHpXnNGsaddZuFfFBuhSPHxi1e+B8MyLKdy9sU/mbUR1Vob4yrAU/TzxV
         dFWC5qeOxswuOtdaNTVGxfSJERd5I7gyiZLV6mi1JgEwJZfpNcd/0ELsdtkWWA8mXs+d
         dceAA6uMCITMNDTB9V3AJCpweMNOxb8E6XfSdA9uUCEx9XDtA1Bd/JA4ukKL9Czj8hK0
         +WOpj6avS2TrkpIcI7gWogfMVGyUlW9E9PmEdXCy2wr0jFjLB6ri3UbkHCuzqd0vEhze
         qoGg==
X-Gm-Message-State: AOAM5312HhS9vgZH/tt6lXanyBFrp5W1TjEmCAE8Jsqz5OB4kcJDmI2g
        nbBSXjgvdwfQzF31595xxhz/+i2s0NsAVw==
X-Google-Smtp-Source: ABdhPJwoXkLN/yki/p/Nl7rk5K8p4UfzLX1z4H8VqCpUnDmQzGXhiEVBIV01t81o4vGj/zpvUKz2og==
X-Received: by 2002:a2e:9910:: with SMTP id v16mr14937280lji.213.1590443293740;
        Mon, 25 May 2020 14:48:13 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:13 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 03/16] rcu/tree: Repeat the monitor if any free channel is busy
Date:   Mon, 25 May 2020 23:47:47 +0200
Message-Id: <20200525214800.93072-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is possible that one of the channels cannot be detached
because its free channel is busy and previously queued data
has not been processed yet. On the other hand, another
channel can be successfully detached causing the monitor
work to stop.

Prevent that by rescheduling the monitor work if there are
any channels in the pending state after a detach attempt.

Fixes: 34c881745549e ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d28010cf158b..ae21e1bddd3e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2971,7 +2971,7 @@ static void kfree_rcu_work(struct work_struct *work)
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
 	struct kfree_rcu_cpu_work *krwp;
-	bool queued = false;
+	bool repeat = false;
 	int i;
 
 	lockdep_assert_held(&krcp->lock);
@@ -3009,11 +3009,14 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
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

