Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01970C6FD18
	for <rcu@archiver.kernel.org>; Wed, 29 Mar 2023 21:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC2Vfm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjC2Vfl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Mar 2023 17:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435352681;
        Wed, 29 Mar 2023 14:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D232561E64;
        Wed, 29 Mar 2023 21:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9269C433D2;
        Wed, 29 Mar 2023 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680125739;
        bh=3/ErZefX8mbOmybd8OsptVhwLqlM2jaFb4npBE4SWCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsJeJ3I+DPdPAEnAwFt9NPcTFFshbnTNv2zu7ptmhKS6CBAT6y2mHkNkJluW4L8yV
         KY1ZdJ/SjYsMHfPR/M9F8oXEi1hzOgFkbZf37kZ8rQbmA4PypHf037Xv/Zdzuqak4l
         Op0zvvB8sQwrbkJRZbQ0pJUOWW3jYHrGaUkG1TvX0mNDiSXRzKpnPgslzhXM4Uufxd
         IMnxkh9lZMzQAQ1kXJfKOzrZgaGY0K1L0HLEmuHphee6zUKwHenaneD8yH1ACTE4Cp
         yrkZvIvpy4+KNF+K8iK8xE9vh54kKktVtWs5q0RtTit4grU/aFFVvaYEPRkLGu9dGY
         JzqCrLiFP7N2w==
Date:   Wed, 29 Mar 2023 23:35:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Message-ID: <ZCSvKOJqhejuW09u@lothringen>
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-5-frederic@kernel.org>
 <519aadf0-6acd-43c0-89cf-caab9e229a46@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519aadf0-6acd-43c0-89cf-caab9e229a46@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 29, 2023 at 01:58:06PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 29, 2023 at 06:02:03PM +0200, Frederic Weisbecker wrote:
> > Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
> > over the NOCB mask is enough for both counting and scanning. Just lock
> > the mostly uncontended barrier mutex on counting as well in order to
> > keep rcu_nocb_mask stable.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Looks plausible.  ;-)
> 
> What are you doing to test this?  For that matter, what should rcutorture
> be doing to test this?  My guess is that the current callback flooding in
> rcu_torture_fwd_prog_cr() should do the trick, but figured I should ask.

All I did was to trigger these shrinker callbacks through debugfs
(https://docs.kernel.org/admin-guide/mm/shrinker_debugfs.html)

But rcutorture isn't testing it because:

- No torture config has CONFIG_RCU_LAZY
- rcutorture doesn't do any lazy call_rcu() (always calls hurry for the
  main RCU flavour).

And I suspect rcutorture isn't ready for accepting the lazy delay, that would
require some special treatment.

Thanks.
