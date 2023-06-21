Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FFDEB64D8
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 02:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFUCdC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjFUCdB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 22:33:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037EA10F0;
        Tue, 20 Jun 2023 19:32:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2361406b3a.1;
        Tue, 20 Jun 2023 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314778; x=1689906778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16uWDlZdQR3Juwac+BQwsJvGxkAsevnPbRvEaTU5eEY=;
        b=JM2yRxUx0DuMsUf2ncZJON3wepLg5qqvC/Flm5A3O+CrUzbdgimRgELNYGtuKg+hu7
         BxGfMT1vB06xClWfEPgR4cBH+Q9RX/FKPQ+Xw3cyZ5DS75m32iihLR8jfq5iNJCqx/HO
         Y4Qc7PlMhQG01a5462b3oFSFI3vrYVSI1IZ/xJ2JKhSRx0csQUxKVRqdea2gh+ADUzQi
         N/pBoRBo5ivr3MyvcoTjFidRwbC0mYXK0d2FK87kmFh4WACi0tXoXJhpXMSnY5WC7yh0
         ksqWTn7KvUWAV+pXDqe30brSlR8dS4ZP+v9Bit5L1Z7VyvfVFENZfDW/loP+xWQ2zXNg
         Nb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314778; x=1689906778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16uWDlZdQR3Juwac+BQwsJvGxkAsevnPbRvEaTU5eEY=;
        b=SMb+uL/voQXAY84aPDdgUqbXDwlzveadCRxKyS4uMxmgd2YbSLkfLGI4iaR+k7vIhq
         AR/AQ3MYSy6dueYnphLLot3TZxAue8wmerhDBHZRRMXV99gobrIH01p2mqdVN7HQbWzg
         9U2qk9dqW98Kz9jLszZnTidTzUpzEoYQqKF79BegXpHFYe+9/gms2rmc8Bq0Tt7L9iMY
         TCNpRu1wKubyGC2/nEHoZIGgEZ+c8PieI36MmxmNjOIQV1eMc8Vex0VHB2r49nuJnqCT
         me64LwxeB1rYtSKk82Dd9JitawbShpK9xo6QGqyFS4kNoTLIXGh7nVZ6FoHzymFcjz2i
         RDww==
X-Gm-Message-State: AC+VfDzn9ddQeAXHQi3cg/YtwJGoSunMOGuJz6e8EgA85P2QFvv+2bYc
        t+biMbo3nLWIX73L1UgaITs=
X-Google-Smtp-Source: ACHHUZ4z3QrQN1C47A7g4yKSTcLxPm1+c2/TqM0d7kBM8i4Dri+ssgwk1ld3d0ZiQHBcH1vxBHbOlw==
X-Received: by 2002:a05:6a20:842a:b0:114:6390:db06 with SMTP id c42-20020a056a20842a00b001146390db06mr14501851pzd.32.1687314778326;
        Tue, 20 Jun 2023 19:32:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id n21-20020a170902969500b001b016313b1esm2264547plp.82.2023.06.20.19.32.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:32:57 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 04/12] bpf: Refactor alloc_bulk().
Date:   Tue, 20 Jun 2023 19:32:30 -0700
Message-Id: <20230621023238.87079-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Factor out inner body of alloc_bulk into separate helper.
No functioncal changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 46 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 693651d2648b..9693b1f8cbda 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,11 +154,35 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		/* In RT irq_work runs in per-cpu kthread, so disable
+		 * interrupts to avoid preemption and interrupts and
+		 * reduce the chance of bpf prog executing on this cpu
+		 * when active counter is busy.
+		 */
+		local_irq_save(flags);
+	/* alloc_bulk runs from irq_work which will not preempt a bpf
+	 * program that does unit_alloc/unit_free since IRQs are
+	 * disabled there. There is no race to increment 'active'
+	 * counter. It protects free_llist from corruption in case NMI
+	 * bpf prog preempted this loop.
+	 */
+	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	local_dec(&c->active);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
-	unsigned long flags;
 	void *obj;
 	int i;
 
@@ -188,25 +212,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 			if (!obj)
 				break;
 		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			/* In RT irq_work runs in per-cpu kthread, so disable
-			 * interrupts to avoid preemption and interrupts and
-			 * reduce the chance of bpf prog executing on this cpu
-			 * when active counter is busy.
-			 */
-			local_irq_save(flags);
-		/* alloc_bulk runs from irq_work which will not preempt a bpf
-		 * program that does unit_alloc/unit_free since IRQs are
-		 * disabled there. There is no race to increment 'active'
-		 * counter. It protects free_llist from corruption in case NMI
-		 * bpf prog preempted this loop.
-		 */
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-		__llist_add(obj, &c->free_llist);
-		c->free_cnt++;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
-- 
2.34.1

