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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0226FC433DB
	for <rcu@archiver.kernel.org>; Wed, 27 Jan 2021 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD09020771
	for <rcu@archiver.kernel.org>; Wed, 27 Jan 2021 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhA0Mub (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 27 Jan 2021 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbhA0Ms0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 27 Jan 2021 07:48:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C25C061574;
        Wed, 27 Jan 2021 04:47:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o10so2428473lfl.13;
        Wed, 27 Jan 2021 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ycFolyNp8VLN9fdHlmeqTVkpJxs4UNit0j6/is8DNJ8=;
        b=AVqeJIkyvhXWwI+qn/+9ZIQhLYFrjzIjDLvlhBtFlhOEpwM/JTQp1kK+AdbfTrUUoO
         lX1RBokgpz/EDBJMamvfSOPLPtN9BLcq5CvJJORkdwY2fDbek/zGLL6qywRTT3EeLDCH
         RC8ERjakKTKly9R4KOOJrSfx+jN5BGHF8dEexWKtWyFrwItbl40plihJTIaemAAKLnE7
         NrJFb0X6YEnrdYfRadXQmiDjtQywbDZ2Kt/clZzfGJH3YlqM5p7rQO05+eZPbT9eOWa2
         6cyEmvDfNXNv4VUm7EuUmlU5BP1zf9cxOwhitGKra/HQWjau2xyZTyr08t5CqpHvmT6G
         z27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ycFolyNp8VLN9fdHlmeqTVkpJxs4UNit0j6/is8DNJ8=;
        b=RBj7oi0OltbOQ2bq1yWXoJruOoiyew9amytfjLwDGgoFjqd7PfMUsO8AT64AAD8P2K
         I4dg40i67bSvdSLqO8td8kuswfQt71JYtAW4lxAi8lEFqrIj7wYEmSe240nIaHJnvioN
         XMOq48JFlXkIc2+3j+DhfMvO110YnFxdCLI0WIBWCXiGKC3O0C4hBKhFDbYMiygPOL8z
         QTec5B1SvKotN0S+vyPvWRczLFeC8EdD4Ly8ozWKUItozRvUYfvt8kyjzqBgwP/LADxy
         Y/Spj2g6IL/USkBByGxejLagKnogdjLTtriyEFKelBtA3gSI1EASJJQPJ+e1r2wQ5esr
         l/sg==
X-Gm-Message-State: AOAM533At5lCoDk8lZTMQK9kXDo6F8nGgLT8swHArzaoLlLmeBOaz8H2
        jAJG8VlGQ3GdZmEfrkVJ2Td3iacMAZwZYQ==
X-Google-Smtp-Source: ABdhPJzihYE9Gh2cxfCvInz9t3p1/SnlfMWF6f35Lm2j8PelUN/RYdz2dj1DyXMoDpFwwMp0jaTVaw==
X-Received: by 2002:a05:6512:1053:: with SMTP id c19mr4777315lfb.518.1611751663466;
        Wed, 27 Jan 2021 04:47:43 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u11sm473266lfr.124.2021.01.27.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 04:47:42 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 27 Jan 2021 13:47:40 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbng==?=
 =?utf-8?B?5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= rcu: Release per-cpu krcp page
 cache when CPU going offline
Message-ID: <20210127124740.GA1856@pc638.lan>
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
 <20210121185615.GR2743@paulmck-ThinkPad-P72>
 <20210121202635.GB2454@pc638.lan>
 <BYAPR11MB26324D17B990FC099919CBB7FFA00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210122143129.GB1873@pc638.lan>
 <BYAPR11MB2632BB67FCC17E3B32CEAEA3FFBE0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210126140705.GA1942@pc638.lan>
 <BYAPR11MB26320FC73B7CE5E4195CB499FFBB9@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB26320FC73B7CE5E4195CB499FFBB9@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 27, 2021 at 09:00:27AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年1月26日 22:07
> 收件人: Zhang, Qiang
> 抄送: Uladzislau Rezki; Paul E. McKenney; rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: 回复: 回复: [PATCH] rcu: Release per-cpu krcp page cache when CPU going offline
> 
> >
> > On Fri, Jan 22, 2021 at 01:44:36AM +0000, Zhang, Qiang wrote:
> > >
> > >
> > > ________________________________________
> > > 发件人: Uladzislau Rezki <urezki@gmail.com>
> > > 发送时间: 2021年1月22日 4:26
> > > 收件人: Zhang, Qiang
> > > 抄送: Paul E. McKenney; rcu@vger.kernel.org; linux-kernel@vger.kernel.org; urezki@gmail.com
> > > 主题: Re: [PATCH] rcu: Release per-cpu krcp page cache when CPU going offline
> > > >Hello, Qiang,
> > >
> > > > On Thu, Jan 21, 2021 at 02:49:49PM +0800, qiang.zhang@windriver.com wrote:
> > > > > From: Zqiang <qiang.zhang@windriver.com>
> > > > >
> > > > > If CPUs go offline, the corresponding krcp's page cache can
> > > > > not be use util the CPU come back online, or maybe the CPU
> > > > > will never go online again, this commit therefore free krcp's
> > > > > page cache when CPUs go offline.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > >Do you consider it as an issue? We have 5 pages per CPU, that is 20480 bytes.
> > > >
> > >
> > > Hello Rezki
> > >
> > > In a multi CPUs system, more than one CPUs may be offline, there are more than 5 pages,  and these offline CPUs may never go online again  or  in the process of CPUs online, there are errors, which lead to the failure of online, these scenarios will lead to the per-cpu krc page cache will never be released.
> > >
> > >Thanks for your answer. I was thinking more about if you knew some >platforms
> > >which suffer from such extra page usage when CPU goes offline. Any >issues
> > >your platforms or devices run into because of that.
> > >
> > >So i understand that if CPU goes offline the 5 pages associated with it >are
> > >unused until it goes online back.
> >
> >  I agree with you, But I still want to talk about what I think
> >
> >  My understanding is that when the CPU is offline,  the pages is not
> >  accessible,  beacuse we don't know when this CPU will
> >  go online again, so we best to return these page to the buddy system,
> >  when the CPU goes online again, we can allocate page from the buddy
> >  system to fill krcp's page cache.  maybe you may think that this memory
> >  is small and don't need to.
> >
> >BTW, we can release the caches via shrinker path instead, what is more makes
> >sense to me. We already have a callback, that frees pages when a page allocator
> >asks for it. I think in that case it would be fair to return it to the buddy
> >system. It happens under low memory condition
> 
>   I agree. it can be done in shrink callback, can release the currently existing per-cpu 
>   page cache.
>   
Would not you mind to send a patch? If you need some input, i am happy
to participate.

Thanks!

--
Vlad Rezki
