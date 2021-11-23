Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35516C433F5
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhKWR2t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbhKWR2t (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 23 Nov 2021 12:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637688340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygX9stNObBwTwa4yUUs6NE8vyjejsSHuXhBtzRR0RVw=;
        b=IFoM3vTOdVYGSVH5bwQWT4b+JFQhBfZlAbEgUtBK2R4DTz9A8ASzIoPCf8EDoCtSvkoScw
        mvAqelllmx3dMWGiwCOY+sdrhpouFUn5BPA1Hu/ORUNe1I8Qi3cZuNRGy4Mn/VIDEp3vcH
        mhRuNXU4Fj7mHzVdnZKmjJ3B3ZngEPk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-Cu5vddAiOgKdFRsA28-fPA-1; Tue, 23 Nov 2021 12:25:39 -0500
X-MC-Unique: Cu5vddAiOgKdFRsA28-fPA-1
Received: by mail-wm1-f69.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso8282351wmc.2
        for <rcu@vger.kernel.org>; Tue, 23 Nov 2021 09:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygX9stNObBwTwa4yUUs6NE8vyjejsSHuXhBtzRR0RVw=;
        b=muqUVyEosyY0CE5I05EdDk3FfbieS/AZe+eOcAfY11zg2UbabHgnsztAaTmi5Zykek
         cnKGCD5p4mG2ZZWgqzcAxjmdj6WHFapdQnDfVLjk+oRAO1mIUKtfvd8dnpFWvNDW2T+v
         /PiCn+rMlhxWtU1Swlf2YFUJYt7O0K8rojb1ajkK9f5Ubs/o7LKSoD/tLaggBqz+uyrg
         8SYWooCAjUV1kG0xVuaWjGKmKx6gFsMu0sIcJPugyfW+eU5yciJuU+1L5suCeYUrdq2p
         Jzl0jywLGAfJ2G2CU0NwODL8clfgt+wq9yK4SNjz7ObVcaydxUTjIQiz/1seESUlJFKM
         vjhA==
X-Gm-Message-State: AOAM532WmOEi0/cz2bpQw6vcMsOchlsXEceRSp2tgyimyUuEJ0aomYnq
        cJwPyTBVqRnYAMgrqkkUtG32sb59K5mOwR9B68ySWfG411hn3YUz94y5M9efj4ddYhFJOhuqA6a
        watOYoHcsSo4o
X-Received: by 2002:adf:f708:: with SMTP id r8mr9172768wrp.198.1637688337090;
        Tue, 23 Nov 2021 09:25:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysPEMbhEoCEjBU+0lOVwkGDJAd1JCc2Oie62LzmXyvWxSm0wdinZHG7f/zAbM739fUr3LvyA==
X-Received: by 2002:adf:f708:: with SMTP id r8mr9172716wrp.198.1637688336836;
        Tue, 23 Nov 2021 09:25:36 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a17:4f01:3a16:ae0:112c:ba92])
        by smtp.gmail.com with ESMTPSA id h3sm11524486wrv.69.2021.11.23.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:25:36 -0800 (PST)
Date:   Tue, 23 Nov 2021 17:25:34 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/6] rcu/nocb: Last prep work before cpuset interface v2
Message-ID: <20211123172534.iaaagfa4eygfsjew@localhost.localdomain>
References: <20211123003708.468409-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123003708.468409-1-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 23/11/21 01:37, Frederic Weisbecker wrote:
> Changes since v1 after Paul's reviews:
> 
> * Clarify why the DEL vs ADD possible race on rdp group list is ok [1/6]
> * Update kernel parameters documentation [5/6]
> * Only create rcuo[sp] kthreads for CPUs that have ever come online [4/6]
> * Consider nohz_full= on changelogs
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/nocb
> 
> HEAD: da51363e5ddf54d6ce9c2cfbab946f8914519290

I run this on RT. It survived rcutorture on different kernel cmdline
configurations and creation of rcuox/N kthreads seemed sane. :)

FWIW, feel free to add

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks for working on this!

Best,
Juri

