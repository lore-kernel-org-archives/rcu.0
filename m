Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076FAC433F5
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 17:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhKWRb2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233865AbhKWRb1 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 23 Nov 2021 12:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637688499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rbwewLFsABuwwFA7Yf68+QvHaRv0OksbhJ5ANLDADx0=;
        b=gztDFCs8PhEXMFTOqn0H+WBWISYbneO/qTAmBvrdDtPAponahIwuyjq9NUh2R46cu4GEDW
        WQtesxVHKm61GnB3elLKl0/DUEV3rveJ8zec+kBBbR91hx17nL5dj6Uu/gm1tkElnyd3ql
        9owEe9mPkAVuTnK57oxIRlPILM/iQTE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-Uyz1qc3SPgqhEGFXCuydXA-1; Tue, 23 Nov 2021 12:28:17 -0500
X-MC-Unique: Uyz1qc3SPgqhEGFXCuydXA-1
Received: by mail-wr1-f71.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so3871349wrc.22
        for <rcu@vger.kernel.org>; Tue, 23 Nov 2021 09:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbwewLFsABuwwFA7Yf68+QvHaRv0OksbhJ5ANLDADx0=;
        b=UfTSnQLr0CGCxXqgwHHoDroFfVl+mQn2teCcXksfy+y6a4b6jktmGDiPoWKBf56726
         b2hwVN4pE1FZTN2GQX+mOGLSDRrKfY/lwtQBQ5at8NQ9CrGUMcFA5ksxFVBn22Jiqu5c
         VuTXNlP8RZ7RaQdo3IZCB81CZbeYNsN75+LmPaXI1VMtn10dwFTM8LWTzl8HC70jingU
         9Kgi2BC6tBcmbKhLzuFqqWrlVvZSxm5gq6k3duK3QFuAFkc5tuPcH617dKv3fnV4LmAc
         T561c/6/Deviv33v3j8s6A9d6F3jdKrnjAUyv5n2N6VmDiVW6612MdSKdtaNM92vardx
         dnnA==
X-Gm-Message-State: AOAM5337jmXqTq+q4VWWPH1+d94GKX13eZ3V6C5S2wfWxTUeQrsrRdYw
        GlYQk0kC8tWvE1QHn8RS4Mg3L8/5VF7+VmyaIh43AU/8ii62GlOjG9ILPba0KuNGd9AnuEkzbG8
        MmGqlkBPMO7aT
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr4980354wmq.77.1637688496429;
        Tue, 23 Nov 2021 09:28:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkGcSDFJfJ/eExQMmeWAJzI8oQYUpvN8NFnVUgfIHLPXSuqBAOg/ZJ3gCDo+Vofun2YxFzkA==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr4980310wmq.77.1637688496191;
        Tue, 23 Nov 2021 09:28:16 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a17:4f01:3a16:ae0:112c:ba92])
        by smtp.gmail.com with ESMTPSA id p62sm1827353wmp.10.2021.11.23.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:28:15 -0800 (PST)
Date:   Tue, 23 Nov 2021 17:28:14 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/6] rcu/nocb: Create kthreads on all CPUs if "rcu_nocb="
 or "nohz_full=" are passed
Message-ID: <20211123172814.4rev7z45onxvjmy4@localhost.localdomain>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123003708.468409-5-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 23/11/21 01:37, Frederic Weisbecker wrote:
> In order to be able to (de-)offload any CPU using cpuset in the future,
> create a NOCB kthread for all possible CPUs. For now this is done only
> as long as the "rcu_nocb=" or "nohz_full=" kernel parameters are passed

Super nitpick! In subject and above sentence, "rcu_nocb=" is actually
"rcu_nocbs=", isn't it?

Feel free to ignore the noise, of course. :)

Best,
Juri

