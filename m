Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81940EC8743
	for <rcu@archiver.kernel.org>; Thu,  7 Sep 2023 16:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjIGQX5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbjIGQWd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB335B6
        for <rcu@vger.kernel.org>; Thu,  7 Sep 2023 09:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41954C32791;
        Thu,  7 Sep 2023 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694097285;
        bh=ozKMeLH6MG2BlHULrox+j5fLhZ07xglLotrIjS1h+p0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NChr2DsXXIdyUxnjCkj3Rl0uZx+B1m16ePYmSjK7bN45fVJPKUWvCmWeCMR+YA+IL
         f7ww6863x8bEHa0/zhAUhAtQ++rsagc/3kIw4xytOKTY3xDtrAJP8PQo3T4CdB58eF
         hz5NY0qfr5eAROEHJrj99IgXzMEEMmpewf1QJn7k8vNL0bFQA8hsdIR0ZYAm5M6Hao
         kdTm3QEEQcjZuXujlBtOPYgnZghtEiWzAi2I0MBwpQm9M/d+es2YNg3DY1A9LtzPBF
         z1BdHKod+OzVNOfScv2vcKu4Py0f/HEauPg8OtzZeZa0hmnwew9KfKsjmEXGDClHZ8
         HjSuUJkO81Hfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9A32CE0D07; Thu,  7 Sep 2023 07:34:44 -0700 (PDT)
Date:   Thu, 7 Sep 2023 07:34:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state
 RTWS_COND_SYNC_FULL
Message-ID: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> Hi,
> Just started seeing this on 6.5 stable. It is new and first occurrence:
> 
> TREE04 no success message, 234 successful version messages
>  [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> f0x0 ->state 0x2 cpu 6
> [   38.388342] Call Trace:
> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> f0x2 ->state 0x2 cpu 6
> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> f0x0 ->state 0x2 cpu 6
> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> f0x0 ->state 0x2 cpu 6
> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> f0x0 ->state 0x2 cpu 6
> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> f0x0 ->state 0x2 cpu 6
> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> f0x0 ->state 0x2 cpu 6
> [..]
> 
> All logs:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04/

Huh.  Does this happen for you in v6.5 mainline?

Both the code under test (full-state polled grace periods) and the
rcutorture test code are fairly new, so there is some reason for general
suspicion.  ;-)

							Thanx, Paul
