Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E704CC43463
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BFF21D42
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS8wqurD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIRTsp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgIRTsm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 15:48:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D5C0613CE;
        Fri, 18 Sep 2020 12:48:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so6005182ljd.10;
        Fri, 18 Sep 2020 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pihU19ZyV1tR9rxjJBUfTFPiShIHT6wFJWQRUBqDuSU=;
        b=bS8wqurDjQBWPYzxoQcs/RTFMBIpDOsIN5r0Vh5wX+3vYkIyVlIjt5XSIMtOJstZVK
         wb5EiRTsmWoA0Cp8WZy/jSjGkQR2T6ZuFRH3hci0DFMhtnD06XU2yZICKtAEn5vg/hpd
         KV0eJycW4/86TauW7eoyQ/E0dz+UDN5qU4WOpJWlS2yLKFi/bDBT41Pc1qzrlDzkKvDB
         OeZDVLMLFzjzLZ6QzDVdRIkQ+hIk1N2s3SUEwFL47OvxQ4+WZ1kmaqriNQlipgbfuCZo
         kCOVW9IhZ6C/HiDlwve9rHe/GOCZdKrMrh9qjgyKuVs3P/uxNZIC9xHjIzYdnZfq/yyK
         JuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pihU19ZyV1tR9rxjJBUfTFPiShIHT6wFJWQRUBqDuSU=;
        b=fA43XjVQK/czkpTOHp0UqDsObxAunSnLPH1o7zaeZQt4F0Oc1n1VCNRNij3cOsb1BJ
         hyQqWSJwx4tFkuXQHOgOZZuBd4stljBzbDv5VcjWliULQlBhrdjCJ/o+6/KLYl/PunOP
         EGzaEVD5jQ0jzDqaOYYqual9IVLKi5IzcJBB44zK8qwGyPSNng80xcv6magXuscw8B81
         e/lOy0MgGUiL/yqNZQofLvogjmQ2vR8TZvWZTSUYSx7z1hfnX2h14hKTiuBTTtE7ZHlp
         iJBYSYFqykSgzJ4AEKrdAcDlqSIdSnx/PvGpZxLsu3UMJ6fUVb98i6P7XKsR9yixVoSF
         GPBw==
X-Gm-Message-State: AOAM530+xcMHVxtE17MTGjshFponjlZf6hYHH4O2cY3Ihj/d8DQaZQnu
        eNqdASt8o48te0zY3GFuaA8Tjq00jSELUHlz
X-Google-Smtp-Source: ABdhPJwbBuxfhOpviYZGwvbN5A+9fD5A8wr8vfAimfJY/Xc6BHGV8kJjoXIMhF++dXqMjZqyGvocnw==
X-Received: by 2002:a2e:911:: with SMTP id 17mr13543936ljj.207.1600458520502;
        Fri, 18 Sep 2020 12:48:40 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a17sm766769lfd.148.2020.09.18.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 12:48:40 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 3/4] rcu/tree: use __rcu_alloc_page_lockless() func.
Date:   Fri, 18 Sep 2020 21:48:16 +0200
Message-Id: <20200918194817.48921-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918194817.48921-1-urezki@gmail.com>
References: <20200918194817.48921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Use a newly introduced __rcu_alloc_page_lockless() function
directly in the k[v]free_rcu() path, a new pointer array can
be obtained by demand, what reduces a memory footprint, does
it without any delays and in time.

Please note, we still keep the worker approach introduced earlier,
because the lock-less page allocation uses a per-cpu-list cache
that can be depleted, what is absolutely a normal behaviour.

If so, the worker we have, by requesting a new page will also
initiate an internal process that prefetches specified number
of elements from the buddy allocator populating the "pcplist"
by new fresh pages.

A number of pre-fetched elements can be controlled via sysfs
attribute. Please see the /proc/sys/vm/percpu_pagelist_fraction.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4bfc46a1e9d1..d51209343029 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3401,6 +3401,10 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	if (!krcp->bkvhead[idx] ||
 			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(krcp);
+		if (!bnode)
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__rcu_alloc_page_lockless();
+
 		/* Switch to emergency path. */
 		if (!bnode)
 			return false;
-- 
2.20.1

