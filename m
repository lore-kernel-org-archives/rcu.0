Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4284C433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 14:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9795920716
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6gtUdPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMOWs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMOWs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 10:22:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B89C061757;
        Thu, 13 Aug 2020 07:22:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c15so3142984lfi.3;
        Thu, 13 Aug 2020 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8+HCeEKYDSAzBIC/4Ytqu8YSMHhVGSgqY8osWVZbTo=;
        b=t6gtUdPFyH90g0kuyxr8PAuQf/gGRlY1CSRb6+5HHZ4Z3A6sSM0v0Fh5I3HQ80FiiG
         MnLOay61Va70sOQ8qRblYMrU9c8Dohz40DCeve+8nD53n25Ydx8IeAz1kxfVaK6eRoS2
         HxjN7PZg+VY0rNR4kj5OQ3KYet4StJVgNappY8wNv6zQdnPzphhQ2xiO219Cv6nK6z6o
         X9vEvIU+Wuol6s3FDeAeokbOeObxL6Ad+dNvGZjlCTCt3SG8C2PVgCWYjTueu7d70Vw7
         /ukwwdLabgbTzZbvMUvl9Jbs5kkWPR8P5FKEGJquYPlEjHWzFxRHtrsaA7ukFvo2XfIa
         qD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8+HCeEKYDSAzBIC/4Ytqu8YSMHhVGSgqY8osWVZbTo=;
        b=pv4WUC0hU2hzWDPK1yDbIuV/2kVJl9+iaebBzOK+xXGYBO9Vr4jQopyzQe+iG2SUv2
         RXb0XbFmBAdntn49N0GNXShG8mHhSIZm/sQVlEDrwGok35aTbQ2Lv07FTduu+2xZOTjw
         PLTtcQ5NyleOLOro9x40Rbv6E+98jcJnUbkdPvFhz9ObA0+NPVUBbKWI65JTMOoiKRdh
         PRfNd96RSNlcG5L0x01rPP8nIJeaeOyXz19WrKO717HIEc/Uc1c/VayW1yc2Ez6J0ELm
         R51dra2ap25g9Bs1P0aVxkFcD0G3XDAA4exs8alDXxGNFFVmJGwbEoPlWzCwak14j+QR
         JZbA==
X-Gm-Message-State: AOAM531+YjGNt8QklzVsojMFfSaUl2y3538wXYTvuFYVv5I4dtqIIC6H
        fNw1erO3OroVUj314c4r/rw=
X-Google-Smtp-Source: ABdhPJwkGpxkpofNQlm4NTGG260rebKIv4E7sq4PKxuhwxmvCnamsgWJnyNpnbHSWgBZU6c7um1cyA==
X-Received: by 2002:a19:c3d0:: with SMTP id t199mr2331028lff.56.1597328566067;
        Thu, 13 Aug 2020 07:22:46 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x2sm1132506ljc.123.2020.08.13.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 07:22:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 13 Aug 2020 16:22:43 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813142243.GA26852@pc636>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <20200813132931.GA26290@pc636>
 <20200813134039.GL9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813134039.GL9477@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 03:41:39PM +0200, Michal Hocko wrote:
> On Thu 13-08-20 15:29:31, Uladzislau Rezki wrote:
> [...]
> > I was a bit out of focus and did not mention about one thing. Identifying the context
> > type using preemtable() primitives looks a bit not suitable, IMHO. GFP_* flags are
> > not supposed to identify a context type, because it is not possible for all cases.
> 
> Yes, GFP flags do not identify context and that is why my draft didn't
> really consider gfp flags for anything but the retry logic which is
> already gfp based already. The buddy allocator path simply always bails
> out for those rt atomic paths whenever it gets close to zone->lock
> 
> > But that i
> 
> You meant to say more I guess
> 
Ahh. Right. It was not completed. The idea was that we do not really need 
to identify preemptible we are or not. Unless we want to help RT to proceed 
further, based on if "RT && preemtable()", allowing to take zone->lock and
improve a chance of to be succeed with allocation. Basically not bail out.

> > Also, to bail out based on a context's type will not allow to get a page from atomic
> > contexts, what we try to achieve :)
> 
> Yes lockdep will need some special treatment but I suspect we want to
> address the underlying problem first and only then take care of the
> lockdep.
> 
> > Whereas, i mean, we do have possibility to do lock-less per-cpu-list allocation without
> > touching any zone lock.
> > 
> > if (gfp_mask == 0) {
> >    check_pcp_lists();
> >       if (page)
> >           return page;
> > 
> >     bail out here without doing farther logic, like pre-fetching.
> >     return NULL;
> > }
> 
> The existing code does that already. __rmqueue_pcplist will go
> rmqueue_bulk only when pcp lists are empty. Or did I miss your point?
> 
Right. Probably we look at it from different angles :) Right, when
pcp is empty the zone->lock is accessed. 

I got the feeling that you want to bail out based on the if (RT && !preemptible()) -> bail out
i.e. On RT below code will always return NULL:

<snip>
    raw_cpin_lock();
    page_alloc();
<snip>

Thanks!

--
Vlad Rezki
