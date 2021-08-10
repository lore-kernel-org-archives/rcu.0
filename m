Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF2C432BE
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124E161019
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhHJItF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237554AbhHJIsz (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 10 Aug 2021 04:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yZNIu6PGRqh0XUsAg6YLnUrC7a2tSubYiI4yoIHuuI=;
        b=DMogTnkr9RUoD3rOw9m059GepuLU1xEQT/GkiFyNKDvjytvA2iwIa1QAHarVEi6WVVwDRr
        txflRtU/MavrsMFS5NHasucESODA439L1HHKh3Hrs07yU4lgqUc2f+ED26nBFJ+D3TqPNW
        Ce8OR/uRojn0WZTJoNDBKPWOR9iQqE0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-E8n9l5cOOhS_VrAIkSIROA-1; Tue, 10 Aug 2021 04:48:31 -0400
X-MC-Unique: E8n9l5cOOhS_VrAIkSIROA-1
Received: by mail-ej1-f69.google.com with SMTP id k22-20020a1709061596b02905a370b2f477so5332512ejd.17
        for <rcu@vger.kernel.org>; Tue, 10 Aug 2021 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yZNIu6PGRqh0XUsAg6YLnUrC7a2tSubYiI4yoIHuuI=;
        b=dEm7OnHJ2tr1qizBTN1pw3nXDfP4/UscPhyqujpKjnqkHULqKMltHOd6ZG7R31G0xB
         bOWPZcxJP2cM7gxaqnxLYT1mrvQX9RdCtT5Eri7K/LhiO0P9x1WBOaXDe39rZH49eHPF
         aSf0BCsrd3Rc9NokRpmhUVnfBUQSDbWX+kF4OSCe13BUbrsFEpZThnbtJI8iVz4nD1zm
         X3JDnPd4ZnPvWIjMU2ts63i5uz6EYU4qhTBH2MeTMXnO265O6HasPda5YkTqjDqOu538
         j5m5vuD58GYp99QfBWIQUXwORJxrXdLf0oJY7zYujlYXIlXw63IS61f/5b8LlZ0ntdQ1
         BK6Q==
X-Gm-Message-State: AOAM530q1IQhz85EV+RrtQGfjcACR0hrG3wyBrsnUBl3I3fe8U+0IOCS
        FlxdgzHteN/IZmN5PlQHgRjwWLhXTUFdhD8eyCrRgBI5QigcAw1rK59sYC3cyiO7mYgp1a86kfC
        qTlbVOUWXmx9p
X-Received: by 2002:a17:906:405:: with SMTP id d5mr26430805eja.189.1628585310191;
        Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz22EQal9Exqyj7ThilEjaTvbLq4Q2a5syoFgJGe/g8lj7NmDmRexbLX8nYJHLpkiLxzCdkUg==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr26430786eja.189.1628585310038;
        Tue, 10 Aug 2021 01:48:30 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:29 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 2/2] rcu: Make rcu update module parameters world-readable
Date:   Tue, 10 Aug 2021 10:48:16 +0200
Message-Id: <20210810084816.155203-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810084816.155203-1-juri.lelli@redhat.com>
References: <20210810084816.155203-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu update module parameters currently don't appear in sysfs and this is
a serviceability issue as it might be needed to access their default
values at runtime.

Fix this issue by changing rcu update module parameters permissions to
world-readable.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index bd551134e2f4..94282dc12bab 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -54,11 +54,11 @@
 #define MODULE_PARAM_PREFIX "rcupdate."
 
 #ifndef CONFIG_TINY_RCU
-module_param(rcu_expedited, int, 0);
-module_param(rcu_normal, int, 0);
+module_param(rcu_expedited, int, 0444);
+module_param(rcu_normal, int, 0444);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
 #if !defined(CONFIG_PREEMPT_RT) || defined(CONFIG_NO_HZ_FULL)
-module_param(rcu_normal_after_boot, int, 0);
+module_param(rcu_normal_after_boot, int, 0444);
 #endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
-- 
2.31.1

