Return-Path: <SRS0=lcpH=AO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C5C433E1
	for <rcu@archiver.kernel.org>; Fri,  3 Jul 2020 21:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C508920782
	for <rcu@archiver.kernel.org>; Fri,  3 Jul 2020 21:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2pdlL5uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgGCVd4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVd4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Jul 2020 17:33:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C6C061794;
        Fri,  3 Jul 2020 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Vuxc0AZ1aOD+7/2KPkVMGopdMJau4NZBmFMwxzUm9JU=; b=2pdlL5uHXIkqeCQOfc4OIggmi2
        yXQCAZkA80LlP2CxyWmDzYmVISCuS+FgtGo183c1XRfm6COfmosbMWgf83lrD3gwESMXpPPFsEo3p
        NcAU2K4xvi/1LNsGahOr6yHGHCh2q1z6bnqHM4pPGK6CAA1i/lRyr+HFCmBloGFNjOxKD08H7G9e4
        RG5Fh+jhWEkUZP/Z0nvESBGd8ImMBCtAXteEl4YTUllU81tlj5bbFFJblNNOs8/05iYnVwMU8mifv
        v5JrlT8bWUwpoFRVQoSihRxjRaf614+c1yR6l5vS+KFOHgmoWHH95UEL3IJEZjKGTJQgKiK7paTkc
        D9uxEDzw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTJh-0006YP-4l; Fri, 03 Jul 2020 21:33:53 +0000
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
Subject: [PATCH 1/2] Documentation: RCU: Data-Structures: drop doubled words
Date:   Fri,  3 Jul 2020 14:33:41 -0700
Message-Id: <20200703213342.30842-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703213342.30842-1-rdunlap@infradead.org>
References: <20200703213342.30842-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

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
---
or it could be changed to "then the".

 Documentation/RCU/Design/Data-Structures/Data-Structures.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ linux-next-20200701/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -963,7 +963,7 @@ exit and perhaps also vice versa. Theref
 ``->dynticks_nesting`` field is incremented up from zero, the
 ``->dynticks_nmi_nesting`` field is set to a large positive number, and
 whenever the ``->dynticks_nesting`` field is decremented down to zero,
-the the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
+the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
 the number of misnested interrupts is not sufficient to overflow the
 counter, this approach corrects the ``->dynticks_nmi_nesting`` field
 every time the corresponding CPU enters the idle loop from process
