Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797BC43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3377520EDD
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896504;
	bh=XYZ5OlzazNfJ+PLESdELLC4jtpXCFsDdXwR3nL+c5fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i06ZrtKd5wTsCl396vE55S+QS/TI3vEoeWWZuvremwSZvdM17ABZt7mmX/OlQAdFA
	 2lxUGNoYV4SmGGPShVG1rXj7ja9FxTLvW2FdmTsP6MkpA/S5+A+1UlurOVNRenzz1z
	 lfpFbhv0SFrfv7HdeQdXyPaTWeo3A0vEeMTCn66w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHaRzD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgHaRy4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 13:54:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD818214D8;
        Mon, 31 Aug 2020 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896496;
        bh=XYZ5OlzazNfJ+PLESdELLC4jtpXCFsDdXwR3nL+c5fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faC5HXtQQeWHwSAHyydELC+PIvoWp/Y7EMDmrgnw9ti2l/zk6PoGLsbpi5Qi3sAkM
         p6fKtXZ8ZGrd8EMEeM52otRYJ2bdNX/9mFAXfCfdjjXHzv/R8LvkYkvnnomb4NuSEI
         PwSy22BvLoP43MRccCaANtIwf9b5nFW7nNFjCWyw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] doc: Drop doubled words from RCU Data-Structures.rst
Date:   Mon, 31 Aug 2020 10:54:51 -0700
Message-Id: <20200831175452.32381-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831175419.GA31013@paulmck-ThinkPad-P72>
References: <20200831175419.GA31013@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Data-Structures/Data-Structures.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 4a48e20..f4efd68 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -963,7 +963,7 @@ exit and perhaps also vice versa. Therefore, whenever the
 ``->dynticks_nesting`` field is incremented up from zero, the
 ``->dynticks_nmi_nesting`` field is set to a large positive number, and
 whenever the ``->dynticks_nesting`` field is decremented down to zero,
-the the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
+the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
 the number of misnested interrupts is not sufficient to overflow the
 counter, this approach corrects the ``->dynticks_nmi_nesting`` field
 every time the corresponding CPU enters the idle loop from process
-- 
2.9.5

