Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADAECAAD2
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiIAWSD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiIAWSC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07F543C2
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:01 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jy14so145918qvb.12
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7NTlW4AVEaEifdUDNJKG5n5TSALhIocTrw3kCCpTxNA=;
        b=JOSQJQVjQiQE0lsAHsymw5P/1/LCdxuxYv3QrWVdzDXjflavEeAYjmd5/uZ37cCbmF
         zhBGTGNbXYEWseXrqhdIgH5eL3LYuesO89moXDEXUlnu/SLgEN2N3XUtV/AIkJ3Zw4BO
         xRsqlByOAsBzFkWDPtCz2rpRDgUAwAOEujFyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7NTlW4AVEaEifdUDNJKG5n5TSALhIocTrw3kCCpTxNA=;
        b=jQxysGOCu3biAzsapUETF0a7g1C3dwMtC8yAtmNYXNGr+orttoo+nUn5JSwUxYMizQ
         thdDxL8m4Cz7h8PxSUgmrDFcNatXgcCvRlugUIxNNeB/rwrH9JeovF+s48hdBA1ATkm3
         dmjZIV9qxm+30XVGxs61bqvFFkwOeil7FDIAFgGTox+vtLoU8FW5wLR4gzS+sRbS8ltS
         3WGFfeTtiRFaYm+G2Wffn6KiV4ZKge7SKhEuA/Xg/81gPW8FaVgGtaW08vc+JMY8c6wC
         Baatp4IK2d2Bk08LRwOOXwHGaP8WEfDhqF5+xCM6SakbF0OMDgDW/BGpTD1iFXvXTwX8
         RC2g==
X-Gm-Message-State: ACgBeo1qWF1eI9JnLw2XK72yMMg+oIyO+wT82jEnpD09NB/sG+QBQacw
        g7VVBmYPBr0iBXuDS0DZR10xDcH2fSTTjg==
X-Google-Smtp-Source: AA6agR5R0KAg3JQMxVIXb/rgAzL7TYmscgkTXfoxMN9Q5ya69Oe6nssTMAHS9mjy5O7k72Bf0BpSEg==
X-Received: by 2002:a05:6214:29cc:b0:477:38c2:105e with SMTP id gh12-20020a05621429cc00b0047738c2105emr26673145qvb.93.1662070680808;
        Thu, 01 Sep 2022 15:18:00 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 05/18] rcu: Move trace_rcu_callback() before bypassing
Date:   Thu,  1 Sep 2022 22:17:07 +0000
Message-Id: <20220901221720.1105021-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If any CB is queued into the bypass list, then trace_rcu_callback() does
not show it. This makes it not clear when a callback was actually
queued, as you only end up getting a trace_rcu_invoke_callback() trace.
Fix it by moving trace_rcu_callback() before
trace_rcu_nocb_try_bypass().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..9fe581be8696 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2809,10 +2809,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
-		return; // Enqueued onto ->nocb_bypass, so just leave.
-	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
@@ -2821,6 +2818,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+		return; // Enqueued onto ->nocb_bypass, so just leave.
+	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
+	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
 	/* Go handle any RCU core processing required. */
-- 
2.37.2.789.g6183377224-goog

