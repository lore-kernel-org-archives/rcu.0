Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4040DC48BD7
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2812054F
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 16:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNnwQ4np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF0Qrw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:47:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37667 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF0Qrw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jun 2019 12:47:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so2981606otp.4;
        Thu, 27 Jun 2019 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S1JTLWONeYHszNksz5yX0e4HLpZ/otqice4fh/k9YV4=;
        b=BNnwQ4npcQVu/OBkWNkt02z2xp3JBy/JRiLTrr7of+u7+tWol2azW2pVCpmzd1io8u
         K0pXnLQ7v5bCt3S+imlKjFbA5053YlMTI4pA3/lnGLZNFKN69dG+nCPuHsO0X5LslB1R
         mqah6EB9X4hSRBpyzUNJ0EJdIRAvwdc9AuTHHphPLymLTcCgOw3/vuu0PZB3n/ieZtbX
         gEpenO8Ay5i4n/CVhttiwLtak5UOVNn026296FU3XLtE6K7ZdsK0Z9AdwybvD0kpCCXX
         2u2Y8tNqla51StShTMRqVc/q8ucwpnPDbth6PhgefuSa3fXVcvE45PUejODHbq+w0EWX
         AdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S1JTLWONeYHszNksz5yX0e4HLpZ/otqice4fh/k9YV4=;
        b=jabnifSbqzrKufEO2No5+62X3MZwtKeC5MQCY3YXUSCytR08lXj6IKc16Dxi0D2BwJ
         bYLivpGTelCDGW3BZfri3vBOu2b9p7OMkkOVJ5KqHThbHFcXo6SMeavbnQf1QMY+5Ttt
         Am5yRv7209CecJjdS0F8xJV//h5Cpe7k/HrMIOH/BANqGVhoYskzL+pyHef0HTRpaVLV
         o+1Bngkk0QUivKcLskRobZYxnlB4kBoKel4Ka9tKJWujlroMr4+jg148gyZFAYtF1b3f
         SKEqU0+syXxV1D07feQDhx+ZuKsdtOnzAUjy+LJQ/XCRKONHvWTtODouhErih+UG9l1r
         pjLg==
X-Gm-Message-State: APjAAAUekrpa/c95YSEL9StIr5DAiclHcXhixpex3XXQH+SATtaeBDr7
        8L0rnngLMhtNJdHgGL7PG6k=
X-Google-Smtp-Source: APXvYqwKh7OXwkb6/brR9MO8fVAuBeJBRvb99KHVeIM+pAHgIu8fXZUd6v+F2lrwrFwQBlRQytSKwg==
X-Received: by 2002:a05:6830:13c3:: with SMTP id e3mr3709438otq.253.1561654071690;
        Thu, 27 Jun 2019 09:47:51 -0700 (PDT)
Received: from rYz3n ([2600:1700:210:3790::48])
        by smtp.gmail.com with ESMTPSA id k18sm959379oib.56.2019.06.27.09.47.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 09:47:51 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:47:50 -0500
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v5 1/5] Documentation: RCU: Convert
 RCU basic concepts to reST
Message-ID: <20190627164748.qeg7o2ixwe5yu3i4@rYz3n>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
 <20190626200705.24501-2-c0d1n61at3@gmail.com>
 <20190627083443.4f4918a7@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627083443.4f4918a7@lwn.net>
User-Agent: NeoMutt/20180716
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 27, 2019 at 08:34:43AM -0600, Jonathan Corbet wrote:
> On Wed, 26 Jun 2019 15:07:01 -0500
> Jiunn Chang <c0d1n61at3@gmail.com> wrote:
> 
> > RCU basic concepts reST markup.
> > 
> > Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> So this is a little detail but ... your signoff should be the last thing
> in the set of tags on the patch.
> 
> This isn't worth making you do yet another revision, so I went ahead and
> applied the patches and fixed the tag ordering on the way in.  I'll also
> append a patch adding the new RCU stuff into the core-api manual so people
> can actually get to it.
> 
> Thanks,
> 
> jon

Hello Jon,

I will keep this in mind for next time.  I would like to thank you, Joel, Paul
and everyone else who has helped me learn the Linux kernel patch process.

I will send a patch for the UP systems change Paul sent me for _bh suffix.

THX,

Jiunn
