Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54203C4361B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 03:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093F522D0A
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 03:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgLJDJj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgLJDJj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 22:09:39 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC24C0613CF;
        Wed,  9 Dec 2020 19:08:59 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id m185so2487964qkf.12;
        Wed, 09 Dec 2020 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MGopRfIQ84njt41srjp1x814V/Gi4dHkKQji3y+cUbg=;
        b=BjaN1/8m2/L1jDHkgnKUTnvIbIg/6SupRzc1F3IjvAFt4wgMRPZImkHT/cZfv71cPG
         V/yGGxHJnOu5ceYB9zUTFZUKRbAdCoN095s4F+Zee045buNo6ujjZ+efQ7OmALeekJPg
         BGEC5So61ZIOgQ51qwXCWI+tlLMUda9JUWFeFGHkxKhJwMM0xEnzqN80d7iNk2V6LxRP
         ftK4yGSoqZMrKfMgr4XWjVxRni9CoFzz/BcmeSU9jS30pJslRdbMhG4WmGb1gVnsZoNy
         T6IdjXSPV/WItcgD9YEGYODu9W2XI0aPypF87tm3HvlUO95DgsAVR/gKNHkS5u3PyESV
         5P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MGopRfIQ84njt41srjp1x814V/Gi4dHkKQji3y+cUbg=;
        b=soRQppDBeSoPGw2SVfeDP0E7q01RnrSJBJoZUlo13TE5MJRN/QzhKt7J/87pskA0SF
         FTTd8V5unpQ6TQ4F9PGjtaORo8/4iLuNYQDl/BzzPAZ8M45cJlN0BLuRe6llIm9CvSGC
         eNxYDSWtJBLAXzCWSxS1U6A0zAH6Qn40F/BB0HNCuDNudDYXrGNFL2RwC4I95+1m2A4M
         Jgsn12UeJWNMiCoWTPzRiODgiqusSjKNKdRMMQNNck4VN1uZyhvto4zUbVeMfjY+v7sJ
         D026WLUkb+Cl5EkCz2+ub/Y6mdNSVnBqExOtFiJdn/y/83IVRS1dBA9Dq6b4KkblakgG
         VnbA==
X-Gm-Message-State: AOAM5316Sk6eMn5haJk9KEJl76aIF0Vf1aR/teWJrjkEp2TYX8LDkIj0
        x4GlzUtmd0vhYEO4JjGV7jw=
X-Google-Smtp-Source: ABdhPJyn6Wna66dBE92eS0xSo6cX5wP6yG4+dKkY3kp/pDluqC504qwCJ7Z71OPhFPaQWixGv2J08w==
X-Received: by 2002:a05:620a:69b:: with SMTP id f27mr6397306qkh.252.1607569738438;
        Wed, 09 Dec 2020 19:08:58 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v137sm2795917qka.110.2020.12.09.19.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:08:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CA9F527C0054;
        Wed,  9 Dec 2020 22:08:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Dec 2020 22:08:56 -0500
X-ME-Sender: <xms:R5HRX_0rtJQnnHpCOCgKDvYaLpjKFTueatCBsqb7XPGN2U0MPKycaQ>
    <xme:R5HRX0mo5YgR1zVljsBe3-ShA2UmSNmwzSZsMmbzGjx-csIDPl1qGfcecDO4JbZjN
    pxRlM4Rwrr4devvSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudeijedrvddvtddrvd
    druddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:R5HRX95HMKnB_2sX3xfQxhHPQJf5wXlBTYu1QE4T-RU01bu5aUUt7Q>
    <xmx:R5HRX3lZcjwf2OG_k7WpWjWGKpZU_9_UEbnIWVXWEb3HRNODknGY9g>
    <xmx:R5HRX4WxjFwGXy3i7t-gd1KSJDox3OB--t4y_o4ZuxcskdoDqbUQ5g>
    <xmx:SJHRX0SyI2JQY40KC-3tWLVoTQX7TnR-3BoXWNP0FgaC-D3HDGiYsG8gfgE>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CC20240065;
        Wed,  9 Dec 2020 22:08:55 -0500 (EST)
Date:   Thu, 10 Dec 2020 11:08:54 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/19] rcu/nocb: De-offload and re-offload support v4
Message-ID: <20201210030854.GA2958157@boqun-archlinux>
References: <20201113121334.166723-1-frederic@kernel.org>
 <20201208024131.GI3025@boqun-archlinux>
 <20201208125104.GB16597@lothringen>
 <20201210012158.GO2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210012158.GO2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 05:21:58PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 08, 2020 at 01:51:04PM +0100, Frederic Weisbecker wrote:
> > Hi Boqun Feng,
> > 
> > On Tue, Dec 08, 2020 at 10:41:31AM +0800, Boqun Feng wrote:
> > > Hi Frederic,
> > > 
> > > On Fri, Nov 13, 2020 at 01:13:15PM +0100, Frederic Weisbecker wrote:
> > > > This keeps growing up. Rest assured, most of it is debug code and sanity
> > > > checks.
> > > > 
> > > > Boqun Feng found that holding rnp lock while updating the offloaded
> > > > state of an rdp isn't needed, and he was right despite my initial
> > > > reaction. The sites that read the offloaded state while holding the rnp
> > > > lock are actually protected because they read it locally in a non
> > > > preemptible context.
> > > > 
> > > > So I removed the rnp lock in "rcu/nocb: De-offloading CB". And just to
> > > > make sure I'm not missing something, I added sanity checks that ensure
> > > > we always read the offloaded state in a safe way (3 last patches).
> > > > 
> > > > Still passes TREE01 (but I had to fight!)
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > > 	rcu/nocb-toggle-v4
> > > > 
> > > > HEAD: 579e15efa48fb6fc4ecf14961804051f385807fe
> > > > 
> > > 
> > > This whole series look good to me, plus I've run a test, so far
> > > everything seems working ;-) Here is my setup for the test:
> > > 
> > > I'm using a ARM64 guest (running on Hyper-V) to do the test, and the
> > > guest has 8 VCPUs. The code I'm using is v5.10-rc6 + Hyper-V ARM64 guest
> > > support [1] + your patchset (I actually did a merge from your
> > > rcu/nocb-toggle-v5 branch, because IIUC some modification for rcutorture
> > > is still in Paul's tree). I compiled with my normal configuration for
> > > ARM64 Hyper-V guest plus TREE01, boot the kernel with:
> > > 
> > > 	ignore_loglevel rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7	
> > > 
> > > and run rcutorture via:
> > > 
> > > 	modprobe rcutorture nocbs_nthreads=8 nocbs_toggle=1000 fwd_progress=0
> > > 
> > > I ran the rcutorture twice, one last for a week or so and one for a day
> > > or two and I didn't observe any problem so far. The latest test summary
> > > is:
> > > 
> > > 	[...] rcu-torture: rtc: 00000000f794686f ver: 2226396 tfle: 0 rta: 2226397 rtaf: 0 rtf: 2226385 rtmbe: 0 rtmbkf: 0/1390141 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 181415346 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 108102 nocb-toggles: 306964:306974 
> > > 
> > > Is there anything I'm missing for a useful test? Do you have other setup
> > > (kernel cmdline or rcutorture parameters) that you want me to try?
> > 
> > Thanks a lot for reviewing and testing. You seem to have tested with the right
> > options, I have nothing better to suggest. Plus I'm glad you tested on
> > ARM64. x86 is the only target I have tested so far.
> 
> Boqun, would you be willing to give your Tested-by?
> 

Sure, FWIW, for the whole series, feel free to add:

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 							Thanx, Paul
