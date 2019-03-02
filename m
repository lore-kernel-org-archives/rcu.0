Return-Path: <SRS0=ZqZC=RF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B560C43381
	for <rcu@archiver.kernel.org>; Sat,  2 Mar 2019 08:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4CF20836
	for <rcu@archiver.kernel.org>; Sat,  2 Mar 2019 08:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvEVk5rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbfCBI5Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:57:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfCBI5Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 2 Mar 2019 03:57:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so157502pgl.5
        for <rcu@vger.kernel.org>; Sat, 02 Mar 2019 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AASO09S013pyKisQW6pFp4SixQF+H6IxPOg3z6XrL8s=;
        b=uvEVk5rH01yd1CCaW+JoYYL1XnHyOxpu0dUsf4ybdstMgfhPWiwEJZKTnhnGFcfLA3
         WGZE48Ba/d80Nom0QZ904QHVjZipAzzaNTxNOspw8NIefxpfsmxF5hoWhvZqiJkuKpqz
         FUnDkGS14Yl9vycax7b6uuMw7sp0ilpp4MIN7SjC2oTLFj9E2LYajGKaTOEnvRG2JRKm
         PfpHfuNLeUhGrjfiH2LzZbyifZiX9/5kLjb0vTmj5myNfShZoPYAekNWQYARdfRQpWyF
         MyOuVPEz2uBXpek/NmpLkS1p1R+eMt11Xf8QdKzze5P6cM1+rE8KH89o/u6GM0/gafFc
         1eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AASO09S013pyKisQW6pFp4SixQF+H6IxPOg3z6XrL8s=;
        b=tXOWE/rbGFl41kb7tB3DxoBFUrv10Vjkq93xkdnlymG63FO6/XW2ttq+K4t501Cs3+
         IvFiyL0GUycE49Zu+jELw3VtdbP2KGmF0+p9XWxXm2t1OOgRbmkY8o8NDJ8EvriQpuD/
         8B5zJEzSHVituo+1u/FvsJav37duOoQqRn9/ZMUZexhvcDoCF0bBoL6fowwz4z5CyG0O
         kA0+6SyvMXCBljKvUwEe9y378sZHs7aReTJ5toZ+G9Bv/jG+X6bXVLRzxl0EoTfWEZD0
         WWAnY4T30qs9eu8qMYYVewJub0lv+HvVtozVLd/Q8LjAT7fkXnod2axWStpanTEZDa3p
         zTSA==
X-Gm-Message-State: APjAAAW9LD8mXgR6ucjixet3c1U7ldmkTby2/1U7BTA6aAfvyaplPFkD
        uiT2eycMpuMFLrSvyXdZgJ83Qt9G
X-Google-Smtp-Source: APXvYqyrfp2PUi+W83GsnfiTYJTsdO/vd3cUVo+89QpXEZo3Yp9obdsmqSHKudkClCZbp0TcpCmzFQ==
X-Received: by 2002:a65:60cb:: with SMTP id r11mr9104308pgv.143.1551517043366;
        Sat, 02 Mar 2019 00:57:23 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c130sm934728pfb.145.2019.03.02.00.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 00:57:22 -0800 (PST)
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] rcu: Move common code out of if-else block
Message-ID: <9ee20ff4-c91a-89ce-eab3-62064ec31855@gmail.com>
Date:   Sat, 2 Mar 2019 17:57:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From 97f4bcece9a9beb792b623f847570144a0a71ccc Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sat, 2 Mar 2019 17:25:19 +0900
Subject: [PATCH] rcu: Move common code out of if-else block

As the result of recent addition of "rdp->core_needs_qs = false;" in
the "if" block, now both branches of the if-else have the same
assignment.

Factor it out and reduce line count.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
Hi Paul,

This patch is supposed to do the change mentioned in off-the-list
correspondence.  As the earlier change by Joel has not landed on
tip tree, I avoided mentioning the commit id of the change
(ac2baf64948d in -rcu as of today) in the change log.

Does this work for you? 

        Thanks, Akira
--
 kernel/rcu/tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7273ef0..449e8a4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1910,12 +1910,10 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
+	rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
-		rdp->core_needs_qs = false;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
-		rdp->core_needs_qs = false;
-
 		/*
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
-- 
2.7.4

