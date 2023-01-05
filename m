Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D2CC53210
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjAEAKQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjAEAKB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9443A32;
        Wed,  4 Jan 2023 16:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3585B81980;
        Thu,  5 Jan 2023 00:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7389CC4339E;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=0etIo6hBjooXT6XtfpnKLk00LP5yH/3ZBijhs3GTztk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUnjV/KbazTXNXp3MyXoNTfMfc5z1c0VQmlRw8Kiyih+n7dYcRBhcPyVnyzNsq7rw
         s2kQmfcaxtwiBk2EN0kPbBPVrGRunRgDo4Yb9dLrzXfi67QBmsytKYjQeMaKQMipw7
         EXNpIGlYdJvIxZ3sMuT8taahFKM3ayenjPMVqSQrhcdlZ9DatEGtkA+/wVL40R8t0I
         ivB4IuDaqlOKr3+X5lwQozkWg+1xK7N/UCvyfNKZWUpcHN02g3IUQSf9nFJqn3XsxU
         lnPjC2hgjXDcmSRYMkdZJkQG2XU8Geh/w81H9DcRMTiDKcLmEASg6TvVLXmdEcOcO/
         hjk49VXyz2DJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CDA165C1ADF; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/15] doc: Update rcu.rst
Date:   Wed,  4 Jan 2023 16:09:46 -0800
Message-Id: <20230105000955.1767218-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit provides a couple of updates based on the inexorable passage
of time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 3cfe01ba9a494..381cb86f657d8 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -77,12 +77,13 @@ Frequently Asked Questions
   search for the string "Patent" in Documentation/RCU/RTFP.txt to find them.
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
+  Many (but not all) have long since expired.
   There are now also LGPL implementations of user-level RCU
   available (https://liburcu.org/).
 
 - I hear that RCU needs work in order to support realtime kernels?
 
-  Realtime-friendly RCU can be enabled via the CONFIG_PREEMPT_RCU
+  Realtime-friendly RCU are enabled via the CONFIG_PREEMPTION
   kernel configuration parameter.
 
 - Where can I find more information on RCU?
-- 
2.31.1.189.g2e36527f23

