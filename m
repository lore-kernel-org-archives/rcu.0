Return-Path: <SRS0=l9jG=3S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC365C2D0DB
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E2C20720
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580325012;
	bh=gMB61TugbTETLOelIlSzb0zII7/V7zLdZi/9zcPYho4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xk2PPHOIoQ4mvlzYrcky3gVUV8AAgouNlpwp+FAkr1MgIlEDAmLnUwpEwRPaqm9sD
	 WHHyo1DTeS0MrjG+e0JGMqGh72w5SNirTcdw1w95N7YSoM5steNQ76c7Awijnq/8m9
	 8/y1fO56rC4LqLe0f2i6MqehLvVF2btd+VfmV7ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgA2TKI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbgA2TKI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jan 2020 14:10:08 -0500
Subject: Re: [GIT PULL tip/core/rcu urgent] RCU fix for boot-time splat
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580325007;
        bh=gMB61TugbTETLOelIlSzb0zII7/V7zLdZi/9zcPYho4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yDsJ83JoBjk5P4woSuPMxzxWfHR/cwCPSLREp191WVOCEx7KPUY99u/RFhTpeg1dB
         /bqvQfo/GbiNbJqKwN19+3p7F6Ozwfyeuav3b82r1crCml+GmJd0Anl7PZegFkU5Ws
         J2p2jCNNLK594nAY+vDpRsqapvBqB/Z/CENSRWX4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129120206.GA15554@paulmck-ThinkPad-P72>
References: <20200129120206.GA15554@paulmck-ThinkPad-P72>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129120206.GA15554@paulmck-ThinkPad-P72>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 urgent-for-mingo
X-PR-Tracked-Commit-Id: 59d8cc6b2e375ff486b030da6703b1d481e186e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15d6632496537fa66488221ee5dd2f9fb318ef2e
Message-Id: <158032500759.28574.17205140926246637211.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:10:07 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        a.p.zijlstra@chello.nl, tglx@linutronix.de,
        akpm@linux-foundation.org
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 04:02:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15d6632496537fa66488221ee5dd2f9fb318ef2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
