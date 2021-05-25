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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4AFC2B9F8
	for <rcu@archiver.kernel.org>; Tue, 25 May 2021 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C59161417
	for <rcu@archiver.kernel.org>; Tue, 25 May 2021 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhEYJdw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 May 2021 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhEYJdw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 May 2021 05:33:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9E2C061574;
        Tue, 25 May 2021 02:32:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j12so22269448pgh.7;
        Tue, 25 May 2021 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Lb5zYLwrFrCEh5qo7xkBR6QBgvdORkPSIIhuNkZrZ4=;
        b=F4PcLZ1pnlMHAyIQZ2uEZ99XklRGiCEGtqIFXFGYATSxJirWmTDiejCdV2WjuoWDWI
         qTR9k1hkqOUp5KNnHKUfD314ZxxIglof5ZqmClKEW07dmO4hH2TJ0q9Xua9lMWEm2P6F
         zcEOrNyuEwvyKLunb8uPpGSA0oyFLJKLWF/LsZ0hz8wFc+xnylkIMHRzWBisCH56OnqQ
         7ZATHXgiUf0FHmBneHtb2GRP2j+gHgcdxDrVoMt4HGZoXlAM1Xl9RdhW9F5pUbbVfgRE
         6rHq8qXQnh8thx676vNeMmJiBsuwGWwJhC+3p3cm2sh+2z00nyJRN71MLCgVPjFprJN+
         Uj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Lb5zYLwrFrCEh5qo7xkBR6QBgvdORkPSIIhuNkZrZ4=;
        b=PDDDvDJcDK3tIhJphIht0UC1l/GJj9q9s7QegQi7rAZKm5+1w8ECPnvTRz3M6h/5AM
         2Z/FDMzzFrRmdEe6YUp4oufejfaMXX+/r3amBWlQW5Q8mrf8gL5oRzwp7A4xfhgkqSOV
         3NArZp0OeJO46ZyFerRZVZjOf4lxi5x4q2gK8djzj7hq++P2VIJDZUGA+xjGRPjCOCK5
         vp5XWl+vO8Quyd1wmAvFt8M64sfjYclK636l0Pe70Oz3qZYx3AjXI7TCIYWDm56BaOEl
         ebBKbNTPNndB1J7nbrMPWQR1P3kJIVaVMNwF+Bya+nVgq30ujhUNazwO8sPVT+45RNaG
         GFTQ==
X-Gm-Message-State: AOAM532WroNALAV1Q3Pk++QhrggrJkn7e3cCTNr+JpYFVDMBSkTmI/b6
        FZ1swRd+vDDWDVA4FimEOC4=
X-Google-Smtp-Source: ABdhPJwfvmT54j/T7oPQ3pny1gsG+uS07A8OjjRm2ztNz0tjF1g4gdFeomMEQiIrKN+df4fcXyZY1A==
X-Received: by 2002:a63:f50:: with SMTP id 16mr10130737pgp.373.1621935140754;
        Tue, 25 May 2021 02:32:20 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id p36sm13895550pgm.74.2021.05.25.02.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 02:32:20 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH] docs: Fix a typo in Documentation/RCU/stallwarn.rst
Date:   Tue, 25 May 2021 17:31:52 +0800
Message-Id: <20210525093152.26627-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add the missing ')' in the documentation.

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 Documentation/RCU/stallwarn.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 7148e9b..a9381e43 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -224,7 +224,7 @@ is the number that had executed since boot at the time that this CPU
 last noted the beginning of a grace period, which might be the current
 (stalled) grace period, or it might be some earlier grace period (for
 example, if the CPU might have been in dyntick-idle mode for an extended
-time period.  The number after the "/" is the number that have executed
+time period).  The number after the "/" is the number that have executed
 since boot until the current time.  If this latter number stays constant
 across repeated stall-warning messages, it is possible that RCU's softirq
 handlers are no longer able to execute on this CPU.  This can happen if
-- 
2.9.5

