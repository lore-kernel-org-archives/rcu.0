Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D847C4332F
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhKXLGe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbhKXLGd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:33 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A6C061714;
        Wed, 24 Nov 2021 03:03:23 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l7so4629375lja.2;
        Wed, 24 Nov 2021 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRFZOZBISWVsMEfEfq8dVdCo/Tw4TaJob4DOCG924LI=;
        b=A2nc3TXjxPAEpbztlo4+XwswZ+OH5o66Hohyj6s7snVXMWyCT3Ta2oGfo0kVNWVvWb
         m0V7gcIdnpHG6/5TDTtqQRBob+723yNE3N5HyfNGDCf0AAQC4MgEa4gEJVOzQou1HaXN
         jk2y0qL2zMI8vmrpJhI3jK455vObdZXbePWLdG98juWaem7xyKAicvUQzFsXgsgO2tiM
         A5MzppLuvv8UZeHY9PGtiBOWgXFhpwJcbXkWUVOLrBBqm4uVGkZE+bcVgmEUB7x48Tkc
         LT82Y5E+WxoouBC3ESk2mUChcIc7zTqGzT7HCoH0cDViKIurOJcTH8ohSd+TQdhM/vgv
         Qckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRFZOZBISWVsMEfEfq8dVdCo/Tw4TaJob4DOCG924LI=;
        b=mDvsA5OPcY9dFV+Gb3ZiRFDoRRHHNk8We85gItW2p1Whn0m84V6/gxc0v2pepkYA6e
         p1vGg0UOiKoiJNrCu5H2td8yoxaGoGZLdvH15TOF4NTQu1mrve4tPtleBrOP300ZoOKa
         JgLakbG+xLhUt13sHAtYNnw7BGsDKMTlG7NTjXzwHTWMq/xkzFSzSDzjBeEXz+qRckH0
         2XnihEG7+8KgN8HY9yDlfBqVO4zvSYjvtErrt1k7SxwSsAWK7dRTs8JGlQhqko0ZrXrT
         Pmnycq3jyTBuJ8/8VbpFsheHcAwMP9ugfQE3ByfbogamTVsRKAQmHstXM2ZOLmHD6SQq
         F4sQ==
X-Gm-Message-State: AOAM532BVOOc8pES5sDg/zwHK9zu8Hdw/7kusDT+hwtmFytslNeSQRqU
        O6Th/9FdpZDxugem76C2LLdUAxXIWqm1608Q
X-Google-Smtp-Source: ABdhPJwDAj5txFUr6y64TXj1m4KFMEgmvd2G+IYDBYwUr/4r/62OB7eMlSBTF2eGkch1P6g7HyxonA==
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr14876402ljq.251.1637751801301;
        Wed, 24 Nov 2021 03:03:21 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:20 -0800 (PST)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 3/9] fs: nfs: sysfs: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:02 +0100
Message-Id: <20211124110308.2053-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

CC: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
---
 fs/nfs/sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8cb70755e3c9..ff88d5d58e1e 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -113,10 +113,9 @@ static ssize_t nfs_netns_identifier_store(struct kobject *kobj,
 	if (!p)
 		return -ENOMEM;
 	old = rcu_dereference_protected(xchg(&c->identifier, (char __rcu *)p), 1);
-	if (old) {
-		synchronize_rcu();
-		kfree(old);
-	}
+	if (old)
+		kvfree_rcu(old);
+
 	return count;
 }
 
-- 
2.30.2

