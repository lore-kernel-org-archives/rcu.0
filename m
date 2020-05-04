Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB657C4724C
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8C4206B8
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 18:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gnaxHkTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgEDSIJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732232AbgEDSIH (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 14:08:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D015C061A0F
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 11:08:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so482101qke.7
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8lqlcqzLSXs6kQK5WzXKsA6SXfOJlZ0T+LEde0fpTBU=;
        b=gnaxHkTW0xp32Dnjn0U3/jhSQEoLB3QVuJZRpwpZQqGjQpILV2SWkM0bQgd73dRrsh
         V/J7zKNRB3rG2HTqPTTN47hpUnZBw81Uv14JodvK3TSNjF1447WH41WQOwua+88IdE35
         RQ58FtnvDfzr+hliOFTTwbzGh4QByFIFewB78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lqlcqzLSXs6kQK5WzXKsA6SXfOJlZ0T+LEde0fpTBU=;
        b=fg9RYYmUqqgLK5T02gCs91cIMAcQyrK6bSsB5MaTTBe86jbOrvE+EUTMGC0FK4mVwa
         1XqV9v8K+DeqaBUQ3IjViHR6RD5sReqvJYQB18rVBhROBjcOxnuiCQrDl3V/WnL99Wkw
         jy5QRoBoYS1efALzIZSugha29O7BOzj7vUv8cD62qcWXUwIZ8GR+cmoRGdiwRCK5wbRQ
         ghrYrrNuOssQwdgkWYG81iimGlRkYwYptaikSbHvvkOljp6eTM9r44fjBa0mTLx0mnvX
         6PQkn9ugS86EDDg7LG6dUiKq5eRr10cm+zrHzmfVCnndRVhAcLeXb2vCrrbtcyVP7XGb
         gmwQ==
X-Gm-Message-State: AGi0Pua/Ig2kga0KGTzccR/XkDGGgtYuEBuWtp3o3BLQZYFLCi1tjA9a
        3FDb9HGVCi3SlOXRM2HaMNkjVA==
X-Google-Smtp-Source: APiQypI5eZszvopLJuDAZRuwCkGzdKXSDC/oOtdUeAQZtCszD77WvOxRYkXISoFQHLqf83/FhKwcrg==
X-Received: by 2002:a37:809:: with SMTP id 9mr468583qki.93.1588615686148;
        Mon, 04 May 2020 11:08:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g16sm8606827qkk.122.2020.05.04.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:08:05 -0700 (PDT)
Date:   Mon, 4 May 2020 14:08:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504180805.GA172409@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
 <20200504174822.GA20446@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504174822.GA20446@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 07:48:22PM +0200, Uladzislau Rezki wrote:
> On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
[..] 
> > > > Presumably the list can also be accessed without holding this lock,
> > > > because otherwise we shouldn't need llist...
> > > > 
> > > Hm... We increase the number of elements in cache, therefore it is not
> > > lockless. From the other hand i used llist_head to maintain the cache
> > > because it is single linked list, we do not need "*prev" link. Also
> > > we do not need to init the list.
> > > 
> > > But i can change it to list_head. Please let me know if i need :)
> > 
> > Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> > callback processing, the operations were open-coded, but they have been
> > pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> > 
> > Maybe some non-atomic/protected/whatever macros in the llist.h file?
> > Or maybe just open-code the singly linked list?  (Probably not the
> > best choice, though.)  Add comments stating that the atomic properties
> > of the llist functions aren't neded?  Something else?
> >
> In order to keep it simple i can replace llist_head by the list_head?

Just to clarify for me, what is the disadvantage of using llist here?

Since we don't care about traversing backwards, isn't it better to use llist
for this usecase?

I think Vlad is using locking as we're also tracking the size of the llist to
know when to free pages. This tracking could suffer from the lost-update
problem without any locking, 2 lockless llist_add happened simulatenously.

Also if list_head is used, it will take more space and still use locking.

Thoughts?

thanks,

 - Joel

> > 
> > The comments would be a good start.  Just to take pity on people seeing
> > the potential for concurrency and wondering how the concurrent accesses
> > actually happen.  ;-)
> > 
> Sounds like you are kidding me :) 
> 
> --
> Vlad Rezki
