Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A5C46467
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 00:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjAQAPL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjAQAPK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 19:15:10 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A28233E5
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 16:15:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q10so20572242qvt.10
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 16:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIC0NTdL/gZNzAp24dsZkyIJXUTc51NvXJMuZcPT/6E=;
        b=crsNgCC2NiG7nSJfJY+wIx1ZFmgMWtgqhn4BBF6aIDEFjxhsuZP1vj43r2abWWfF7G
         eXxV1nXprXx//OwnUuhPiUZ31P5IC9ZmUZLYr/xJO3QZpBuZgEG/b3Urq4coa5D1ZRJE
         sBxu6R/jZ2RATIhYTPCZgYV1Ta2Tiov3Rb9II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIC0NTdL/gZNzAp24dsZkyIJXUTc51NvXJMuZcPT/6E=;
        b=IR0+flIws2dR232B+6D3MCupy/h65/w5iEtTef7ES9FdTGcy5nIhz3RkreUC5KHOmx
         IPTbU52I0Vi+vyg9grtuawvG6JeOevcggJHk1xLTXl8zAINeOQBioozb6iS3s+F1d8FR
         /3Ky001JotAwAaeW8IQm0Dakj6090REvsg0giQJFH3nP/oIMWb8W7duZ5cHMmGYjj0i+
         f7d1kipWePUvAS9QBBBYxCbGO7NEOywTSqI5bXdO307nLYjJes8SroTRuevnWUmE4Ul8
         JV0stV/fKZHZYo70Z4ccXpuFCPncoJ0W18W7u9OEfo0p0mu5Chi1wYc/NELv9LI4Ir7j
         N1Pw==
X-Gm-Message-State: AFqh2koexbJgxU2PcN1oHGcghmUvkPxNz0A+4+P2KD9pq4rX7FmCN7cG
        Zx8QlbC800PLOecF9Ed7kLswwQ==
X-Google-Smtp-Source: AMrXdXuCu49wSWg4RBAobfIwQ6s1NTMGMAE+8SmW2CvxJf7lLEMbK0mY/sgizwykBxSjxV6Pm0H+ZA==
X-Received: by 2002:a05:6214:5811:b0:534:2684:dbeb with SMTP id mk17-20020a056214581100b005342684dbebmr1930266qvb.43.1673914508525;
        Mon, 16 Jan 2023 16:15:08 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006eeb3165565sm19198479qko.80.2023.01.16.16.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 16:15:07 -0800 (PST)
Date:   Tue, 17 Jan 2023 00:15:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <Y8Xoi3UvMs+Oy78O@google.com>
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
 <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> Hi Zhouyi,
> 
> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> [..]
> > On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > Hello,
> > > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > >
> > > This causes warnings in torture tests:
> > > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > >
> > > Full kernel log here:
> > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > >
> > > Any ideas on why this is happening and only for CPU 0 (presumably the
> > > boot CPU)? I'd personally need these warnings to go away for my tests
> > > as this causes rcutorture's tests to not cleanly pass for me. It
> > > appears remove_cpu() -> device_offline() is what returns the error.
> > >
> > I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > nohz_full mode, which prevent that cpu from
> > going offline [1]. We have discussed this topic, but there is no
> > agreement on how to solve it yet.
> 
> But I am seeing the issue in TRACE02 config which is:
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> 
> So that is not NO_HZ_FULL:
> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> However, I can't seem to find the full kernel logs for that.
> 
> Also, other than the TRACE02 fail, I only see the issue with configs
> with CONFIG_NO_HZ_FULL=y
> 
> Can you try TRACE02 specifically, and see if you can reproduce the
> same issue on your setup? Meanwhile, I'll try to trace what is
> returning the -EBUSY.

How about something simple like the following? (untested)

---8<-----------------------

diff --git a/kernel/torture.c b/kernel/torture.c
index bc8fb361efc0..cd64110694c0 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			// PCI probe frequently disables hotplug during boot.
 			(*n_offl_attempts)--;
 			s = " (-EBUSY forgiven during boot)";
+		} else if (tick_nohz_full_running && ret == -EBUSY) {
+			(*n_offl_attempts)--;
+			s = " (-EBUSY forgiven if nohz_full is running)";
 		}
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
