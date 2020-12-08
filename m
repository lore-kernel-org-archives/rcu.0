Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C366FC433FE
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4C723975
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 14:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgLHO6v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgLHO6v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 09:58:51 -0500
Date:   Tue, 8 Dec 2020 06:58:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607439490;
        bh=2DK5VJbB1dLxPU5eq82tpm0Zqe5mMOFjP1U3f6Jru40=;
        h=From:To:Cc:Subject:Reply-To:From;
        b=kf71kpUiFeZL6OJWEiBf/Ws8izbgwiovyXTtRpkPowtWc/LlGJqsHAZk3fsFL9VZb
         A9eM3y/pHEIxHNrLjLgMzwn8VOxy3YRAJWKz3dpgmTspj85npP4gAXkJtWhMNCFXXe
         NwwKq58BZe4WjDkqAyRtrnmCY7kQvZBMW3CZnpIh2UcNQ44poLNGnN/6Fv9p4xAUTi
         ttXKNqJFoQ/iFsKS11BRhvQpj++cSxwxfyLJCewDMdvbgehWVdU4Xp2vH3LlWKwPau
         oCZQxrhUVwqAjaZUuU1kwrP10jj+rUNzshTNYiXKXR3syNn+2CneEHkucKjUTfKJU1
         wi0u9tgb9v3lw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201208145810.GA4875@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Frederic,

Boqun just asked if RCU callbacks ran in BH-disabled context to avoid
concurrent execution of the same callback.  Of course, this raises the
question of whether a self-posting callback can have two instances of
itself running concurrently while a CPU is in the process of transitioning
between softirq and rcuo invocation of callbacks.

I believe that the answer is "no" because BH-disabled context is
an implicit RCU read-side critical section.  Therefore, the initial
invocation of the RCU callback must complete in order for a new grace
period to complete, and a new grace period must complete before the
second invocation of that same callback to start.

Does that make sense, or am I missing something?

							Thanx, Paul
