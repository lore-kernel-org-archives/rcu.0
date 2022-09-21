Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF2ECAAD8
	for <rcu@archiver.kernel.org>; Wed, 21 Sep 2022 11:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIUL4z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIUL4x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Sep 2022 07:56:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFD689CE7
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 04:56:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u69so5716651pgd.2
        for <rcu@vger.kernel.org>; Wed, 21 Sep 2022 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uzC1qDBxEJJgrb7vKDLNlt0ZgBdIAvVzwqCIwR7BEGI=;
        b=IQQNMV9b5ofUDDB6PyMXq+UBLZZg9+ABcJp9gZHKPnpIk/N2igGFZE5CxUdooaUfVc
         jYFBILuhA38u0kSSm+he/VBb9FGkzBiSduzDJ8i8oGM5j0izsdobdPMy0NBcK8at8kfx
         2Elqepla8aTQaMFkq2p6Cfe3TqVBJQyY22JD5FbIB89CGXPnX5D1Kxl32qjxCTDNqK2a
         G2/BxN4rHDzYjBIZOyp2Y4YsYJl0bR+LHDOM+X7UE0Qi6+z2Kgf9wh3Ohhyu56KXdVJA
         lGbJf2yxKXcDlpeLrN8EmaJ7fHIkzP5tVkCAAEY92ebnwSs9CTjYMSH/KvOoEIZZBnMu
         RbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uzC1qDBxEJJgrb7vKDLNlt0ZgBdIAvVzwqCIwR7BEGI=;
        b=UZSqLBueJk6Ve3nJ0ri4MToXlccO+GsrudzBsEH20VlN9vuSy1vcHaKNXang5xXcBz
         Okb3XJARkgqa3OUEw2WPcugQHEUr3OV1fGfwBi+plYgl+fCEciJIKZ5gBm8Ex7g2vqLL
         714ImKF9M2/YL9Hj8LuySQMmuxotz5cLCG0Sj2epChYZhtNoiAr9b7wa0hviAEakeO4x
         4Ua5giSqJfBwRGQ31Ok/FCEYHzrenXhp5pJlDekhWUAdaUtzwMSrvTvokcaSUwYW0r4Q
         RwygAmrabj3fmhTY/38v7rORYSrFi0i58RFCWKPDD7qrnYniH5I/NLRkyd75Ox/s3kIv
         ZeKA==
X-Gm-Message-State: ACrzQf1xB3OJ1LkpfEFj/WDVDxh1588SHcmctR1PDbNS8xI2X84VJ3FM
        j3lAEB4qyynd6jUD2l5uQA==
X-Google-Smtp-Source: AMsMyM5ylBn4W0vjCSssHZp7UnQ9RPARtgKyMAYys6jOyiTBAam8QkAGfidjYHmJ3JrFlemc2GM6ag==
X-Received: by 2002:a63:141:0:b0:43a:3851:b2ba with SMTP id 62-20020a630141000000b0043a3851b2bamr10892136pgb.90.1663761411733;
        Wed, 21 Sep 2022 04:56:51 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b0016be596c8afsm1790215plh.282.2022.09.21.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:56:51 -0700 (PDT)
Date:   Wed, 21 Sep 2022 19:56:43 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when
 rcutree_online_cpu()
Message-ID: <Yyr7+0YBEFY86GJj@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-2-kernelfans@gmail.com>
 <20220920103143.GB71722@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920103143.GB71722@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 12:31:43PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 15, 2022 at 01:58:23PM +0800, Pingfan Liu wrote:
> > rcutree_online_cpu() is concurrent, so there is the following race
> > scene:
> > 
> >         CPU 1                               CPU2
> > mask_old = rcu_rnp_online_cpus(rnp);
> > ...
> > 
> >                                    mask_new = rcu_rnp_online_cpus(rnp);
> >                                    ...
> >                                    set_cpus_allowed_ptr(t, cm);
> > 
> > set_cpus_allowed_ptr(t, cm);
> 
> Just for clarity, may I suggest:
> 
> 
>           CPU 0                                    CPU 1
>           -----                                    -----
>        rcutree_online_cpu()
>            rcu_boost_kthread_setaffinity()
>                mask = rcu_rnp_online_cpus(rnp);
>                                                 rcu_cpu_starting()
>                                                     WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>                                                 rcutree_online_cpu()
>                                                     rcu_boost_kthread_setaffinity()
>                                                         mask = rcu_rnp_online_cpus(rnp);
>                                                         set_cpus_allowed_ptr(t, cm);
>                set_cpus_allowed_ptr(t, cm);
> 
> 

OK.

> > @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> >  	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> >  		return;
> >  	mutex_lock(&rnp->boost_kthread_mutex);
> > +	/*
> > +	 * Relying on the lock to serialize, so when onlining, the latest
> > +	 * qsmaskinitnext is for cpus_ptr.
> > +	 */
> 
> Given how tricky the situation is, I suggest to also add more details to the
> comment:
> 
>         /*
>          * Rely on the boost mutex to serialize ->qsmaskinitnext and
>          * set_cpus_allowed_ptr(), so when concurrently onlining, racing against
> 	 * rcu_cpu_starting() makes sure that the latest update eventually
> 	 * wins with the right affinity setting.
>          */
> 

Appreciate for your re-phrase. I will use it in the next version


Thanks,
	Pingfan
