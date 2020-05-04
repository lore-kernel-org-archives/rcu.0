Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0457C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7805A206A4
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAh8Ld/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgEDRs2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728158AbgEDRs1 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 13:48:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A1C061A0E;
        Mon,  4 May 2020 10:48:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w14so10567081lfk.3;
        Mon, 04 May 2020 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufpIeFmcKaIEVY6FRQ1/+O0Pn/Xjsjbz3pEhyns+6jw=;
        b=ZAh8Ld/jlx1jmmCPIeCJ2rRIos8a28KH8H/Hrer+1tyMica5znVSMEwwO+OBBIC118
         AmsTqZyFLfNTy1AOmddTyJ+moXb+7dL8miYOHqkVf/52UC3Xa6oEDUKGEBwhpo5ZC9a+
         VDHRMAsK2QUnNIQyxPuesRC6DS7l96p96vDP/gIHTxlljh3CfX+p8hzv8mE0Dp8aH+pi
         3vJfOmSQWMpvetNst/kEbw8cHuHV9Zh6DR/lMAZhmyh+pyA8Y7Sr1oeBsLSX5QSoUIN7
         8XLvymEJggFvYiMN7t3D4X/1ldL3MiZIE4Zl9Di/a5FvBHfHaNvR3zbedERWypJmyrQ0
         ZntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufpIeFmcKaIEVY6FRQ1/+O0Pn/Xjsjbz3pEhyns+6jw=;
        b=DyWCm1+a5t5hUrV3j256baBRHjt6JIZClJwTSK6zH0qAVH2MX9r0fAL9XbycZr5EyH
         a2v8hM9KhQF4eSYMFWmcg+wWdkP+kfVqhLgk4mBnqvSvvsswzeSOUXi3x5p83HcRK9an
         oKPSMDghklNXluNn6l9G4cEqqZoRCCPZex+Sv4cYfquEKHS3sFPZlGGfdu0KNYzaGVuV
         NkrGm2PfTUAg8PQm1VKf12Zin0/BN4/kpmYXhc9Zzjczdr05OwCGOO8GJTy429ftDxVx
         ohQTc4cu30SxpcU7hDy7398uX63K7EeJMkSn1oqr05eI9PcFyLixPaNvPddW45ndQdwB
         ZFlg==
X-Gm-Message-State: AGi0PuYUwQqIHcJJqc7gi6AYUsdO54L3c6NOcndZp+7r9HQbw9DkkACL
        gcppD/omxo7coyTAe7cHqAk=
X-Google-Smtp-Source: APiQypIn9k+BgZSHofdoK+xEoluwCmPe+zJr6r5AGYebAphv3YmqBkABK1xXyqd/fIQaBVPC/Bow8w==
X-Received: by 2002:ac2:53af:: with SMTP id j15mr251493lfh.191.1588614505736;
        Mon, 04 May 2020 10:48:25 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n7sm11138476ljj.72.2020.05.04.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:48:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 19:48:22 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504174822.GA20446@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
 <20200504152437.GK2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504152437.GK2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 08:24:37AM -0700, Paul E. McKenney wrote:
> On Mon, May 04, 2020 at 02:43:23PM +0200, Uladzislau Rezki wrote:
> > On Fri, May 01, 2020 at 02:27:49PM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 28, 2020 at 10:58:48PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Cache some extra objects per-CPU. During reclaim process
> > > > some pages are cached instead of releasing by linking them
> > > > into the list. Such approach provides O(1) access time to
> > > > the cache.
> > > > 
> > > > That reduces number of requests to the page allocator, also
> > > > that makes it more helpful if a low memory condition occurs.
> > > > 
> > > > A parameter reflecting the minimum allowed pages to be
> > > > cached per one CPU is propagated via sysfs, it is read
> > > > only, the name is "rcu_min_cached_objs".
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 60 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 89e9ca3f4e3e..d8975819b1c9 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -178,6 +178,14 @@ module_param(gp_init_delay, int, 0444);
> > > >  static int gp_cleanup_delay;
> > > >  module_param(gp_cleanup_delay, int, 0444);
> > > >  
> > > > +/*
> > > > + * This rcu parameter is read-only, but can be write also.
> > > 
> > > You mean that although the parameter is read-only, you see no reason
> > > why it could not be converted to writeable?
> > > 
> > I added just a note. If it is writable, then we can change the size of the
> > per-CPU cache dynamically, i.e. "echo 5 > /sys/.../rcu_min_cached_objs"
> > would cache 5 pages. But i do not have a strong opinion if it should be
> > writable.
> > 
> > > If it was writeable, and a given CPU had the maximum numbr of cached
> > > objects, the rcu_min_cached_objs value was decreased, but that CPU never
> > > saw another kfree_rcu(), would the number of cached objects change?
> > > 
> > No. It works the way: unqueue the page from cache in the kfree_rcu(),
> > whereas "rcu work" will put it back if number of objects < rcu_min_cached_objs,
> > if >= will free the page.
> 
> Just to make sure I understand...  If someone writes a smaller number to
> the sysfs variable, the per-CPU caches will be decreased at that point,
> immediately during that sysfs write?  Or are you saying something else?
> 
This patch defines it as read-only. It defines the minimum threshold that
controls number of elements in the per-CPU cache. If we decide to make it
write also, then we will have full of freedom how to define its behavior,
i.e. it is not defined because it is read only.


> > > Presumably the list can also be accessed without holding this lock,
> > > because otherwise we shouldn't need llist...
> > > 
> > Hm... We increase the number of elements in cache, therefore it is not
> > lockless. From the other hand i used llist_head to maintain the cache
> > because it is single linked list, we do not need "*prev" link. Also
> > we do not need to init the list.
> > 
> > But i can change it to list_head. Please let me know if i need :)
> 
> Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
> callback processing, the operations were open-coded, but they have been
> pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.
> 
> Maybe some non-atomic/protected/whatever macros in the llist.h file?
> Or maybe just open-code the singly linked list?  (Probably not the
> best choice, though.)  Add comments stating that the atomic properties
> of the llist functions aren't neded?  Something else?
>
In order to keep it simple i can replace llist_head by the list_head?

> 
> The comments would be a good start.  Just to take pity on people seeing
> the potential for concurrency and wondering how the concurrent accesses
> actually happen.  ;-)
> 
Sounds like you are kidding me :) 

--
Vlad Rezki
