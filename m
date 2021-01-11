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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32AEC433E0
	for <rcu@archiver.kernel.org>; Mon, 11 Jan 2021 01:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D8221973
	for <rcu@archiver.kernel.org>; Mon, 11 Jan 2021 01:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAKBKE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Jan 2021 20:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAKBKD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Jan 2021 20:10:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B55C061786;
        Sun, 10 Jan 2021 17:09:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq13so6789977pjb.3;
        Sun, 10 Jan 2021 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9W27aDEcM2zclqETCrZa+HXBBxEceLbS1pDaUDxlwnY=;
        b=O74ymKZCnKUo7LJYtV6u42gGexQ/NcGqi6IhXI+q0cF7X08qR6JkA3KIpZVWTGsHYr
         5oqNAAJASR6FUFa+xDAiMiqOuX/9Fsdg9IPjpGRNQ0/UpI1pyKqZC0zjcO/hPWVYFRKM
         00lXr6DBAxegl0n4NOhqRdLZYwUk/udyOzpFsWQDPmusBI9O1HToCKVCBKx4QsQk6iNS
         0bi2vVERzOXRqafFTh55BXBuPjybB5q0DPSqcp7ZeogH5AbzFIizyDPwEGQ3UXF+2foJ
         EQ7/l/HIz9zzMUcIeN2em62JZTQNBAZr2uB9VSi0V6sD1fK+W2ai9zWoFY9rkrDiho2E
         ahIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9W27aDEcM2zclqETCrZa+HXBBxEceLbS1pDaUDxlwnY=;
        b=SH91FTK/OANgh231FLQkhAy/2BiiRMByS5gXxUFVLqUtWZ+EzKQHhylro7v8HKKSI7
         /C+LpquHsNUOUeekOGgGrw9ljFCUAIsOGrciCcBmnK2htqG3pdD+GPaCv/jGxpHuE4Ik
         ps6/zawOyk9v8KEsgjK82lUWCWntQMmmJvSSe2bnj937XAufzPTlb7t911X9X1cMaA2v
         IAkp9JzajEXMAV7kU2v4NqIuFAfgV1FMsYEpPPbMwgkXEOxvM+L7LXdiXPiaHJJl2q+5
         1yqWu91XA/Hp4SciKttCGoW3wVNV37BAoix4O/RMBY1A4TeFkGx0y9ALqp5GS1riqy03
         I3zA==
X-Gm-Message-State: AOAM532ubicpUtBx+ivmkRBLSA2l5fPZDovJI+j8YfPBhYbN8/Bkjj5e
        vIWhrSt1SKwBnMUP89BzxGc=
X-Google-Smtp-Source: ABdhPJwdM43NMBeAb8Gwnqd9m1yuUkJKRLjYG47J2cgNCRcY3pKLIUX6BLePfqo18RDLB+hkHjbpjA==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id u2-20020a170902b282b02900dafd057766mr14230591plr.52.1610327362467;
        Sun, 10 Jan 2021 17:09:22 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.18])
        by smtp.gmail.com with ESMTPSA id x5sm15659171pjr.38.2021.01.10.17.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 17:09:21 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     340442286@qq.com, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] rcu: remove surplus instrumentation_end in rcu_nmi_enter
Date:   Mon, 11 Jan 2021 09:08:59 +0800
Message-Id: <20210111010859.7778-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In function rcu_nmi_enter, there is a surplus instrumentation_end
in second branch of if statement, although objtool check -f vmlinux.o will
not complain because of its inability to correctly cover all cases
(objtool will visit the third branch first, which markes
 following trace_rcu_dyntick as visited), I think remove the surplus
instrumentation_end will make the code better.


Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3dd253e..eaec6f6032c2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1021,7 +1021,6 @@ noinstr void rcu_nmi_enter(void)
 	} else if (!in_nmi()) {
 		instrumentation_begin();
 		rcu_irq_enter_check_tick();
-		instrumentation_end();
 	} else  {
 		instrumentation_begin();
 	}
-- 
2.25.1

