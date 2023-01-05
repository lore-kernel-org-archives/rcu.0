Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC63C53210
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjAEAXT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjAEAXM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7134436F;
        Wed,  4 Jan 2023 16:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 239C9B81985;
        Thu,  5 Jan 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2CAC433EF;
        Thu,  5 Jan 2023 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878187;
        bh=0ljvs2QOdGuLUAaxiiCnltc5mW3jT5j/qQAFulm3cTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQ30BrwZpdHVHwiV8AvKN4qD68IuNfd7pZ3HCV3tSA+xnYTPknssJ03j+KSIwDPRT
         d1LVu6c34jQAptXnXPtEJ93Qu4i+fagmjDXhWQJLcgvgWkxuuFDYZsVDKcWRDL8+YF
         LaOExSXR68T4b08uJAQhHjGKNo+nGSqNjkSZJuXZPq/Ksv17G9I0wuk/B9JRHneruR
         w1rspg+xPwl18VgiiV9bFfXBR1W1+o+BSJnAFDWgMK8jWZBz40eV3kNvnlFLHAZeuN
         mReSTicA3crOuq/1B2lZafVGei3PAuz9ACzVibvvsi3LYEBtWACDBpj3QbZBETq3+U
         7thuX9zkbw0sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7327F5C05CA; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/10] rcu: Use hlist_nulls_next_rcu() in hlist_nulls_add_tail_rcu()
Date:   Wed,  4 Jan 2023 16:22:56 -0800
Message-Id: <20230105002305.1768591-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

In commit 8dbd76e79a16 ("tcp/dccp: fix possible race
__inet_lookup_established()"), function hlist_nulls_add_tail_rcu() was
added back, but the local variable *last* is of type hlist_nulls_node,
so use hlist_nulls_next_rcu() instead of hlist_next_rcu().

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index d8afdb8784c1c..ba4c00dd8005a 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -139,7 +139,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	if (last) {
 		n->next = last->next;
 		n->pprev = &last->next;
-		rcu_assign_pointer(hlist_next_rcu(last), n);
+		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
 	} else {
 		hlist_nulls_add_head_rcu(n, h);
 	}
-- 
2.31.1.189.g2e36527f23

