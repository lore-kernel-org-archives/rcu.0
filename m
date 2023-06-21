Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2824BEB64D7
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 02:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFUCdE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFUCdD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 22:33:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22089B7;
        Tue, 20 Jun 2023 19:33:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b525af07a6so25443515ad.1;
        Tue, 20 Jun 2023 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314782; x=1689906782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=demoIvd6FUiWf68KRG+qXQL3nbt4VblYJWw6+Cz8IOo=;
        b=JNKCkfG9NmGn61uAnLjtFFkMM5+EQn0vYwBstEQwyylfetErBEuyj2aOGsbHx+p3mi
         /Lqe5bro7krmF6Rc/uQzaOXvfnjf6TT0Mj7DPoGZ+PzdDoAv+DDuNFdVULEfYyk+1dYl
         a7FU3G/1+x+jEI9jmKBvzTgEP34Rm5pvn1pbSCRgbMhS6AVkaTXZxtEt60vtA2TmXEhr
         7Unc2WQiXCmQK8TB3bFJh3CWE06X1q3fy77nFEF4BVYKbSwlxy0LgrPC26J0TuvBsucG
         +akhV6F+9j5n2fPrGDLzt0762log1lRnuDdL3TdCh9t15+UZ/OZuEnyprKBw3f68sL18
         xwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314782; x=1689906782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=demoIvd6FUiWf68KRG+qXQL3nbt4VblYJWw6+Cz8IOo=;
        b=UjZpWJLWRf0uhtefssV0SYm2vRvNEVGMsMP1QrwojFfh0KEkhc4UJsGGTcpwXRkdAW
         7daHLX7M86BtJTmmMfu6z9a02BWDP6XKOkmvKY7Lw8sWNDu7yUfPZoEF24kwspuzSLBq
         2p67Gup9U40c9+dhTEYZ91rcSASC1hqcFNNZl9b5hoXck9en8Cb7tLN/PAWxq+dDeOp7
         VQ+RTEJEdCzyMdfN562vMbXMpjWrwW3TgPp3VgxsQOX9l5u9lrzg5XYpn1/fJ23eMFB7
         WpnnPvAlijemOqorgqb3QHnfMTDZyp5DTSTt4iHuAedAq48hSpZ9F7BX5P4tjy5OVysu
         BO4A==
X-Gm-Message-State: AC+VfDzCiFN0E3jSZ3N4Kq5aGgTpqkvlre39ZASHYQ1Fni83J5kKZo4B
        UtKoh06Q4IKSPfFpdHqEmKU=
X-Google-Smtp-Source: ACHHUZ6ZAFSZLYBnwYiDyEaEljhkLUZQmw69WAPUZX4bk5W7Q/cNakX5ngte0EHX2LihuWU/EExNqA==
X-Received: by 2002:a17:902:eacb:b0:1b3:fb76:215b with SMTP id p11-20020a170902eacb00b001b3fb76215bmr10280282pld.48.1687314782528;
        Tue, 20 Jun 2023 19:33:02 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001ae5d21f760sm2250764plb.146.2023.06.20.19.33.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:02 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 05/12] bpf: Further refactor alloc_bulk().
Date:   Tue, 20 Jun 2023 19:32:31 -0700
Message-Id: <20230621023238.87079-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

In certain scenarios alloc_bulk() migth be taking free objects mainly from
free_by_rcu_ttrace list. In such case get_memcg() and set_active_memcg() are
redundant, but they show up in perf profile. Split the loop and only set memcg
when allocating from slab. No performance difference in this patch alone, but
it helps in combination with further patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9693b1f8cbda..b07368d77343 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -186,8 +186,6 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
-	memcg = get_memcg(c);
-	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
@@ -202,16 +200,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		 * numa node and it is not a guarantee.
 		 */
 		obj = __llist_del_first(&c->free_by_rcu_ttrace);
-		if (!obj) {
-			/* Allocate, but don't deplete atomic reserves that typical
-			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-			 * will allocate from the current numa node which is what we
-			 * want here.
-			 */
-			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
-			if (!obj)
-				break;
-		}
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
+	memcg = get_memcg(c);
+	old_memcg = set_active_memcg(memcg);
+	for (; i < cnt; i++) {
+		/* Allocate, but don't deplete atomic reserves that typical
+		 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+		 * will allocate from the current numa node which is what we
+		 * want here.
+		 */
+		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+		if (!obj)
+			break;
 		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
-- 
2.34.1

