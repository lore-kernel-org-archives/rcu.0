Return-Path: <SRS0=l9jG=3S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67817C33CB2
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 12:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385252071E
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580299328;
	bh=OxBv/uHgVr9/HqkUSFAjENjNm3fctbgRZ8dGInJ5ves=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=poiNmnj4w+YkdTbRnGOjlJXNxdopXtSWwfE+2OrsPx/T3mIT3ijdA4XGYoPzFvmLA
	 3mOQWASGtN8zyfPAfOKNGqd5EvTBit7C8nNj/esGnOCg9/ebkYxPFkHMO+LOf00Kpo
	 bgGc65/BaZmCHXMDk0mZ/m2WjNaTHxszRDGyiT7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2MCI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgA2MCH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jan 2020 07:02:07 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E032070E;
        Wed, 29 Jan 2020 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580299327;
        bh=OxBv/uHgVr9/HqkUSFAjENjNm3fctbgRZ8dGInJ5ves=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=eK4wOCcnIM4ISOPeO55LIgl6Zg9LUK8u/vHWXdDqdsEEkv8cUlDH6WJZMWaP9IiNo
         dHDQQzz9cklMLfxdYQo1P5uGxprxTGizLsfNfCCKD+hOWkDOPvCcHp6MDA9OXSyIii
         VVQT3tO5MobCWJ6GbQHZV/e0rWxxGfYN21/WJaMg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CABCD352276F; Wed, 29 Jan 2020 04:02:06 -0800 (PST)
Date:   Wed, 29 Jan 2020 04:02:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
        tglx@linutronix.de, akpm@linux-foundation.org
Subject: [GIT PULL tip/core/rcu urgent] RCU fix for boot-time splat
Message-ID: <20200129120206.GA15554@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Ingo,

This pull request contains a single commit that fixes an embarrassing
bug discussed here:

https://lore.kernel.org/lkml/20200125131425.GB16136@zn.tnic/

which apparently also affects smaller systems.

The following changes since commit 0e247386d9ed5ab8b7dad010cf4b183efeb1e47d:

  Merge branches 'doc.2019.12.10a', 'exp.2019.12.09a', 'fixes.2020.01.24a', 'kfree_rcu.2020.01.24a', 'list.2020.01.10a', 'preempt.2020.01.24a' and 'torture.2019.12.09a' into HEAD (2020-01-24 10:37:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo

for you to fetch changes up to 59d8cc6b2e375ff486b030da6703b1d481e186e6:

  rcu: Forgive slow expedited grace periods at boot time (2020-01-25 12:00:40 -0800)

In the meantime, I will go place a brown paper bag over my head.  :-/

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu: Forgive slow expedited grace periods at boot time

 kernel/rcu/tree_exp.h | 1 -
 1 file changed, 1 deletion(-)
