Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C76C433E0
	for <rcu@archiver.kernel.org>; Sun, 24 Jan 2021 17:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA592223E
	for <rcu@archiver.kernel.org>; Sun, 24 Jan 2021 17:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbhAXRne (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbhAXRnd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 24 Jan 2021 12:43:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1EC061573;
        Sun, 24 Jan 2021 09:42:53 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u11so12440862ljo.13;
        Sun, 24 Jan 2021 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=huKUEf/T+Pt85OuxeEgIzQUXu/vH0w4ojEpai0/V1ZM=;
        b=NSmRghhj2w8K5ygxT20aPO1jxmsmrPDF+dho9pDVeLAsd3QYWg7+vuQuqJ432fzWJz
         cTWFne1qy0xqXx1tdXjFxtvvfqyKubItaT9RPtsBM7PCNUu9ZpQ70hzdW+WizpD4lguH
         s/GfpFsRo+6I249cqPkxFyjuETMSWFcTNa09QqBk0X3WrD8GfH7sEkZo45ypYRP3OmXx
         DzArd4kOgouLfgF2QFrciTPSnrOuSi00Ne/nDXLmqilGkXQMoCRitbA3JdSGVKz0ndYV
         EoEbtWWUo/9lrV0dRPdFH+udT+pQb6saX79TaQehWajwc+P4uirUdl7BMay0swbzv3F8
         PGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=huKUEf/T+Pt85OuxeEgIzQUXu/vH0w4ojEpai0/V1ZM=;
        b=SjCxBApwfjgVSnkUC1wpeB1YXJpWc3B54E2wp7SQMCg3z/7f8ZUnN3CA4wBrfzG+2u
         +48Fkcouk0jf8OYTODhYRskAR+dGrXvLNrOBGvzrv3ZXDnUFMmMG1oPdhEQAOuAau3r7
         laS2AKPmpS5dneyBvXb7rMCuMkHEz+W2NCovLo5hCTUgQp91l1VkgkPkOV7s0qA9Rzci
         3BPy0M+/vgzcOFtU0fY3p9Qz8Jqucif+Up66UVrPobEzRZz1OXYaXHC7gHeJzi5OBO/M
         mtAOSy4SYq+Oegc8/R6wCDlTN4CTzT1nAxyssWH+KC6W79V20pLSMaN5mFJBX6Pojaip
         q5nQ==
X-Gm-Message-State: AOAM530Euj6Mdm22+6ybRd5az5YHZIt/DBe9tHrmqLlvjEhFHdAqgyo7
        MNN9qT3No+4yOUZ5PjKKLJ8=
X-Google-Smtp-Source: ABdhPJyjcg4QFB+CVn74y0uDhiPHc2wFCm/yHSFtJYpe12NxS1vZtBsh422yCtcR7mBbR6xSQ08cHQ==
X-Received: by 2002:a2e:760a:: with SMTP id r10mr538157ljc.11.1611510171462;
        Sun, 24 Jan 2021 09:42:51 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c10sm1455058lfs.75.2021.01.24.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:42:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 24 Jan 2021 18:42:48 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?= =?utf-8?Q?H?=
 =?utf-8?Q?=5D?= rcu: Release per-cpu krcp page cache when CPU going offline
Message-ID: <20210124174248.GA1076@pc636>
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

On Sun, Jan 24, 2021 at 02:21:07AM +0000, Zhang, Qiang wrote:
> 
> 
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
Exactly. I think that 5 pages are not that important(small amount of memory),
so it is not worth to build the logic around it in order to return them back
to the page allocator when CPU goes offline, even forever. This is how i see it.

If you are aware about some specific systems where it is critical, please
let's as know.

--
Vlad Rezki
