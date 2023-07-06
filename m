Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C61EB64DA
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 03:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjGFDfU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 23:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjGFDfS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 23:35:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CB1BCB;
        Wed,  5 Jul 2023 20:35:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e64e97e2so212097b3a.1;
        Wed, 05 Jul 2023 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614515; x=1691206515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2OQn7u8qk7CwTWC1dwQlpoJqxJbcJEgwvja+T4+A5c=;
        b=SjfDf38U3NJ6GR34LWjxD86lOZ5TMYyrnjrf1khx3T7KXD/xPWuqDCu0WFtPKI6Txe
         OiZKgwpPqbITx+55hkv9PwNpF3xQsc1M4fz74vN8nVHGp2fhXeo5QW802aiu2Z+pyY5A
         APorq/3G3t9WtiRzwp2cH/bG2BNd6gUS06JCq4CbYL7AWZ+vjP8SI2UctZwvKzPd9s11
         O2eFZ9lEBs2pdAvzsi6q4ut3KE9z2ShkgQ2LK0WAevsvUtVq+6qKu8iMX67Q2zmvqxGL
         T7qR+7k48oEQTezJv+HwCXZOz+z0qi40Po4YffUIXvCdaxp0dK8ZlmL/vwI21DA7nAoG
         yLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614515; x=1691206515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2OQn7u8qk7CwTWC1dwQlpoJqxJbcJEgwvja+T4+A5c=;
        b=chWM4VqMGTanJ2yd6cQVwooMLUBtPT+HtYsDrUdb1JmRksDzuoUrl1Yu9fT85RZvb0
         z2B9dmvVEMtIMYBukFXSYfrSMxgd0Puue0mjgPvc02vvyAJabemaFHl2qT6jCBBHHpJ/
         WSMwwnCVHsStmnwHcf6oGxo/G53ue+iA5TVMdav/TWoFV4/UQzXQSn8fH0QR+jNxxWCb
         ceKxJL61Yx3QpBfiFpNEETULt/6dOQCdqZ+IGJd1dRlfNZIcm/UARs6b64D03mGFhvYY
         VC4Ca02dbNlJS1WczQd6TPu6GcUxjnpj9NVnaqhAAnb8OGJ6fs/2Xy1Kiv/wh+R0Fgjr
         F5Dw==
X-Gm-Message-State: ABy/qLbFwIu6p6BKjllHXX0Rf12GtjBoTe115x5Yi5+RvDPJX84kMA9X
        YV4InYzKDiYrll3g4YMshZU=
X-Google-Smtp-Source: APBJJlHC7KpOFYfVUDMOMHsFuCtZz/EE3l6YqBwEqSkQvMkvESbDsiz4Vf91+WraVqedGo8m7/TkPw==
X-Received: by 2002:a05:6a00:1acb:b0:66a:5466:25c6 with SMTP id f11-20020a056a001acb00b0066a546625c6mr524076pfv.18.1688614514898;
        Wed, 05 Jul 2023 20:35:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7924a000000b0066a31111cc5sm232228pfp.152.2023.07.05.20.35.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:14 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 06/14] bpf: Further refactor alloc_bulk().
Date:   Wed,  5 Jul 2023 20:34:39 -0700
Message-Id: <20230706033447.54696-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

In certain scenarios alloc_bulk() might be taking free objects mainly from
free_by_rcu_ttrace list. In such case get_memcg() and set_active_memcg() are
redundant, but they show up in perf profile. Split the loop and only set memcg
when allocating from slab. No performance difference in this patch alone, but
it helps in combination with further patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 052fc801fb9f..0ee566a7719a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -196,8 +196,6 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
-	memcg = get_memcg(c);
-	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
@@ -212,16 +210,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
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

