Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A01C001B0
	for <rcu@archiver.kernel.org>; Mon, 24 Jul 2023 00:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGXAdB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 Jul 2023 20:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGXAdA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 23 Jul 2023 20:33:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F683AD
        for <rcu@vger.kernel.org>; Sun, 23 Jul 2023 17:32:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso89736539f.1
        for <rcu@vger.kernel.org>; Sun, 23 Jul 2023 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690158779; x=1690763579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okkG/ASud8bLD06JXRVQQQz75TIzTLjFE+g1R5XNRR0=;
        b=wzEpS8znt/KxoJH41SBjTpOAf7SjE8+6B76QKwyLShkp6frvxhQTjNA01CdMQpJvwH
         i4e46zjY7u+xtcpm3n+Jjpc1VkUT3Tx9CRwPSZ8n79ENbfx3zEJTBBIk/NVWzQ36PBkh
         WaiLgAMF89nIO4b973kH7KlJyNwsK2uARFgzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690158779; x=1690763579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okkG/ASud8bLD06JXRVQQQz75TIzTLjFE+g1R5XNRR0=;
        b=IB0A1NHcpQinZ+rRPgwaObTinsQrPPbl1gpjW+1gJYMxCTOxlkgLl/SJ+bqnVS6yie
         rAxYXyyMWnUxHAU8y2gMM8sg3yIsFZzKTkpsLxvQF6aaI72Q4MB0VaJ7l/qrSYPXSmU+
         JVDWHtrqGdYYNMHlYhlMUrYj7ZcWTAPCQBV4Z4IgoNz3vfdA5WpNoTrR1ub8JO+nEfqm
         EqfHyly76aTmEZM8Bu/39M6soXMAygBUqWkWJyRT6R4zU9652PxwW+JJCxe0/6Q+Yxpc
         eHPx9w1pId+IirJjNIGGU8Kw99zbk75QrJS59I+h5M3rLNCyiDwh8ouPAvFxYVML9pkb
         +6TQ==
X-Gm-Message-State: ABy/qLYxKjBnf/NbtGYS0AS27XaRT1QeEqILXgkXU7xboLtPn9MHM2Lj
        pZsulyI83XhS639kiFRYk8pUKg==
X-Google-Smtp-Source: APBJJlENT9DK1h4VT6XVyoZzt/3Fi6aMgmGbSTEM9F5klJFOr9BBANR8HvOe7z8qwGRAEPyA984uJw==
X-Received: by 2002:a5e:a810:0:b0:786:7100:5727 with SMTP id c16-20020a5ea810000000b0078671005727mr4057316ioa.1.1690158778914;
        Sun, 23 Jul 2023 17:32:58 -0700 (PDT)
Received: from localhost (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id m3-20020a056602018300b00786fd8e764bsm3115485ioo.0.2023.07.23.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 17:32:57 -0700 (PDT)
Date:   Mon, 24 Jul 2023 00:32:57 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <20230724003257.GA60074@google.com>
References: <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
 <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
 <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org>
 <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> > 
> > 
> > On 7/22/23 13:27, Paul E. McKenney wrote:
> > [..]
> > > 
> > > OK, if this kernel is non-preemptible, you are not running TREE03,
> > > correct?
> > > 
> > >> Next plan of action is to get sched_waking stack traces since I have a
> > >> very reliable repro of this now.
> > > 
> > > Too much fun!  ;-)
> > 
> > For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> > in stutter_wait() that is beating up the CPU0 for 4 seconds.
> > 
> > This is very similar to the issue I fixed in New year in d52d3a2bf408
> > ("torture: Fix hang during kthread shutdown phase")
> 
> Agreed, if there are enough kthreads, and all the kthreads are on a
> single CPU, this could consume that CPU.
> 
> > Adding a cond_resched() there also did not help.
> > 
> > I think the issue is the stutter thread fails to move spt forward
> > because it does not get CPU time. But spt == 1 should be very brief
> > AFAIU. I was wondering if we could set that to RT.
> 
> Or just use a single hrtimer-based wait for each kthread?

[Joel]
Yes this might be better, but there's still the issue that spt may not be set
back to 0 in some future release where the thread gets starved.

> > But also maybe the following will cure it like it did for the shutdown
> > issue, giving the stutter thread just enough CPU time to move spt forward.
> > 
> > Now I am trying the following and will let it run while I go do other
> > family related things. ;)
> 
> Good point, if this avoids the problem, that gives a strong indication
> that your hypothesis on the root cause is correct.

[Joel]
And the TREE07 issue is gone with that change! So I think I'll roll into a
patch and send it to you. But I am also hoping that you are Ok with me
setting the stutter thread to RT in addition to the longer schedule_timeout.
That's just to make it more robust since I think it is crucial that it does
not stutter threads indefinitely due to the scheduler (for any unforeseen
reason in the future, such as scheduler issues). And maybe, as a part of
that I could also tackle that other TODO item about cleaning up
torture_create_kthead() as well to add support to it for setting things to
RT and use it for that.

Let me know what you think, thanks!

 - Joel

