Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7EEE14D8
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 10:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjIJKVm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjIJKVk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 06:21:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D545CCC
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 03:21:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139BFC433C7;
        Sun, 10 Sep 2023 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694341295;
        bh=4J5tbOuxzAGX0AoX5APcjTA31FGv7zak57vbv73lxc4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eYwdyMcN2UiDmm5KaDlR8oREeKEnu2Nafwj6ixIkd777NjrLNu6+cPBMPti8ScqWH
         oiC44XqeZLygIXhd7cI+IKf++iSt9pMo6xWJyhE1vN3+BWxP8aS6PmsNHZfiNqFofY
         4VJgxDiJ9m8f8RAXG5I8TcDCBuDPWd3YBTRdN+LChZqi/zclMIjdU2Tts7UWqSelFP
         VSuT4UZP49Q5wj3+MKevPHHlNRCvuzMz4pbL1FIlcg6BGNQKvbjlvcfp5k/Y6VGOpP
         N/5LF9UugX1pHgZY26a260AF3QRTiuOk4WiuwQqqeTeJDPNTnkSq/cnxEe+VZoU6ag
         pbCBsfx4EV0uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 972B8CE080A; Sun, 10 Sep 2023 03:21:33 -0700 (PDT)
Date:   Sun, 10 Sep 2023 03:21:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [BUG] NOHZ tick-stop error: local softirq work is pending
Message-ID: <4673a906-1baa-41cf-8fd3-7d28fdd0a820@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Sep 09, 2023 at 10:28:36PM -0400, Joel Fernandes wrote:
> Hi Paul, Frederic, ever since this recent patch got merged into all
> recent stables:
> https://lore.kernel.org/all/20230818200757.1808398-1-paul.gortmaker@windriver.com/
>  ..
> 
> .. I am seeing this happen a lot now causing rcutorture failures:
> "NOHZ tick-stop error: local softirq work is pending"
> 
> It looks like the "tick-stop error" as local_bh_blocked always returns
> false on !PREEMPT_RT, so that patch itself seems correct.
> 
> However, it appears the string in console-badness.sh is different:
> 
> console-badness.sh:grep -v 'NOHZ tick-stop error: Non-RCU local
> softirq work is pending, handler'
> 
> So the string in the script needs an update?

Looks like it, though I believe that there is a fix in the offing,
at which point that "grep -v" should just be removed.  Depending on
timing, of course.

> Also, considering that it is being grep -v'ed out, any background on
> why this message is not bad and any history? Why is softirq work
> pending when the tick is stopped?

That was so long back that it is pretty hazy.  I vaguely recall that
this was considered to be in need of fixing, but a false positive from
a torture-test perspective.

							Thanx, Paul
