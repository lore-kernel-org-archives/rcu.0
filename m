Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB9C433EF
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D76610F8
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhKHKQC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbhKHKPL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0CC0613F5;
        Mon,  8 Nov 2021 02:12:25 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12E011EC0505;
        Mon,  8 Nov 2021 11:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dsN1KahJp/YRuwxssCUwC9tC2Gq1F8xatSCed4RDYK0=;
        b=XW0S8cGQlrUU7Sx4YYUUqYSl7rK+m1lQDApwNyNOhVz6vrJu/e7+P4U1bGfGXbfHMVDyXN
        Y8uAm5IJGhwoL4KDkc5TRE4CoSj0W1pCSeycHBn8vysOxc6YxxtvwQL1VenFJAU2VP+i1j
        f/aiTSo1F8b3Zq+KdJ76uCjinG24up4=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v0 20/42] rcu: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:35 +0100
Message-Id: <20211108101157.15189-21-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: rcu@vger.kernel.org
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5e2fa6fd97f1..0c1d631214f4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -101,7 +101,9 @@ static struct notifier_block rcu_panic_block = {
 
 static int __init check_cpu_stall_init(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block))
+		pr_warn("RCU warning suppress notifier already registered\n");
+
 	return 0;
 }
 early_initcall(check_cpu_stall_init);
-- 
2.29.2

