Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ECFC433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 01:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbhKYBHd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235652AbhKYBFd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 20:05:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B3D4610C8;
        Thu, 25 Nov 2021 01:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637802143;
        bh=lvKQsZfga7dHq31IgqM34O5VmfnpbZHFLcWr/bqoZYY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kkuI+wpjjK8PP0F8SWkV1sMu412kyE2IjZEDJhphy2qklgJnS1XJzLk5tfNOF0BPD
         Gl/v1o4++o/UhC6IheqW7lHTSURyggpPewt8AkAyk9LLiqtlo1n8JAGpaDBy2uB/jI
         OHEc0UyVwnmqPhtvgO4/8dWodQ9kPnkSute05fo13H9RxW/lTPVTl/mZsnRCHbJvYr
         3za2sO1tXOKqhmRdJJxLDU2djCn8uJTlWxwjXBEkSmR3aqhO+uqVGgJjp2iJKHkO6X
         yCuqyXXLhu69fjU6VjYpA6HtylCyg/L70hkOXtNv9nhFhVpD0K/W6GqqOql603ezQd
         dhfEvCHjfIPrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D7F305C0A31; Wed, 24 Nov 2021 17:02:22 -0800 (PST)
Date:   Wed, 24 Nov 2021 17:02:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211125010222.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
 <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
 <20211125005526.GA490855@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125005526.GA490855@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 25, 2021 at 01:55:26AM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 24, 2021 at 04:47:20PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:
> > > If a user wants to boot without any CPU in offloaded mode initially but
> > > with the possibility to offload them later using cpusets, provide a way
> > > to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> > > the creation of dormant nocb kthreads.
> > 
> > Huh.  This would have been a use for Yury Norov's "none" bitmask
> > specifier.  ;-)
> 
> This must be the last missing piece before we can finally support NR_CPUS=0 ;)

;-) ;-) ;-)

							Thanx, Paul

> > I pulled this one in with the usual wordsmithing.
> 
> Thanks!
