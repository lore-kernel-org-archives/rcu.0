Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA70BC433E3
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8170214F1
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 16:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgGBQ2P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGBQ2O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 12:28:14 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C5C08C5C1
        for <rcu@vger.kernel.org>; Thu,  2 Jul 2020 09:28:14 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49yNn64kMxzvjcZ; Thu,  2 Jul 2020 18:28:10 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: RCU: fix typo in function name
Date:   Thu,  2 Jul 2020 18:28:10 +0200
Message-Id: <20200702162810.31227-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

s/sychronize_rcu/synchronize_rcu/

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 Documentation/RCU/whatisRCU.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index c7f147b8034f..fb3ff76c3e73 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -360,7 +360,7 @@ order to amortize their overhead over many uses of the corresponding APIs.
 
 There are at least three flavors of RCU usage in the Linux kernel. The diagram
 above shows the most common one. On the updater side, the rcu_assign_pointer(),
-sychronize_rcu() and call_rcu() primitives used are the same for all three
+synchronize_rcu() and call_rcu() primitives used are the same for all three
 flavors. However for protection (on the reader side), the primitives used vary
 depending on the flavor:
 
-- 
2.27.0

