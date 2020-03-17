Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4926BC0044D
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 01:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14561206C0
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 01:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584407287;
	bh=6DE/46Oq6UlYKQyFn7/zwJq7l6fZb4kJ6dk0KKT6XYo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=CK38vuvjdpyhMHytq+mfwXAJd1E1wX5HJkrmQemgWtjh9ZasupS2P03gBAGWjaKv+
	 zbHQue4HgFl6jNFQch/3TORpYe9ZL4vRBS+8GbQ3hc2GYgzjTfjF4ayDGDQuLaHWxf
	 AnPh3Zw82nyiYyNekc7RRHfcughfEU45DesGnvSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgCQBIG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbgCQBIG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 21:08:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304A32051A;
        Tue, 17 Mar 2020 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584407286;
        bh=6DE/46Oq6UlYKQyFn7/zwJq7l6fZb4kJ6dk0KKT6XYo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HME+xkOg/ALYqHmwtsiT+f0w3915q5jvNDdplg0hVxGifO8bhDfzKW7IzZRuol+ka
         TtS7zZPKIi4b5axQHL5hC1kkFB6dPXi9q1+qgoxjOk5FadECyPQmBfoN0HAAIq8wCE
         FQBpn6ib0bcO3FfmGB7zbJ6UNeEI7Wg91s9+wYlQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 521F43522E56; Mon, 16 Mar 2020 18:08:05 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:08:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: Power outage
Message-ID: <20200317010805.GD3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJzB8QEUkcfx19N5369AqvfkOfQ+DL3pEjYJsK7yJi+tSq8CFg@mail.gmail.com>
 <CAEXW_YSBe3UOWwjTBpya_bM47RvrpV8kcx=RrskPP3z0i0nY2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSBe3UOWwjTBpya_bM47RvrpV8kcx=RrskPP3z0i0nY2g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 07:29:46PM -0400, Joel Fernandes wrote:
> I saw a bunch of ping timeouts on IRC and was wondering, yours among
> them. :-). See you soon back online!

Just to add insult to injury, vger rejected the email.

Due to its belief that said email contained a virus.

You just can't make this stuff up!

							Thanx, Paul

> On Mon, Mar 16, 2020 at 6:55 PM Paul McKenney <paulmckrcu@gmail.com> wrote:
> >
> > More than 2000 affected. Current repair estimate 6:45 PM PDT. For some reason, going to the local coffee shop seems less attractive than it might have a few weeks ago. :-)
> >
> > Thanx, Paul
