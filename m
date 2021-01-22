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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611FC433DB
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 14:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C1C20731
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 14:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbhAVOcV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jan 2021 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbhAVOcN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jan 2021 09:32:13 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394CEC061786;
        Fri, 22 Jan 2021 06:31:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h7so7796178lfc.6;
        Fri, 22 Jan 2021 06:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lORbjL7NcGT/PStpr8zM4Wz5Tzho57XEv/tw4+222nQ=;
        b=lYghFhdW3WyhRY0OQX6QvLVjSyF/tw8v9KGOVngfSJysoGEvuM8wKoMVUn2dtZ+SUM
         5D5Ym0q/o9kQsqjzLUbHt6AEDgUVPznvX5Rc71IxP7MzdAKaiFMes1ELCfY0c0g7Ffln
         UWHFNr+W/NprXS8P40SUEHCAhEc/szw1VaWoCqOVSqDac9aulHPnCMX12Qr/xttajWCH
         vxkadgJ2JfEu1lwgubXOI76ASxmdvMahOqCcQAPZIriynCZ8kO3ojqRGz103CQk7zIWF
         GqnjIChdtuBqAmEctexUCTbzyRw8kqNKp1DETXQXSo2uyfEcjojZc7CV4yqITM1gB2tt
         RBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lORbjL7NcGT/PStpr8zM4Wz5Tzho57XEv/tw4+222nQ=;
        b=F2BNt69IS+1XM80qMPH7j9ZR8/OABwm5ft3qW1K8oWYkvjLuMPiIXNq6Wc3GjK/h8c
         uPoq1RTTvUGwAF+62X22hCAMf3h2hqIC4khesy5ExdU7/yCvXV4kBgmoSWs7f0NMehAY
         ZRjU90UwcClLG7DQ4rHvMNcvo0k/VirILctq6ydyYqYUhtKJN9pS1e6/fS0g+qeq++ta
         EIOUJl0Uua2jPtrkTVUUfZiPO0XMihesU8bvXR7n3CI2WUusNJys0PZp7re3KeOOzlWl
         aHg8qva025uzrtTOXzKp5hPbqBHk3KCdZB0WCc1bLPQpWThLVNYEkb48dIrrteVqdYkz
         nSHg==
X-Gm-Message-State: AOAM530gLNEu42+XHga4yXpUt4243RcUtTBOdko9HwuJLvibukM+AhQg
        5dJa6m91Pb8EMHcABeHITfsOkYqVYsD0ng==
X-Google-Smtp-Source: ABdhPJzdYb0VJp3v8CYf26OiQ1krmECtdYGgsHXEaBOQ9XwNH2Ul05edaphTwfyTSJUYqgMy7TOONA==
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr1199536lfu.167.1611325891745;
        Fri, 22 Jan 2021 06:31:31 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f23sm905859lfc.63.2021.01.22.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:31:31 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 22 Jan 2021 15:31:29 +0100
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= rcu: Release
 per-cpu krcp page cache when CPU going offline
Message-ID: <20210122143129.GB1873@pc638.lan>
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
 <20210121185615.GR2743@paulmck-ThinkPad-P72>
 <20210121202635.GB2454@pc638.lan>
 <BYAPR11MB26324D17B990FC099919CBB7FFA00@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB26324D17B990FC099919CBB7FFA00@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 22, 2021 at 01:44:36AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: Uladzislau Rezki <urezki@gmail.com>
> 发送时间: 2021年1月22日 4:26
> 收件人: Zhang, Qiang
> 抄送: Paul E. McKenney; rcu@vger.kernel.org; linux-kernel@vger.kernel.org; urezki@gmail.com
> 主题: Re: [PATCH] rcu: Release per-cpu krcp page cache when CPU going offline
> >Hello, Qiang,
> 
> > On Thu, Jan 21, 2021 at 02:49:49PM +0800, qiang.zhang@windriver.com wrote:
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > If CPUs go offline, the corresponding krcp's page cache can
> > > not be use util the CPU come back online, or maybe the CPU
> > > will never go online again, this commit therefore free krcp's
> > > page cache when CPUs go offline.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> >
> >Do you consider it as an issue? We have 5 pages per CPU, that is 20480 bytes.
> >
> 
> Hello Rezki 
> 
> In a multi CPUs system, more than one CPUs may be offline, there are more than 5 pages,  and these offline CPUs may never go online again  or  in the process of CPUs online, there are errors, which lead to the failure of online, these scenarios will lead to the per-cpu krc page cache will never be released.
> 
Thanks for your answer. I was thinking more about if you knew some platforms
which suffer from such extra page usage when CPU goes offline. Any issues
your platforms or devices run into because of that.

So i understand that if CPU goes offline the 5 pages associated with it are
unused until it goes online back.

--
Vlad Rezki
