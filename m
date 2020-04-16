Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5828FC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347B420786
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587061790;
	bh=mD/+39ffbpQesSUBiv9pmuWohUYq+0n1F0ANplrC4lk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KndxB+A1EXSD0lLbOdA+Tz75RD/LaHp0clR8W+0cnxcKcHy7ufbaHtFv/CUYt5KaY
	 qY86hbEedinTCbtc1edHDJpUAo0AFDENShLnJ2xiBwlqCgc8v+85PhkLjcNzGqVK4b
	 wtAfzlhZwreukxagpBxSI0/cH+B++3Di4vyGhYBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbgDPS3t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDPS3t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:29:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E309C206D5;
        Thu, 16 Apr 2020 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587061788;
        bh=mD/+39ffbpQesSUBiv9pmuWohUYq+0n1F0ANplrC4lk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U8nsnzIxbNHP4dtcnwJ0I0lSqityCFWNz+2WNFubZJsN61QNwjWEaH426bCV6jLGj
         5BBcU/nEwFdPju3FUiX2i4y1pgTvsZGHFOP4ND1ejksuJ4TCOYAOx/EtIhhLUbNHbT
         rI8IRG+FQUKKkbTUyfxUKj77K04gzh196OgUPaEk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B292C3522C68; Thu, 16 Apr 2020 11:29:48 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:29:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416182948.GV17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
 <20200416153844.GA8191@pc636>
 <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
 <20200416172953.GR17661@paulmck-ThinkPad-P72>
 <20200416182309.zytrgowlngpewxbt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416182309.zytrgowlngpewxbt@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 08:23:09PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 10:29:53 [-0700], Paul E. McKenney wrote:
> > > migrate_disable() would work.
> > 
> > Or moving to a raw spinlock, correct?
> 
> I'm currently in favour of that migrate_disable(). raw spinlock does not
> work because there is memory allocation via get_page() later on.

Fair enough!  IIRC, get_page() uses non-raw spinlocks, so...

							Thanx, Paul
