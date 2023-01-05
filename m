Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E5C54EBF
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjAEAlC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbjAEAir (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4ADC1B;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 572E66189F;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8101FC433B3;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=zkZ8AeyBUD5bYoynief0pjvU2ogx9k9CKTyFXK04KFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAGp6iX6SICmhEgIb67V031ubnOM0MV1K5lobMNAnmlW34LbWtnogmY/XfPXXDETs
         ggYVRNmjieSnYCCMF74DkpixYoDAVX2NfyWRtUZJMby0ETFdTLonlP/kyGvHSv9iG7
         ZJtj8RaNy8kQmYz7gyMeBORJ9Us4snlKwCYj25UsbxWFzcfOGoBQZMxWmP+XYGOvzw
         nkPns3amJi3WdevHErd+0lm4CEpn6bujFtmkC3litt81KC9PdUIhd16cu7VGOSFGd8
         OMJn0ZGcy74/iR0EHj6bjTiM12mMuwl44nkijO8EhosMnC3pnxjigUpFWbuJT6fde0
         zVlcrGWrZk/HA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB5265C1C78; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: [PATCH rcu 12/27] drivers/devfreq: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:37:58 -0800
Message-Id: <20230105003813.1770367-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/devfreq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 9754d8b316211..3c4862a752b5a 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig PM_DEVFREQ
 	bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"
-	select SRCU
 	select PM_OPP
 	help
 	  A device may have a list of frequencies and voltages available.
-- 
2.31.1.189.g2e36527f23

