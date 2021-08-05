Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75FEC4320A
	for <rcu@archiver.kernel.org>; Thu,  5 Aug 2021 08:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82308610A0
	for <rcu@archiver.kernel.org>; Thu,  5 Aug 2021 08:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhHEIB7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Aug 2021 04:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239182AbhHEIB6 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 5 Aug 2021 04:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628150504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K2ghss8N4x5+qkA+P5j44zXDC0+0LL6Ii3eIbL81nCo=;
        b=RhYuf7WGRwH2LeAcDTkSwR6MRMb3FeFRGs5M7lD/VqWFjl987/i9qkfwuMOlYrkuq/TDNg
        ezG+t9sdXAlpcQBPir6nSCU9lhUeFpHs27TX3kSQ4jzwPy4+enKqGrQpUqcsP/ICXmMu9+
        ZRT7dC6oz2JOX0rVUmqQPbJlnGD12/Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-iIze_m5NMtCPAbK_mpivGw-1; Thu, 05 Aug 2021 04:01:43 -0400
X-MC-Unique: iIze_m5NMtCPAbK_mpivGw-1
Received: by mail-ed1-f70.google.com with SMTP id cm18-20020a0564020c92b02903bc7f21d540so2741771edb.13
        for <rcu@vger.kernel.org>; Thu, 05 Aug 2021 01:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2ghss8N4x5+qkA+P5j44zXDC0+0LL6Ii3eIbL81nCo=;
        b=ACQwN9Lxh8S9T7rI5IZJnPhJ36SWYuSP19BPtcRijpaYzucUHuj0NmkIZEQmUTypj5
         yYa/XTzbSYjJgEhO6k5gLdFsG5F0vhk0esMBlWSckp29cIukoQYMOQL03xTYV64vLuwC
         7tw0JkI8HHfg01B7Wr8I+cumfpdt5DOV2me2cZL5qrlEjwuoyBPA8L1zi+K53IRhMyUD
         g4KJz+GNWqv1CX6DwoCanx2W1n9fbN3grep07CBSmfLEUGEK+5kRaLtfk4pSpkz19hYi
         e53xV5DhxyCgwoKx70SxdAjYi+JyuGZKPIAiQzjO2TVLT0GXS4u1kW+x1S08MWl18Ls3
         x8FA==
X-Gm-Message-State: AOAM533PcCbF/X+qBcnyEtxXTz/oC3+AostGNybzotzbG6aVbBsXz+PA
        wx4S5ieTlKRRz1CsHDHidxZS8bLT7n3+p9g02Xt5PwxMX2iBmDYmN9yhk0kd3K6yVgWO/lRBnig
        o8DZLDulptmSq
X-Received: by 2002:a17:906:8443:: with SMTP id e3mr3653493ejy.46.1628150502341;
        Thu, 05 Aug 2021 01:01:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRZM+Kqhl+Aet0UV2RVMRB/Uaogk6zdAX2mcOhTRyejWYvAHB4AjPVaC92ipDE99MWEylOig==
X-Received: by 2002:a17:906:8443:: with SMTP id e3mr3653470ejy.46.1628150502187;
        Thu, 05 Aug 2021 01:01:42 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id n15sm1925851edw.70.2021.08.05.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:01:41 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] rcu: Make rcu_normal_after_boot writable on RT
Date:   Thu,  5 Aug 2021 10:01:23 +0200
Message-Id: <20210805080123.16320-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Certain configurations (e.g., systems that make heavy use of netns)
need to use synchronize_rcu_expedited() to service RCU grace periods
even after boot.

Even though synchronize_rcu_expedited() has been traditionally
considered harmful for RT for the heavy use of IPIs, it is perfectly
usable under certain conditions (e.g. nohz_full).

Make rcupdate.rcu_normal_after_boot= again writeable on RT, but keep
its default value to 1 (enabled) to avoid regressions. Users who need
synchronize_rcu_expedited() will boot with rcupdate.rcu_normal_after_
boot=0 in the kernel cmdline.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/update.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..0fdbf937edac 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -57,9 +57,7 @@
 module_param(rcu_expedited, int, 0);
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
-#ifndef CONFIG_PREEMPT_RT
 module_param(rcu_normal_after_boot, int, 0);
-#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.31.1

