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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF2C433E6
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A0364E02
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 20:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhA2UI6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhA2UGZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Jan 2021 15:06:25 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392FC061573;
        Fri, 29 Jan 2021 12:05:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m22so4478719ljj.4;
        Fri, 29 Jan 2021 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sa1Ma2Z8zuM8ysbfSP6MXLX2duLuO3ZQmjjAWLBtfAQ=;
        b=hWsGKuue+lwtwva/2VIQne2M9mPPUErX566HD/TqiZIdCyA+4xJhs/EZcRp/QxWh2Y
         3e+bP0B8IpmGTBX5rfvT7iTaBFKlRhvIAd7N9C0QHM+GywzA5Q9rUSOvohzOXIHFl1Mh
         p/E7apSbdLwL0zeFu8C6ykJqVuzp3RWFOtrCG8rju+93er6q/XIiNlb9gCPABqSfNwCb
         uoixfV3JMc5u23nMfnj7tjTK8HA8Va5E+hQV1WX+eeCgYv4s3hMiwEOMKqbfk5Dd3NYJ
         gtyq3K+Tleg8+w2WW9BJ7WFiaMXpK6NvKv7KvtMIz/xDm63c75K7q7qghSg1cyVBYGY5
         4yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sa1Ma2Z8zuM8ysbfSP6MXLX2duLuO3ZQmjjAWLBtfAQ=;
        b=lNKDzdap0AIhtjfPeBtRr1glNpWcrEhjx7cPJ5RNYIX07m6maZGURQXWtAR4eEq2MF
         wuk+1WgZQVhvoRXK8ztu2ShEDQdUBDWzqX1esLdYA8f/y22g4xlB8FlXl0+n0thHzTqJ
         RU0lY8XeqXqLforG+yRyziLiMwPlzqexyG3OM4+YhJNnYUJpYogpBOHWR+YRBynYz33H
         aTyo4gmK9aO6Qzy1EPaPkjsPj45abHoaYnIKNuhOo2zHyhH03ynGn5PNLMqHJCigf9id
         t5uDzz8dTx1K1Iz0bNimgBIa1Onc1iSIgFONBYIFrfcILZvRHmiQCPLNOQ+YoQB9b90I
         S3mQ==
X-Gm-Message-State: AOAM530JfgpMt02uE6cMBMuChtnp6lM6EeRemYnAeifctMcOVG0CiGd4
        Ua5NNF0/iJFPmGOff6XUBdYW1WRJtRr1Ig==
X-Google-Smtp-Source: ABdhPJw+ZRWWibh6b6CKvVjNl4MbzaBK8kIPdpxFfJRWSR/R5t9U0x+IeIOTXwcu7XOfEnNlJlPuWw==
X-Received: by 2002:a2e:300d:: with SMTP id w13mr3253506ljw.383.1611950716300;
        Fri, 29 Jan 2021 12:05:16 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n2sm2127387lfu.274.2021.01.29.12.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:05:15 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
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
Subject: [PATCH 1/2] rcuscale: add kfree_rcu() single-argument scale test
Date:   Fri, 29 Jan 2021 21:05:04 +0100
Message-Id: <20210129200505.5273-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To stress and test a single argument of kfree_rcu() call, we
should to have a special coverage for it. We used to have it
in the test-suite related to vmalloc stressing. The reason is
the rcuscale is a correct place for RCU related things.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 06491d5530db..e17745a155f9 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -94,6 +94,7 @@ torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
+torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 
 static char *scale_type = "rcu";
@@ -667,10 +668,14 @@ kfree_scale_thread(void *arg)
 
 		for (i = 0; i < kfree_alloc_num; i++) {
 			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
+
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			kfree_rcu(alloc_ptr, rh);
+			if (kfree_rcu_test_single)
+				kfree_rcu(alloc_ptr);
+			else
+				kfree_rcu(alloc_ptr, rh);
 		}
 
 		cond_resched();
-- 
2.20.1

