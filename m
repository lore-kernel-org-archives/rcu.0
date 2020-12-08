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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D815C4361B
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A3E23A9D
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 10:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgLHKdU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHKdU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 05:33:20 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A7C061749;
        Tue,  8 Dec 2020 02:32:39 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so16472207ioo.2;
        Tue, 08 Dec 2020 02:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zasq3hOf488E8r9Qeq/ZBegpZO9Gd3Da9Wxnom9qujU=;
        b=MkzVELqW4gvyq69eepeuLTWDKPGtIDbI3eYq1IbMJNOu3JG6FCM1ONPULknnSkm0R2
         D66g1YXGnzNG5TPbb0Y6H5SZu0KtwKAo/Db8vXUuauGCoBsCZXVVbFgxs3RZyUrrC5/E
         CJ6da9SGcQLG0pCY9c3Fhx2fXEpi6m7fdKyGB0zluRZtQjCkFnkjjPhqzvFHjIVKE27t
         sfsHDbmoFf4UxJD/iT3CWlJ5NvDQ/MIP7jCb2HYOzYGiobKJCbsvVQAChl5oulE83b22
         FdEITo599wP0e3aunuwQFB+1SXze9W9CY+boIwIHAgmFsm1C0+MrPnzn/cOlgwAAuJAJ
         2BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zasq3hOf488E8r9Qeq/ZBegpZO9Gd3Da9Wxnom9qujU=;
        b=neDJCIYtvjfO1CNMR7dYe43UfmhhmGeqqcylwGj1YFQLjCdmKyqLtYF9WEhKw6byjV
         QIkvcCzoFJrJjvW04i2EoHPGovApPgjF8u2+/l0NQ8qdxlD/jyTxMoz4oL9myA8DicDh
         ZOVGcVqgr+fVdA5bnNcG6+rYsJuavStbZ5cLIBwwqHY1YSF5Q5SPi35EexOjSnNVqoAc
         OJY/dxtCJrSrl8iumy6C8mggmf3Qg1mXT14FabVadHRdP/Z3jqosD/IT6nsZ+Cdn1my/
         91ppM42I+ysiLncSO8xd1Kg6iiK4t4dpdhHVtgr+tiobNUjiRd038YyUu3skL3yMGMLF
         RoqQ==
X-Gm-Message-State: AOAM530xkIWYv0PhEV+SOr8VkACGEBrx7/OQs0tW3KB0X8T+xYMV8TGu
        wLkJZwcQZVYK0ddUTZQo5dY=
X-Google-Smtp-Source: ABdhPJy96YyUubZjhxhmB0SZGsED3HyHvkllSTg+UYZftnTs2dvpH0T+GNaNVrv8hWn2WGKbyAcMsA==
X-Received: by 2002:a6b:6f17:: with SMTP id k23mr24077438ioc.147.1607423559355;
        Tue, 08 Dec 2020 02:32:39 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c15sm7584349ils.87.2020.12.08.02.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 02:32:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3B81B27C005A;
        Tue,  8 Dec 2020 05:32:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 08 Dec 2020 05:32:37 -0500
X-ME-Sender: <xms:RVbPX3WCrkGvzNFgFYapxaEKYp3kfxvIyVPdaDLCIlilqWAOaopG7w>
    <xme:RVbPX4gDW34apDQUkrCNKmK5PfsSQSW4zxGef6S-JRvsuFDP1WZDsjjuRxHUZtsGI
    ZhOk6nVyqWmR7MXbg>
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
X-ME-Proxy: <xmx:RVbPX-_4hRk1ZKu9D9V82Oo9x3vPn7GD-P04aH6dSkgIS3kzyoLnBQ>
    <xmx:RVbPXyb5dvF3O6eP7PM__UVIMQayorb5pGO27-ICFXxjfhgLU9hjrA>
    <xmx:RVbPX92TS59YcZoTWsT1WKitQdWVNEq_B6-jGZsxlV0AGJnRp0nltA>
    <xmx:RVbPX04Uzn3NtM2Md0pFa3arqQbTjFBeBNYeTz9E01H5sByL-u-N3st2_OU>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04EC824005D;
        Tue,  8 Dec 2020 05:32:36 -0500 (EST)
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
Subject: [RFC lockdep 1/4] lockdep/selftest: Make HARDIRQ context threaded
Date:   Tue,  8 Dec 2020 18:31:09 +0800
Message-Id: <20201208103112.2838119-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208103112.2838119-1-boqun.feng@gmail.com>
References: <20201208103112.2838119-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since we now use spinlock_t instead of raw_spinlock_t in lockdep self
tests, we should make the emulated HARDIRQ context threaded, otherwise,
spinlock_t cannot be used in the HARDIRQ context and some test cases
will fail because of wait context checking when
PROVE_RAW_LOCK_NESTING=y.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index afa7d4bb291f..0af91a07fd18 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -186,6 +186,7 @@ static void init_shared_classes(void)
 #define HARDIRQ_ENTER()				\
 	local_irq_disable();			\
 	__irq_enter();				\
+	lockdep_hardirq_threaded();		\
 	WARN_ON(!in_irq());
 
 #define HARDIRQ_EXIT()				\
-- 
2.29.2

