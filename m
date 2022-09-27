Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26720C07E9D
	for <rcu@archiver.kernel.org>; Tue, 27 Sep 2022 09:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiI0J7M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Sep 2022 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI0J7L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Sep 2022 05:59:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344C9E0C3
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 02:59:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so7519524pgc.5
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tZEE2tgSN7rT7rwyBwS3MiPUv8x/+GIF1LKcvRD6d7U=;
        b=GfjrQSJUSHH9GAq2UHuMS6Ee+rI2M2MB/DrzdKvFaWET/PpGGIHmNzPBJ21iiU8ARq
         JLGyPOsp3iAQiMOW4aFvnHvwkzoehTPGsP8+tgtYDcxyT+twnELi5SiFGzjb3wxZnsPE
         WPyBuT3tLf6BpZlPYeJg1ciqfVexb1TFKAfqaBb/IF+Or3DdpqdPSCGE9Fr/+Oy196FF
         Qom/2aUJXWMdx7jZbDaNvxcqQS3ofG4ZPHnQQ7W4wkv/iaC1Sya/qnBz2ng1bOGrW0nU
         pqJMSeSgQ0u87Us3tR4WgPPvXTeVyNuo4W5i1fC8lWNqvS+u/x5ezyXmAZvnhvd1Wyw3
         O+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tZEE2tgSN7rT7rwyBwS3MiPUv8x/+GIF1LKcvRD6d7U=;
        b=P/6M0MRjAi2V2U7j+5q2FUMCV3zzqCFVyoydMwYgn7NrqGRAbhnW+Jg1eeFBSiK0so
         P5p/Valkow+78nWIhVd7Z1llx5HUe0vafhMUSLFKc943Wm9QyuZh1BmI6sE7dbfg8gvk
         E9NhcIhCnya8ZL+aFV/w/dIDUnTOhcGDbASA1GoBbw3FP/WfYFZJA3UaktT3mmE9ls43
         X47uVAGnesU1uIjzo/tIaPc/jahGfVufNEhEaBO9lazeZdpOje9ywNvZ3GzCU+iPbc+n
         +btR8Ph0jeR0D1i0SINnmxq4Pu6ZpcJNssgrEsyFCG0aEKPHR3ICOQfGPgZAH7LACFiG
         MZ5Q==
X-Gm-Message-State: ACrzQf29Qc68/maHT7WDqPxBhflC8LTFwuCasN/57nOOBszascz+/s1E
        mqLG+ZC5XgtSwwCVlaTS0H/uWLFOvmKi
X-Google-Smtp-Source: AMsMyM6qApXEK+1iX7NHyPZEyQjbxndIWVYNafuvCp9lsXpXbxtbIRjvKPXEKUtdzYt8FNX68w18cQ==
X-Received: by 2002:a05:6a00:23c5:b0:557:a75c:b430 with SMTP id g5-20020a056a0023c500b00557a75cb430mr17687687pfc.16.1664272750370;
        Tue, 27 Sep 2022 02:59:10 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b0016d1b70872asm1076024plg.134.2022.09.27.02.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:59:09 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:59:01 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
 <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 26, 2022 at 03:23:52PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 26, 2022 at 02:34:17PM +0800, Pingfan Liu wrote:
> > Sorry to reply late. I just realize this e-mail misses in my gmail.
> > 
> > On Thu, Sep 22, 2022 at 06:54:42AM -0700, Paul E. McKenney wrote:
> > [...]
> > > 
> > > If you have tools/.../rcutorture/bin on your path, yes.  This would default
> > > to a 30-minute run.  If you have at least 16 CPUs, you should add
> >                                             ^^^ TREE04 has CONFIG_NR_CPUS=8, so I think here the num is 8
> 
> Yes, you will get some benefit from --allcpus on systems with from 9-15
> CPUs as well as for 16 and more.  At 8 CPUs, it wouldn't matter.
> 
> > > "--allcpus" to do concurrrent runs.  For example, given 64 CPUs you could
> > > do this:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "4*TREE04"
> > > 
> > 
> > I have tried to find a two socket system with 128 cpus and run
> >   sh kvm.sh --allcpus --duration 250h --bootargs rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30 --configs 16*TREE04
> > 
> > Where 250*16=4000
> 
> That would work.
> 

This job has successfully run 24+ hours. (But maybe I can only keep it
about 180 hours)

> > > This would run four concurrent instances of the TREE04 scenario, each for
> > > 10 hours, for a total of 40 hours of test time.
> > > 
> > > > > It does take some time to run.  I did 4,000 hours worth of TREE04
> > > >                                         ^^^ '--duration=4000h' can serve this purpose?
> > > 
> > > You could, at least if you replace the "=" with a space character, but
> > > that really would run a six-month test, which is probably not what you
> > > want to do.  There being 8,760 hours in a year and all that.
> > > 
> > > > Is it related with the cpu's freq?
> > > 
> > > Not at all.  '--duration 10h' would run ten hours of wall-clock time
> > > regardless of the CPU frequencies.
> > > 
> > > > > to confirm lack of bug.  But an 80-CPU dual-socket system can run
> > > > > 10 concurrent instances of TREE04, which gets things down to a more
> > > > 
> > > > The total demanded hours H = 4000/(system_cpu_num/8)?
> > > 
> > > Yes.  You can also use multiple systems, which is what kvm-remote.sh is
> > > intended for, again assuming 80 CPUs per system to keep the arithmetic
> > > simple:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 ... sys20" --duration 20h --cpus 80 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "200*TREE04"
> > > 
> > 
> > That is appealing.
> > 
> > I will see if any opportunity to grasp a batch of machines to run the
> > test.
> 
> Initial tests with smaller numbers of CPUs are also useful, for example,
> in case reversion causes some bug due to bad interaction with a later
> commit.
> 
> Please let me know how it goes!
> 

I have managed to grasp three two-socket machine, each has 256 cpus.
The test has run about 7 hours till now without any problem by the following command:
tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 sys3" \
--duration 45h --cpus 256 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "96*TREE04"

It seems promising.


Thanks,

	Pingfan
