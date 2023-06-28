Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FFAEB64DC
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 01:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjF1B5F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjF1B5E (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jun 2023 21:57:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC97D2D71;
        Tue, 27 Jun 2023 18:56:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso343433a91.0;
        Tue, 27 Jun 2023 18:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917418; x=1690509418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8BWINMaO4z5rYdGjPlWk6lrzjT7qss1KTXXTsv4P9Y=;
        b=V218ZcqFUz03ODmojkFc9PKb24QgZyhpe577ezZzhZxnmTogwyipfjqhQ7T0Izep65
         ehSUNFZbiyUxOJKZUzwE+NaadzFo218wVe79RW+Qr3aTaaWeN/B/feQIuWfivZ833KXn
         c9m2ZwT/56KNbzQVINRgffQwIGrKEiKM5YhExJpQy3+xcOReLTNbsFudyMXzlJFJrzeU
         a8JC3pnuuJJsKql1EanzsLM2nabMJQnU6q9LqNNtZpfURgJIXgWhXC7jhzbAMxPPVaG2
         PFf5xzbp93hSHHgzNY3W1HVDQlLbZ6hXhP0jFjIBRcPGKB6i33Or2LOC9T4TbjUQ4Ft6
         UAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917418; x=1690509418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8BWINMaO4z5rYdGjPlWk6lrzjT7qss1KTXXTsv4P9Y=;
        b=cqJBfV+o9JQJijZVNHxH3sEEAHy6aQE7Eb5C1iVqfBKW2TFBLSnn4BmIkwvhbHupKD
         zj9+wrKfP0NNydKy78H30myJKxF/0z2LBKswaBExLl6AtZX/iZeTH7ir9t2GDm0f3Znw
         gjZlj+UmRbSqlfG20xaqDiR1BhGlMb7aC4QKoaG/i8kEtDsm7FCqf/Xm+7Qe8FMuXCyt
         Qk5/vdUZau62Yvx7SuH9YowTsPG72YHcLnmDGxbMCdo4ZGjG28eZDly9G5JOFm7DXVxK
         OULF1ZPW/mll+WPcCgAA+szhruTiRBoxRgw9aM8KgmTHddiP8Ti9rpx2hRqpyhJ0aI3h
         HJjw==
X-Gm-Message-State: AC+VfDyWFo1ylKA4ZQpVjEJkSVQGg1An5pRDcRWDwYZKpsVnIfMSK+hI
        ZCd2ELPZALetR5khRpl8YgI=
X-Google-Smtp-Source: ACHHUZ6aolvwT3c+0SJ5D0uOOzQKMRbUbSrimdEVSFAtHw/32TYPRsHmrl/Ag3/Cdq7WIn7iCOhS6A==
X-Received: by 2002:a17:90a:7541:b0:262:ce9e:8a25 with SMTP id q59-20020a17090a754100b00262ce9e8a25mr13865966pjk.22.1687917418199;
        Tue, 27 Jun 2023 18:56:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090a881200b0024e05b7ba8bsm6744131pjn.25.2023.06.27.18.56.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:56:57 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 05/13] bpf: Factor out inc/dec of active flag into helpers.
Date:   Tue, 27 Jun 2023 18:56:26 -0700
Message-Id: <20230628015634.33193-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Factor out local_inc/dec_return(&c->active) into helpers.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9693b1f8cbda..052fc801fb9f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,17 +154,15 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
-static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
-	unsigned long flags;
-
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		/* In RT irq_work runs in per-cpu kthread, so disable
 		 * interrupts to avoid preemption and interrupts and
 		 * reduce the chance of bpf prog executing on this cpu
 		 * when active counter is busy.
 		 */
-		local_irq_save(flags);
+		local_irq_save(*flags);
 	/* alloc_bulk runs from irq_work which will not preempt a bpf
 	 * program that does unit_alloc/unit_free since IRQs are
 	 * disabled there. There is no race to increment 'active'
@@ -172,13 +170,25 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 	 * bpf prog preempted this loop.
 	 */
 	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-	__llist_add(obj, &c->free_llist);
-	c->free_cnt++;
+}
+
+static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+{
 	local_dec(&c->active);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(flags);
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	inc_active(c, &flags);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	dec_active(c, flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -300,17 +310,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 	int cnt;
 
 	do {
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_save(flags);
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
 		if (llnode)
 			cnt = --c->free_cnt;
 		else
 			cnt = 0;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		dec_active(c, flags);
 		if (llnode)
 			enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
-- 
2.34.1

