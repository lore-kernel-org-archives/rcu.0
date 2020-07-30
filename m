Return-Path: <SRS0=zn4Z=BJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E157DC433E0
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B972A20809
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596147663;
	bh=NgJpcR0LL0zYDccbtazPPHHNYrCpIo7SgHXiesZqEp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GA7OOLFot1jNxAkM+g6S5WVJs76rtqcrnhAvKcx7PUG9t+hZkL60aJ0p31lL6p2fm
	 JsyRmx/HUZcPEJXgf6eNnJ+L3p62nsnIzTDzr2GsyLh7SH68n2au0MAeku8wrxin9S
	 bhFrSaxde5GrrY2FC7yiwyd4NRc2xcj/f9aQcSMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgG3WVD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgG3WVC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 18:21:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75357C061574;
        Thu, 30 Jul 2020 15:21:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so11589050eds.2;
        Thu, 30 Jul 2020 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y+mpXV57TW2iO0c6IHfRHHNirfzxpC6g/J95M/azzkY=;
        b=JWF6dui1IzPCk7OPjzXS68CeUeDkUYBrDVhoV57bX+R12EF+lGgYYXfAiiYl+rvLuR
         qNNUK2R9V/hIYGJqF9d+oukJDzsFTk2qlCfw/l7MYYlV9RxqDGnyBZBW7wS/AFXKRK8/
         ybTYNbEz+IWOaqzW4MfuyXO8FrXHfvkY+V9U9xElqO0BlWSKfjpy3i9DOzvYi7UCAMWQ
         LZPbbHo5WFq3dzpHDQFU471gNJI84dYat78N7NFpCfFfOlo0hoQ6DzzItwTlpV0nxi3W
         pZ1rtwtcgF2/j5vcp5xYYj0plvPMRLJSF4Ior4nDQxtxqRkn/v/mXjI+ngtUqfKFDXd1
         GIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=y+mpXV57TW2iO0c6IHfRHHNirfzxpC6g/J95M/azzkY=;
        b=IGj0WRtR7mN7fNVLSGIaTiCr+Qjdi7jx+k9Ds8ckbyLG9VM7k4sE0YmBaCfJMGgqjq
         lRpbNyjMEhZvxm5cvm0DeLYThJovIGr253EJ0za9MHPMj8O8878OoVhcbKicM1q0P9S/
         r/p3SjT6a+y31CXSIpWVCCmaZ/jfy23R7QQ0019o/2Fsi9J+t48skfQ3fFbO17FigRIn
         zUKSnWKpXLucIEmyVZbt38ild9c9dt/6SqmzwUiz2HeXMYpNTBYP779P747sRwh3iF5y
         uRiddCGvvtZ7C8v8rnO2DaiKIt55aQbtIA4Ye7DYcjSaHsHwvQNkOSjkOsA4JfKurJL3
         tIog==
X-Gm-Message-State: AOAM533lQcC/HU/XVKWuj7aK65Gyyy0yAV4NDkBtHAz1gyzuFtP3RxTH
        BwDSZ8J1tr4/3mNPjYvO4YI=
X-Google-Smtp-Source: ABdhPJyI6nx7BepTT+yJdQ/rbOjasxKetAGavgY9Wfr4+anngSW2RrkSYvoL9VX9kHKzBffTSZ/FGA==
X-Received: by 2002:a05:6402:1346:: with SMTP id y6mr1167784edw.192.1596147661214;
        Thu, 30 Jul 2020 15:21:01 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y14sm6313577ejr.35.2020.07.30.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:20:59 -0700 (PDT)
Date:   Fri, 31 Jul 2020 00:20:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org, arnd@arndb.de,
        bigeasy@linutronix.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200730222057.GA423051@gmail.com>
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714172701.GA31369@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains the following changes:
> 
> 1.	Documentation updates.
> 
> 	https://lore.kernel.org/lkml/20200623000923.GA25047@paulmck-ThinkPad-P72
> 
> 2.	Miscellaneous fixes.
> 
> 	https://lore.kernel.org/lkml/20200623002128.GA25456@paulmck-ThinkPad-P72
> 
> 3.	kfree_rcu updates.
> 
> 	https://lore.kernel.org/lkml/20200624201200.GA28901@paulmck-ThinkPad-P72
> 
> 4.	RCU tasks updates.
> 
> 	https://lore.kernel.org/lkml/20200623002423.GA25869@paulmck-ThinkPad-P72
> 
> 5.	Read-side scalability tests.
> 
> 	https://lore.kernel.org/lkml/20200623002941.GA26089@paulmck-ThinkPad-P72
> 
> 6.	SRCU updates.
> 
> 	https://lore.kernel.org/lkml/20200623003310.GA26539@paulmck-ThinkPad-P72
> 
> 7.	Torture-test updates.
> 
> 	https://lore.kernel.org/lkml/20200623003731.GA26717@paulmck-ThinkPad-P72
> 
> All of these have been subjected to the kbuild test robot and -next
> testing, and are available in the git repository based on v5.8-rc3 at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 13625c0a4074d3bab61b1dc70a828b574255f339:
> 
>   Merge branches 'doc.2020.06.29a', 'fixes.2020.06.29a', 'kfree_rcu.2020.06.29a', 'rcu-tasks.2020.06.29a', 'scale.2020.06.29a', 'srcu.2020.06.29a' and 'torture.2020.06.29a' into HEAD (2020-06-29 12:03:15 -0700)

>  61 files changed, 2395 insertions(+), 680 deletions(-)

Pulled into tip:core/rcu, thanks a lot Paul!

I assume the fix Uladzislau Rezki is working on will resolve Sebastian 
Andrzej Siewior's objections?

Thanks,

	Ingo
