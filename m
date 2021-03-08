Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDEC433E6
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD3565227
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCHQwE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Mar 2021 11:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhCHQvz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Mar 2021 11:51:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39E6D65227;
        Mon,  8 Mar 2021 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615222315;
        bh=ePZ+lo+DDFaEUBCXUo9vIb22Wk5nFnarOctAWVQYEl8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=L5+ioNNhEuIO+S1QcbbP8a+7v46BtP8lc9dYQe+9CmC5Jv94VFXjax7FeHEbJukNB
         YcqqExLp8lrvA3XHWKvC+1KL9cID4rFDtiHSRyxG6hKUhWo6tPgg4WAtOo3aGD7Hjs
         4ZBAHB/EFlE42VSyRDdWwprNMtrLm6mt7IqIt/tsmy+tItcf/zHCqjaljNI7bvmuDQ
         GrrM6OxiPX1BSMv3wULfW1/GU8onGghiiy/JLOOfhfSmgYaBJ3p4E0FxrZG70KPojW
         Pucf7aA33eRqwb7pZ1BVdrHGv+IGgud1ZIpkRyfmX14HPBzta89UC6700bSv3lTQHw
         OXPyUhq5gPGTA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E0BB635239E3; Mon,  8 Mar 2021 08:51:54 -0800 (PST)
Date:   Mon, 8 Mar 2021 08:51:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: You see, rcutorture does not use swap, so...
Message-ID: <20210308165154.GA3545@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

I will be rebasing -rcu onto v5.12-rc2.  On the other hand, I well recall
when running rcutorture on -rc1 was foolhardy, so actually a sign of
progress [1].  And no, rcutorture does not use swap, so I have been
blissfully ignorant.  My fervent apologies to anyone who attempted to
run -rcu on a configuration requiring swap!

							Thanx, Paul

[1] https://lwn.net/Articles/848431/
