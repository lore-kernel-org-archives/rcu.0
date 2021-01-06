Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7175C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A998822227
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAFAyu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbhAFAyu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:54:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9564322EBF;
        Wed,  6 Jan 2021 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894449;
        bh=kRpZWm5PgDMmZLtf+kkcLLcT/9so+o68wCUaaW0QNj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mr7ZYdmPAlXlfx1llukiGbkCUhIaTwkuiPwePltEVspBeLNdx3FJraMymTU/dzWvS
         oYy8yJ52OClNiURrlWGik+noDIU0DFkCX2nOCT9Zm5hVvKgDKTMk7yhfGDELRts8Y7
         GK+31f+QSHws1rp3XGMYjuL1bvaA6w7giTL791v4fcO/+25682cyW46i87QsbARQ3Q
         gz2aHt3VJ6pH19vFfys+YbVXDALXYSeY32UflrfLg+mtsGWAQF26tjEfKpj733+YX1
         7X9UJ9iBgaA99v4s3wF8ltILuim6mSoO0j74AayRFex37rBlsZ/efED+5y9A1MUqhd
         aacP99iJueb5w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/8] list: Fix a typo at the kernel-doc markup
Date:   Tue,  5 Jan 2021 16:54:02 -0800
Message-Id: <20210106005407.12295-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005334.GA12159@paulmck-ThinkPad-P72>
References: <20210106005334.GA12159@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

hlist_add_behing -> hlist_add_behind

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 89bdc92..f2af4b4 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -901,7 +901,7 @@ static inline void hlist_add_before(struct hlist_node *n,
 }
 
 /**
- * hlist_add_behing - add a new entry after the one specified
+ * hlist_add_behind - add a new entry after the one specified
  * @n: new entry to be added
  * @prev: hlist node to add it after, which must be non-NULL
  */
-- 
2.9.5

