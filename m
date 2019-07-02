Return-Path: <SRS0=UBUU=U7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC77C5B578
	for <rcu@archiver.kernel.org>; Tue,  2 Jul 2019 02:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713D7216C8
	for <rcu@archiver.kernel.org>; Tue,  2 Jul 2019 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FDgZtNJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGBC4t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:56:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35559 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBC4s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jul 2019 22:56:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so6939459pgl.2
        for <rcu@vger.kernel.org>; Mon, 01 Jul 2019 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XpNqq0VnkT3p8I/BExmdJcnD5/YacSkOpq73JLluvdE=;
        b=FDgZtNJllpxHQ/po4qmDfmnopFfjnJD7bEqCQX6/Cfb7BetApqWVPOJN+KIjafTz4H
         +0f6SrnECA1VMISldTqt0RDKzMOBz1vGxgPgb0XiKealb+DW8SQ1XF/ReKOah2VVjYfv
         M3YCmqNDGFTUW+//b3VzqgjWNrQbdO+8inY70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpNqq0VnkT3p8I/BExmdJcnD5/YacSkOpq73JLluvdE=;
        b=S/Vww4emmqiDKqz6zMgR0i+jdZrhdM6N4BuYE3CcFqLdaID2oQ3Zima4sCGy6bRCiX
         XYomfAItifMAWVeC+dB17XGHCp3bkb2K4Pn/ZlCc9MR/X4m/6xEdJk/BrkUdzbv8NFYI
         Sh6M98NIH5RPZ4ZpQ3/160KXLxdJvS5MCOek54GxbVfaDCZ9saqP4BFZL0sCwVQ1YjG4
         GMAQCNd4sNsq76SQfaaZEBt6j8OGXhql1o1CLT7lNJMLWb8oNctv8e7H4KCbhne4+xqd
         /HPUic5xosHREVBZKtBsQe8pCVygY0Hv+ZQ8Xsxr4M4d6iL8lFBzU8poVx/f3n8e7ZT2
         fGRw==
X-Gm-Message-State: APjAAAVGuBah1K8GcnY7T1xa9f9St/trBJVXwmMyU/sKRzpesACp0T0n
        mDUE2/8TKDudw5rrYM/Y4Pz9ow==
X-Google-Smtp-Source: APXvYqySyxJQDfO3C4TuGxzgX42AEeBOsYWRSkkgsmbgujdZNy4Mse+Chn/9NYobVy6MI+Nv4Tlq4w==
X-Received: by 2002:a63:ce4f:: with SMTP id r15mr27761535pgi.107.1562036207821;
        Mon, 01 Jul 2019 19:56:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g2sm20204075pfb.95.2019.07.01.19.56.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 19:56:47 -0700 (PDT)
Date:   Mon, 1 Jul 2019 22:56:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190702025645.GC240327@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
 <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
 <20190701141403.GA246562@google.com>
 <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
 <20190701145920.GA71270@google.com>
 <20190701202727.GR26519@linux.ibm.com>
 <20190701213107.GA240327@google.com>
 <20190701215020.GW26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701215020.GW26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 01, 2019 at 02:50:20PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 01, 2019 at 05:31:07PM -0400, Joel Fernandes wrote:
