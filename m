Return-Path: <SRS0=GKHO=C2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F190EC43461
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 00:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FF82064E
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 00:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600304131;
	bh=9ulv5jv9pJhqtRTxFWJWZ3bKt7i9GYxG1m9W2m+4RSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bEy6wqVWFnzRsr7SsssySV8E7zu+NMuRmv1pdeo9CFaLeGKv715NYDidgm1xj4Zps
	 rs79in8e5myNOTXsfXrPRO7Em4qepFgo0BHwTUSjPUP3No1F4WdqC4nueth+I1pP2L
	 M6G+2h+K/qxFPAL0XLaHLAkL5kRv8/v48LN0OHsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIQAzb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgIQAza (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Sep 2020 20:55:30 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:55:30 EDT
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25335206A4;
        Thu, 17 Sep 2020 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600303718;
        bh=9ulv5jv9pJhqtRTxFWJWZ3bKt7i9GYxG1m9W2m+4RSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZotmgASXWB6fIEAU9GkPSAO/v4Tagu4jVZSwB41P4mgM92EeiC+NZ5ZwnBVl6K0Oq
         2EUz1Ql5c3swNskssvc7TROyx8qXpA+MSKtOInjpwRCfn6S9J1HQDyg00rnJs0HB/D
         65CbAlgT9kTFiv+gJ6aq1YUVqgLLFlCdwzFzlfs4=
Date:   Wed, 16 Sep 2020 17:48:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     davem@davemloft.net, joel@joelfernandes.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, peterz@infradead.org,
        christian.brauner@ubuntu.com
Subject: Re: [PATCH net-next 0/7] rcu: prevent RCU_LOCKDEP_WARN() from
 swallowing  the condition
Message-ID: <20200916174836.4dd22aca@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200916231505.GH29330@paulmck-ThinkPad-P72>
References: <20200916184528.498184-1-kuba@kernel.org>
        <20200916231505.GH29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 16 Sep 2020 16:15:05 -0700 Paul E. McKenney wrote:
> On Wed, Sep 16, 2020 at 11:45:21AM -0700, Jakub Kicinski wrote:
> > Hi!
> > 
> > So I unfolded the RFC patch into smaller chunks and fixed an issue
> > in SRCU pointed out by build bot. Build bot has been quiet for
> > a day but I'm not 100% sure it's scanning my tree, so let's
> > give these patches some ML exposure.
> > 
> > The motivation here is that we run into a unused variable
> > warning in networking code because RCU_LOCKDEP_WARN() makes
> > its argument disappear with !LOCKDEP / !PROVE_RCU. We marked
> > the variable as __maybe_unused, but that's ugly IMHO.
> > 
> > This set makes the relevant function declarations visible to
> > the compiler and uses (0 && (condition)) to make the compiler
> > remove those calls before linker realizes they are never defined.
> > 
> > I'm tentatively marking these for net-next, but if anyone (Paul?)
> > wants to take them into their tree - even better.  
> 
> I have pulled these into -rcu for review and further testing, thank you!
> I of course could not resist editing the commit logs, so please check
> to make sure that I did not mess anything up.

Done & thank you!

> Just so you know, unless this is urgent, it is in my v5.11 pile, that
> is, for the merge window after next.
> 
> If someone else wants to take them, please feel free to add my
> Acked-by to the RCU pieces.

Sounds good to me, the RCU tree seems most appropriate and we added 
a workaround for the issue in net-next already, anyway.

Thanks!
