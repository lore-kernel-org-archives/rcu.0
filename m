Return-Path: <SRS0=v0Re=DQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D62FC433DF
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 06:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D889522251
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 06:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zleWHzII";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5vyvJZW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgJIGf5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Oct 2020 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732134AbgJIGf4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2960C0613DB;
        Thu,  8 Oct 2020 23:35:47 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=khxhsAbU45LYuHnIPGuwL3HaoaN0JNjjVfoNYv5j93s=;
        b=zleWHzIIPyDuo/YCJyOpIi32U7CH1gMXYkd57SP4NRgNLtNBJw4selyM59H7b/UOUxzvAX
        tua65wthccIlSjCJZsIxtJUgtsOtGmWhu8/uLso24/zsRg7/OS96NuOD8Qo9uWClni2pdq
        sfXqKl9dgMWUvf9XjT43QyBfLsK+6agYuNXLzdoSg3uNhisYW4Hnw2x0UV0jmt7t9h4inl
        rVT8KepgMZHXWQdPcSv1plZRBMyAjosZiL/yVY3xybiSwAxnexJ6foTYK1ok9SJJSM4aa5
        svxVE3Opp3eOSVine2VtJRIq5w4ytCJ0Ndoy084GWTFajMLDVZKOn95L35xh1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=khxhsAbU45LYuHnIPGuwL3HaoaN0JNjjVfoNYv5j93s=;
        b=5vyvJZW4FIufHHGXgjQZks2fTItx3HUYL0NMXBO0nyDFMabE6Tyxm0PXxMbOSmro1Uh7op
        rtrWspne3riG7KBQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Drop doubled words from RCU requirements documentation
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534557.7002.3373041201583952594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7f45d6f8ae383ed01070883b3c74ee51c9740065
Gitweb:        https://git.kernel.org/tip/7f45d6f8ae383ed01070883b3c74ee51c97=
40065
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 03 Jul 2020 14:33:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 14:29:17 -07:00

doc: Drop doubled words from RCU requirements documentation

Drop the doubled words "to" and "for".

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
 Documentation/RCU/Design/Requirements/Requirements.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documen=
tation/RCU/Design/Requirements/Requirements.rst
index 8f41ad0..1ae79a1 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2162,7 +2162,7 @@ scheduling-clock interrupt be enabled when RCU needs it=
 to be:
    this sort of thing.
 #. If a CPU is in a portion of the kernel that is absolutely positively
    no-joking guaranteed to never execute any RCU read-side critical
-   sections, and RCU believes this CPU to to be idle, no problem. This
+   sections, and RCU believes this CPU to be idle, no problem. This
    sort of thing is used by some architectures for light-weight
    exception handlers, which can then avoid the overhead of
    ``rcu_irq_enter()`` and ``rcu_irq_exit()`` at exception entry and
@@ -2431,7 +2431,7 @@ However, there are legitimate preemptible-RCU implement=
ations that do
 not have this property, given that any point in the code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows =E2=80=9Cclassic=E2=80=9D RCU in that=
 an
-RCU-sched grace period waits for for pre-existing interrupt and NMI
+RCU-sched grace period waits for pre-existing interrupt and NMI
 handlers. In kernels built with ``CONFIG_PREEMPT=3Dn``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
 ``CONFIG_PREEMPT=3Dy`` provide a separate implementation for each.
