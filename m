Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D54C4338F
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFE360F25
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhHJIsv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236828AbhHJIsv (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 10 Aug 2021 04:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PKUTk+76laugq4Cr2nwyksE4Heb04pD9E5SNbJNctsA=;
        b=UG6URQNx34V2H1IjPgI6xFkUJAf0uPlvfjWMOw8b1WXga4iVJ2j3pjbElit1Y3Ac4eRzdz
        zRqvz6WSM9zx7iDX/s3rlMmRadPU5/XUX+ka/fZ4D4yPFxJ65HAhbBEP1uYSIQg2ufZY2Y
        qghJV75Gyj+8NSdixBkcVOOcvKTUqRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-fRNDOGlPNrWlC-vuOTpuFg-1; Tue, 10 Aug 2021 04:48:28 -0400
X-MC-Unique: fRNDOGlPNrWlC-vuOTpuFg-1
Received: by mail-ed1-f69.google.com with SMTP id l3-20020aa7c3030000b02903bccf1897f9so10418005edq.19
        for <rcu@vger.kernel.org>; Tue, 10 Aug 2021 01:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKUTk+76laugq4Cr2nwyksE4Heb04pD9E5SNbJNctsA=;
        b=ZHzNWFCam9R6C1AKJSPQHe63CWHPMVD+ve07KBM7PM7AFKPUx5N5MsiM5KU0VE6B60
         trFZ6Fl0qCAolstJhXusWIto4ktxfCdLZS+Osyrs8IEneVUUPycQ6Sngcx6kbFblMER6
         CD0+DHEqYJoQ7a5ppgxqjBaF7G0miGs8EYg75AsKbq5o4hjvw8myL07IS1+qNeshSMYU
         Oc6nPSu5q36aPmzwvX5hMZbkYgz4TBn0sjjTqQlEd1JDgHBPz6iR3huqOTg0oSJI0xIv
         dX+Z92iGGSY8bLidLZk0giNDGJ2mok7qR89Q1S8X+ixeTjU0JhKs+FryUPb/jV9kKLAh
         IHMg==
X-Gm-Message-State: AOAM530ZKq16/b9AXp39io+97DWVu2/zHHXP33ZaUMXTtZFTmQ3snU/U
        LI1VNwO5j50kzEwc1tC9Zg6OHk2kQVXH42XstA/KohrKhUJEn4GqG+Q4UPpl9qNxvxRythPNVOy
        fTmlCt3oj/9ET
X-Received: by 2002:a17:906:cd02:: with SMTP id oz2mr1164204ejb.227.1628585307148;
        Tue, 10 Aug 2021 01:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyheDIpLjXKFM5u8jw6L0eI1kwX1Dc7r3iPjoVrOT6gQ4QtZ8X7tCUI7yirfMTRZQ9clwv1nQ==
X-Received: by 2002:a17:906:cd02:: with SMTP id oz2mr1164195ejb.227.1628585306983;
        Tue, 10 Aug 2021 01:48:26 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:26 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 0/2] rcu: Make rcu_normal_after_boot writable again
Date:   Tue, 10 Aug 2021 10:48:14 +0200
Message-Id: <20210810084816.155203-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

v2 of a proposed RCU change to make rcu_normal_after_boot feature usable
on PREEMPT_RT as well, as it turns out it's useful on RT as well on
NO_HZ_FULL configurations.

v2 gained an additional patch to revise rcu update module parameters
permissions (as suggested during v1 review [1]).

Changes wrt v1:

 - Restrict the option to !PREEMPT_RT || NO_HZ_FULL (Paul, Sebastian)
 - Change module params permissions (Paul) (02/02)

Thanks,
Juri

v1 - https://lore.kernel.org/lkml/20210805080123.16320-1-juri.lelli@redhat.com/

Juri Lelli (2):
  rcu: Make rcu_normal_after_boot writable again
  rcu: Make rcu update module parameters world-readable

 kernel/rcu/tree_exp.h | 1 -
 kernel/rcu/update.c   | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.31.1

