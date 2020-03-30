Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B958C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 12:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5015B206F6
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgDgFjod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgC3MtD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:49:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39528 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgC3MtC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 08:49:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so17905465ljn.6;
        Mon, 30 Mar 2020 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yJlVVKeLd5TaPn/Me6iYYSCfAeG+ZykuXZ4qCxcjxic=;
        b=mgDgFjodGfs/tgXVpHOm+ddXiwOlaywSDzMN6XLWzY25fepCZ4bXct6/IC+71pO1sr
         JbRdrFIoAL4XCxQDqiTYKJN/AZDrieZjoG824C+naszyUxFttD5SMzK0u9nz839I8VdM
         hT5HPfEcDWfBFcKOxnaXqt7zfXdoLbFql10zPJ9XWK94zZqB1s6vCY2R43uMT6JxxkPP
         UvsB6TEtlR6DpdOxJwnEEAqi5xUiCrTE2bVdTRCie9GFnQOsaj+o9c9OqPbsOAgrNjhq
         O02GP6+WxV5FHnlIIpSJ7mM8BoJYxv9ecUIhV2uCtDgmVxoLn8Eppw5/RQ9UpJTjeMaW
         vH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJlVVKeLd5TaPn/Me6iYYSCfAeG+ZykuXZ4qCxcjxic=;
        b=UWsJ5F/6fNlyQ+PRdEP5o9oeaTcLSSDzGAHkk7nY9Z9PCj8LdHtQBwnZZCqYPG4F+n
         mcBP1XcGApOkGtNuI+5zYrIc6uQPAVj23mvwRYaGE2eqjgUKVEHQg1MH0ViriqR/+FVS
         r/1yutVqKg51ZJSxGw6K/XALsQRdILRolu6C/PaSNl6MHB3ubhakAJOmQ9+uAjOMd5QN
         9DJU9vazxFiVFxatQCJt6i9VQzAlzL6D+irCor9PA+eS3y2b3cNiak857FZ2qOE80Jcp
         CeiWaboMrdLNJCCvS+B8M2RU/iGmIl95PJtVPaXfu0Et2qmMGulk3SYJTl0VS2oxYyCJ
         B6Cw==
X-Gm-Message-State: AGi0PuarIylmTnXFHYnDIlhURuTzVVc5sl7UZzk7+TSo+2bqBUg/f0dj
        VaC59J6fR1d2xWbHbyUUbyM=
X-Google-Smtp-Source: APiQypKg5+v/r/XUQa3s09TJaeKdUyJILEy3iif1u9ojSl1WAemanDLN4DIPvO94A+atsysEq63ulg==
X-Received: by 2002:a2e:9097:: with SMTP id l23mr510984ljg.279.1585572539723;
        Mon, 30 Mar 2020 05:48:59 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r9sm6813068ljd.10.2020.03.30.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 05:48:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 30 Mar 2020 14:48:41 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 4/7] rcu/tree: support reclaim for head-less object
Message-ID: <20200330124841.GA15431@pc636>
References: <20200323113621.12048-1-urezki@gmail.com>
 <20200323113621.12048-5-urezki@gmail.com>
 <20200329225610.GA102186@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329225610.GA102186@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> Very nice work, Vlad! And beautifully split! Makes it easy to review! One
> comment below but otherwise patches 1-4 look good to me, I will look at
> others as well now. I have some patches on top of the series, mostly little
> clean ups which I will send together with yours.
> 
Thanks, Joel!


> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 94 +++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 86 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 869a72e25d38..5a64c92feafc 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2892,19 +2892,34 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	 * when we could not allocate a bulk array.
> >  	 *
> >  	 * Under that condition an object is queued to the
> > -	 * list instead.
> > +	 * list instead. Please note that head-less objects
> > +	 * have dynamically attached rcu_head, so they also
> > +	 * contain a back-pointer that has to be freed.
> >  	 */
> >  	for (; head; head = next) {
> >  		unsigned long offset = (unsigned long)head->func;
> > -		void *ptr = (void *)head - offset;
> > +		bool headless;
> > +		void *ptr;
> >  
> >  		next = head->next;
> > +
> > +		/* We tag the headless object, if so adjust offset. */
> > +		headless = (((unsigned long) head - offset) & BIT(0));
> > +		if (headless)
> > +			offset -= 1;
> 
> Just to be sure, can vmalloc() ever allocate an object at an odd valued
> memory address? I'm not fully sure looking at vmalloc code whether this is
> the case.
>
No. It must be PAGE_ALIGNED(addr). 

> 
> As per the tagging, allocated objects have to at least at a 2-byte boundary
> for the pointer's BIT(0) to be available. If that's not the case, we need to
> add a warning to the code at a bare minimum.
> 
> Another approach which is better I think is to add the tag to the offset
> itself. So if the offset is > LONG_MAX / 2 or something like that, then
> assume it is headless, and override offset to sizeof(unsigned long *) in that
> case. Then you would arrive at the correct pointer for the wrapper. That
> would take care of the case where in the future, either SLAB or vmalloc()
> ends up returning pointers that are only byte-aligned.
> 
> Thoughts?
> 
I saw your https://lkml.org/lkml/2020/3/29/480. I think it is OK,
and we can go your way. There is advantage that it is tolerate to
any alignment :)

Thanks!

--
Vlad Rezki
