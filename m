Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292BC433F5
	for <rcu@archiver.kernel.org>; Mon, 30 May 2022 15:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiE3POb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 May 2022 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbiE3POM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 May 2022 11:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5ADA6EC40
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653920028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rWHGtydye04Pc0qlr5FGyqa1kfhiweLX/99E3DuULf0=;
        b=DjfZSdNtRAGFg7jpRAZQ9XNCanKrYCFcveMhlosA5p6WyZNPmM+RkNsmlT0Yoow+yi/O2E
        tNKJm7VX8NC+IPqCqDLYWKzcGcMQqe/ac/I4ilTAtKe00SgjnsV/9Lwvk4DXPNO0qcAmUe
        FaBz/zxrRXpur3dsHyHD/NA1F0vz41o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-SLjQHTFMN2eBGIDMZk4TLg-1; Mon, 30 May 2022 10:13:47 -0400
X-MC-Unique: SLjQHTFMN2eBGIDMZk4TLg-1
Received: by mail-wm1-f70.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so7048070wms.6
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 07:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWHGtydye04Pc0qlr5FGyqa1kfhiweLX/99E3DuULf0=;
        b=H9vijUjoC/qTTPMTlZQnGY2YAypAKgosNU8Zja4h/xQHfmCJpsYwgPUCF2uqZSgM17
         /Yov9vic6Wrq0mfeYXTLwNPd/4k4KTEVAzLjLa5pDyub3Iyd5AxBFesMLbWJK9Eo6q76
         uc4Q1/Mwzo5ylg7MBjwpxF6ReTTUdYTIwhKwYOCTfPcAswgdZp8sqCC8CP5jURJVgsCP
         CNMGkv3reAPndx9Gkad8fUJ71ZwJ79BFduuJ4CWtt5N87MjIs1Es7xHaV3t0aW49FA7L
         SmgFAPKBdy3Qx353t7wgKFHAX7FzYXUsMV9Ql4aEn5jR5Ept2IythgzsVxeVMoaKtGbf
         qmPQ==
X-Gm-Message-State: AOAM5303nBZ/v9VHHK1n2FCafMPnt30uJk1uVKcPRqhcijfL5lzGeiTF
        vNxn1znI+7T3sbUzhE2n7flH9tixGrfPtCMZQ0IzYowUP/847oguy0bo3VYrm0h29tcCC7koxCb
        /STYWxaY1z/sw
X-Received: by 2002:a05:600c:1f0e:b0:397:707f:5a60 with SMTP id bd14-20020a05600c1f0e00b00397707f5a60mr18750191wmb.3.1653920026201;
        Mon, 30 May 2022 07:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1e34u+loAw8VqZvb9FL0bHKiEQ+1d9UEpMOs2QB0ub76Kzi7QWkgcn90Ht1UuKmcalYImZg==
X-Received: by 2002:a05:600c:1f0e:b0:397:707f:5a60 with SMTP id bd14-20020a05600c1f0e00b00397707f5a60mr18750170wmb.3.1653920025881;
        Mon, 30 May 2022 07:13:45 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b00397243d3dbcsm11368749wms.31.2022.05.30.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:13:45 -0700 (PDT)
Date:   Mon, 30 May 2022 16:13:42 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <YpTRFotSs0UnMEJJ@localhost.localdomain>
References: <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
 <20220530105650.GA1257179@lothringen>
 <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 30/05/22 15:16, Peter Zijlstra wrote:
> On Mon, May 30, 2022 at 12:56:50PM +0200, Frederic Weisbecker wrote:
> 
> > > This is ABI, you can't walk back on it. I would suggest starting with an
> > > 'all feature' isolation. Only if there's real demand for something more
> > > fine-grained add that on top. Simple first etc.
> > 
> > That's actually my worry. If we start with an all in one ABI, how do we later
> > mix that up with more finegrained features? Like what will be the behaviour of:
> > 
> > cpuset.isolation.rcu_nocb = 0
> > cpuset.isolation.all = 1
> 
> Well clearly that doesn't make sense. I was more thinking along the
> lines of cgroup.subtree_control, where instead all features are enabled
> by default.
> 
> But only if there's a real usecase, otherwise there's no point in
> providing such knobs.

All features on/off knob + house-keeping sub-partition/mask seem to be
what isolation users I could reach so far (OCP mostly) would indeed like
to have in the future.

