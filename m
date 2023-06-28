Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D4EB64DC
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 01:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjF1B47 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjF1B46 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jun 2023 21:56:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE91B1;
        Tue, 27 Jun 2023 18:56:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668730696a4so2841203b3a.1;
        Tue, 27 Jun 2023 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917414; x=1690509414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16uWDlZdQR3Juwac+BQwsJvGxkAsevnPbRvEaTU5eEY=;
        b=LGDhdUQK8AZIfJYvAUIHp72/FPZ6uOtmdiIuTL9jhgBe6LCEIwUdKOaoUS9wp1kg/f
         W5SyOK8M5z+6zu4GkDVY9caCJJ+Ze59YpHD+dPk0hXIfSnpIC3pyj1lFNpzP1Kl71w3R
         g59T0C3mjdtoalBX2YCoOw/1a/izVyEHL8agkJqFIpiu5g91EvL7XBJ6BGDKRUQtXJ6M
         GCqqHwZdYedBMyp5/jpECxF7TlDoWgk6BLDMm03z7h63LfC/O5bidKi/HSGiMTWAOr1w
         Lf7yEo0jB7j+D/9PxMDp2zUqdYCPwff7fM11gzJHhxlqDI30eFD6aMZFMsgFrxj4UAJJ
         PHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917414; x=1690509414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16uWDlZdQR3Juwac+BQwsJvGxkAsevnPbRvEaTU5eEY=;
        b=A0hq2H+jwMSmhOkv42izgUR6mLHmnmKGQgDrZTuLQdz0GCs4KGXuF79lM3kElh4NBW
         g4dn4QAI6SZ7eWYsMyvPwMT6mt5bRPSFX3dxXRlIixgdBYsXw3ejDFhCmfpO4sNStkCW
         VUfWs2FpEqfcOL7wquB/I0kBIUbJ1yjZBT4//V+3snk1IhOz5L0GqPctrpmI+UJxavyT
         HYH7bt/KJ91FHuNNYsP7+4I/mJ3uCStdVMMYiXnb1PbCTdxdMvWUsxlfSOqQoROePq3c
         /wLANDjzwjw50JsBkBmjWbuo5KYPjoFlOgwo6odeX3e2TNgCeAGwk0T+b1ziR15X2lYz
         bx0w==
X-Gm-Message-State: AC+VfDxYrVqPqcXBJpZosOoI0L/9ktp5NanUMgtuAqjMnB7/K4ueKOI8
        sUFOCefD48KzqLfhZt7zczE=
X-Google-Smtp-Source: ACHHUZ4Vr1vZEFzpEmFIvWEEIFUJro27nERclTEnm3p/Z8PK+dbp9XwSTFBmQ2lT0a4IBwQNPcoV8A==
X-Received: by 2002:a05:6a20:8e19:b0:11f:7aa:1b27 with SMTP id y25-20020a056a208e1900b0011f07aa1b27mr25859487pzj.51.1687917413730;
        Tue, 27 Jun 2023 18:56:53 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b001b3eed9cf24sm6563026plb.54.2023.06.27.18.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:56:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 04/13] bpf: Refactor alloc_bulk().
Date:   Tue, 27 Jun 2023 18:56:25 -0700
Message-Id: <20230628015634.33193-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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

