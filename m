Return-Path: <SRS0=e+uF=U6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528AC0650E
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 14:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76D920665
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 14:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XTLNTxAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfGAO7X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:59:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43970 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAO7X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jul 2019 10:59:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so6178877pgv.10
        for <rcu@vger.kernel.org>; Mon, 01 Jul 2019 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5y62+0FFlEOJ4wqoIJ4BKfS4aH2ZeWmGiU2RoeaVxs=;
        b=XTLNTxAmcLMByyqS4pDTU8M4JggErW2udQuU2wfqaKXiorMn7AamHAOPsEi/Hf4wtO
         r9pYiqSz19wiMLywDzCxMO6GkSCQ0QQFIME9nHcNHkGiWwn+8RnDndTb1YO7foRsEM2Z
         LJJDU7GEnNCejqBFfasWPXe5l8kYxRp+iB2fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5y62+0FFlEOJ4wqoIJ4BKfS4aH2ZeWmGiU2RoeaVxs=;
        b=ZOc77trADRSf/x0I+lAfbzoggZh6KO21gG1TRnPA1iOr0OeRfJWTTzSLe4zIRl45EW
         k++0eUP+QQxfM2Dk+0Dy9wNIHBGsrh71w7MZ7ixbXc9PdcQKZ8ErFpDPRPtwyQyOVkUr
         JfbLCzAjAhLqGXAUu+T5dJHl2hTjYL3hlmr/KGH7MP4qVwsRXRf/5FUVS1eiX14m/hcP
         JQpoO/ulmMOJ3/pHu/22cuyb0DMWve8IZT5JIYRnLgUfdECbGTnzlR8EGqtEvDBaS7h0
         XNIh8vFpJkLkCA8fg2Vs/I3A+voFN3VyDcLoD5WL6MBrOIf9AO0I5+I0o3Qgp8lofGxu
         G3SA==
X-Gm-Message-State: APjAAAUf48H50MZka9CYyPcXO4+v2TmO5Ja1KtY2vWzguaq6+WRK3XkK
        4xHBGRjxMHH1wsW/1d9Nv682CFCGOQY=
X-Google-Smtp-Source: APXvYqwdPuDzJMGgvRb3FdkTBcAuOJNmpkvejGQK0WCO10NaOnX+8wcnoOKHS9VKBXBaRiw1SOTDMQ==
X-Received: by 2002:a17:90a:fa12:: with SMTP id cm18mr31568290pjb.137.1561993162315;
        Mon, 01 Jul 2019 07:59:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s129sm10737707pfb.186.2019.07.01.07.59.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:59:21 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:59:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190701145920.GA71270@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
 <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
 <20190701141403.GA246562@google.com>
 <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 01, 2019 at 04:48:43PM +0200, Dmitry Vyukov wrote:
> On Mon, Jul 1, 2019 at 4:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > > > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > > > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > > > runs but does nothing.
> > >
> > > Nope. I would like to know *why* you need 'noapic' to work. Is it a
> > > brand new or old qemu-system-x86_64?
> >
> > I did not have time to debug yesterday and I posted this particular revert as
> > an 'RFC' just to make aware of this problem.
> >
> > I spent some more time just now, it looks like this has nothing to do with
> > 'noapic' and appears to be a problem on debian distros with the e1000e NIC.
> > May be this NIC was added to the virtual hardware because of -machine in the
> > patch?
> >
> > Any if I add the following to the qemu command that kvm.sh runs, it works again:
> > -net nic,model=e1000
> >
> > Without it I get:
> >  qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"
> >
> > Seems to be mentioned here:
> > https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211
> >
> > And in syzkaller as well:
> > https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88
> >
> > Adding Dmitry who is syzkaller owner for any thoughts as well.
> 
> I don't have many thoughts on this. That particular error looked like
> a bug in the package in the particular distro/version.

Paul, what is your preference here? Can we add the -net nic,model=e1000 to
fix it for the benefit of any other Debian folks running kvm.sh?

Or do you prefer if I just built my own custom Qemu? I can't upgrade Qemu on
this machine unfortunately. But may be I can build my own.

I prefer the -net option since I can save the time for something else. ;) Let
me know what you prefer and I'll fix it accordingly.

thanks,

 J.

