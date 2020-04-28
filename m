Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47983C8300C
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266EB20731
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYukFqdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgD1VAP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbgD1VAB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 17:00:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB7C03C1AD;
        Tue, 28 Apr 2020 13:59:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so258820ljl.2;
        Tue, 28 Apr 2020 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBXzHuBlNIiG5WL15rHVAeI2UeCimXr5JALsutUTg9Y=;
        b=UYukFqdvOw/RYQ+Em+r2cvMx8ideTgu8rhd+I9bYqLwxcbgu9vNXU3uaca55s732ym
         CrEQXN6x38a8DRsG2xFDMK4jMsgvDPwo5MBF0NBh/mZ4wod0iMehj046iiSrKLhDhxTD
         OLv6OW+1XR9USm3IGF083IXEWzo5J8uRc39cB1SyQZ5W9JXESO9ihoIFmDJaTahQ8jis
         vjc9UkiSGkqOJqqtzYOpN6RBPV6P3Df43fHcETpcrBu2P0GzMYBv4gsYLtHb74LY7+/s
         InJNpW48Iukvavept/9+c6OE54pG3/uqM0Sl1LdoqWfgWT5ZBgHdYawwx2PKGzYxu77m
         pjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBXzHuBlNIiG5WL15rHVAeI2UeCimXr5JALsutUTg9Y=;
        b=mCeesFEXcKo1A4RYTt502imsIpmJnFX9kI96NXLHYJju0DSy6c20yPwp6DNztG5Xab
         FSBYYOrzVysPp0H68Cbjdq4wpRAJ5jGmPtaFfF5Q4YbcxNcFOs7s/gZg4145jMlT3zyn
         TdeeXoytG7S7liaGcJIn3TPI6UwhQanVozbEmKTVd11rej6zvHfq3+pJ1GMeOHuARJZn
         JuDsgYrlo3chvaejcq6kHTqJ7xBzn9zCXKWrx+c1r0JqcjFVs5nm8b8pVJLB5YDPcK5k
         p0zOu2P04KMdz4S8UTWQNYKYhQbxapvz9C195qV8/B1eduFYTe21uxyIOnP3pz2+lX3T
         y0WA==
X-Gm-Message-State: AGi0Pubatzrmr7bBJEnLviMckSwrEKagTaiX+vxZEjg1YUSH9voZwVcE
        lLK5DGOcWebRoACoaHeiPdraPzLsmmgOYA==
X-Google-Smtp-Source: APiQypKbwyjmz7XAKZZaGzDhUO4GGzDo1hAKGgC0IXSPp5QF7iC3hAYqf7fmKiCv2L6QXg614yuycw==
X-Received: by 2002:ac2:5dc6:: with SMTP id x6mr20373376lfq.108.1588107597607;
        Tue, 28 Apr 2020 13:59:57 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:57 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 21/24] rcu/tiny: move kvfree_call_rcu() out of header
Date:   Tue, 28 Apr 2020 22:59:00 +0200
Message-Id: <20200428205903.61704-22-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Move inlined kvfree_call_rcu() function out of the
header file. This step is a preparation for head-less
support.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcutiny.h | 6 +-----
 kernel/rcu/tiny.c       | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 0c6315c4a0fe..7eb66909ae1b 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index aa897c3f2e92..508c82faa45c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
-- 
2.20.1

