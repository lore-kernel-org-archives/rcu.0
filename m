Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F355C433DF
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3903206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPIyjT10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgEYVsZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgEYVsY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB8BC05BD43;
        Mon, 25 May 2020 14:48:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o14so22215787ljp.4;
        Mon, 25 May 2020 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZjrHlimgcUYomtREHYCFuAeJrpRl9IFi+y5djKRQas=;
        b=hPIyjT10zycop+JKy8135w3NPFuM+OtEngjMZW8KAmLmVW2Vxp0+BJgjELMVgXLFs5
         jyDXvM8J2pQxwbEB2pyNztU7Se3z5Wd060ijoHg6DDb5aRWX5ZuAMUaNSzHofFIoEJNv
         8aI29V6q0aJUJxkrbzIr+/lmfTa+pNBCgK3xFfTkXlN7U0Y/awGBKWtblhWlDEmhuaqL
         k6nPkAczXPGTLmBEXQYigDrVKl/eeB9s3UKwKW4wuEL+s+zKfha/ZpW43aFl2wLg2amm
         4o+lmYtE0sBrX9HIUArLZ8k9W1xEtbHyYJUczmpOqSXo8FfhTp+nx9OiDgLI7iZo7XYS
         628w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZjrHlimgcUYomtREHYCFuAeJrpRl9IFi+y5djKRQas=;
        b=GJDnQsdpYc/WpqZm6eHXNC5Ld3XAC6APOpMaou+EmLZhyHJ5cx01tV6cexBa6GrvcL
         QTl5QyX0oEAryyt8C6i8h/mxbT+7eZp39Yk2t3mJQjC4LNe2udbpiE67GCAOAQySD4sf
         71ZYsQDY3uTWwKIHNgAIfkESjFKBn7X2W7v1a2v08XApMyosWeFushv2WEQZFsgxx3St
         mCxt54kR8rugNX4EISlRyUf4JrK+ofiP+OwwOqdst7jKR9fDnB3MsOq3GPz9ANp1JR2+
         KMb+7zQpZ4denAKTiHgwlJ7s+txWpsH24Xa9cXIw/07TlompcBGIQtoQL7kCVGCKWX97
         19cQ==
X-Gm-Message-State: AOAM532nI6bb/silVmm0CpAblk8amtex2Hd3GnUNpHZ3QjkiExVS8wYw
        5Snj51mDiUu49GP9+9W0VxgvvvLKWVNg5Q==
X-Google-Smtp-Source: ABdhPJyxvtoEaRJXilbbh+ynL0lLxOteStevxPIViaI0XOVzTSChAjJHtXaOv/FWincgOqizXxgD0g==
X-Received: by 2002:a2e:711c:: with SMTP id m28mr14476316ljc.104.1590443301892;
        Mon, 25 May 2020 14:48:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:20 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 10/16] rcu/tiny: support vmalloc in tiny-RCU
Date:   Mon, 25 May 2020 23:47:54 +0200
Message-Id: <20200525214800.93072-11-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Replace kfree() with kvfree() in rcu_reclaim_tiny().
This makes it possible to release either SLAB or vmalloc
objects after a GP.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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

