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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36412C43461
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A4361074
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhDORUi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhDORUi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:20:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B8C061756;
        Thu, 15 Apr 2021 10:20:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u20so27945103lja.13;
        Thu, 15 Apr 2021 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaitYXgxr7HEleqn63B+r6EAvhxLY064O9GfL3Ta3dY=;
        b=UXqw48Ojshs8EoYKdpioSNS10GEgnDdPGnS9OE/G8rOaarWPhzKH7BrmclQRHvNpLQ
         pNAaDtnwkkFlV2AylyQl9LJW04q+dYCHIYyVQ4wojDd3pQ5a6pBtjirryTOfsnYJ2sWg
         OmiHRdBQ5dfvK0joHysDRgotW8ri6WHagG7DMEuv9q64kxMLR3C2krnMdijf33OM81qu
         dh4H3ZI3gnEo2GxmXdJtl0G46BD12/knVocOzQ7aybELJdMt8Pro9/Fb87lKS5ixelvC
         VCjCudzAjtSu3lzuKjRTcd3zCaICA/d8PpzskO/Tj2fk2Auw1TF8rZXG6KMHGEZ6AVOk
         pyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaitYXgxr7HEleqn63B+r6EAvhxLY064O9GfL3Ta3dY=;
        b=W7bc9U+u7nGH23SdqBfTdzveylab0cnPdlF3zOErWCbQTlQRzkh7kCZGKjzI9ENY+s
         R26koT35HCCRQm4bCwBk13CvDN0wy09auJYctEqtswN6yQYOgsjVPc2vh5P3zoEAnsI1
         wqAef5u3qm9HhzZpySd7UuqVuh/gB++ZFg02JruoTCtjYcneXdIgUSJVYBIlbbWhPTef
         KlosXZ6nTmWSyrmnEnkfW0nTKz8ej8XlUs4a0bFhbXd/JeFeCMooQrIrc3C1R5bSTaOF
         q2comXA32Zr/gpaCYqVremCWJFjLR3cJtuKmpxu0lKxNfef6ozVg8u9zJIMm3DSzKs9N
         F5jw==
X-Gm-Message-State: AOAM533jl0ywSGPNex3sAGHAIpYpL0FbgVBJLkrKSTkSrHeMDb8ZCdsH
        l/EJNAlUid93EKl1uWz4uP23gqHCqqxbCQ==
X-Google-Smtp-Source: ABdhPJxY5cMl3MC5xdWnWSKoCSO6CbLOuP184NE62nII7XhoRs/IbQ1QlDGO5u3IDtyfFnIzWskOwA==
X-Received: by 2002:a2e:2206:: with SMTP id i6mr135397lji.273.1618507213242;
        Thu, 15 Apr 2021 10:20:13 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm84358lff.276.2021.04.15.10.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:20:12 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 2/5] kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
Date:   Thu, 15 Apr 2021 19:19:57 +0200
Message-Id: <20210415172000.15086-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415172000.15086-1-urezki@gmail.com>
References: <20210415172000.15086-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

nr_bkv_objs represents the counter of objects in the page-cache.
Accessing to it requires taking the lock. Switch to READ_ONCE()
WRITE_ONCE() macros to provide an atomic access to that counter.
A shrinker is one of the user of it.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 742152d6b952..07e718fdea12 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3223,7 +3223,7 @@ get_cached_bnode(struct kfree_rcu_cpu *krcp)
 	if (!krcp->nr_bkv_objs)
 		return NULL;
 
-	krcp->nr_bkv_objs--;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
 	return (struct kvfree_rcu_bulk_data *)
 		llist_del_first(&krcp->bkvcache);
 }
@@ -3237,9 +3237,8 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 		return false;
 
 	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
-	krcp->nr_bkv_objs++;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
 	return true;
-
 }
 
 static int
@@ -3251,7 +3250,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	page_list = llist_del_all(&krcp->bkvcache);
-	krcp->nr_bkv_objs = 0;
+	WRITE_ONCE(krcp->nr_bkv_objs, 0);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	llist_for_each_safe(pos, n, page_list) {
@@ -3655,18 +3654,13 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
-	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->nr_bkv_objs;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
+		count += READ_ONCE(krcp->nr_bkv_objs);
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
-- 
2.20.1

