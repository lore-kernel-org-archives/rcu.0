Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5588EDE9A5
	for <rcu@archiver.kernel.org>; Thu, 14 Sep 2023 11:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjINLLh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Sep 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjINLLf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Sep 2023 07:11:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA11FD4
        for <rcu@vger.kernel.org>; Thu, 14 Sep 2023 04:11:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DCC433CA;
        Thu, 14 Sep 2023 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694689890;
        bh=Py3gKDehUdo/afmDk2Anr7QNPtfiRxlC229LID+1dPY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sucrBlkZdN8egzWdxSHw4wIjeL0PZGNAizGH2Jmw9TJyRz7rGbdoACvjrPe3olFNw
         Ll26LDN4SluMld6j9pzyu05teIN6UaeaV/iX64Xzwj+GvS8i3rVx5TvTiihFIUYts5
         KY/IbT+KQWAl8DR0tdqUxbaEm/EwzJWwhn8fL0mQWu34mUdl3ygGetOFiynetcFpBZ
         MUpM/23QQLwe2FcYdZ0UYwo//grEAHO7YktrqBLK+fDQ78if/OwYOlK96C7hu5CJft
         SfX269tDaIw3OSw67qcTtFRiAAV+47YHI3/+MixQGFnUUPd2CZvu5SabjByOG6Dg7q
         6zXDN9oR9XN8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3BB3CCE0D10; Thu, 14 Sep 2023 04:11:26 -0700 (PDT)
Date:   Thu, 14 Sep 2023 04:11:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230910201445.GA1605059@google.com>
 <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 13, 2023 at 04:30:20PM -0400, Joel Fernandes wrote:
> On Mon, Sep 11, 2023 at 4:16 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> [..]
> > > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > > and then I'll also look at why is it being pushed out in the first place.
> > >
> > > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > > for several hours.
> >
> > Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> > the problem still occurs?  If yes, then there is definitely some reason
> > other than CPU hotplug that makes this happen.
> 
> Hi Paul,
> So looks so far like onoff_interval=0 makes the issue disappear. So
> likely hotplug related. I am ok with doing the cpus_read_lock during
> boost testing and seeing if that fixes it. If it does, I can move on
> to the next thing in my backlog.
> 
> What do you think? Or should I spend more time root-causing it? It is
> most like runaway RT threads combined with the CPU hotplug threads,
> making scheduling of the rcu_preempt thread not happen. But I can't
> say for sure without more/better tracing (Speaking of better tracing,
> I am adding core-dump support to rcutorture, but it is not there yet).

This would not be the first time rcutorture has had trouble with those
threads, so I am for adding the cpus_read_lock().

Additional root-causing might be helpful, but then again, you might
have higher priority things to worry about.  ;-)

							Thanx, Paul
