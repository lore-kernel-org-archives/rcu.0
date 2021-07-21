Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BECAC6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CFE61222
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhGUTzp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhGUTzo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:55:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE5961221;
        Wed, 21 Jul 2021 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899781;
        bh=/wxAFIqgtYQFGYfLbqrm+AjM60PFfFL8F/IJVYY05ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6wLdHzQdQA9b+Q7t8p5rugcDKp1xiItcMS5fcijMHSVm7tn40BWoG1uk+lJDLPDm
         QEIDBcWfSov+0n0tuZLHdteLoEFM6ErUDzSpZrlEt8bA8AuNGxr4r1mAfk0wpQM0Lt
         dEwA248FToehssKv1m3fjeODvSe9FJpGyrm2shmuCdPv8yrM55kM0ZTTmyCeLPIoRZ
         JhWaVGgvi8zXcTkRAacRfYj2cAn4Gux/gnW9CtoALEATHR36nzTpoJH90/sBathc+T
         ibH91sx0w2bq7uEAsI4liji0bb9CQfecrqDKANOqo+kiS1jHlxwlt6u4d3+YKZX1aY
         NBaEEqa/7+j+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4C725C09A4; Wed, 21 Jul 2021 13:36:20 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 1/2] tools: include: nolibc: Fix a typo occured to occurred in the file nolibc.h
Date:   Wed, 21 Jul 2021 13:36:18 -0700
Message-Id: <20210721203619.3373350-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203600.GA3360826@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203600.GA3360826@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>

s/occured/occurred/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 8b7a9830dd221..13c194aeaf3f0 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1031,7 +1031,7 @@ struct sys_stat_struct {
  *     scall32-o32.S in the kernel sources.
  *   - the system call is performed by calling "syscall"
  *   - syscall return comes in v0, and register a3 needs to be checked to know
- *     if an error occured, in which case errno is in v0.
+ *     if an error occurred, in which case errno is in v0.
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
-- 
2.31.1.189.g2e36527f23

