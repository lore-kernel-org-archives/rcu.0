Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D28C11F64
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475F16140D
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 19:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGAT7c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 15:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhGAT7c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 15:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6231160233;
        Thu,  1 Jul 2021 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625169421;
        bh=P6FMnPh5QE8ld7D7J60u5bTaKEaCvw7UhT4hTLM9ms4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dJs44HlooD4EYdg0C3YlMNAcJ5lg6Hd6w1ktQeQaA+485/xniyNE12bKxr/7rtv6w
         htC3HvJH+4NJrWZXc29WheUPBnC26ZrgoW7XdKXZ+JgnwR4K3MOlMPuN+LI49VU+gK
         TECx3i2ECa1SRaw1MY4hgQegTVp8MbfTBnaCtMtwIdRs4wonpxJSLlEvHYRzV1l0Rf
         fSdoKesbJATUMWGAx6FdsB1uof60cBFy29mgrhnPeQDSvzVckV6SsJLsH9SB1WKAKc
         XM8rmQ216LobZ58IyWZghfYkxNl5/VgZ8sfKwPgB52DoEDpvsgNE9baS3lgfzcTtky
         4f+lTdPtI/X2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2C9CA5C04BC; Thu,  1 Jul 2021 12:57:01 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:57:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        Liu Song <fishland@aliyun.com>, liu.song11@zte.com.cn,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
Message-ID: <20210701195701.GG4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210630140802.39138-1-fishland@aliyun.com>
 <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
 <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <bb788228-9756-2ee9-f11c-eae133c34593@codeaurora.org>
 <20210701183933.GA1948@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701183933.GA1948@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 01, 2021 at 08:39:33PM +0200, Uladzislau Rezki wrote:
> On Thu, Jul 01, 2021 at 10:35:43PM +0530, Neeraj Upadhyay wrote:
> > 
> > 
> > On 7/1/2021 10:01 PM, Paul E. McKenney wrote:
> > > On Thu, Jul 01, 2021 at 08:24:32PM +0530, Neeraj Upadhyay wrote:
> > > > 
> > > > 
> > > > On 6/30/2021 7:38 PM, Liu Song wrote:
> > > > > From: Liu Song <liu.song11@zte.com.cn>
> > > > > 
> > > > > In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> > > > > pointers. This patch adjusts a few codes that have not done so.
> > > > > 
> > > > 
> > > > Minor: Can we also add below statement?
> > > > "This patch doesn't introduce any functional change."
> > > > 
> > > > > Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> > > 
> > > Applied with the usual wordsmithing, including adding words to this
> > > effect, so thank you all!  I removed the obsolete chunk that Neeraj
> > > pointed out as well.
> > > 
> > > Please take a look and check to see if all is well.
> > > 
> > 
> > Looks good to me
> > 
> Same to me. Looks good.
> 
> There are two dots though in the commit message: "change.." :)

Good eyes, fixed, thank you!

							Thanx, Paul
