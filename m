Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF9C636CC
	for <rcu@archiver.kernel.org>; Wed, 15 Feb 2023 14:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBOOvu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBOOvu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Feb 2023 09:51:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443939CC1
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:51:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x40so27858371lfu.12
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FPNxk2yysrjzlbFSB5JvYKtr5KWLaNTWE26xdU6d35M=;
        b=jcClCRX4DibG+AxF/B3x7mrMekpJZLC+16y8clhgAtBk+gdWef3KD2yxQilLQvl9sQ
         hzwQ6A6SqHcZzpCQnsGn7a7WM0uUcI8+2WTG4Tr3QGYBlCATqbS0z5BJdJMm4Jp9OdgR
         E0pnfPGLb9vJdbAENpFtnNXT2Vpe3UDjXGKkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPNxk2yysrjzlbFSB5JvYKtr5KWLaNTWE26xdU6d35M=;
        b=hlPYb05pQ/tL59qFV/iNOjttDhI4CoIPU1O21HG79bpnn/y73GI8jglGixYDX2jR4u
         uZ349hjvcdCq2tkS/VWWxpNXBoP7aYLyNvp+gkSwSJ5FtRySzKYScDn1CBf5ya0oqzsG
         9qT4AbKbzXwoXcxu9vhwhyCnQK0w4Ketfufv4gtwlJbBS2UWYFWq4MtMu0brt7haV+Dm
         QiiEaz9hzgMSZkzXuCDKPOUCLvynM1fwr5zGgmPj+ej62qgleZ2LS9XaGbzMuKFpu1cK
         JFilSYdAfSA2WvyB2S8MVHp5WhZXBQkmbeOWDhbwVrPkOfCphUX5D2K/i4+RizOk1hwn
         wqew==
X-Gm-Message-State: AO0yUKXmR9VUX5vbCZtI3EOMCiMhc9vUU9lj1AjChRUCiBOtDpttLefI
        d6/YYQM1lc1Wy2wifflPdFXtKBQ5K7Gqid6Gwwcm0w==
X-Google-Smtp-Source: AK7set9x3FvjDHQkCZvDNNbAYkvQDwhCUNHAVu3h9AFkckE2ot4i0GIDOv9xvK/wHwKb/r6AcA8gB418i0V3uN+ec/g=
X-Received: by 2002:a19:5203:0:b0:4db:3fd1:6ac3 with SMTP id
 m3-20020a195203000000b004db3fd16ac3mr614165lfb.11.1676472706341; Wed, 15 Feb
 2023 06:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20230209102730.974465-1-qiang1.zhang@intel.com>
 <Y+WQkmiypKUUUfcj@lothringen> <PH0PR11MB58803E9D69F2FAC51C5E5589DADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58803E9D69F2FAC51C5E5589DADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Feb 2023 09:51:34 -0500
Message-ID: <CAEXW_YS_CXbvhdu3EoaDB2zj3YGNUYXQ3C6xGOJ1cyvUJZZYjw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 10, 2023 at 12:26 AM Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>
> > For kernels built with CONFIG_NO_HZ_FULL=y and CONFIG_RCU_NOCB_CPU=y,
> > when passing cpulist to "isolcpus=", "nohz_full=" and "rcu_nocbs="
> > bootparams, after system starting, the rcu-related kthreads(include
> > rcu_gp, rcuog*, rcuop* kthreads etc) will running on housekeeping
> > CPUs, but for cpulist contains CPU0, the result will deferent, these
> > rcu-related kthreads will be restricted to running on CPU0.
> >
> > Although invoke kthread_create() to spwan rcu-related kthreads and
> > when it's starting, invoke set_cpus_allowed_ptr() to allowed cpumaks
> > is housekeeping_cpumask(HK_TYPE_KTHREAD), but due to these rcu-related
> > kthreads are created before starting other CPUS, that is to say, at
> > this time, only CPU0 is online, when these rcu-related kthreads running
> > and set allowed cpumaks is housekeeping cpumask, if find that only CPU0
> > is online and CPU0 exists in "isolcpus=", "nohz_full=" and "rcu_nocbs="
> > bootparams, invoke set_cpus_allowed_ptr() will return error.
> >
> > set_cpus_allowed_ptr()
> >  ->__set_cpus_allowed_ptr()
> >    ->__set_cpus_allowed_ptr_locked
> >      {
> >                 bool kthread = p->flags & PF_KTHREAD;
> >                 ....
> >                 if (kthread || is_migration_disabled(p))
> >                         cpu_valid_mask = cpu_online_mask;
> >                 ....
> >                 dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
> >                 if (dest_cpu >= nr_cpu_ids) {
> >                         ret = -EINVAL;
> >                         goto out;
> >                 }
> >                 ....
> >      }
> >
> > At this time, only CPU0 is set in the cpu_online_mask, the ctx->new_mask
> > is housekeeping cpumask and not contains CPU0, this will result dest_cpu
> > is illegal cpu value, the set_cpus_allowed_ptr() will return -EINVAL and
> > failed to set housekeeping cpumask.
> >
> > This commit therefore add additional cpus_allowed_ptr() call in CPU hotplug
> > path. and reset the CPU affinity of rcuboost, rcuog, rcuop kthreads after
> > all other CPUs are online.
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Good catch! But based on that and your other fix, I suspect that
> >nohz_full=0... has never been seriously used.
> >
> >A few points:
> >
> >* This is a problem for kthreads in general. And since HK_TYPE_KTHREAD =
> >  HK_TYPE_RCU and both are going to be merged in the future, I think we should
> >  stop handling the RCU kthreads housekeeping affinity from RCU but let the
> >  kthread code handle that and also fix the issue from the kthread code.
> >  RCU boost may be an exception since we try to enforce some node locality
> >  within the housekeeping range.
>
> Agree.  indeed, these works that set housekeeping CPU affinity should not be handled by RCU,
> and not only RCU-related kthreads are affected, other kthreads created earlier also have the
> same problem.

Agreed as well.

> >* If CPU 0 is isolated and it is the boot CPU, we should wait for a secondary
> >  CPU to boot before activating nohz_full at all. Unfortunately the nohz_full
> >  code is not yet ready for runtime housekeeping cpumask change but work is
> >  in progress (I'm saying that for 10 years...)
> >
> >* I'm tempted to revert 08ae95f4fd3b (nohz_full: Allow the boot CPU to be
> >  nohz_full) since it doesn't work and nobody ever complained?
>
> Yes if remove 08ae95f4fd3b, this problem will disappear.

Just checking. So what's the next step, revert this?

Thanks.
