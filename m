Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FD2C433F5
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 00:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbhKYAnU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245036AbhKYAlJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 19:41:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B831E610A6;
        Thu, 25 Nov 2021 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637800678;
        bh=yb7KDOQ3YzIOX2isILQhopFv8tMuMQWusc7b2eO2ZZs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RTgKVblr2qhdEdFLs8D8JutZVecuB/2+enrWyOTi9khoabop/NWRJgALH5yDSUpnK
         zw6jvDUtrLkxvuyhX0f32Nv2ZD31i6oJHienD961deIAnNr631kaXG6De7Z4ZSV/l+
         V+Wh1ke+Cxr7ElnvQZeVjl37Pes61qvkidlduY9o6CA+84xpDVFYT/qNAZytdq6A/B
         k1lgPJ7HoZIReZty4R3z6olGdC9H/a7QfNhakv9DfCClwz4D9xM6XIJIpjdRvPxvCl
         fnk58EeZtP2IHvLQDH7gzPh3ROx82G66dp+7LGxI59PXKMUAy9sAZaJmwE4Ti9kKZR
         G4XmAXipPVbCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 813CD5C0A31; Wed, 24 Nov 2021 16:37:58 -0800 (PST)
Date:   Wed, 24 Nov 2021 16:37:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/6] rcu/nocb: Create kthreads on all CPUs if "rcu_nocb="
 or "nohz_full=" are passed
Message-ID: <20211125003758.GU641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-5-frederic@kernel.org>
 <20211123172814.4rev7z45onxvjmy4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123172814.4rev7z45onxvjmy4@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 23, 2021 at 05:28:14PM +0000, Juri Lelli wrote:
> Hi,
> 
> On 23/11/21 01:37, Frederic Weisbecker wrote:
> > In order to be able to (de-)offload any CPU using cpuset in the future,
> > create a NOCB kthread for all possible CPUs. For now this is done only
> > as long as the "rcu_nocb=" or "nohz_full=" kernel parameters are passed
> 
> Super nitpick! In subject and above sentence, "rcu_nocb=" is actually
> "rcu_nocbs=", isn't it?
> 
> Feel free to ignore the noise, of course. :)

What is life without a little noise?  ;-)

I fixed this, and thank you for spotting it.

							Thanx, Paul
