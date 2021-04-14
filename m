Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44894C43470
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1148360FF3
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhDNMND (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhDNMNB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 08:13:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEBDC061574;
        Wed, 14 Apr 2021 05:12:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x20so2495395lfu.6;
        Wed, 14 Apr 2021 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1StD1decQS7zRdEOzRVJotVRFVyFLJ+Y3wtmlXev/IY=;
        b=YWqdqVidTwyyPcwaWIOh+MXw/0ithmAZaBZD3lJOeFdoAUMnyIH5NwJuIjaNrmkZda
         08k/n5gwIihOOlDl0d2uYPib5faG9ctnuiU0+8Dyf7ZY0lhxwB6eZX0dTg2K0F087fLz
         9Y5F8Sx5yKkeMHP/olqsd35+mJ0IZT58pLbx3h9+5mgyWzpgAWPMZUV5Q/2IWnFHacDm
         WvVRNbtA4bhY4b9DKAvg75Nb3wgcLsRh928TDQ1tYDX1JX230704PKDtl39IaTMC2Own
         l+NkCgGBt4YLJDrKP2dR2j0bM19lDRxMUYmzXeAK83d3L5FTgzP0mjPl3s24s21KRRrh
         lklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1StD1decQS7zRdEOzRVJotVRFVyFLJ+Y3wtmlXev/IY=;
        b=W952oUtYzNfm93ESDMJWL5AByutBqTB513erjkfzz6jzECvEETXTnCSpdTQmeWiMRX
         Q7A8rH6Flb/oGlRQYFr9pCGPWg/PqblsKz9kMGTzV45iTpyeOeIo6xMDiERBtx3gDVTU
         l3tpe0qo+u4YsQjxMPbSIWv2Vr+a3XAnFPPMg9gWa6Do5W1CtGXZF9Zb07VsZzCDe6oC
         gOQBDkYcuEBwjehGn5MW0znepfGkH+wZ9c35AGmsvtU4hpykFFL7ZCLbHDKLrMt+5YkJ
         ZrKC9uppp9SWJkcytQJ9yAOy9epC/v+RKSjNBmZ9PG6sdCcKdrnT5FABrjzlSiKwC5Z0
         Hxpw==
X-Gm-Message-State: AOAM5309NsrppSeEBpbhB29MaoS+UPoMxRF+hthf/bPSQblqfzYUE+4u
        8tTLd6FJQJHx4msirfsCeTXF+2jyFvaAHw==
X-Google-Smtp-Source: ABdhPJwH59eH06gguM5t4WgzIM5xI8HRNEkg0jGasy30GLT2kvSHfzUWhP/f0O/1f5MqTSbLNoxsrw==
X-Received: by 2002:ac2:5e30:: with SMTP id o16mr19820524lfg.35.1618402358997;
        Wed, 14 Apr 2021 05:12:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i4sm4338061lfu.33.2021.04.14.05.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:12:38 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 5/6] kvfree_rcu: clear KRC_MONITOR_TODO bit once a batch is started
Date:   Wed, 14 Apr 2021 14:12:25 +0200
Message-Id: <20210414121226.2650-5-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414121226.2650-1-urezki@gmail.com>
References: <20210414121226.2650-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Before attempting of starting a new batch the KRC_MONITOR_TODO
bit is cleared and set back when a previous RCU batch is still
in progress.

Clear the KRC_MONITOR_TODO bit only when a new batch has been
successfully queued, if not, it stays active anyway, thus no
reason in setting it back. Please note that checking/setting
this bit is protected by the krcp->lock spinlock.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da3605067cc1..012030cbe55e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3427,16 +3427,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
-	clear_bit(KRC_MONITOR_TODO, &krcp->flags);
-
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
+		clear_bit(KRC_MONITOR_TODO, &krcp->flags);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	set_bit(KRC_MONITOR_TODO, &krcp->flags);
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
-- 
2.20.1

