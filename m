Return-Path: <SRS0=zrtj=4W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBAC3F2D2
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 22:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9845120801
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DeveEGgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCEWXo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:23:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:44301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgCEWXo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 17:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583446984;
        bh=LGz0Ac8M2VCBTBKcZ8Cfwh9vk3xuYtKImru4lo9VeqI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DeveEGgdJvCius7RQhsJdo1/YgH2ToK+TvWed9EoPc+smbnGfB+ScI8ZZg4v863Ew
         y84x2W3AHjCjlBKuxNwXWrh6m28d4wsFGquk34aIAuY2zQmgLgA95Rm8bBpP6H/DzW
         wR5LvhyOhGfYAaZ/+LAATha0X2skX2dKyz/QKmIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.153]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1j1yYE47sL-00AIgE; Thu, 05
 Mar 2020 23:23:04 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     rcu@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "rculist: Describe variadic macro argument in a Sphinx-compatible way"
Date:   Thu,  5 Mar 2020 23:22:55 +0100
Message-Id: <20200305222255.25266-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lcYis6IUbD9AoVz5IC9ajdFSVsnIDAIJYcwNlhjvJYmMaT3EFMz
 VwFhBw3Z8icfhHL5o7wo/23JyZWt2XcARlBkcYlgJxXlBB8VSEuwpkeS5aDlWLtdn5FJSCB
 WitTn+CjFA5J9AISGKWTrfK/yIhSqb6XWNnzlJsyvRjW+JB7tUXvr8u+3DTwg4UaLFaSpgL
 wmKgi4xLFYqRAOdiRwAfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qMJoParss7A=:JIqFDbLdbYdIYtJmy8sdXz
 A5iDrxV7UvXiY9FkdIbypNqSC9796zDTEtv939X2/x/+69V8bmuiI01QPgO9RPSH+J0CJG/9U
 MuOvVp7tBoaJzbU5fpVvA5By75xKX6c4EIzpWBPfQEJExL5oVMDDpo23zn7a8ETB+axr/F04u
 zZKCnHBwmnFb/0Rd/x2/h7u7iy7yYq7Qzy1OJcbSYQLh0XaVHEzp/aEInqV9FDYxiYXq3Agpp
 nnGXO9ICKu7YKDaFnj4ztGElj3m2W+JGbC7/mLX+5k8vcTy1Zud7ct+gRQ3eKUt4CZ04PGq4e
 eFGhn2bZaoQY682wuPwiTiT0rncOYHch+seVUbIyFHIW+c2WwLGVHWqWJj0FrOHSta/wTMW4G
 4U7o5+t2/ri3uWqBgv0Y+We3AQ7PYl4XEI85FjdQVJFhUotyGqiT4g/pT04HK867DIwG5qpfn
 j3/f0sBHYz0UKOCqa2pg5kHUJEC7GccIcvkF8RVD7k5OPbDIKyylGl2TfREE0dlmlC1OUSBSF
 Sz6kLoYXSMaAgMjqx4oPi7NpJqrOfWmlfammD/0wKnO1jWbwBvEinDnfQlnyoWXPyyfc+b50u
 cDWhVfr2cCe3tTa74FL7z+J/jcVJpBMBmfWpN4GlTGm7P5TcGKtKwncmm2FdGfBn7TaY83TzJ
 Kv0xpimUuXSFIx2Lp3J2qWyKKKQGRQFcGZk/4udr8JT5MbYu808fwUKJqoA+qn7XKBBspC3H+
 hXyVPJIQqd6qi485hP8jgPXK1BTNa0kc20iEnOTKkWwp8cOfORMt4zDcfbYo6en8/hwPcAxjC
 8hGVT9dQWitEvQ6Q12cEM6OZGYildEa7IpF+mV1u7e45NDWgfK+4vcgZb4FAqnRP/RMxZO5iJ
 rd7u5ETJtY02w9cjLGqhKKoD+M/Zpuo3DAO6Uts2A7DCznrjCRXASHk+cnEDCJtrclzWJMTt6
 vOBz6QTydhUqNxnPlr7wVpujzvwcH2ptKn1DQUtTv1qBOuRMmPzS9bOfiixMzFgPqNuN6Di/r
 EUBjNx9+hoSNWN+SEVralpFO+PG4Cs+hnWkO3FM3JEfA++9Mvv1oBBpMxs+4NMiC5sxYPdOFV
 pZq02nvpeLoPaG823z03FydrNvYGIQFcT7u4FUpZhuZ4sksmBxg8Z13qfsmVwsgFj2XMCmHK7
 BeSHFCgF5vsk53IgI/+btR1kvY7sBcUbZlwaq4pzXyE23kJmj7egk4+OGG3DjIxu1tQpf4b1D
 pQD+huMsZ/N7rbgZy
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This reverts commit f452ee096d95482892b101bde4fd037fa025d3cc.

The workaround became unnecessary with commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 9f313e4999fe..93accccb9620 100644
=2D-- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -371,7 +371,7 @@ static inline void list_splice_tail_init_rcu(struct li=
st_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
- * @cond...:	optional lockdep expression if called from non-RCU protectio=
n.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
@@ -646,7 +646,7 @@ static inline void hlist_add_behind_rcu(struct hlist_n=
ode *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
- * @cond...:	optional lockdep expression if called from non-RCU protectio=
n.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
=2D-
2.20.1

