Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF38C00140
	for <rcu@archiver.kernel.org>; Tue,  2 Aug 2022 16:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiHBQWm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiHBQWl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 Aug 2022 12:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A02914D3D
        for <rcu@vger.kernel.org>; Tue,  2 Aug 2022 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659457357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O3tsEKvxskgi9In/Fyj4bXLYVphFO38qknn8fDGj1Oo=;
        b=ASUspYOwu3cNXE4B+1kQQUwo4MhTdWQO2O6AMUnupZCSayQ4g74f16JoLtCD5fA9smipHV
        2k9HH1rK3M7M4UsFSTvfEqIgJ6Cld1Q8Ug2iHPLKWzTRm/KdEnVK0vUHKDTeC1I1o+c2FA
        SBpUs53Z/SEsraKGfwLA/la3O3bx7o4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-AdmL_DQ9NPylL4h9rfL0iw-1; Tue, 02 Aug 2022 12:22:36 -0400
X-MC-Unique: AdmL_DQ9NPylL4h9rfL0iw-1
Received: by mail-pf1-f197.google.com with SMTP id f9-20020a056a0022c900b0052e0e9cb3b2so143222pfj.16
        for <rcu@vger.kernel.org>; Tue, 02 Aug 2022 09:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=O3tsEKvxskgi9In/Fyj4bXLYVphFO38qknn8fDGj1Oo=;
        b=kAk2xdvyLBaDxOO1YGgjfNs7GH6FxLinuLJPFNufgoaVXhFKrxnzthxfiY9kngDJNC
         m8D1YM8NbYRzsSXY5qhSTaIf/D9IJdlffRiNEYWmb1UeMKnVOeJ808kMMp//qlG6y3b0
         +JLZA5hzNZZz/OWDNLcoiv4WPl/j1dHPN0i6s7tIEx5pEThuCxq+3gfKfwadlRZk9C1o
         roBbSydvXSkKpY5TrBRZqteuCrN5ei6CG2d/pAOzvdf1qfeydhlby0HmHSFJC17bYPoJ
         Q34Azkp3b6L2uchM2TFafXHm0sks/6Adt3vbxGmXQ/0XuGKoF0UibfgFa5O+utCIMuVi
         AwtQ==
X-Gm-Message-State: ACgBeo20ZnQFnYZkGfedhzXW/f9CLp1kU3rNPvGbGfd70SnbpSL0zb0t
        0ileAMAg/cdde9TvvKfG2mA0gSOfhhlEJakkqJEbxYlsmcmE9pD9yixkjsCCDK15Gnx0Vs0A2gi
        RlDU18QHuMGC8
X-Received: by 2002:a17:90b:390d:b0:1f2:4dbe:5f44 with SMTP id ob13-20020a17090b390d00b001f24dbe5f44mr253343pjb.27.1659457355673;
        Tue, 02 Aug 2022 09:22:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5r2Bfnmi/4f+Rd86nVyGuOIS5NmcCw3g6A/n5mcpUzWsdYZwfrpmAg/dDCyUCILR43VvmE5w==
X-Received: by 2002:a17:90b:390d:b0:1f2:4dbe:5f44 with SMTP id ob13-20020a17090b390d00b001f24dbe5f44mr253317pjb.27.1659457355413;
        Tue, 02 Aug 2022 09:22:35 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id z21-20020a630a55000000b00419ab8f8d2csm9342299pgk.20.2022.08.02.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:22:34 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     paulmck@kernel.org, frederic@kernel.org, neeraju@quicinc.com,
        josh@joshtriplett.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()
Date:   Wed,  3 Aug 2022 01:22:05 +0900
Message-Id: <20220802162205.817796-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

pr_info() is called with rtp->cbs_gbl_lock spin lock locked.  Because
pr_info() calls printk() that might sleep, this will result in BUG
like below:

[    0.206455] cblist_init_generic: Setting adjustable number of callback queues.
[    0.206463]
[    0.206464] =============================
[    0.206464] [ BUG: Invalid wait context ]
[    0.206465] 5.19.0-00428-g9de1f9c8ca51 #5 Not tainted
[    0.206466] -----------------------------
[    0.206466] swapper/0/1 is trying to lock:
[    0.206467] ffffffffa0167a58 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x327/0x4a0
[    0.206473] other info that might help us debug this:
[    0.206473] context-{5:5}
[    0.206474] 3 locks held by swapper/0/1:
[    0.206474]  #0: ffffffff9eb597e0 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic.constprop.0+0x14/0x1f0
[    0.206478]  #1: ffffffff9eb579c0 (console_lock){+.+.}-{0:0}, at: _printk+0x63/0x7e
[    0.206482]  #2: ffffffff9ea77780 (console_owner){....}-{0:0}, at: console_emit_next_record.constprop.0+0x111/0x330
[    0.206485] stack backtrace:
[    0.206486] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00428-g9de1f9c8ca51 #5
[    0.206488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
[    0.206489] Call Trace:
[    0.206490]  <TASK>
[    0.206491]  dump_stack_lvl+0x6a/0x9f
[    0.206493]  __lock_acquire.cold+0x2d7/0x2fe
[    0.206496]  ? stack_trace_save+0x46/0x70
[    0.206497]  lock_acquire+0xd1/0x2f0
[    0.206499]  ? serial8250_console_write+0x327/0x4a0
[    0.206500]  ? __lock_acquire+0x5c7/0x2720
[    0.206502]  _raw_spin_lock_irqsave+0x3d/0x90
[    0.206504]  ? serial8250_console_write+0x327/0x4a0
[    0.206506]  serial8250_console_write+0x327/0x4a0
[    0.206508]  console_emit_next_record.constprop.0+0x180/0x330
[    0.206511]  console_unlock+0xf7/0x1f0
[    0.206512]  vprintk_emit+0xf7/0x330
[    0.206514]  _printk+0x63/0x7e
[    0.206516]  cblist_init_generic.constprop.0.cold+0x24/0x32
[    0.206518]  rcu_init_tasks_generic+0x5/0xd9
[    0.206522]  kernel_init_freeable+0x15b/0x2a2
[    0.206523]  ? rest_init+0x160/0x160
[    0.206526]  kernel_init+0x11/0x120
[    0.206527]  ret_from_fork+0x1f/0x30
[    0.206530]  </TASK>
[    0.207018] cblist_init_generic: Setting shift to 1 and lim to 1.

This patch moves pr_info() so that it is called without
rtp->cbs_gbl_lock locked.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 kernel/rcu/tasks.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3925e32159b5..d46dd970bf22 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -227,7 +227,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
 		rcu_task_cb_adjust = true;
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
 	} else if (rcu_task_enqueue_lim == 0) {
 		rcu_task_enqueue_lim = 1;
 	}
@@ -256,6 +255,10 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+
+	if (rcu_task_cb_adjust)
+		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+
 	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
-- 
2.37.1

