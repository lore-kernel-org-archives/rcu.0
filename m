Return-Path: <SRS0=Hkx7=5Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D07C2BA19
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09E2206F7
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586468436;
	bh=9dyLI5RAAKHVpf5COZohFfM4M1jp6nIK4sUdo1kFkzs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=khO91c/176mWNuttY23L+ewGhUZJjalLYPIQ/Pb6ePpLSarvTTtPzGxzFbuX9nuuG
	 R3oJ6nXNDtpg3tG93lR4JxTR+6vOw5Cwa45KcFgawMzCqpDEcn2QbTcLrYila/ACss
	 Ii0Fmrk2w4ECfLCx1Y90K8Y8s2LyM8tWYGIQr1KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDIVkf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgDIVkf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Apr 2020 17:40:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190BB206F7;
        Thu,  9 Apr 2020 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586468435;
        bh=9dyLI5RAAKHVpf5COZohFfM4M1jp6nIK4sUdo1kFkzs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aJKaSsi770ITcSPZwZK1Xhu+zGlFOpkapXQsesdzVgyK18jJ5sYwU5N6FF4rHBztt
         QL4cWsiCscOpjIfnz5VcI42FD50DbSQKFbpekLlFHGwdBX/n7bOvFfTqud2LDF/dj3
         0gTSZTmnp+l58U81jzFmNeKh7ZkHksBeS8Z0n6tc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E7D36352305F; Thu,  9 Apr 2020 14:40:34 -0700 (PDT)
Date:   Thu, 9 Apr 2020 14:40:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/rcu: fix a typo in RTFP
Message-ID: <20200409214034.GQ17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200409132437.11531-1-richard.weiyang@gmail.com>
 <20200409134634.GL17661@paulmck-ThinkPad-P72>
 <20200409211851.ttld7nmkqmncovhe@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409211851.ttld7nmkqmncovhe@master>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 09, 2020 at 09:18:51PM +0000, Wei Yang wrote:
> On Thu, Apr 09, 2020 at 06:46:34AM -0700, Paul E. McKenney wrote:
> >On Thu, Apr 09, 2020 at 01:24:37PM +0000, Wei Yang wrote:
> >> If I am correct, this character should be 'u'.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >
> >Nice!!!  ;-)
> >
> 
> Hi, Paul
> 
> Glad to hear from you.
> 
> >This is a play on words between the word you are thinking of and the
> >old UNIX "fsck" (filesystem check) utility.  It stays, but rest assured
> >that you did get point!
> >
> 
> Sorry I am confused.
> 
> My change is correct or the word fsck is correct and it means "read filesystem
> check papers"?

https://en.wikipedia.org/wiki/Fsck#As_an_expletive

Interestingly enough, this section is missing from the Chinese
translation of this page.  ;-)

							Thanx, Paul

> >> ---
> >>  Documentation/RCU/RTFP.txt | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
> >> index 9bccf16736f7..261eeb501ba5 100644
> >> --- a/Documentation/RCU/RTFP.txt
> >> +++ b/Documentation/RCU/RTFP.txt
> >> @@ -1,4 +1,4 @@
> >> -Read the Fscking Papers!
> >> +Read the Fucking Papers!
> >>  
> >>  
> >>  This document describes RCU-related publications, and is followed by
> >> -- 
> >> 2.23.0
> >> 
> 
> -- 
> Wei Yang
> Help you, Help me
