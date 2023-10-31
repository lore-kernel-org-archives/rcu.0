Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D33C4332F
	for <rcu@archiver.kernel.org>; Tue, 31 Oct 2023 10:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjJaKTH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Oct 2023 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjJaKTG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Oct 2023 06:19:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB983;
        Tue, 31 Oct 2023 03:19:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF366C433C8;
        Tue, 31 Oct 2023 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698747544;
        bh=83ff9t5GCQi9LOG5AEcLmIHSOIfxWn+23hXnudO34gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDi4pR+R28eO1zaLyqiV8wJNzoTJXHMmD+itcI8WaI9n10K8Jfd9up7scbAtkpjbz
         3fVA8GjwnD2Ggc98CW6OyR4svLaKG+Q9xA3c89AENdNlhLfS8AP31G4xz3xmrBDZsw
         Vk4k3pFIgyTaGkWrEzytwPeZVv2Y2jS0DL/7uOzJfyxQZ98SwlA7YqTnWiKUwc4puW
         PTBSSjbT0AeRJ8dZw/wl/za2wURYC7oDUGszeekBcr8lLF/aYR4P2Md0sXkBAwQ6qR
         VYgPuiGPP0oZvHlDFST+ZcGXtd48zHCuuYzDzXHtuB8GdHXk8+J8GHQ3BJoX6lVAYf
         BHMsiNguKjVpQ==
Date:   Tue, 31 Oct 2023 11:19:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
Message-ID: <ZUDUlQq6hEEPBiCR@lothringen>
References: <ZTuf+xNrfqGjHFDK@lothringen>
 <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 30, 2023 at 06:12:51PM -1000, Linus Torvalds wrote:
> On Fri, 27 Oct 2023 at 01:33, Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > rcu/stall: Stall detection updates. Introduce RCU CPU Stall notifiers
> >         that allows a subsystem to provide informations to help debugging.
> >         Also cure some false positive stalls.
> 
> I absolutely detest this stall notifier thing.
> 
> Putting the stall notifier before the stall message does not "help
> debugging". Quite the reverse. It ends up being a lovely way to make
> sure that the debug message is never printed, because there's some
> entirely untested - and thus buggy - notifier on the chain before the
> printout from the actual stall code.
> 
> I've pulled this, but I really want to voice my objection against
> these kinds of "debugging aids". I have personally spent way too many
> hours debugging a dead machine because some "debug aid" ended up being
> untested garbage.
> 
> If you absolutely think that this is a worthy and useful thing to do,
> then at the very least make sure that these "debug aids" will always
> come *after* the core output, and can't make things horrendously
> worse.
> 
> But in general, think twice before adding "maybe somebody else wants
> to print debug info". Because unless you have a really really REALLY
> good reason for it, it's more likely to hurt than to help.
> 
> Right now I see no users of this except for the rcu torture code, and
> it certainly doesn't seem hugely important there. And so I'm wondering
> what the actual real use-case would be.

I see, one possibility is to revert this and switch to normal calls
for any future debug information to add from another subsystem. I'll
wait for Paul's opinion...

Thanks.
