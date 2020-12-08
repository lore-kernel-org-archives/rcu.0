Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35752C2BBCD
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BECE23A9D
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgLHKdb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgLHKdW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 05:33:22 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE5C061794;
        Tue,  8 Dec 2020 02:32:42 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id o8so16445004ioh.0;
        Tue, 08 Dec 2020 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4D59QsHWJqFC21FiVVLBULBi2/XT3U9WgcWBwv/M3U=;
        b=mjStu7Q0Du0ep2444KcREaNjizDLUWuAh5ixTJWEIfVloeTFC9F/Fv7bJQbUUiKhTv
         6mUEJUqM4NKkCir6NRIGQM+3h1qBREOXVQX5b669MVNsZxOoEMt2ktuyauUpi6mpED7e
         eNUD/cGjLe3G8fvI4QLfLBIkW9KRvdEPmrrBrI7wchCdhPye1d17My8vyjkvv+EF4+bv
         Bcez5RfKzTDM1juVNdGw02/elZ+x1Lp8jnvwRl+Or8mKarvAN5FoVkiSnsn5Vtv7SH5p
         VLyUDoa8eFA8vtr9d8UA4W4tM6frnFgzs1bzzpPztM+iJiTxblgH5TSYUIU1CgKZ8blg
         718A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4D59QsHWJqFC21FiVVLBULBi2/XT3U9WgcWBwv/M3U=;
        b=Ht9gWrDNv/047/SKQrTryIaB2XCyD/KzEa5t0tcJLgHVjWYliM+3hdWR5MxCrLAO9w
         xiXXOuAzJcLt+PHWP0zKtzYyfW8ezkX0zpcBj2KjnwgLZIMMoSnbhoxOSwb1Djlf3unV
         DzPs5QDt6riY77EGFCjZSLq5gY8+qnX3I80oT4YehddqsFkysaUAcx+wvgYSfFC/cdgb
         PshFtBdjZ1l9JicYrimHGVvDGaf5i2pKkiTOGwLtXATPDiHuTVo5ssu2c38InWZA+oWb
         ZxUjc0TMmSIw0D08tt1cIfFRcU7cB/yzwzDz/0ZB4np5i1uV5pRaSE2AK9o2fzydnr0C
         H6BQ==
X-Gm-Message-State: AOAM531SxvlboG2muQK7Ruf4VduBzRBmGpzE9UzFgV7n/Q0AeYLrjLhe
        eYne2ddj1K75B/KESMl30XQ=
X-Google-Smtp-Source: ABdhPJzmPK2SGHVXnuvkJkF96PnI0OFhjDTfm05vwoLmnaYuY4IYkur5MbrWKlsJd7UmOwD/6b415g==
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr24108972iow.66.1607423561701;
        Tue, 08 Dec 2020 02:32:41 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d18sm5502459ilo.49.2020.12.08.02.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:32:40 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7B93027C005A;
        Tue,  8 Dec 2020 05:32:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 08 Dec 2020 05:32:39 -0500
X-ME-Sender: <xms:RlbPX-FQi8Litr8X1aYqZG08FozLwdN74csPZTC2NIisKtFoagWTtQ>
    <xme:RlbPX9TdoAPmUx88ZacbVWYf7yo5h5Atw9UMvg6H1Q16Ly-ZLHxyudwISgekiJWVl
    II51NQZyWP1ecfgog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RlbPX6csrGHh1C_pIr2gVYbAanFUVQqOfeLwRBTMgV-UODnA02NA-w>
    <xmx:RlbPX8pnJIv5-jtPFhO5GCArN26zapx40hPRBkOENqkracdtsf8iIA>
    <xmx:RlbPX78c5bExALZQLRqd29TPiJppXJLDN7v-8DNSZZh6qtDvmQJ4bw>
    <xmx:R1bPX7APALn5y6VToNWaKei3DjqhAa8zpQZOjpLNSx-bfT6PLcoGNMZMjes>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFB8424005D;
        Tue,  8 Dec 2020 05:32:37 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC lockdep 2/4] lockdep: Allow wait context checking with empty ->held_locks
Date:   Tue,  8 Dec 2020 18:31:10 +0800
Message-Id: <20201208103112.2838119-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208103112.2838119-1-boqun.feng@gmail.com>
References: <20201208103112.2838119-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, the guard for !curr->lockdep_depth in check_wait_context() is
unnecessary, because the code will work well without it. Moreover, there
are cases that we will miss if we skip for curr->lockdep_depth == 0. For
example:

	<in hardirq context>
	some_irq_handler():
	  // curr->lockdep_depth == 0
	  mutex_lock(&some_mutex):
	    check_wait_context() // skip the check!

Clearly, it's a bug, but due to the skip for !curr->lockdep_depth, we
cannot detect it in check_wait_context().

Therefore, remove the !curr->lockdep_depth checks and add comments on
why it's still working without it. The idea is that if we currently
don't hold any lock, then the current context is the only one we should
use to check.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c1418b47f625..d4fd52b22804 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4508,7 +4508,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	short curr_inner;
 	int depth;
 
-	if (!curr->lockdep_depth || !next_inner || next->trylock)
+	if (!next_inner || next->trylock)
 		return 0;
 
 	if (!next_outer)
@@ -4516,6 +4516,10 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 
 	/*
 	 * Find start of current irq_context..
+	 *
+	 * Note: if curr->lockdep_depth == 0, we have depth == 0 after the
+	 * "depth++" below, and will skip the second for loop, i.e. using
+	 * the current task context as the curr_inner.
 	 */
 	for (depth = curr->lockdep_depth - 1; depth >= 0; depth--) {
 		struct held_lock *prev = curr->held_locks + depth;
-- 
2.29.2

