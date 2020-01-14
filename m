Return-Path: <SRS0=FQhq=3D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E3C33CB7
	for <rcu@archiver.kernel.org>; Tue, 14 Jan 2020 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0D224670
	for <rcu@archiver.kernel.org>; Tue, 14 Jan 2020 19:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HX1p1M7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANTRg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:17:36 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35647 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgANTRg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jan 2020 14:17:36 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so6321110pjc.0
        for <rcu@vger.kernel.org>; Tue, 14 Jan 2020 11:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KKog2MzKI2EmbmFRZbPQAj3SDffD3J1/gHWJI9GN8Ak=;
        b=HX1p1M7M0qxTTrjPtfNCyMe/XxOTqf3q/mYb+Bs7xX2IsBGHIdUtLmO3lbUJnekqs3
         zmZx8eaYvmH4+wfQapPvneyFUPr/+naxzGfN2z9odiTcSz9ffOPkHSr8fVCJMQIDdqjd
         8+zg9cI3eFRQ+yHpgNKile2uqExmKwhkD4jRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KKog2MzKI2EmbmFRZbPQAj3SDffD3J1/gHWJI9GN8Ak=;
        b=Ua7WYwIMi9+G2iDp5SE/JsVfR9uQl6cVSCrJuHpcIlpz93gp5QG+kg9MX3JTiwYCJ8
         9gYx6f84L9rcsQj6fIb5ecL+cblZT0ZH99EVTRv54EdioVw2umOjxZjEk25yynSeGi1a
         NUSKCWZFruloPk3goVUnLCBVa3QbYxjHqvip/pT52ebSPW9R0/RmM/RZLbyUS/R7tDT+
         WI6J4IbfZ/PVpphdUKTZiLRT/7twrxJQHgbf/flOZq8QQavlHxvjhjh8+LXwBB4LjK1K
         MGOcWUunIatQQApq913pOxNXYpp+mzjSHaGM+7UzYFqG3rRDtvwI4mSFmm0z4dpw0XSs
         Nctw==
X-Gm-Message-State: APjAAAX4P8jlsggBSnIQzgfouq+Xu8+uvpWYJBsCEZE3M+u5UwEhKxPo
        ydMD/uJExWBGB7xGPneDafV4ig==
X-Google-Smtp-Source: APXvYqz/3Tp3YfGdmLiQ3GBfQqRxYY+gia7aeZJwE4eJzKME0PsjfIh1cEmo6Hcm9w+t3OeBhqLjQg==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr31844615pjn.113.1579029455327;
        Tue, 14 Jan 2020 11:17:35 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b21sm20338404pfp.0.2020.01.14.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:17:34 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:17:33 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     dennis.dalessandro@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        mike.marciniszyn@intel.com, paulmck@kernel.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200114191733.GC103493@google.com>
References: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
 <20200114165740.GB22037@ziepe.ca>
 <74adec84-ec5b-ea1b-7adf-3f8608838259@intel.com>
 <25133367-6544-d0af-ae30-5178909748b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25133367-6544-d0af-ae30-5178909748b1@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 15, 2020 at 12:04:58AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Dennis Dalessandro <dennis.dalessandro@intel.com>
> 
> On 1/14/2020 12:00 PM, Dennis Dalessandro wrote:
> > On 1/14/2020 11:57 AM, Jason Gunthorpe wrote:
> > > On Tue, Jan 14, 2020 at 09:53:45PM +0530,
> > > madhuparnabhowmik04@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > 
> > > > list_for_each_entry_rcu has built-in RCU and lock checking.
> > > > Pass cond argument to list_for_each_entry_rcu.
> > > > 
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > >   drivers/infiniband/hw/hfi1/verbs.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/hfi1/verbs.c
> > > > b/drivers/infiniband/hw/hfi1/verbs.c
> > > > index 089e201d7550..22f2d4fd2577 100644
> > > > +++ b/drivers/infiniband/hw/hfi1/verbs.c
> > > > @@ -515,7 +515,7 @@ static inline void hfi1_handle_packet(struct
> > > > hfi1_packet *packet,
> > > >                          opa_get_lid(packet->dlid, 9B));
> > > >           if (!mcast)
> > > >               goto drop;
> > > > -        list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> > > > +        list_for_each_entry_rcu(p, &mcast->qp_list, list,
> > > > lockdep_is_held(&(ibp->rvp.lock))) {
> > > 
> > > Okay, this looks reasonable
> > > 
> > > Mike, Dennis, is this the right lock to test?
> > > 
> > 
> > I'm looking at that right now actually, I don't think this is correct.
> > Wanted to talk to Mike before I send a response though.
> > 
> > -Denny
> 
> That's definitely going to throw a ton of lock dep messages. It's not really
> the right lock either. Instead what we probably need to do is what we do in
> the non-multicast part of the code and take the rcu_read_lock().
> 
> I'd say hold off on this and we'll fix it right. Same goes for the qib one.
> 
> Alright, thank you for reviewing.
> 
> The rdmavt one though looks to be OK. I'll give it a test.

Madhuparna, there seems to be an issue with your mail client where it is not
quoting text correctly, either there is a '>' missing or there are too many.
Can you look into it and figure what's wrong with it?

thanks,

 - Joel

> 
> Thank you,
> Madhuparna
> 
> -Denny
