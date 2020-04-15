Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485CC38A2B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B35D216FD
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970725;
	bh=H1/zidkF6OSM7TJ+p+RwiOuGN0FtwY/L1UE0AMqyfYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LdWLJfydzt6Dwxe5Y8ispmPzLmX3rpbyXQ6ZqgHqxAAPqPVUotLH2skEVUQR+hkCl
	 qATZGyhiWxGyLAZqPKy2FfLnyOYXCicZSP4n1gENGEqrHA4qJjrCi2Fzgg/Js9LWge
	 jEVNsa74IV26xQACmVVL15lxidihKSjVY+ajPymg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416397AbgDORME (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410713AbgDORLA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E04DA21D7F;
        Wed, 15 Apr 2020 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970660;
        bh=H1/zidkF6OSM7TJ+p+RwiOuGN0FtwY/L1UE0AMqyfYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoZe+h6RWlWA8uvwJhcfXgpfURFd3vZTfwS1pESTnDt11npJxbbuJy8jgmFsWBD+c
         WxRM1JsU5aA47X0lbAnpmUpA9Tc5g/vlbHWyD+7Aq/9MuQCJQypNyv8jzatGRLPFal
         YvUuUHgH1SbZXVANhS39YaQnb3pVdMsRVAUtsp/M=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/19] Revert "rculist: Describe variadic macro argument in a Sphinx-compatible way"
Date:   Wed, 15 Apr 2020 10:10:47 -0700
Message-Id: <20200415171054.9013-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

This reverts commit f452ee096d95482892b101bde4fd037fa025d3cc.

The workaround became unnecessary with commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 8214cdc..7375bb3 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -371,7 +371,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
- * @cond...:	optional lockdep expression if called from non-RCU protection.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
@@ -646,7 +646,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
- * @cond...:	optional lockdep expression if called from non-RCU protection.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
-- 
2.9.5

