Return-Path: <SRS0=e+uF=U6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77122C5B578
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CCD206E0
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 21:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L81GFbx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGAVbL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:31:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43440 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVbK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jul 2019 17:31:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so6606274pgv.10
        for <rcu@vger.kernel.org>; Mon, 01 Jul 2019 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/3VftcDyULufJ2oLXcyl7qKFET9zh9U1crrvakTqBHA=;
        b=L81GFbx0bZNIGlxvEkg2pGiQNO+QOu2XUvBIJqHdXXbmhAaQF4KQ5YzA6WznqxUZtB
         spGBjjrFhCqA1iUhILHvBudreviNQ3WOry0a6ZuPr6glz71UrrXXED5SDOwcKPMVOrkX
         gHXE7Kd05wZzSYBbPytaPp5pI5mp7N2p0bmyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/3VftcDyULufJ2oLXcyl7qKFET9zh9U1crrvakTqBHA=;
        b=NzSaj3eBShiMh72GcdCqGnroBn6wguI+7o+peAQBFYC9u8cpv/aQ7aVoRBxUuFyAjW
         G6BeCvm90lRJbIqZlYoigrelisjQETbsq9VhQQQh3Wt3IVnszB2b68OcPwFZ2jYiQzJn
         0D8VdaGECcgSoLKbPPqQ06uCRk5L3KpT+hkmRsLQkEA1+3Z5JIarAWqsaI6SLQZiXJqv
         nazqIEIJhJ4aVrD4zuTmHTLkrSrb0+jRSpe8/fpCC/RKBCHVTUz/wIZ/DAe/wkYOShfy
         atVxyM5EQF/p2ZqM+VJHkbHgybXRoBQYQis1r1eWppatCNogTr5uJ4qBrKtonuR69ZOA
         wfUg==
X-Gm-Message-State: APjAAAV3OdsrMVzh1L/rzjfDjrJRxnGVzleMt8tXAY5eK74KyNKoGXzy
        dJcGyDs83uwH8jdnCTEJRIqfgt4FX58=
X-Google-Smtp-Source: APXvYqzNspxXTnotf4qGtI2H8bePxVsykQfVR3XBpp2fKQpUh4p1DVx5fgrbpkmMweO0H4etfPU7GA==
X-Received: by 2002:a63:a1f:: with SMTP id 31mr26566577pgk.66.1562016669814;
        Mon, 01 Jul 2019 14:31:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e6sm11596170pfn.71.2019.07.01.14.31.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:31:09 -0700 (PDT)
Date:   Mon, 1 Jul 2019 17:31:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190701213107.GA240327@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
 <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
 <20190701141403.GA246562@google.com>
 <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
 <20190701145920.GA71270@google.com>
 <20190701202727.GR26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701202727.GR26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 01, 2019 at 01:27:27PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 01, 2019 at 10:59:20AM -0400, Joel Fernandes wrote:
> > On Mon, Jul 01, 2019 at 04:48:43PM +0200, Dmitry Vyukov wrote:
> > > On Mon, Jul 1, 2019 at 4:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > > > > > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > > > > > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > > > > > runs but does nothing.
> > > > >
> > > > > Nope. I would like to know *why* you need 'noapic' to work. Is it a
> > > > > brand new or old qemu-system-x86_64?
> > > >
> > > > I did not have time to debug yesterday and I posted this particular revert as
> > > > an 'RFC' just to make aware of this problem.
> > > >
> > > > I spent some more time just now, it looks like this has nothing to do with
> > > > 'noapic' and appears to be a problem on debian distros with the e1000e NIC.
> > > > May be this NIC was added to the virtual hardware because of -machine in the
> > > > patch?
> > > >
> > > > Any if I add the following to the qemu command that kvm.sh runs, it works again:
> > > > -net nic,model=e1000
> > > >
> > > > Without it I get:
> > > >  qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"
> > > >
> > > > Seems to be mentioned here:
> > > > https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211
> > > >
> > > > And in syzkaller as well:
> > > > https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88
> > > >
> > > > Adding Dmitry who is syzkaller owner for any thoughts as well.
> > > 
> > > I don't have many thoughts on this. That particular error looked like
> > > a bug in the package in the particular distro/version.
> > 
> > Paul, what is your preference here? Can we add the -net nic,model=e1000 to
> > fix it for the benefit of any other Debian folks running kvm.sh?
> > 
> > Or do you prefer if I just built my own custom Qemu? I can't upgrade Qemu on
> > this machine unfortunately. But may be I can build my own.
> > 
> > I prefer the -net option since I can save the time for something else. ;) Let
> > me know what you prefer and I'll fix it accordingly.
> 
> Why not just add the following to your kvm.sh command line?
> 
> 	--qemu-args "-net nic,model=e1000"
> 
> Easy workaround and no need to wait for changes to hit mainline.
> 
> Yes, I am perhaps naively assuming that the qemu bug in Debian will
> be fixed in about the time that it would take for any change to the
> rcutorture scripting to make its way into mainline.  ;-)
> 

Thanks for the pointer to the args! Just what I wanted.

Only down side is then we run into the risk of other developers running
kvm.sh on debian as well and wondering why torture is broken. Perhaps the kvm
tweaks commit hasn't hit that many machines yet but it might. At least we
have this discussion archive here to guide such poor souls, if we don't want
to append these arguments by default ;-)

The other fix, could be I just build and run a new custom qemu instance but I
am happy with qemu-args as well.

thanks,

 J.

> 							Thanx, Paul
