Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A6C55179
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3692420FC3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STSTn1Qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgJ2Quo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgJ2Qun (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E3C0613D7;
        Thu, 29 Oct 2020 09:50:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id p15so3836005ljj.8;
        Thu, 29 Oct 2020 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1IQUYcSmq/5hfOvulXy2uBLT11xfum3KTVeoGsLjmE=;
        b=STSTn1QvE85EhMLGj1aGyuYnX3EzNRjghoqtDH9YoiaJ39Sf5AsuFOeqATV+3rE+b8
         XpHth49pG01+pNOim/GaQLg/g3/QLrrTdyKX9+UtE5lqExWesv6k+BCnOTpPnl0wCkZ4
         RJ6iDjcQSSK5Iu9EfdsY1TcW8iwwrF741qqojogBxcS3zdVi4rJj2IFVT7IGIZFsKNAf
         O1tFWFvqOuLt0fcRnPIwVzvGrNB2ax2idM7J4y+7gnCRDJh/Z2IG5g+hG5QtEkFiy/Tf
         rNXeNuOKFbV7/c0iFd4GL/kXy+qAue+YzZ6829/EzVauIk1QM41SmLHInMaIN0nye6au
         xvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1IQUYcSmq/5hfOvulXy2uBLT11xfum3KTVeoGsLjmE=;
        b=ZaJGDCVwUPHMVlkG2v3SabWjIeWz3ENQ+FrbSWZ3mzA/M6aTlqtOnezSbGGqmZqQIS
         zTvYHoy/OpUP2r6e+HYCZF05W1QTQ8GM+V73K2x7TaLn4tOWxV1NYXMjj7sVMjTkFSuX
         LOwFc7UMjXk8m/pvOFnyBQhD96Lm+DDPcv2nnh9q+79liEtjgguHRJ17gEcRkm6TwGb4
         PsnZu3Ktz1eCLyrwYCZ/9wUArM1xGFTWOUKGZ/qO7kvOv88F7VImJtJDYcuWgGHYFGET
         FpPPJ42gocX69gsevpc0w9Zs0f5KZeL6VW15XHhRHS4Chzub3lXNQguYpjW2FUdoAlj/
         d81g==
X-Gm-Message-State: AOAM5311BzyKbz8UspWVPVSAfcjkpKFYHVpFcqTvlUP116h8U0Ra40yL
        Jf7xI0fiOwlZvaET/k9BBf1/Fyrq+bRONQ==
X-Google-Smtp-Source: ABdhPJxvlKKVfgwJjdbafEKnTyiGrYyRLleVdS7dD7F9drITXJcQjcx3J5iPRWstU2d3Rg5XIFH3ZQ==
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2078541ljh.377.1603990240391;
        Thu, 29 Oct 2020 09:50:40 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:39 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org
Subject: [PATCH 06/16] mm/pagemap: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:09 +0100
Message-Id: <20201029165019.14218-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/pagemap.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c77b7c31b2e4..cbfbe2bcca75 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,9 +204,7 @@ void release_pages(struct page **pages, int nr);
 static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
+	VM_BUG_ON(preemptible())
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
 	 * this for us.
-- 
2.20.1

