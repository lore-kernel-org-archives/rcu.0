Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789BC433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 06:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4434D206F0
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 06:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eero.com header.i=@eero.com header.b="mMuV++7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHaGmP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaGmL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 02:42:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F9C061575
        for <rcu@vger.kernel.org>; Sun, 30 Aug 2020 23:42:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so71850pfh.3
        for <rcu@vger.kernel.org>; Sun, 30 Aug 2020 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lePqauQjz9Sd2dUbMGeNvcTItQagQt9MRkoKef7xMoE=;
        b=mMuV++7kXi9DX4iUzgcE1l87I/NJm1DIKfEzEPkGIItjHYZmg/qZvA5Bj98Rdkhmj/
         WwWA3GyDuYKpVcv3CgtUoUNg86K79TX8txJoQ5T6+v5RPPhXso2d/cVeovgp7TYEmHNr
         yI0NiYcUl7bPBU7v6bsGSFU0w08apfXEy5ecM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lePqauQjz9Sd2dUbMGeNvcTItQagQt9MRkoKef7xMoE=;
        b=CuTQyH/VvKU26E8pj2CAa22gbc60xVPsJYuKT2f4lWd0i5qe/TGtaKk0jg+ogjIag1
         XI6LpKOBvRVTj2v945aG2jas3izwPaEUXrJplGCz9jNLJPJAABwp0G8lorosrKB6b0BX
         HoIg3Clt09StIo0EP+8K0ELQ3Wl72S876wmHU1sx5pUAg3qI9AwHd3EsHXBf2FaO+39s
         ouO1KX6iNe7+XkyZpqjSK8YXCjpf05D2RMTHftABYGIKAJHI2m27TxVaG4Bpxc+J7o7O
         8H1hkzW8IZVm7K6P9IMkEDmpVmboGPHpCopD9lzUaDKfFUve33lxFEW7I9xqaVXuEMd/
         8r6Q==
X-Gm-Message-State: AOAM531t8t1iY+Xmtgh+k2p5KeGY/a5A7JI7YJsYYuqza15z7djVRdhW
        m265m5VdgDEUpL7KHeBMdpkMOJnJlYjbvSkm
X-Google-Smtp-Source: ABdhPJzcbcXUZYCwB3meJr2TFj9fHrqbxRCp30+LZPJlad6BHtdL2x/t2akM9egg/i14APPq22uCaQ==
X-Received: by 2002:a62:3641:: with SMTP id d62mr172887pfa.82.1598856130951;
        Sun, 30 Aug 2020 23:42:10 -0700 (PDT)
Received: from ubuntu.localdomain (c-73-170-162-203.hsd1.ca.comcast.net. [73.170.162.203])
        by smtp.googlemail.com with ESMTPSA id o9sm6026346pjs.47.2020.08.30.23.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:42:10 -0700 (PDT)
From:   chao <chao@eero.com>
To:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     chao <chao@eero.com>
Subject: [PATCH] rcu: allow multiple stalls before panic
Date:   Sun, 30 Aug 2020 23:41:17 -0700
Message-Id: <1598856077-58603-1-git-send-email-chao@eero.com>
X-Mailer: git-send-email 2.7.4
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Some stalls are transient and system can fully recover.
Allow users to configure the number of stalls experienced
to trigger kernel Panic.

Signed-off-by: chao <chao@eero.com>
---
 include/linux/kernel.h  |  1 +
 kernel/rcu/tree_stall.h |  6 ++++++
 kernel/sysctl.c         | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 500def6..fc2dd3f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -536,6 +536,7 @@ extern int panic_on_warn;
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
 extern int sysctl_panic_on_rcu_stall;
+extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b5d3b47..2047423 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -13,6 +13,7 @@
 
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+int sysctl_max_rcu_stall_to_panic __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
@@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	static int cpu_stall;
+
+	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
+		return;
+
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f..1bca490 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2651,6 +2651,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#if defined(CONFIG_TREE_RCU)
+	{
+		.procname	= "max_rcu_stall_to_panic",
+		.data		= &sysctl_max_rcu_stall_to_panic,
+		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+#endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 	{
 		.procname	= "stack_erasing",
-- 
2.7.4

