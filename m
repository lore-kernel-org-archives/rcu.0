Return-Path: <SRS0=cFCT=AH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023FC433E0
	for <rcu@archiver.kernel.org>; Fri, 26 Jun 2020 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FB7207D8
	for <rcu@archiver.kernel.org>; Fri, 26 Jun 2020 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593181878;
	bh=/kBNAzvVFhfi6jKdA/b/fP+qMcs9P70aySHGpjntgoU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xrPGakMvtfX1zSKkVHiE3ojsgfJH4jrsCioQaE/dXqLLvKCMCK9tHKQewYT0FPdfe
	 MuSufUZ07y/bGldnOIpT7fpxxwyumRS70u5CDfCzR/ZxUaB7jWAhEe9g3shvtQhqKd
	 zuyAAwgTOxzqQE6AvxCEoHVuxTYll8TsB441I8rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFZObS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFZObS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Jun 2020 10:31:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6196206DD;
        Fri, 26 Jun 2020 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593181877;
        bh=/kBNAzvVFhfi6jKdA/b/fP+qMcs9P70aySHGpjntgoU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zhk5TC0u79WVwW3y79YHjBQVtTxhMpeq6glkB6pAHuSJC0RXIR0YgoBKG2yFQCGOG
         6Ki44tLgLaJsnhSyGa5KqAlWRhqZtMwyn9QR/IrDU+n/TpDnyzyGnJqLVxaZb/euB1
         i9i+/gz4Aqf+gWogZZR4uHItiXrtB9LHQq8g+OB0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA7103522788; Fri, 26 Jun 2020 07:31:17 -0700 (PDT)
Date:   Fri, 26 Jun 2020 07:31:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     peterz@infradead.org, x86@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [GIT RFC PULL rcu/urgent] Fix noinstr warnings for KCSAN
Message-ID: <20200626143117.GA1532@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200626041232.GA10544@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626041232.GA10544@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 25, 2020 at 09:12:32PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This pull request contains a single commit that uses "arch_" atomic
> operations to avoid the instrumentation that comes with the non-"arch_"
> versions.  In preparation for that commit, it also has another commit
> that makes these "arch_" atomic operations available to generic code.
> 
> Without these commits, KCSAN uses can see pointless errors.
> 
> This pull request is currently RFC pending ongoing -next testing.

And it has now cleared a round of -next testing!  ;-)

						Thanx, Paul

> This was not entirely free of drama, with Stephen needing to handle
> a merge conflict:
> 
> https://lore.kernel.org/lkml/20200626131425.73ee4e27@canb.auug.org.au/
> 
> However, the resolution looks straightforward to me.  In addition,
> these two commits pass rcutorture testing and associated KCSAN testing.
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent
> 
> for you to fetch changes up to b58e733fd774f3f4b49d9e7640d172a57e35200e:
> 
>   rcu: Fixup noinstr warnings (2020-06-25 08:24:32 -0700)
> 
> ----------------------------------------------------------------
> Peter Zijlstra (2):
>       locking/atomics: Provide the arch_atomic_ interface to generic code
>       rcu: Fixup noinstr warnings
> 
>  include/linux/atomic-fallback.h       | 236 +++++++++++++++++++++++++++++++++-
>  include/linux/compiler.h              |   2 +-
>  kernel/rcu/tree.c                     |  32 ++++-
>  scripts/atomic/gen-atomic-fallback.sh |  31 +++++
>  4 files changed, 292 insertions(+), 9 deletions(-)
