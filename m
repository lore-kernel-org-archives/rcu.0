Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C8C4167D
	for <rcu@archiver.kernel.org>; Wed,  1 Nov 2023 17:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbjKARNM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344598AbjKARNL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Nov 2023 13:13:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3720010E;
        Wed,  1 Nov 2023 10:13:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB57BC433C8;
        Wed,  1 Nov 2023 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698858788;
        bh=FSBuDV3vn5ABFwCq/Fw5E+UxUcGXr0n01nZQCGovems=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k+uuAch9XlzhQ6zX3uH+i4yKj/TY1VgTdvuHDW2BWMAgvlR/MNCLqoKsfkNVFrOB9
         BM8+qaMam0gvD9emFXsJ0kUvmwYFaIjLkbjrgeMfzzWKjnOqTfr6+/0v8o/v4/UICB
         nTTe9F7PW2/oUCJbHtpDv88UfPxYkusD8iNAHGrcyPAoZHxA83Hl9QI9MWe7ALvaLu
         IGHVpJQBkN6xpJYa0lJXysvTIjhDWvL20iE5YkQnLm7lhq/nBsZtC9AkB9PYgx3nlX
         H4Hzlhb9HGw581IFptvys8kTiz6B2aDKhvq3Z2nGFHNfjrMM3ql9kUSJ/99t93hdwm
         4ODVtWtRQ0LZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6705ACE09BE; Wed,  1 Nov 2023 10:13:08 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:13:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
Message-ID: <5e797896-6c0b-4686-98b7-d66bcdb10d0a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZTuf+xNrfqGjHFDK@lothringen>
 <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen>
 <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
 <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
 <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 31, 2023 at 06:07:57PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 31, 2023 at 01:06:44PM -1000, Linus Torvalds wrote:

[ . . . ]

> > I really think that we should *never* have any kind of notifiers for
> > kernel bugs. They cause problems. The *one* exception is an actual
> > honest-to-goodness kernel debugger, and then it should literally
> > *only* be the debugger that can register a notifier, so that you are
> > *never* in the situation that a kernel without a debugger will just
> > hang because of some bogus debug notifier.

Here you might have been suggesting that I use gdb and just set a
breakpoint in check_cpu_stall(), and then use gdb commands to read out
the state.  And yes, this work well in some situations.  In fact, there
is a --gdb parameter to the rcutorture scripting for just this purpose.

Except that I normally run a few hundred rcutorture guest OSes spread
across 20 systems, and sometimes more than a thousand guest OSes across
50 systems for hard-to-reproduce bugs.  In my experience, managing that
many remote gdb sessions is cranky and unreliable, which is not helpful
when debugging.  Writing a few tens of lines of C code in the kernel is
much simpler and more reliable.

Assuming of course that I avoid the traps you point out.  Which I have
done thus far.  (Famous last words...)

							Thanx, Paul
