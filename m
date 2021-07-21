Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592BCC6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3814361249
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhGUT2V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232638AbhGUT2U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C604261248;
        Wed, 21 Jul 2021 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898134;
        bh=lA/QHlL5d0jfUY7FayAW2eJWWfARJLcZWOiMrku0yGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ne4WvxF2bjOchRy0WZiPdbpDQR5i0Co6JaMZVfCnZigCOi24mBIkhoJjcMBbjVfxL
         2RHeNmUjpZT9rWqlrti/LlZbjNDd3eYJMkAlnoWteIgQl+/akVpwnO29mlH/rwm91v
         /aaRx+L1f+v/qtwbM4mBFvND1ueoFQBmrcIJ0+EDO22xRRWNV+RHv04Tr+7IcCvI50
         kYLGIANPmu19ScyLHAjKhUPQ3YNdoFmjaWwW4mT829vLUZNMnOxlhXwdsnr3/hc6cF
         oRy5Jj3Mxx3MtMD1K8kQs9tFs7v0GBorMNkAKX9I8CBTnnFqHd431P5RD9Y1u/+Wo6
         3z7wCjrEbsbVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 872B15C0A03; Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] Documentation/RCU: Fix nested inline markup
Date:   Wed, 21 Jul 2021 13:08:50 -0700
Message-Id: <20210721200853.1175189-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
References: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

To avoid the ``foo`` markup inside the `bar`__ hyperlink marker,
use the "replace" directive [1].

This should restore the intended appearance of the link.

Tested with sphinx versions 1.7.9 and 2.4.4.

[1]: https://docutils.sourceforge.io/docs/ref/rst/directives.html#replace

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 38a39476fc248..45278e2974c04 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -362,9 +362,8 @@ do_something_gp() uses rcu_dereference() to fetch from ``gp``:
       12 }
 
 The rcu_dereference() uses volatile casts and (for DEC Alpha) memory
-barriers in the Linux kernel. Should a `high-quality implementation of
-C11 ``memory_order_consume``
-[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
+barriers in the Linux kernel. Should a |high-quality implementation of
+C11 memory_order_consume [PDF]|_
 ever appear, then rcu_dereference() could be implemented as a
 ``memory_order_consume`` load. Regardless of the exact implementation, a
 pointer fetched by rcu_dereference() may not be used outside of the
@@ -374,6 +373,9 @@ element has been passed from RCU to some other synchronization
 mechanism, most commonly locking or `reference
 counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.
 
+.. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
+.. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
+
 In short, updaters use rcu_assign_pointer() and readers use
 rcu_dereference(), and these two RCU API elements work together to
 ensure that readers have a consistent view of newly added data elements.
-- 
2.31.1.189.g2e36527f23