> > On Mon, Jul 01, 2019 at 01:27:27PM -0700, Paul E. McKenney wrote:
> > > On Mon, Jul 01, 2019 at 10:59:20AM -0400, Joel Fernandes wrote:
> > > > On Mon, Jul 01, 2019 at 04:48:43PM +0200, Dmitry Vyukov wrote:
> > > > > On Mon, Jul 1, 2019 at 4:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > > On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > > > > > > > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > > > > > > > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > > > > > > > runs but does nothing.
> > > > > > >
> > > > > > > Nope. I would like to know *why* you need 'noapic' to work. Is it a
> > > > > > > brand new or old qemu-system-x86_64?
> > > > > >
> > > > > > I did not have time to debug yesterday and I posted this particular revert as
> > > > > > an 'RFC' just to make aware of this problem.
> > > > > >
> > > > > > I spent some more time just now, it looks like this has nothing to do with
> > > > > > 'noapic' and appears to be a problem on debian distros with the e1000e NIC.
> > > > > > May be this NIC was added to the virtual hardware because of -machine in the
> > > > > > patch?
> > > > > >
> > > > > > Any if I add the following to the qemu command that kvm.sh runs, it works again:
> > > > > > -net nic,model=e1000
> > > > > >
> > > > > > Without it I get:
> > > > > >  qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"
> > > > > >
> > > > > > Seems to be mentioned here:
> > > > > > https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211
> > > > > >
> > > > > > And in syzkaller as well:
> > > > > > https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88
> > > > > >
> > > > > > Adding Dmitry who is syzkaller owner for any thoughts as well.
> > > > > 
> > > > > I don't have many thoughts on this. That particular error looked like
> > > > > a bug in the package in the particular distro/version.
> > > > 
> > > > Paul, what is your preference here? Can we add the -net nic,model=e1000 to
> > > > fix it for the benefit of any other Debian folks running kvm.sh?
> > > > 
> > > > Or do you prefer if I just built my own custom Qemu? I can't upgrade Qemu on
> > > > this machine unfortunately. But may be I can build my own.
> > > > 
> > > > I prefer the -net option since I can save the time for something else. ;) Let
> > > > me know what you prefer and I'll fix it accordingly.
> > > 
> > > Why not just add the following to your kvm.sh command line?
> > > 
> > > 	--qemu-args "-net nic,model=e1000"
> > > 
> > > Easy workaround and no need to wait for changes to hit mainline.
> > > 
> > > Yes, I am perhaps naively assuming that the qemu bug in Debian will
> > > be fixed in about the time that it would take for any change to the
> > > rcutorture scripting to make its way into mainline.  ;-)
> > 
> > Thanks for the pointer to the args! Just what I wanted.
> > 
> > Only down side is then we run into the risk of other developers running
> > kvm.sh on debian as well and wondering why torture is broken. Perhaps the kvm
> > tweaks commit hasn't hit that many machines yet but it might. At least we
> > have this discussion archive here to guide such poor souls, if we don't want
> > to append these arguments by default ;-)
> 
> What is the likely timeframe of a qemu fix in Debian?

I dug through debian's archive. Indeed they have already fixed it
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=884240

I may need to upgrade my debian release or pull patches from debian testing,
or something. It might not be worth the trouble and I could just as well have a
custom kvm.sh command in my bashrc.

> This does raise a question of rcutorture workarounds in general.
> There will be times when some failure or another is expected behavior.
> For example, in current -rcu getting an rcutorture_oom_notify() splat or
> the occasional RCU CPU stall warning from TREE04 is expected behavior.
> This is because rcutorture's forward-progress testing is more aggressive
> that the TREE04 configuration can currently handle (but I am working
> on it).

I see, thanks good to know. I would love try out those tests as well.

> 
> For internal-to-RCU issues, I could make rcutorture warn of the likely
> problem.  for external-to-RCU issues, such as your fun with Debian qemu,
> that won't work all that well.  I could blog about the external-to-RCU
> issues, if that would help.  Or we could trust people to either do
> the websearch or ask for help on the rcu email list.

Yes this discussion is here. I also feel it may not be worth working around
since it is a distro bug which is already fixed it. Another approach could be
to look for that error message in qemu-output and tell people to use a custom
command or upgrade when they run the script. But that also may not be worth
it unless more people are running into this due to the default distro package
they are using.

> Thoughts?
> 
> > The other fix, could be I just build and run a new custom qemu instance but I
> > am happy with qemu-args as well.
> 
> My concern is that applying the workaround to the rcutorture scripts might
> break someone else.  Plus it is hard to synchronize with qemu releases,
> to say nothing of distro releases containing qemu.  Hence my preference
> for use of kvm.sh's --qemu-args for this purpose.

Yes, that works for me.

Thanks a lot for the discussion!

 - Joel

