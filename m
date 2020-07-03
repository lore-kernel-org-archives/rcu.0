Return-Path: <SRS0=lcpH=AO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2532C433DF
	for <rcu@archiver.kernel.org>; Fri,  3 Jul 2020 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF78420782
	for <rcu@archiver.kernel.org>; Fri,  3 Jul 2020 21:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyRD3uMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGCVeA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVeA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Jul 2020 17:34:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC658C061794;
        Fri,  3 Jul 2020 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=4Z+X9rQ5enFegvrmP6F7+xzCAGqA6Q+IWHznK3Laj+E=; b=qyRD3uMrBpoxO7JobmBpj/Ntw8
        h0EM/WAF7X68bof1pEKvZ42tH8YZQoUecN/ASXAdkSxZaXd/unT+Hgq7MxyCZlN23t+vwSmutUt0T
        TV554CS1ZhhwYxg4gf90KKYNNZI9Qts6keaV+e7ZPdpoo37M0w5/WsE9lpo4L+Zlfynopw5e5qOEO
        J/kVK5FTnbESUKCMtF0fB6QBRYYq6Sn7awif/bAE7YsKXXKQjpFzIYi1l0fIfF4A/xVqokfWqNXVn
        DnWnookanKPd9iEooXXk+ae5PWAExqsi1NHmTiP27RsInoz5REfEDuY/N0Vk5G2DySXLcE1NV3xX4
        ie2AtBvQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTJl-0006YP-D5; Fri, 03 Jul 2020 21:33:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 2/2] Documentation: RCU: Requirements: drop doubled words
Date:   Fri,  3 Jul 2020 14:33:42 -0700
Message-Id: <20200703213342.30842-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703213342.30842-1-rdunlap@infradead.org>
References: <20200703213342.30842-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

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
---
 Documentation/RCU/Design/Requirements/Requirements.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/RCU/Design/Requirements/Requirements.rst
+++ linux-next-20200701/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2162,7 +2162,7 @@ scheduling-clock interrupt be enabled wh
    this sort of thing.
 #. If a CPU is in a portion of the kernel that is absolutely positively
    no-joking guaranteed to never execute any RCU read-side critical
-   sections, and RCU believes this CPU to to be idle, no problem. This
+   sections, and RCU believes this CPU to be idle, no problem. This
    sort of thing is used by some architectures for light-weight
    exception handlers, which can then avoid the overhead of
    ``rcu_irq_enter()`` and ``rcu_irq_exit()`` at exception entry and
@@ -2431,7 +2431,7 @@ However, there are legitimate preemptibl
 not have this property, given that any point in the code outside of an
 RCU read-side critical section can be a quiescent state. Therefore,
 *RCU-sched* was created, which follows “classic” RCU in that an
-RCU-sched grace period waits for for pre-existing interrupt and NMI
+RCU-sched grace period waits for pre-existing interrupt and NMI
 handlers. In kernels built with ``CONFIG_PREEMPT=n``, the RCU and
 RCU-sched APIs have identical implementations, while kernels built with
 ``CONFIG_PREEMPT=y`` provide a separate implementation for each.
