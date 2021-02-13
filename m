Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF31C433DB
	for <rcu@archiver.kernel.org>; Sat, 13 Feb 2021 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F964E2C
	for <rcu@archiver.kernel.org>; Sat, 13 Feb 2021 16:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBMQo7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 13 Feb 2021 11:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhBMQo7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 13 Feb 2021 11:44:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A161B64E3B;
        Sat, 13 Feb 2021 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613234658;
        bh=hBqZYS1HKSB8x0IF79tmfO8p4Il0RAPTJUBhjQOOphM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f/pXY/oSoT9fS+4YyM/Mn9Eq8Bd/3Vhde7nRnat5O/mjaRlac98nkDHGB/SyIIh7P
         z4EDXEMwVTYGSRdo3P0gODcPUqz7t0ZlS8qHNLCf/LfC8eVu7lg3AXRj4Y30pm4V/d
         coVul4B0hoHgWf1fItUVP9IUZJd6xkMkUQ2fqvt5BuJUR3ZPMOhQadjuGyYq2zS/N3
         VwsHnhxYK09kER8O6v2uyY6LJbqHbC17rE+tgy9q+vwWu7paiYIKRIUFxMYOdMrEZo
         rknLQ4G/H6kSYtCTJf9bo2L/IvlCvuGpB4gTE9Coy75hdw4C0vrJ8htJRa7hXMi9F4
         ZWVVeXaNwSqeg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 65BA53522F70; Sat, 13 Feb 2021 08:44:18 -0800 (PST)
Date:   Sat, 13 Feb 2021 08:44:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-team@fb.com
Subject: "Single user mode" initrd [ Was: [GIT PULL tip/core/rcu] RCU, LKMM,
 and KCSAN commits for v5.12 ]
Message-ID: <20210213164418.GR2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210128010437.GA32221@paulmck-ThinkPad-P72>
 <20210212123109.GB2185387@gmail.com>
 <20210212150705.GO2743@paulmck-ThinkPad-P72>
 <20210213123658.GA3500@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213123658.GA3500@1wt.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[ Dropping non-list CCs. ]

On Sat, Feb 13, 2021 at 01:36:58PM +0100, Willy Tarreau wrote:
> Hi Paul,
> 
> On Fri, Feb 12, 2021 at 07:07:05AM -0800, Paul E. McKenney wrote:
> > Thank you, Ingo!  In the future, I will group nolibc with RCU.  But there
> > has to be something other than RCU that needs it.  I will take a look. ;-)
> 
> All my kernels boot using a "preinit" that is built with nolibc and
> integrated into the initramfs. Historically it used to just create /dev
> entries and mount the rootfs, nowadays it's used to untar modules and
> finish the boot so that I can have a clean separation between a kernel
> image and a rootfs. It even allows to perform some minimal debugging as
> it includes a minimalistic shell. Do you think something like this could
> be of any use in your development sessions ? If so I can discuss this
> with you in a separate thread so as not to annoy everyone. Just let me
> know :-)

I currently use virtme when I need to poke around in userspace, which
has been working well so far.

I suspect that your preinit could be used to make a boot-loader that
automatically knows the needed Linux-kernel filesystems, thus avoiding
the long series of bugs due to filesystem mismatches between the Linux
kernel and the boot loader.  In the old days, the larger size of the
Linux kernel would have been a problem, but given the size of firmware
these days, this should no longer be a problem.

But my guess is that this has already been tried.  Plus there would have
to be someone quite excited about doing a large body of boot-loader work.

Thoughts?

							Thanx, Paul
