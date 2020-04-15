Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4154EC38A29
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B9206F9
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415122AbgDOQAy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:00:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415127AbgDOQAu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 12:00:50 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOkSx-0005uv-Vr; Wed, 15 Apr 2020 18:00:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] rcu: Avoid using xchg() in kfree_call_rcu_add_ptr_to_bulk()
Date:   Wed, 15 Apr 2020 18:00:34 +0200
Message-Id: <20200415160034.662274-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415160034.662274-1-bigeasy@linutronix.de>
References: <20200415160034.662274-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is no need to use xchg(), the access is serialized by krcp->lock.
The xchg() function adds some atomic barriers which remain hidden in
x86's disassembly but are visible on ARM for instance.

Replace xchg() with a load + store.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b31b61721a9ff..04d11c49ff3b9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3079,7 +3079,8 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *=
krcp,
 	/* Check if a new block is required. */
 	if (!krcp->bhead ||
 			krcp->bhead->nr_records =3D=3D KFREE_BULK_MAX_ENTR) {
-		bnode =3D xchg(&krcp->bcached, NULL);
+		bnode =3D krcp->bcached;
+		krcp->bcached =3D NULL;
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
=20
--=20
2.26.0

