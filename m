Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA6C433E0
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C03423122
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 16:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbhATQ0c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732183AbhATQWR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 11:22:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E048C061757;
        Wed, 20 Jan 2021 08:22:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v67so34887312lfa.0;
        Wed, 20 Jan 2021 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQPDCZoatrcIZYaKHvxiD9OMe09wtCmeCa1ffFLE0pQ=;
        b=oK1o0mvTLkqZuqgxDhACnwVUq1iCCF1/JPxOd4WM1XLisbxT1mC86LD+GO5XNlBMZO
         D1pxfsPVh2TzBhQEHB6WP91rbiCv6eOQVn9NhQNTFxY3PqAfrtpl8nuEfNfVK50dUtSx
         zSoF5az39Kii13ofyGrx7JoT+3tXb9+i1E51HYMDZug1vzP9Vx4RMfcYieU3vooZB9Oj
         4u0xomTqFIlUK4tUQu2tuaBnYQiWBl0ifdwcsb5X1sVVJo5Xvb9lZnCHCeWax52aW4ua
         WkZuh6JjkPssKwmPwujRb+cZ7LvpkTG9GDQoAvNH7YQl43z+9cj6J3Wuqz4CcomlV5Z3
         Uamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQPDCZoatrcIZYaKHvxiD9OMe09wtCmeCa1ffFLE0pQ=;
        b=BBizLsZDuZEsyCOnF1WAN3Ez5M/kSz4lxLZ0a6hziJg55BcTm8Gqvrhy8p8lW36ftQ
         doyVNRZV6c5K5cW5xCtpIn7VzWwxluO1F74MIRflN0MeWRlwAeRi9LAx9++ATsSLUJfv
         ZUmF2AzkWoTEb17Vzt7vlR7t8hT+EKaXUl8dzH4e4cOx0q4zQZ11d76yWWkWfOpgmkgC
         rjG7xurD/Bzyzgrm9/gKRGb+rC4SeOyLCTzeEiJfbu35Z+HTFGbr4nzGtvE0mYbSTpDU
         pptAyi/v1xJosAGMMUav6CEJRKKbjyDZWHwCFbVLIXXmCy3nSvO/7yLHzkz9lJ5BUw/w
         zkHw==
X-Gm-Message-State: AOAM532X8xMeJEPJvwRsbXylQLCZ4oRYlmfV/f68I5LNtdB5/oNDndew
        1fVrN9lnWvkCeUE8eGrp18Viu5kdSChEoA==
X-Google-Smtp-Source: ABdhPJxqOiiMIEzodSilxrtWZfzvUpDQmOJ69M+cNSNDws+NaDv2elPjTSOVAm9UgZ/YZ4JtfmuVDw==
X-Received: by 2002:a19:3f01:: with SMTP id m1mr4371961lfa.203.1611159720673;
        Wed, 20 Jan 2021 08:22:00 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id l8sm237631lfd.276.2021.01.20.08.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:22:00 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/3] kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
Date:   Wed, 20 Jan 2021 17:21:47 +0100
Message-Id: <20210120162148.1973-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120162148.1973-1-urezki@gmail.com>
References: <20210120162148.1973-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
carried out by the single-argument variant of kvfree_rcu(), thus avoiding
this can-sleep code path from dipping into the emergency reserves.

Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2014fb22644d..454809514c91 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3491,7 +3491,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
-- 
2.20.1

