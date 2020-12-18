Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8411DC2D0E4
	for <rcu@archiver.kernel.org>; Fri, 18 Dec 2020 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5138723B74
	for <rcu@archiver.kernel.org>; Fri, 18 Dec 2020 16:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgLRQLP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgLRQLO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Dec 2020 11:11:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E453C23B6C;
        Fri, 18 Dec 2020 16:10:32 +0000 (UTC)
Date:   Fri, 18 Dec 2020 11:10:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+972b924c988834e868b2@syzkaller.appspotmail.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: suspicious RCU usage in modeset_lock
Message-ID: <20201218111031.226f8b59@gandalf.local.home>
In-Reply-To: <CAKMK7uH1agVS=e245b=25Lv9Q+u5c7=KL-_NF8Hte10nKTqAXw@mail.gmail.com>
References: <000000000000cb6db205b68a971c@google.com>
        <CAKMK7uEiS5SrBYv-2w2wWL=9G4ByoHvtiWVsPqekswZzOGmzjg@mail.gmail.com>
        <20201216161621.GH2657@paulmck-ThinkPad-P72>
        <CAKMK7uH1agVS=e245b=25Lv9Q+u5c7=KL-_NF8Hte10nKTqAXw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 17 Dec 2020 11:03:20 +0100
Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> I think we're tripping over the might_sleep() all the mutexes have,
> and that's not as good as yours, but good enough to catch a missing
> rcu_read_unlock(). That's kinda why I'm baffled, since like almost
> every 2nd function in the backtrace grabbed a mutex and it was all
> fine until the very last.
> 
> I think it would be really nice if the rcu checks could retain (in
> debugging only) the backtrace of the outermost rcu_read_lock, so we
> could print that when something goes wrong in cases where it's leaked.
> For normal locks lockdep does that already (well not full backtrace I
> think, just the function that acquired the lock, but that's often
> enough). I guess that doesn't exist yet?
> 
> Also yes without reproducer this is kinda tough nut to crack.

I'm looking at drm_client_modeset_commit_atomic(), where it triggered after
the "retry:" label, which to get to, does a bit of goto spaghetti, with
a -EDEADLK detected and a goto backoff, which calls goto retry, and then
the next mutex taken is the one that triggers the bug.

As this is hard to reproduce, but reproducible by a fuzzer, I'm guessing
there's some error return path somewhere in there that doesn't release an
rcu_read_lock().

-- Steve
