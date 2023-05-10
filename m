Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730BC7EE25
	for <rcu@archiver.kernel.org>; Wed, 10 May 2023 16:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjEJQvV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 May 2023 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEJQvT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 May 2023 12:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B986BA;
        Wed, 10 May 2023 09:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5564163F1C;
        Wed, 10 May 2023 16:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B271DC433D2;
        Wed, 10 May 2023 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737477;
        bh=KUL1vcxfqxgqiiPaLhc5SP0hmmPIpxfJ9zgCriCqIVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDebFwdjgO8FJWuCw/yQ9uxcNy6Yb5/O1wArtwLEdGfPzQFB0rirVM39ODXptVIdy
         0WI7HgN1uS5UxA3sEUtc/Y5aaQi02mic7+DP6kpkCnAjd85yS6jbYmbCS8BFg1g2kb
         K3X2kU1inayBDAgGk4OXQiJa+UfsHjfmKb6+IvjuJisgREPKPy/iqVmfE6KfpoBSJl
         iSxTo2P1zbs7T6VYuLZAq5MF8dXjUwW93GwuoOo/TLgLukZXDroaGWjERqQNP+cdg9
         LSODelVV2uKBMH/ychWoWIleCTAvBvx4Ne2mS7PA3QA9KuNxMnTqAn2VEYveFvss4w
         sK3rxT2LDTgEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 61A46CE1279; Wed, 10 May 2023 09:51:17 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/3] MAINTAINERS: Update qiang1.zhang@intel.com to qiang.zhang1211@gmail.com
Date:   Wed, 10 May 2023 09:51:15 -0700
Message-Id: <20230510165115.2187040-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
References: <16136ef4-9437-442b-b7c8-3fb6b2120873@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The qiang1.zhang@intel.com email address will no longer be used, so this
commit updates to qiang.zhang1211@gmail.com.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..8af0aabe9bf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17778,7 +17778,7 @@ M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-R:	Zqiang <qiang1.zhang@intel.com>
+R:	Zqiang <qiang.zhang1211@gmail.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.40.1

