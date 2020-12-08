Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBDCC2BBCF
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E9823AA7
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgLHKdW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHKdW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 05:33:22 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB8C061793;
        Tue,  8 Dec 2020 02:32:41 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id i18so16439494ioa.1;
        Tue, 08 Dec 2020 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FabaL5xm5fFsmGHDkfDL8iX94DTDCCNa78hK4W+xK+c=;
        b=jrTLE8FuoTXbQvzXx5llN+eCJSCqGStoXxtJKtDlFAabhB39KExKzy3CWjsG8pP8Bu
         uurnG4AXou9p6ipzlCkYTa2cJfxF+kklaR48/AMmJisTeSzqo6AQ0aXKf3q22FBrfwCz
         Ugd57vnS8aKWu0QmgYnrBGAOSHRc+rZf1B2RugsLYSke7SKJdsW85eduKcD+6eHkb9tK
         mG80nx4E5uAXQE4vC4eFNl8QHEBn4b/0+k1wqj+QH630E9frfImNjUrvXPdCvG/yePm2
         xLs9jJq+5lVNfjUS/8vFcIR69lBmb1yzmuni2xx9dJblXQyyJSd4jW+AhlKsHblL+0fY
         W3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FabaL5xm5fFsmGHDkfDL8iX94DTDCCNa78hK4W+xK+c=;
        b=RBMTG3Vs0MfJoJ19d+MNBsb6ywZ1ITrA971oIXu5qT1HWTiABAUycTW00KgTNsW16T
         Gajgmir3II/BOTQwRPLLamcRGCyplXxPdKQ20aq6PTh+RqdlDjj5DylXk7V77vZIJyGc
         a5gSo3cJEkTiHJs8rabZevH7QcuzyiHLDzQ5l9i1fzoH5+33fhZrLdwhJNgYdFXzr0QG
         b6i1/UX3nu0qk+bvJQNqMGpIpJQKsETAeK0+zNUOQPGAP57+fzJZrV0uxkPjSk9ysUuw
         0DEnAZ9aBy64xwTEIx+rQE0wqIH7p1jkd/QVaGb9SIw04P/Mt8UPpqmZc0GqHr7AZIi7
         AtuQ==
X-Gm-Message-State: AOAM533VzPYHPzHEzep6k/1MF3tcabkBU5xCiyatCsbq0dZ4VXmmje9E
        tDeKQVstz60CO+LnUMIOZSw=
X-Google-Smtp-Source: ABdhPJyvGKbJ+kY2oaNvWKWaxf7V3/svBmFi7JdtNexFCrO/itS9EAMdtGRgWFEiYnZdvnwPjyd2LQ==
X-Received: by 2002:a02:8791:: with SMTP id t17mr20415686jai.28.1607423561242;
        Tue, 08 Dec 2020 02:32:41 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t2sm9816087ili.31.2020.12.08.02.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:32:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3D8FF27C005B;
        Tue,  8 Dec 2020 05:32:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Dec 2020 05:32:39 -0500
X-ME-Sender: <xms:RlbPX-8mXE3YC8M8pYec8pc7re7y6PZ4WFQnk01RFsGD62qB7qjWSQ>
    <xme:RlbPX-tpgSlo8dcwzgRPwBrOETIBmcGa1efFR0J6f26diLpWklcClXOR2RR1WFZlx
    kCWkqCVHfJVfo4tZw>
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
X-ME-Proxy: <xmx:R1bPX0CTR1eFRZIKLvcoigcXzEPa8eCluVxg8gegpr_uS7nhWuACzw>
    <xmx:R1bPX2eeqPvMW_-fueFf0g4NZ58k3gIVllrZPX92jeULnpWOQ7p7YQ>
    <xmx:R1bPXzPAUzobxYWfBH2_snUmIYGf66l8Vi1Rg__PJyLCvqUT9YWzyw>
    <xmx:R1bPX0HFRj6N_F6I2uzQe7rW66kgcjQxVRr3fT6FRgPWAyxaCFGYnI9brDM>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id C59CF240066;
        Tue,  8 Dec 2020 05:32:38 -0500 (EST)
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
Subject: [RFC lockdep 3/4] rcu/lockdep: Annotate the rcu_callback_map with proper wait contexts
Date:   Tue,  8 Dec 2020 18:31:11 +0800
Message-Id: <20201208103112.2838119-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208103112.2838119-1-boqun.feng@gmail.com>
References: <20201208103112.2838119-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_callback_map is a virtual lock to annotate a context where RCU
callbacks are executed. RCU callbacks are required in softirq disable
contexts because with some config combination (use_softirq is true and
nocb is disabled) RCU callbacks only execute in softirq contexts.
Therefore wait context annotations can be added to detect bugs like
using mutex in a RCU callback.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/update.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39334d2d2b37..dd59e6412f61 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -269,8 +269,12 @@ EXPORT_SYMBOL_GPL(rcu_sched_lock_map);
 
 // Tell lockdep when RCU callbacks are being invoked.
 static struct lock_class_key rcu_callback_key;
-struct lockdep_map rcu_callback_map =
-	STATIC_LOCKDEP_MAP_INIT("rcu_callback", &rcu_callback_key);
+struct lockdep_map rcu_callback_map = {
+	.name = "rcu_callback",
+	.key = &rcu_callback_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* RCU callbacks are handled in softirq context */
+};
 EXPORT_SYMBOL_GPL(rcu_callback_map);
 
 noinstr int notrace debug_lockdep_rcu_enabled(void)
-- 
2.29.2

