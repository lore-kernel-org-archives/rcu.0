Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F45C7EE22
	for <rcu@archiver.kernel.org>; Wed, 10 May 2023 16:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjEJQvV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 May 2023 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjEJQvT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 May 2023 12:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20186B5;
        Wed, 10 May 2023 09:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43278634B9;
        Wed, 10 May 2023 16:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DEFC433EF;
        Wed, 10 May 2023 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737477;
        bh=jremWaBHcocZsb/N0jgll7N8XO9CgE/u9SH2zaTMJSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E94C47tnPAk06/7Wxbj+rtqW4Sxkw4PtOBMIrIqe5eA9vsDA9sCm6I4Nl10H5/Rht
         3ucL9IopS19pcYlCivNvneuealJpqD0/DYxpzyKlShNvEudmuRbidZ80fb1zWfQIdj
         fjNCpy1hFhwQ0MNrUeVEmA1h7pelKDqOt1Fqg6RyqExqRmb8VJWCBIJZCd6CDi9zyg
         y9RwiFmzd7ss3aRyfS1LnIv/s4cpeMoKh9LoLIdfIf9TDxxmsMQ6d6kGdWNSsRasxO
         PPmEsQId5gqkl3moFyTgidTUh2A6gM8DUkaDglkBoMqFfg7RsLanonXT2Xeral1WhH
         X/VcTD6r0nS1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E5DCCE126E; Wed, 10 May 2023 09:51:17 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] doc: Document the rcutree.rcu_resched_ns module parameter
Date:   Wed, 10 May 2023 09:51:14 -0700
Message-Id: <20230510165115.2187040-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
References: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds kernel-parameters.txt documentation for the
rcutree.rcu_resched_ns module parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8a094e2fc381..c21245c0cce6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4861,6 +4861,13 @@
 			This wake_up() will be accompanied by a
 			WARN_ONCE() splat and an ftrace_dump().
 
+	rcutree.rcu_resched_ns= [KNL]
+			Limit the time spend invoking a batch of RCU
+			callbacks to the specified number of nanoseconds.
+			By default, this limit is checked only once
+			every 32 callbacks in order to limit the pain
+			inflicted by local_clock() overhead.
+
 	rcutree.rcu_unlock_delay= [KNL]
 			In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels,
 			this specifies an rcu_read_unlock()-time delay
-- 
2.40.1

