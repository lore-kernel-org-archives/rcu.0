Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6199AC00140
	for <rcu@archiver.kernel.org>; Thu, 18 Aug 2022 23:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbiHRXFd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Aug 2022 19:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiHRXFc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Aug 2022 19:05:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E8CD79A
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 16:05:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o2so2189931iof.8
        for <rcu@vger.kernel.org>; Thu, 18 Aug 2022 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DEs4QdwBZh24q/YXet07H+yoRoWFt6AeBiWh1qampiM=;
        b=NRf5fd3sxugF1Zngi0c9/hpqIoc552QiPB12KJSFJTFTF7UVI1QeOqUmF5KWIMxnJq
         mBtUqIYHGYxr8OHnH1Yk6aMKEu2+McD7STFeYtAEYlov8ONetZcZAiuRZqUGheH2klwu
         VUNzsd7J7RM218D46GArrQ6WKM+ejqFCQlcpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DEs4QdwBZh24q/YXet07H+yoRoWFt6AeBiWh1qampiM=;
        b=BSgFtrW/hJwku32g2XWtZmP1UH6AL2DRg29a6C4b2NYdo11JT1scbx1Aabh/LS7qFn
         mIw48KOFgr/JrUh763Oul1Z/Yj+YwU3eCE7QTANzgpJsx9K6tTHfAV1N24LZyJovOLMW
         R3fJdeD3ZJb1/cniWrEX9bIseDNel2SvKg0hw2+2qO5olGiSQ4QwacEc06GlvlDCjqa2
         SqFpgcgx1GVJde455ggezhdUgqv3ILuykTe8/gW5XwCTEaTY+tk5SUzvrmxlHFuEZ2EK
         Zo9vxKLwVCGQTsWAtHGoqtlL/q7CuT19o9wVR+cyLB++Qd+76ex0bmGPB4MPH6T8TRwi
         XJQQ==
X-Gm-Message-State: ACgBeo03q0NOvUxho+ZGh8mrcQ3BbCzD7+MvTA14B55NyMiQxOD4Jnou
        pv7lCDwumV1RAs/2kpGH2lbScSvJ66uWJjGc1iXbTA==
X-Google-Smtp-Source: AA6agR4gzrzYri2e4hcP+IvTvBPJ90eC8Z8V93sG2S9RPq9wXt+Goc522k09OwM5cnsLYyh5/EuPN7AcGD9grMoP/PQ=
X-Received: by 2002:a05:6638:378c:b0:343:447e:e6e2 with SMTP id
 w12-20020a056638378c00b00343447ee6e2mr1451606jal.118.1660863931374; Thu, 18
 Aug 2022 16:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org> <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
In-Reply-To: <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 19:05:19 -0400
Message-ID: <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 18, 2022 at 1:23 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> [Sorry, adding back the CC list]
>
> On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > This is required to prevent callbacks triggering RCU machinery too
> > quickly and too often, which adds more power to the system.
> >
> > When testing, we found that these paths were invoked often when the
> > system is not doing anything (screen is ON but otherwise idle).
>
> Unfortunately, I am seeing a slow down in ChromeOS boot performance
> after applying this particular patch. It is the first time I could
> test ChromeOS boot times with the series since it was hard to find a
> ChromeOS device that runs the upstream kernel.
>
> Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
> patch? I wonder if the issue is with wake up interaction with the nocb
> GP threads.
>
> We ought to disable lazy RCU during boot since it would have little
> benefit anyway. But I am also concerned about some deeper problem I
> did not catch before.
>
> I'll look into tracing the fs paths to see if I can narrow down what's
> causing it. Will also try a newer kernel, I am currently testing on
> 5.19-rc4.

I got somewhere with this. It looks like queuing CBs as lazy CBs
instead of normal CBs, are triggering expedited stalls during the boot
process:

  39.949198] rcu: INFO: rcu_preempt detected expedited stalls on
CPUs/tasks: { } 28 jiffies s: 69 root: 0x0/.

No idea how/why lazy RCU CBs would be related to expedited GP issues,
but maybe something hangs and causes that side-effect.

initcall_debug did not help, as it seems initcalls all work fine, and
then 8 seconds after the boot, it starts slowing down a lot, followed
by the RCU stall messages. As a next step I'll enable ftrace during
the boot to see if I can get more insight. But I believe, its not the
FS layer, the FS layer just triggers lazy CBs, but there is something
wrong with the core lazy-RCU work itself.

This kernel is 5.19-rc4. I'll also try to rebase ChromeOS on more
recent kernels and debug.

Thanks,

 - Joel
