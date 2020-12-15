Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B4C4361B
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F22224D2
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 14:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgLOORm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:17:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLOORk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 09:17:40 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608041818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RAV3hT3c/OjUGYMCYa2Z2W/+/rYfZiZcYK0ociYgg0=;
        b=IFsfe4EFmd2I7ViY0c1iqt5EyDnL72Jam3bIYc9jB12vyKpwp3HwePeBEMqTEZTX5rvD8C
        VYU/U27IGgCdamBaTb0EJ+llJrshQ2SDQpQDPiYfzFyL0z+AP6cbUWc3701SqYcuzcW+Ce
        0bqbe1FOzELnuybKNNPHgFruy6jraWw0UyT+WzzsuFKXAl4PKP2LvnPNnwB84YwX35C76K
        wbBAdJs1qqebrq7ih3O19PkCaSuRGvB9p8UihWnKEAq9QjbO0ZPu1bu9eaQRhvQ5HIQplY
        POLJkuhMEyE3FSEMLi6luV9gWxx80Nibw3DCVVxG+WCP4oehSJqNkeuafBRr0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608041818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RAV3hT3c/OjUGYMCYa2Z2W/+/rYfZiZcYK0ociYgg0=;
        b=YKkvDNaghf67fFlm53WOzC+WnzLOxsTA4q3+EIc7kleO/Khkgt8sIJWVai5YHHDF01SiAv
        iO5A6vghBtNNAfBw==
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] doc: Update RCU's requirements page about the PREEMPT_RT wiki.
Date:   Tue, 15 Dec 2020 15:16:48 +0100
Message-Id: <20201215141649.796472-5-bigeasy@linutronix.de>
In-Reply-To: <20201215141649.796472-1-bigeasy@linutronix.de>
References: <20201215141649.796472-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The PREEMPT_RT wiki moved from kernel.org to the Linux Foundation wiki.
The kernel.org wiki is read only.

Update the URL of the active PREEMPT_RT wiki.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Docum=
entation/RCU/Design/Requirements/Requirements.rst
index 95b68c107a8fa..e93cdc476e008 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2317,7 +2317,7 @@ decides to throw at it.
=20
 The Linux kernel is used for real-time workloads, especially in
 conjunction with the `-rt
-patchset <https://rt.wiki.kernel.org/index.php/Main_Page>`__. The
+patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
 is inappropriate. Kernels built with ``CONFIG_PREEMPT=3Dy`` therefore use
--=20
2.29.2

