Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96679C54EBE
	for <rcu@archiver.kernel.org>; Mon, 16 Jan 2023 22:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjAPWiQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 17:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjAPWiO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 17:38:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE0234D4
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 14:38:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so44584351lfv.2
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 14:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KtRzvTolYa3Uc4kvMVMuZai5HuAGzAcSM732ubQWs58=;
        b=Nga4WVhSFh5VaIeR4TOXQOImgfKeO2t4RSxqUZoCTL76vPrFW408FhvsotbdSI9a+M
         sgr518IxmcwwItW06k65uNR+IGYTxFeleMm859G+p3QWrzH28MoKbLqRvZSFygAl9YMw
         X/pfaAJ7W+0UkayVBz6a+J0tlFtEhn6Un9kfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtRzvTolYa3Uc4kvMVMuZai5HuAGzAcSM732ubQWs58=;
        b=MhhaEFj60X57Q9C5OuMkOTB92AlAYEHNHRR387lVAvVVLA7YCcYUnnI30pOWiqFVlA
         fSHur+zwRCieEkEHP6MiQlmCj7up/CdX8Jm1bxRVfHGqsKtzaFJEPtMybaRsnGPEgQkU
         GVqQyG1jZ6q+XGpRbTweOXjvC8EtFZIUkdJCAtKuEycuNzZackwCIX+OV6BfJ1yYrTDY
         w0nZuaIuZtJwnefsXJr9pd9gei/44ohOf0/4OFjCuxbJWnJrocD2moTuE6Nerzdc2TNi
         S59BicQwEFRLm0vzCB9GtuUqvoxTRI2uLLisfHKK1SytV/lByOin41XpXuXqXFxt4K8s
         y/Lg==
X-Gm-Message-State: AFqh2kod+CMuGii/xQYa2+UjQCEivNCOUhrDeXUiTJSxK4sAJbJgh1SI
        pSpz64bnrRl4sqnKztNIMPxDzbdF9RhgavmCH2OdSQ==
X-Google-Smtp-Source: AMrXdXuZCQ9iKh4hUpy+hgY8cHk2N0xsk2CE/McnuNDABBj6p8WikZ3i4KfnlOxbHU1mOUHeUL15IyoxsP5xuhgtG+s=
X-Received: by 2002:a05:6512:230a:b0:4cc:598c:41bd with SMTP id
 o10-20020a056512230a00b004cc598c41bdmr29835lfu.468.1673908691882; Mon, 16 Jan
 2023 14:38:11 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
In-Reply-To: <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Jan 2023 17:38:00 -0500
Message-ID: <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Zhouyi,

On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
[..]
> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hello,
> > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> >
> > This causes warnings in torture tests:
> > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> >
> > Full kernel log here:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> >
> > Any ideas on why this is happening and only for CPU 0 (presumably the
> > boot CPU)? I'd personally need these warnings to go away for my tests
> > as this causes rcutorture's tests to not cleanly pass for me. It
> > appears remove_cpu() -> device_offline() is what returns the error.
> >
> I guess this probably because CPU 0 is the tick_do_timer_cpu in
> nohz_full mode, which prevent that cpu from
> going offline [1]. We have discussed this topic, but there is no
> agreement on how to solve it yet.

But I am seeing the issue in TRACE02 config which is:
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set

So that is not NO_HZ_FULL:
http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
However, I can't seem to find the full kernel logs for that.

Also, other than the TRACE02 fail, I only see the issue with configs
with CONFIG_NO_HZ_FULL=y

Can you try TRACE02 specifically, and see if you can reproduce the
same issue on your setup? Meanwhile, I'll try to trace what is
returning the -EBUSY.

Thanks!

 - Joel

>
> [1] https://lore.kernel.org/lkml/20221127175317.GF4001@paulmck-ThinkPad-P17-Gen-1/T/
>
> Thanks
> Zhouyi
> > You can browse through all the torture test artifacts here which
> > contains everything (build logs, vmlinux, etc).
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/
> >
> > Thanks for your help!
> >
> >  - Joel
