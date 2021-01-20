Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD4C4332B
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E94233E2
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 16:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbhATQXk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404006AbhATQWn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 11:22:43 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB0C0613C1;
        Wed, 20 Jan 2021 08:22:03 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f17so26727553ljg.12;
        Wed, 20 Jan 2021 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5vWudR2N+b1xOBCfk15/krN2AJ4ZrQd3lA45yCJz88=;
        b=kui1rl3utwd4GX02zoBXw2RmW4+uR9AsetKj7qZaNeOmydU/b+6DVk+D/YSDInfBmG
         Bmz9MyypEcOHU5Q1jx8GsUzI3sddCUE4pgfWPzSJSxRLka4EyuPy8pIVwv7ixl/rV5ca
         61ou3CggFqmTnGvBFYxE3bXZs5JtRLuJGStt9aGsAuKogEBkyd10cuZscA7ZZc4yJocN
         kO0gSyfhzwOwb1A1eGESwqLcn9UO/fB6sEVfHYRpm15RwRnI0jyv04nPd4f5VOcI0Uot
         HMtwtwiuGex6Y9GJSwEA5Pqcn3bSpmZ6f4AabCtGY4oGMKSYaH7brofVEIHss5XyLpst
         oIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5vWudR2N+b1xOBCfk15/krN2AJ4ZrQd3lA45yCJz88=;
        b=AvlFfKfs1yu+tesmr45tUk+HcH4fP0uq/N2QfrTRckpuZ/F01X8Aek0IuLw3GEAJNb
         vOGFGZ4N88aITS7dJWryZsKrOR629ueBcLgKldm3aa63XO1K9uU9f7Mlq+olamZNLrj2
         ouMoxyp7/IbTXGgC5fI2L4HL5jirs1WV77l8howWmZAR3xsFMT8c53J5RqlNR4aUCJWu
         sqjLIDhbK2i/QCJlDF4dQbM7yhKKWaJzu7FiBoB9y/SNIIQkZYMANafvY00yygkDSqY9
         2D6kbx5cxsgmIxPSx+OSBO4gMackx1ABLkPq/05MLj2FR/oDX0W+QthNZjwZwwsXVCYV
         Rzuw==
X-Gm-Message-State: AOAM531ocCjBgqMBVfW0F3jF4T2t0OoAZmCEqr9dLIMq+SoUJEH5UE4C
        M+QTohM3KmcL/toASV5z6qnelsOAu0dnqQ==
X-Google-Smtp-Source: ABdhPJzUZLFRHEsnoP2uJ10tpxxYdlvHeLc7OLoR4yvQkeeR+O0I+aFd93KbecY3IoL+BVOkplwXaQ==
X-Received: by 2002:a2e:a593:: with SMTP id m19mr4905528ljp.1.1611159721775;
        Wed, 20 Jan 2021 08:22:01 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id l8sm237631lfd.276.2021.01.20.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:22:01 -0800 (PST)
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
Subject: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
Date:   Wed, 20 Jan 2021 17:21:48 +0100
Message-Id: <20210120162148.1973-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120162148.1973-1-urezki@gmail.com>
References: <20210120162148.1973-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since the page is obtained in a fully preemptible context, dropping
the lock can lead to migration onto another CPU. As a result a prev.
bnode of that CPU may be underutilised, because a decision has been
made for a CPU that was run out of free slots to store a pointer.

migrate_disable/enable() are now independent of RT, use it in order
to prevent any migration during a page request for a specific CPU it
is requested for.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 454809514c91..cad36074366d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3489,10 +3489,12 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(*krcp);
 		if (!bnode && can_alloc) {
+			migrate_disable();
 			krc_this_cpu_unlock(*krcp, *flags);
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
+			migrate_enable();
 		}
 
 		if (!bnode)
-- 
2.20.1

