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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CAC43462
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BEE60FF3
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhDNMND (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbhDNMNC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 08:13:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428CBC06175F;
        Wed, 14 Apr 2021 05:12:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n138so32890375lfa.3;
        Wed, 14 Apr 2021 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/F4pdvzkzZzwdTEYJKDDaCgHwGNIFnZgcaHpEY7Sas=;
        b=L4iJFkdk1+8DyfMQ4scxeJHs+54J8NfC+m2ktDc/0uFL/FOIs1qgfxFwprB+vxD53m
         YqFxb4NgHZ2guDuX/D5ezFyXsgfG9Y2s3FtNjCF62igD6vR+GSYpDhgyJkU2vuBLD5Ft
         sDGwdZJqlg+ZuTekEptS/ZJQB5Vg5M49PkWeWf2arM57EXTB71EJVlf0mYgQ1y7wadKP
         +D1iVKzyUCZA1vYJfEC0Jor0k23XsOc0fZWPALvQ1849ZH0QKfeKXImSxW16PactjGpX
         nrmIxUtORTElSsG35ab9+iRr2uXSQhH9iC672sKxFVoeLiu1LJdJzChr5yK9olN8J0QW
         G6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/F4pdvzkzZzwdTEYJKDDaCgHwGNIFnZgcaHpEY7Sas=;
        b=dzjR1DAtcOf/8+iQqpzEFko8zTNOMQtMnugnZe9OfE45cLYkxEawbnRNhO/2vKY2rm
         gMBFuCiEeE760rVByRy0SxFNRXe28lBUrTHkszPqAYN4yvzcH/aASBmanxRWOdHTsPo5
         v8bqOUAi/g5XMPkUt+hrm6UR/TXDpd6ozofvFOKvNxJuKgUjqrVR2jMICGGS1E7gc2t/
         UvERE0X3QaykBQv0FJ85JpfZRk2yABgblT/Dmja1nlj9cN/MnbYP77qxpSWscKDmkWZc
         ZZgSDsb+H1Qyk+hOtAA/aq8VWFJeJXCDZayJn6kEAUdZZubiGHguxWp4SQn8QSycnX75
         Z+LA==
X-Gm-Message-State: AOAM531VHpjDGlzjL5W6PC9xJwosFCmPTCs6miLklLCDT3g5HK0cnnEL
        k/+3ZadoUCujmJ9e/G3Vg66HgED+5AWRPg==
X-Google-Smtp-Source: ABdhPJyKSj/EPhkNrPglsWOnUo7HmALHeiCEKa1JUwVsIRItBN3YBO1aV0JZNBbJOGoetOictm11uA==
X-Received: by 2002:a19:ae1a:: with SMTP id f26mr16899311lfc.390.1618402359833;
        Wed, 14 Apr 2021 05:12:39 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i4sm4338061lfu.33.2021.04.14.05.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:12:39 -0700 (PDT)
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
Subject: [PATCH 6/6] kvfree_rcu: use kfree_rcu_monitor() instead of open-coded variant
Date:   Wed, 14 Apr 2021 14:12:26 +0200
Message-Id: <20210414121226.2650-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414121226.2650-1-urezki@gmail.com>
References: <20210414121226.2650-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To queue a new batch we have a kfree_rcu_monitor() function that
checks KRC_MONITOR_TODO bit and invokes kfree_rcu_drain_unlock()
to start a new batch after a GP. Get rid of open-coded case by
switching it to the separate function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 012030cbe55e..14e9220198eb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3680,7 +3680,6 @@ static unsigned long
 kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu, freed = 0;
-	unsigned long flags;
 
 	for_each_possible_cpu(cpu) {
 		int count;
@@ -3688,12 +3687,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 		count = krcp->count;
 		count += drain_page_cache(krcp);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (test_bit(KRC_MONITOR_TODO, &krcp->flags))
-			kfree_rcu_drain_unlock(krcp, flags);
-		else
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		kfree_rcu_monitor(&krcp->monitor_work.work);
 
 		sc->nr_to_scan -= count;
 		freed += count;
-- 
2.20.1

