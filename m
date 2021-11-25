Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C90C433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 01:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbhKYBGT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236229AbhKYBET (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 20:04:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC9A61074;
        Thu, 25 Nov 2021 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637802068;
        bh=fRw4MQUGUZ+hWSnuk5YWGpQCBlWLGvUeWSoE63/BYyU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qZcenZfx/qRetjGLSIa7x8sMuE/YaMfW2D1pgkZ6SFasoWKc9Lnoy9U9RsnTaGRAN
         kF8zB2OnIJXKpBzf4YN1z5q/2yWYrnBS3G9HYZr3/h98eLuYsqetisogJ9ywXXNP6G
         QU5Mn31gkhqx9eE4oGEOsoo1hmQno/mT2ItvuBW9NdIs72oiJe4uTMrIbmG6Cbvi40
         f2/t2myI1GloacAD9JNzLF/hUB/kKux/BW6KzoDPA8v2e6VIBbSEo4A7z92UWqEfV1
         HmR4xH7IjAqynJ67h//1mkhYtBoMRGC1gQUGnGUoXsOZCp6Mm6QFlhRzzMm4NwfKoa
         SytVecoFE6qVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F93C5C0A31; Wed, 24 Nov 2021 17:01:08 -0800 (PST)
Date:   Wed, 24 Nov 2021 17:01:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/6] rcu/nocb: Last prep work before cpuset interface v2
Message-ID: <20211125010108.GW641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123172534.iaaagfa4eygfsjew@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123172534.iaaagfa4eygfsjew@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 23, 2021 at 05:25:34PM +0000, Juri Lelli wrote:
> Hi,
> 
> On 23/11/21 01:37, Frederic Weisbecker wrote:
> > Changes since v1 after Paul's reviews:
> > 
> > * Clarify why the DEL vs ADD possible race on rdp group list is ok [1/6]
> > * Update kernel parameters documentation [5/6]
> > * Only create rcuo[sp] kthreads for CPUs that have ever come online [4/6]
> > * Consider nohz_full= on changelogs
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	rcu/nocb
> > 
> > HEAD: da51363e5ddf54d6ce9c2cfbab946f8914519290
> 
> I run this on RT. It survived rcutorture on different kernel cmdline
> configurations and creation of rcuox/N kthreads seemed sane. :)
> 
> FWIW, feel free to add
> 
> Tested-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Thanks for working on this!

And thank you for testing!  Applied to all but the first one, which
I will catch on the next rebase.

							Thanx, Paul
