Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFC1C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2F520A8B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617769;
	bh=Sf2yp4EI68k/6jB0qov6VM41DFTntD/BbUXns+ZCqNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmUFu7QOUNJmeL2tbSY7sExv8+qlkevbtyuYNSTlgrNrZ9iVwD7Emldj1vWuKEHNT
	 fYB0Q32/yBfHIOXnhGM8DLEOIOXki+BVg59/1nDelZ+8McM+1u7lIja+BlZbX4h3Jm
	 0UwvEysqGhRduzoIwfIZFk4E6z2mtixLM3Xv1XLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKEXJ2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbgKEXJ2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A99221FA;
        Thu,  5 Nov 2020 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617767;
        bh=Sf2yp4EI68k/6jB0qov6VM41DFTntD/BbUXns+ZCqNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVmuxILg5hInH/403ckgs0RUKD4coIUjiT/bfSfYqJHmmyLnDkXs8x8IJ6XrJGHsv
         RwTWDu6TUBy1pfWika2cCxfoCYkm+lApdvsKxcTdespSP3p/CVyQ3O2mhdT5fGar9j
         F71Klvp2MyJtR+cTAVq1ynvkLAez1KMloFr2nT0w=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Joe Perches <joe@perches.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/16] rcu/tree: Make struct kernel_param_ops definitions const
Date:   Thu,  5 Nov 2020 15:09:14 -0800
Message-Id: <20201105230921.19017-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Joe Perches <joe@perches.com>

These should be const, so make it so.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bf1513e5..a9b7c9a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -546,12 +546,12 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
-static struct kernel_param_ops first_fqs_jiffies_ops = {
+static const struct kernel_param_ops first_fqs_jiffies_ops = {
 	.set = param_set_first_fqs_jiffies,
 	.get = param_get_ulong,
 };
 
-static struct kernel_param_ops next_fqs_jiffies_ops = {
+static const struct kernel_param_ops next_fqs_jiffies_ops = {
 	.set = param_set_next_fqs_jiffies,
 	.get = param_get_ulong,
 };
-- 
2.9.5

