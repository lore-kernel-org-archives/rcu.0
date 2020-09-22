Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C09C4727F
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8AD208A9
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 21:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600811815;
	bh=epmdI03GzdPJyvBUJoWE5xkKMsy+FzGOjThMWoZGLHA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=EQ6CtR92KsSZyzzENU5uZkvq1BFqzqIPCFZxrwOu1PAr7a+Ub7eKK4bYURBOujxtY
	 Tz3C2MFcHU3HUmN6mAFe17Ty/EqddM+DTYNuKjN1/hNYREpFnTyiPVa/IcCNeKZSr9
	 DDUGdgJSqHcnlU4TJW4RQRqV6cTHfXrP+AhVSM8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIVV4w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 17:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgIVV4w (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 17:56:52 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4775206B5;
        Tue, 22 Sep 2020 21:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600811811;
        bh=epmdI03GzdPJyvBUJoWE5xkKMsy+FzGOjThMWoZGLHA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AQmLVEvyK5W3qCMjjgQaB/KSEoXoNb/bog9KAtom4un7Bu33v9UVlndX30fI00GLP
         2EpnE8etwO5k0vT9SEJTFjs1eCnnjBLg9zorON/vBYJn2u8qQF5YeuVjU5L1HurEQm
         nJvOlJWgQHs3TvHEhM/67msA24dR14mOrrPYPNyY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8A6E035227BD; Tue, 22 Sep 2020 14:56:51 -0700 (PDT)
Date:   Tue, 22 Sep 2020 14:56:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] RCU: export rcu_idle_enter/_exit for loadable modules
Message-ID: <20200922215651.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200922214331.26608-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922214331.26608-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 22, 2020 at 02:43:30PM -0700, Randy Dunlap wrote:
> drivers/acpi/processor.ko uses rcu_idle_enter()/_exit() but
> they are not exported. This causes build errors on IA64,
> so export those 2 functions.
> 
> ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-acpi@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: rcu@vger.kernel.org
> ---
> Is there a problem with exporting these functions for use by
> loadable modules?  If so, this driver should be modified not
> to use rcu_idle_enter/exit.

Good catch, but Borislav Petkov beat you to it:

https://lore.kernel.org/lkml/20200921103741.GC5901@zn.tnic/

Rafael has applied Borislav's patch to his cpuidle tree for v5.9-rc7.

							Thanx, Paul

>  kernel/rcu/tree.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- lnx-59-rc6.orig/kernel/rcu/tree.c
> +++ lnx-59-rc6/kernel/rcu/tree.c
> @@ -673,6 +673,7 @@ void rcu_idle_enter(void)
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(false);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_enter);
>  
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> @@ -886,6 +887,7 @@ void rcu_idle_exit(void)
>  	rcu_eqs_exit(false);
>  	local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_exit);
>  
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
