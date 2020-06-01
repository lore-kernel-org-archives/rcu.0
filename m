Return-Path: <SRS0=avCC=7O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B300C433E1
	for <rcu@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D43206C3
	for <rcu@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO3gY2aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgFASqi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgFASqO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jun 2020 14:46:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73733C061A0E;
        Mon,  1 Jun 2020 11:46:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f5so563889wmh.2;
        Mon, 01 Jun 2020 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bTIqwBCxL2U/AuHSchl2Q5kdZGMc+OIpa4Qkndupk1s=;
        b=AO3gY2aSYpIr7miNszRocL1B8IKVRQsr5DuPaB3DxvCp57x3TimWhBec0LeTmOd6N3
         GiA7u3UmbHRA+jbssGFkbt6AdJcYf6TEhXK63YQ9ha/ZmmxkJRbiV4GlwLxoWByOdOw9
         9kibdYByD7/3bk5jDN6qhejTMwSfdERgBFNx8cojtpE5uBREwgEsGXJRJtORt05Wp49t
         gGtC07WRCEOG+gk8L49hKbPpklhnPfhmrV/gQsxNiHfk2whlPiLrhvVVazhpu/jZ52Zn
         3H8BixGLMvxaiKKB2/snPODahcvJNlW1VIB3sq4Z3viSLfpmuoTtZn5C00HqULgaDEQM
         fUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bTIqwBCxL2U/AuHSchl2Q5kdZGMc+OIpa4Qkndupk1s=;
        b=mjFyCa/7qzUT5LJ3KkVevoqAANdR5PQbxhytYqaC4FYgmrPIu+ybGAh7Mpk5xMqlOa
         B+shsjFpyY6CnDTFKd33xJ02ZAMCmd7D/xQ/CFUZYyGXd2ZeUOX/RGyRDAjeb/vyUZYe
         wFDfkw0yX97QU+VdtmZ9lckXlMSJZR1CKVR6s9GlujeeMCEHrPNnaPDppeSnp7HPdbot
         Bu0o2z2iKOBaro/3ZfpGKjaeo35gKW4TVIe6eYEVR38wdRqk/5VuAGpuQLNj++IS6RXW
         dgV2Xpq7azobU2ID5CSG7GbRhPxDgo0wMAlE8KK2xrm9i2m3Yb6Sg3zLUgzESWieLlmQ
         e+Pg==
X-Gm-Message-State: AOAM5334bofqAZ+6MoQ+8K2PjiposAMBpXSBQUuFtJSIAZHHgqyImeVC
        SghzxQjWXcsMrLaj2+I8TVDe7cxhFauy
X-Google-Smtp-Source: ABdhPJymGmwUPWNgA1v1HyU8WSJ+QAkZ/DPCCviQi454TWuDORNhc+bapkUGeYgbF8kBUlZ9ajTBag==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr553051wma.157.1591037171943;
        Mon, 01 Jun 2020 11:46:11 -0700 (PDT)
Received: from earth3.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.googlemail.com with ESMTPSA id 23sm302229wmg.10.2020.06.01.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:46:11 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Subject: [PATCH 2/5] rcu: replace 1 with true
Date:   Mon,  1 Jun 2020 19:45:49 +0100
Message-Id: <20200601184552.23128-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200601184552.23128-1-jbi.octave@gmail.com>
References: <20200601184552.23128-1-jbi.octave@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

The root cause is the variable rcu_boot_ended  of bool type is initialised with integer 1
Replacing 1 with true fixes the issue.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 28a8bdc5072f..c18ae0cca512 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -193,7 +193,7 @@ void rcu_end_inkernel_boot(void)
 	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
-	rcu_boot_ended = 1;
+	rcu_boot_ended = true;
 }
 
 /*
-- 
2.18.2

