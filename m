Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA59ECAAD8
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 12:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIPMvp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIPMvo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 08:51:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC5AB04E;
        Fri, 16 Sep 2022 05:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C061962B81;
        Fri, 16 Sep 2022 12:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91040C433D6;
        Fri, 16 Sep 2022 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663332703;
        bh=syr2iOZ8WLAe2Icyqy1ThqP3eS6SIEsErM11Ey6B3rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWatUGiGP06fAQsLcj/fzno2Sad3MZYajIeoz8YDh58G7mP2mVRap6D3P6WXQ5M+T
         cC+2fg22SkYbre5HxjEf/rLLlV9AOBUQTX8h2S5BvtvKwWMkDDFC5SgQkCMprWrBfZ
         Gj0s/M4NUmVN9AA4ZArIhb/2EmK5WHH813gbWr805QiZfq+TUwr7mQWuVa0TG3IFCJ
         4Y0hIY5w8FXxHXgwyB6JM16UoyZK0FqUdSw4xie1d23IjNkQlmUt7vQCC8iHR26JXA
         u99DMwUqBwfRBXtbhbLBSFPKctBo48OhxWDoZC/JFkKlGJH8PRR1p21WdhzOx5QiJM
         WDiOtv38F6ASA==
Date:   Fri, 16 Sep 2022 14:51:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 3/3] rcu: Fix late wakeup when flush of bypass
 cblist happens
Message-ID: <20220916125139.GA25891@lothringen>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915001419.55617-4-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 15, 2022 at 12:14:19AM +0000, Joel Fernandes (Google) wrote:
> When the bypass cblist gets too big or its timeout has occurred, it is
> flushed into the main cblist. However, the bypass timer is still running
> and the behavior is that it would eventually expire and wake the GP
> thread.
> 
> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
> soon as the flush happens. Otherwise, the lazy-timer will go off much
> later and the now-non-lazy cblist CBs can get stranded for the duration
> of the timer.
> 
> This is a good thing to do anyway, since it makes the behavior consistent with
> behavior of other code paths where queueing something into the ->cblist makes
> the GP kthread in a non-sleeping state quickly.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
