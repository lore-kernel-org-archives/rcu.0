Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9AC433E6
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FBF22B37
	for <rcu@archiver.kernel.org>; Tue, 26 Jan 2021 14:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbhAZOHz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbhAZOHw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Jan 2021 09:07:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF0C061A29;
        Tue, 26 Jan 2021 06:07:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a12so14729025lfb.1;
        Tue, 26 Jan 2021 06:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pWDnSoBbWygAxp3OZ/0HvBYNQEeIZVy+sfKC9BS9zyg=;
        b=j5Smcrc90DCfvUeGmhwy6JifFQq1QWer338XergVZOO/br66fZDaoLoLBF9DZ177Hm
         NpXisfTYI1mNJ9f6EFBJ4XidsiqnpXC7T3pZxjKRj0S/psEkV/j89ioGaKwP6xNyVT6q
         TCdGMvaDhIi+uKlFfAQ6WcWEG/k8BjMZ0jp+/NQwF+WuiRWLvMoRV60Hsj6oyaa6Cwqg
         XLdd6V1h8eQTTEq74pDpwwYOmJbIsPoixBmBFSNcMrN1wHHObc1/+MtstEW1o3kPohgp
         x19ODI/ex6LTIYdck8LCO9b/IIip1I5J3Wpe4cZwJJAo7BIzxg3ojXVjF4SmoFJF7MCt
         aVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pWDnSoBbWygAxp3OZ/0HvBYNQEeIZVy+sfKC9BS9zyg=;
        b=OPbv8VvC0RqbvZD4LqITsNUAg8mDf4AZXh3UGGa6GJv+nzAnuddgCdItJmSmyZDVs0
         G9adQOBv1cD7A4ibh3e+47Lb+CZ4KfQlXhi+mZdvU3Kbu8QIGijzJRXv2MLF3OwptIc5
         sCTBCw4HAGHzuAMoPUD/ZwPMQcw2AqxI1oGL18+VocWBGQO/8m2lx+wWY9sm0nrhxyP9
         2zyV71G4vJJmjdGIR9jbFtatyP4PltYYVXJdOldIZvbKO41z3JO6vATpCRS1hdLF3TUp
         e+NTQxjtV3Kl5+lIugjAyij8Sr4aFc7eH6dkkemov5LsX+EwiZMaSeweIvovPCuLg3ec
         Q/hg==
X-Gm-Message-State: AOAM530bmXKHeAt+GiVHdR3AvIX8ebqb9PGtdsa80GW9Olx5UdPQlJc1
        CmDwJQI7RUyY8hoVR3zo15o=
X-Google-Smtp-Source: ABdhPJxBL1+lx7dVxDik9L66/FJSV5YVz+jEPTJRyGcidL5EwgFMwApg53PQbuCu57MymBgIQSCiig==
X-Received: by 2002:a19:64e:: with SMTP id 75mr2644602lfg.90.1611670029909;
        Tue, 26 Jan 2021 06:07:09 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id p14sm2105108lji.0.2021.01.26.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:07:08 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 26 Jan 2021 15:07:05 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?= =?utf-8?Q?H?=
 =?utf-8?Q?=5D?= rcu: Release per-cpu krcp page cache when CPU going offline
Message-ID: <20210126140705.GA1942@pc638.lan>
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
 <20210121185615.GR2743@paulmck-ThinkPad-P72>
 <20210121202635.GB2454@pc638.lan>
 <BYAPR11MB26324D17B990FC099919CBB7FFA00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210122143129.GB1873@pc638.lan>
 <BYAPR11MB2632BB67FCC17E3B32CEAEA3FFBE0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632BB67FCC17E3B32CEAEA3FFBE0@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> ________________________________________
> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年1月22日 22:31
> 收件人: Zhang, Qiang
> 抄送: Uladzislau Rezki; Paul E. McKenney; rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: 回复: [PATCH] rcu: Release per-cpu krcp page cache when CPU going offline
> 
> On Fri, Jan 22, 2021 at 01:44:36AM +0000, Zhang, Qiang wrote:
> >
> >
> > ________________________________________
> > 发件人: Uladzislau Rezki <urezki@gmail.com>
> > 发送时间: 2021年1月22日 4:26
> > 收件人: Zhang, Qiang
> > 抄送: Paul E. McKenney; rcu@vger.kernel.org; linux-kernel@vger.kernel.org; urezki@gmail.com
> > 主题: Re: [PATCH] rcu: Release per-cpu krcp page cache when CPU going offline
> > >Hello, Qiang,
> >
> > > On Thu, Jan 21, 2021 at 02:49:49PM +0800, qiang.zhang@windriver.com wrote:
> > > > From: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > > If CPUs go offline, the corresponding krcp's page cache can
> > > > not be use util the CPU come back online, or maybe the CPU
> > > > will never go online again, this commit therefore free krcp's
> > > > page cache when CPUs go offline.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > >
> > >Do you consider it as an issue? We have 5 pages per CPU, that is 20480 bytes.
> > >
> >
> > Hello Rezki
> >
> > In a multi CPUs system, more than one CPUs may be offline, there are more than 5 pages,  and these offline CPUs may never go online again  or  in the process of CPUs online, there are errors, which lead to the failure of online, these scenarios will lead to the per-cpu krc page cache will never be released.
> >
> >Thanks for your answer. I was thinking more about if you knew some >platforms
> >which suffer from such extra page usage when CPU goes offline. Any >issues
> >your platforms or devices run into because of that.
> >
> >So i understand that if CPU goes offline the 5 pages associated with it >are
> >unused until it goes online back.
> 
>  I agree with you, But I still want to talk about what I think
> 
>  My understanding is that when the CPU is offline,  the pages is not 
>  accessible,  beacuse we don't know when this CPU will 
>  go online again, so we best to return these page to the buddy system,
>  when the CPU goes online again, we can allocate page from the buddy 
>  system to fill krcp's page cache.  maybe you may think that this memory 
>  is small and don't need to. 
>  
BTW, we can release the caches via shrinker path instead, what is more makes
sense to me. We already have a callback, that frees pages when a page allocator
asks for it. I think in that case it would be fair to return it to the buddy
system. It happens under low memory condition or can be done manually to flush
system caches:

echo 3 > /proc/sys/vm/drop_caches

What do you think?

--
Vlad Rezki
