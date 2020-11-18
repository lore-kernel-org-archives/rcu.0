Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB1C5519F
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DF2247DC
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DHg/fFC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKRQKy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Nov 2020 11:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKRQKy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Nov 2020 11:10:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D700C0613D4
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2020 08:10:54 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so2269035qkb.7
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2020 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XDDrZ32tt5cIxyE+1WWU1U+ktexYvm+jvQM9PDJ7jg=;
        b=DHg/fFC98sb8qkPaHYTS69DZGl3FJBElL+2BsojGP93n4UNMLDB0Ko4EmZSZt1PSPW
         ZeXJK7S+3rB+cjp5IaUhAFpHQ2KoUDRW52MWFY6K2SCTOvS1Se3KxXB2vsQlZUlFgABD
         1mBkkM2dxuUPT1yRb/4PhXQvAtEOAL7wjSRg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XDDrZ32tt5cIxyE+1WWU1U+ktexYvm+jvQM9PDJ7jg=;
        b=K4lKcRfqj0tS3tLbpBHElzdju5jzVRX3JeRX9p6xPvtVoMUo4zPiZSry1QNG39OSEc
         nZ3WFC371V/ewyZTJc01lVH7BykR+mRGh+DcrXtUe5apNiDYPBsdi8MH2Xa6NzXGE99Z
         DSzlKHoH9wT8rXNwAxAyvh/6z5UFLBuEPyLwoL+JTQs8lZLjrPAIp2/OzAz5ZH6U4Wvh
         lSaOQVBsY2omhzkitX/+Julxb7EyLZ1cRdCUXteF2pe0Ul1WvgTN4FJGqyF1KJVkd2qq
         z1rn2RxwebdyuqtqGc3p5zIGNTCcBW40a+K1CpxCJsxQN+n107zL7NoUI6ceRVzgqKaL
         w8Iw==
X-Gm-Message-State: AOAM5310rJGAKqZ8k8nTytdLHVN869cy0RgphPQp9PqphLmP28p0NCRd
        zoLBVyYfaL37hOfUvPzF+wB18A==
X-Google-Smtp-Source: ABdhPJyg8XatWgCr6orxqOAVodXz3RJ9F2GwbBwPHnW3F6Tlhy9j/LRC1WOTuL8jo7rIVD9reIg3YQ==
X-Received: by 2002:a37:7703:: with SMTP id s3mr5586042qkc.298.1605715853206;
        Wed, 18 Nov 2020 08:10:53 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 21sm17447534qkv.78.2020.11.18.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:10:52 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rcu/segcblist: Add debug check for whether seglen is 0 for empty list
Date:   Wed, 18 Nov 2020 11:10:43 -0500
Message-Id: <20201118161043.3823994-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

After rcu_do_batch(), add a check for whether the seglen counts went to
zero if the list was indeed empty.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  3 +++
 kernel/rcu/tree.c          |  1 +
 3 files changed, 16 insertions(+)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5059b6102afe..6e98bb3804f0 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
 	return READ_ONCE(rsclp->seglen[seg]);
 }
 
+/* Return number of callbacks in segmented callback list by totalling seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp)
+{
+	long len = 0;
+	int i;
+
+	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
+		len += rcu_segcblist_get_seglen(rsclp, i);
+
+	return len;
+}
+
 /* Set the length of a segment of the rcu_segcblist structure. */
 static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
 {
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9faaf51..46a42d77f7e1 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+/* Return number of callbacks in segmented callback list by totalling seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
+
 void rcu_cblist_init(struct rcu_cblist *rclp);
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f5b61e10f1de..928bd10c9c3b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2553,6 +2553,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
+	WARN_ON_ONCE(count == 0 && !rcu_segcblist_n_segment_cbs(&rdp->cblist));
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-- 
2.29.2.299.gdc1121823c-goog

