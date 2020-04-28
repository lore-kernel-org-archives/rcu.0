Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E1C83007
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CDC206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6WjH7SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD1VAg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726859AbgD1U7p (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F7CC03C1AD;
        Tue, 28 Apr 2020 13:59:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so268885ljj.0;
        Tue, 28 Apr 2020 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuCOh3fsoWi6ozxFbpjNX5HY0vVVouy9K1NPB0pENcE=;
        b=a6WjH7SPzi25N3JUy2dkzivo4WGLRcCpkpzaqYd6Fw0ka1nWZ/UmlbhMBdnhfVQZYB
         HNBoFRwvjYE2EnmhQFmBD1dpL5CQuXbjQdRsGrIa4lkDWaJLuS69980noZub88/DhT1O
         qzO1eDhPuABdmhTdtRkUmQNtAZZAQtD2Z5G+BTVuESXENUVSC3W9Tu6W2wGy3d4KjRmS
         LX18i7FFkX5xC3XqnidCDkeJ5qNyHJxcVU1lclTp+09yAtpHLWXQFx+XJTqjf2H0WlCE
         W+Td6Bmf8S8OSSLGjZNe/shh34hNqnCMEUxV9L5lnNBNUgbUPwVTrRQ1BEsme+NE0eQB
         bJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuCOh3fsoWi6ozxFbpjNX5HY0vVVouy9K1NPB0pENcE=;
        b=suvnKF58ibtCH0O6SXWw73W87EDie8fYSRCexJytColB4g7EipJLFz/EnpQnp5ORtB
         iBk1MVEORgoz26COCRsAsyfnIcJolYkTzMvaUP14p4nTz/yc2t/9AZF2NpoEgvHKwmTx
         7EFcv0+aJBFx3L0tMBJFqP7cpg4yaljiKW8UoxKf9LnAUAifaFUxHWciW4uEha0KRbcV
         GoQG0vJn5JnKV7F62dPOhmynEOlhCH6ZlXi/ziDtdXktRYQ1iGhssNpfJY+6v3NpAA6h
         G774cdi7q9mTvi790DWMX+kzTY4dydGyx6/6BqSnLG/KpbFqd4B+SC5vchhNLMpQkyuv
         Z4mw==
X-Gm-Message-State: AGi0PuYATdyHzMC7z65j/ytKIvj6Ny+xrWJtp+7494RVWvlfcvjLR6uF
        9FzhQSDpkLNlyv3A8YYHJtRjirw2un9Hng==
X-Google-Smtp-Source: APiQypLj2b3ByApuoJPSgTS0qYmKq2vkv6PNL4ow5it/sNzKhbIbo7wxp7EgYlwk1Y9ymdWadjFIbQ==
X-Received: by 2002:a2e:9cd:: with SMTP id 196mr3759962ljj.226.1588107583396;
        Tue, 28 Apr 2020 13:59:43 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:42 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 12/24] rcu/tiny: support vmalloc in tiny-RCU
Date:   Tue, 28 Apr 2020 22:58:51 +0200
Message-Id: <20200428205903.61704-13-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Replace kfree() with kvfree() in rcu_reclaim_tiny().
So it becomes possible to release either SLAB memory
or vmalloc one after a GP.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tiny.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dd572ce7c747..4b99f7b88bee 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/prefetch.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include "rcu.h"
 
@@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kfree_callback("", head, offset);
-		kfree((void *)head - offset);
+		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	}
-- 
2.20.1

