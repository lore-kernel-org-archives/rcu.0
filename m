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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE93C43461
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFF6117A
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhDORUm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhDORUl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:20:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF96C061761;
        Thu, 15 Apr 2021 10:20:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m7so17165993ljp.10;
        Thu, 15 Apr 2021 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LUcBozN47KuuAJ5Mhrk/dB22oN6V76etPciyTAjUuc=;
        b=YwovzL7aD1rj++JhNoldrZH6/0OV4G8V2EJcSD2u0gQBk4Xfb5y9fSzX9PCUykuZjn
         ijJzoEENSgAMnjyDEx6yEK6aqMAXneLZOWEqhxaOdbHYNfspeYnk+lom9ZXuzRlCCBaI
         bd5eW0WVlRdItsIcVzHIpRn7LFODRYDvYSb8OlUYQeUJLqB1G8CqVg/tzMr805RJ3LW8
         DRIVT8UzBML7W7Fgb1QbdFV+YGEoaY2b3ONl4LKpoyDPKQ6thDp6T+FDaQGafjI+m8BZ
         Y8RY4ros/W3IKeiTDy1RkYzJfaJsn7MQERNatrNR24mj3O1vwg5ZL5yDKQzlEWwTRQTq
         vgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LUcBozN47KuuAJ5Mhrk/dB22oN6V76etPciyTAjUuc=;
        b=Ls41GT2r6VVJTNbSL4g+XLC/BL4brqTEZQJF5bpXT7fLclvZkIKSJa3VSG1LYcRYex
         dimZnRBDS1zzX9kU4ov6vuPCFA/QEK8VGaaN2urQp2K7NqGd2uduT43sIPXKFjB/uoEM
         BatonpD+uf+CW2tJ4kt7QU2qI/gT5k/1XjLidPREZ/T3sK2w6Xt9lgagCcah0xVyLrTj
         5yhgyjb44PRmlhtD/hg64ETpy09HaxhgJcZII2Dy4CSconbym3btKIxmq5Z7MsNbX7nH
         aeH8JafUdsaaJkCa4CZ+5i0ro0q7wkWETF8W4vvOErdKD0FKn9JPonpUitvf2PajiEzg
         urew==
X-Gm-Message-State: AOAM531YPM8xvKiruSwAAMjayoDupABdzAsh046xrK6PzA5gIqsx+LwJ
        klhuCZ5XzUJMWkITW0bYpC0GypDl6wsw1A==
X-Google-Smtp-Source: ABdhPJwUbelmAbtdf7qmGrBCyIKqUI+M15Nj/0nzI1P6pAB/Brjl8uZk4mIvutfi04o5brhn3uwM8Q==
X-Received: by 2002:a2e:7317:: with SMTP id o23mr157179ljc.250.1618507216124;
        Thu, 15 Apr 2021 10:20:16 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm84358lff.276.2021.04.15.10.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:20:15 -0700 (PDT)
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
Subject: [PATCH v2 5/5] kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
Date:   Thu, 15 Apr 2021 19:20:00 +0200
Message-Id: <20210415172000.15086-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415172000.15086-1-urezki@gmail.com>
References: <20210415172000.15086-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To queue a new batch we have a kfree_rcu_monitor() function that
checks "monitor_todo" var. and invokes kfree_rcu_drain_unlock()
to start a new batch after a GP. Get rid of open-coded case by
switching it to the separate function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 17c128d93825..b3e04c4fefcf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3670,7 +3670,6 @@ static unsigned long
 kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu, freed = 0;
-	unsigned long flags;
 
 	for_each_possible_cpu(cpu) {
 		int count;
@@ -3678,12 +3677,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 		count = krcp->count;
 		count += drain_page_cache(krcp);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (krcp->monitor_todo)
-			kfree_rcu_drain_unlock(krcp, flags);
-		else
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		kfree_rcu_monitor(&krcp->monitor_work.work);
 
 		sc->nr_to_scan -= count;
 		freed += count;
-- 
2.20.1

