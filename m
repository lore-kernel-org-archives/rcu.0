Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443A3EB64DA
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 03:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjGFDfG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 23:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjGFDfE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 23:35:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E221BCA;
        Wed,  5 Jul 2023 20:35:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b80b343178so625325ad.0;
        Wed, 05 Jul 2023 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614503; x=1691206503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwcmYs5zpVjZuQmezI+xbvaGS8SBxqFvKsz2XGqKKoY=;
        b=Xh6FFBG8SnsEBV9Bo1mDrlVJg8Yr6pVxMawnKWc4C2kF2KzaYlls5r4US2QZrD9t7l
         YQrjR4rqzuqPpvYmDHND2WOsG4W0F6SP+sOxbsME9tkIzoi7QpldMUI7Sf58G8JEZ5kk
         tXALQUfg+4uFGiyTkEs8I7LBBstu8LaH98dacjgLn/vVknKF4ziIFZ/BiclGuelbRmLs
         wakfAci2kO8vkWEKpmWjeS9JsL1gGjdIwBkg6bikYWhtgpU1AaHe9RHcBFu87tgFThLE
         LanhBDOGZI+4HZMo1M7svexLo/uMAFODtPeN9//EglfGc9yDUPR+jRFbcU8VtOEha6Ra
         NEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614503; x=1691206503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwcmYs5zpVjZuQmezI+xbvaGS8SBxqFvKsz2XGqKKoY=;
        b=Ivrqpu5lwrwBwu7A8PEP7h2ImMJg6Gc6zI391LdwCLSxGOiUJ9zOYwPlSjGawqLOia
         zotOkXdyXRw45i2eGuPbzFNdm6tYhSmvOJCwBcMQFPYUuOdybr35mMc8X89lxTV5z9Og
         3yZ60h1H9nPQNrbZZnIJXK25QRp9jOMcSqyJlOQ3iA0j3xQNjoMUnJ5CKY1x5M4UfHwl
         uTPf6yXMxCRkIAFUwRByP5Z5qo5yFCr36G7qWTXby729Z4eAQ6dgyCY3UTspk9M8IOch
         rMGVp5xX3oSfGY98hT83+L2aadGuj2C/pYz1pah3FC8CszlGeWxFa7+x1mfe+xvDk4/j
         1WYA==
X-Gm-Message-State: ABy/qLa+WfHY69mEPXfqzerGYfrxu2NS2MIZn2xsRzN1cf6f5ZF1ou3h
        h0oO6QSM81uqvjqprLJKrVaVWrqZUOQ=
X-Google-Smtp-Source: APBJJlG0lZp8369hXp7zzA3vLEN8NovtvLqT6YlpqDUdUjdLAhuxgGIqC9NS5DfeMKZpml7yiyujUA==
X-Received: by 2002:a05:6a20:4429:b0:121:7454:be2a with SMTP id ce41-20020a056a20442900b001217454be2amr641953pzb.45.1688614503296;
        Wed, 05 Jul 2023 20:35:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b001aae625e422sm227108plg.37.2023.07.05.20.35.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:02 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 03/14] bpf: Let free_all() return the number of freed elements.
Date:   Wed,  5 Jul 2023 20:34:36 -0700
Message-Id: <20230706033447.54696-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Let free_all() helper return the number of freed elements.
It's not used in this patch, but helps in debug/development of bpf_mem_alloc.

For example this diff for __free_rcu():
-       free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+       printk("cpu %d freed %d objs after tasks trace\n", raw_smp_processor_id(),
+       	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size));

would show how busy RCU tasks trace is.
In artificial benchmark where one cpu is allocating and different cpu is freeing
the RCU tasks trace won't be able to keep up and the list of objects
would keep growing from thousands to millions and eventually OOMing.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b0011217be6c..693651d2648b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -223,12 +223,16 @@ static void free_one(void *obj, bool percpu)
 	kfree(obj);
 }
 
-static void free_all(struct llist_node *llnode, bool percpu)
+static int free_all(struct llist_node *llnode, bool percpu)
 {
 	struct llist_node *pos, *t;
+	int cnt = 0;
 
-	llist_for_each_safe(pos, t, llnode)
+	llist_for_each_safe(pos, t, llnode) {
 		free_one(pos, percpu);
+		cnt++;
+	}
+	return cnt;
 }
 
 static void __free_rcu(struct rcu_head *head)
-- 
2.34.1

